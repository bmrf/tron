:: Purpose:       Initializes Tron runtime environment. Called by Tron.bat at initial launch or by an individual sub-stage script when launched manually
::                This file determines Tron's overall project version and date
::                Do not edit this script
:: Requirements:  The ability to look and not touch
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
@echo off

:: Tron Project version and date. These two variables determine the overall project version and date
set TRON_VERSION=13.0.0
set TRON_DATE=2026-10-xx

:: Set window title
title Tron v%TRON_VERSION% (%TRON_DATE%)

:: Initialize script-internal variables
set ERRORS_DETECTED=no
set WARNINGS_DETECTED=no
set BAD_RUNPATH=no
set CONFIG_DUMP=no
set TARGET_METRO=no
set FREE_SPACE_AFTER=0
set FREE_SPACE_BEFORE=0
set FREE_SPACE_SAVED=0
set HELP=no
set NETWORK_AVAILABLE=undetected
set SAFE_MODE=no
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" set SAFE_MODE=yes
if /i "%SAFEBOOT_OPTION%"=="NETWORK" set SAFE_MODE=yes
set SKIP_CHECK_UPDATE=no
set SMART_PROBLEM_CODE=undetected
set SYSTEM_LANGUAGE=undetected
set WIN_VER=undetected
set WIN_VER_NUM=undetected


:: Force path to some system utilities in case the system PATH is messed up
set FIND=%SystemRoot%\System32\find.exe
set FINDSTR=%SystemRoot%\System32\findstr.exe
set REG=%SystemRoot%\System32\reg.exe


:: Detect which PowerShell engine to use for WMI work. Replaces wmic.exe, which Microsoft has deprecated
:: This is the ONLY place the engine is detected. Everything else references the variables set here:
::   PS_WMI_MODE   wmi  = Windows PowerShell 2.0+ (powershell.exe) using Get-WmiObject. Windows 7 through current Windows 10/11
::                 cim  = PowerShell 6+/7+ (pwsh.exe) using Get-CimInstance/Invoke-CimMethod/Set-CimInstance. Only used if Windows PowerShell is absent or lacks Get-WmiObject
::                 none = no usable PowerShell found. WMI-dependent jobs are skipped
::   PS_EXE        full path to the selected executable
::   PS_VER_MAJOR  major version of the selected engine
::   PS_CMD        invocation prefix. Usage from cmd: <NUL %PS_CMD% "<PowerShell code>"
::   PS_GET        engine-appropriate cmdlet for read-only WMI queries (Get-WmiObject or Get-CimInstance). Method calls and property writes need per-mode blocks
:: Rules for PowerShell code passed via PS_CMD: the code must be one double-quoted argument containing NO double quotes (use single-quoted
:: PowerShell strings; double a single quote to escape it), NO exclamation marks (use -not), and no percent signs except doubled WQL
:: wildcards (use ForEach-Object, never its one-character alias), so that cmd quoting, percent expansion and delayed expansion can never alter it
set PS_WMI_MODE=none
set PS_EXE=none
set PS_VER_MAJOR=0
set PS_GET=none
set PS_CMD=
set PS_PWSH=none
:: Prefer Windows PowerShell. %SystemRoot%\System32 is redirected to SysWOW64 under 32-bit cmd, which matches how wmic.exe was called
if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" for /f %%a in ('^<NUL "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -NonInteractive -Command "if (Get-Command Get-WmiObject -ErrorAction SilentlyContinue) { $PSVersionTable.PSVersion.Major }"') do echo %%a| %FINDSTR% /r "^[0-9][0-9]*$" >NUL && set PS_VER_MAJOR=%%a
if %PS_VER_MAJOR% GEQ 2 (
	set "PS_EXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
	set PS_WMI_MODE=wmi
	set PS_GET=Get-WmiObject
	goto ps_detect_done
)
:: Fall back to PowerShell 6+/7+ (pwsh.exe). Check the default install path (64-bit and native), then PATH
if defined ProgramW6432 if exist "%ProgramW6432%\PowerShell\7\pwsh.exe" set "PS_PWSH=%ProgramW6432%\PowerShell\7\pwsh.exe"
if "%PS_PWSH%"=="none" if exist "%ProgramFiles%\PowerShell\7\pwsh.exe" set "PS_PWSH=%ProgramFiles%\PowerShell\7\pwsh.exe"
if "%PS_PWSH%"=="none" for /f "delims=" %%a in ('where pwsh.exe 2^>NUL') do set "PS_PWSH=%%a"
set PS_VER_MAJOR=0
if not "%PS_PWSH%"=="none" for /f %%a in ('^<NUL "%PS_PWSH%" -NoProfile -NonInteractive -Command "if (Get-Command Get-CimInstance -ErrorAction SilentlyContinue) { $PSVersionTable.PSVersion.Major }"') do echo %%a| %FINDSTR% /r "^[0-9][0-9]*$" >NUL && set PS_VER_MAJOR=%%a
if %PS_VER_MAJOR% GEQ 6 (
	set "PS_EXE=%PS_PWSH%"
	set PS_WMI_MODE=cim
	set PS_GET=Get-CimInstance
)
:ps_detect_done
if /i not "%PS_WMI_MODE%"=="none" set PS_CMD="%PS_EXE%" -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command


:: Get the date into ISO 8601 standard format (yyyy-mm-dd)
:: Emits wmic's CIM_DATETIME layout (yyyymmddHHMMSS.ffffff). In cim mode LocalDateTime is a .NET DateTime, so it is reformatted with
:: the invariant culture (UTC offset suffix omitted; only the first 8 characters are consumed)
if /i not "%PS_WMI_MODE%"=="none" for /f %%a in ('^<NUL %PS_CMD% "$d = (%PS_GET% Win32_OperatingSystem).LocalDateTime; if ($d -is [DateTime]) { $d.ToString('yyyyMMddHHmmss', [Globalization.CultureInfo]::InvariantCulture) + '.000000' } else { $d }" ^| %FIND% "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%


:: Get Time Zone name and value
if /i not "%PS_WMI_MODE%"=="none" for /f "delims=" %%i IN ('^<NUL %PS_CMD% "(%PS_GET% Win32_TimeZone).StandardName"') DO set TIME_ZONE_NAME=%%i


:: Resume-related stuff (resuming from an interrupted run)
set RESUME_STAGE=0
set RESUME_SWITCHES=0
set RESUME_DETECTED=no


:: Detect the version of Windows we're on. This determines a few things later on
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| %FIND% "ProductName"') DO set WIN_VER=%%i %%j
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion ^| %FIND% "CurrentVersion"') DO set WIN_VER_NUM=%%i


:: Detect system language. This determines which string we look for in ipconfig output for determining if we have an active network connection
:: English
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "0409" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=en
	goto detect_network_connection
)

:: English UK
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "0809" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=gb
	goto detect_network_connection
)

:: German
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "0407" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=de
	goto detect_network_connection
)

:: Italian
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "0410" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=it
	goto detect_network_connection
)

:: French
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "040C" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=fr
	goto detect_network_connection
)

:: French Canadian #1
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "0409" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=fr
	goto detect_network_connection
)

:: French Canadian #2
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "0C0C" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=fr
	goto detect_network_connection
)

:: Spanish
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "0C0A" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=es
	goto detect_network_connection
)

:: Turkish
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "041F" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=tr
	goto detect_network_connection
)

:: Brazilian Portuguese
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "0416" >nul 2>&1
if /i %ERRORLEVEL%==0 (
	set SYSTEM_LANGUAGE=pb
	goto detect_network_connection
)


:: Detect network connection. We assume it's available unless we actively detect it isn't
:detect_network_connection
set NETWORK_AVAILABLE=yes
:: English
if %SYSTEM_LANGUAGE%==en %WinDir%\system32\ipconfig /all | %FIND% /i "Subnet Mask" >NUL 2>&1
if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no
:: English UK
if %SYSTEM_LANGUAGE%==gb %WinDir%\system32\ipconfig /all | %FIND% /i "Subnet Mask" >NUL 2>&1
if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no
:: German
if %SYSTEM_LANGUAGE%==de %WinDir%\system32\ipconfig /all | %FIND% /i "Subnetzmaske" >NUL 2>&1
if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no
:: Italian
if %SYSTEM_LANGUAGE%==it %WinDir%\system32\ipconfig /all | %FIND% /i "Subnet Mask" >NUL 2>&1
if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no
:: French
if %SYSTEM_LANGUAGE%==fr %WinDir%\system32\ipconfig /all | %FIND% /i "Masque de" >NUL 2>&1
if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no
:: Spanish
if %SYSTEM_LANGUAGE%==es %WinDir%\system32\ipconfig /all | %FIND% /i "de subred" >NUL 2>&1
if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no
:: Turkish
::if %SYSTEM_LANGUAGE%==fr %WinDir%\system32\ipconfig /all | %FIND% /i "xxxx" >NUL 2>&1
::if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no
:: Brazilian Portugese
if %SYSTEM_LANGUAGE%==pb %WinDir%\system32\ipconfig /all | %FIND% /i "de Sub-rede" >NUL 2>&1
if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no


:: Build USERPROFILES variable which works across ALL versions of Windows for determining location of C:\Users or C:\Documents and Settings
pushd "%USERPROFILE%\.."
set USERPROFILES=%CD%
popd


:: Build log directories if they don't exist
for %%D in ("%LOGPATH%","%QUARANTINE_PATH%","%BACKUPS%","%RAW_LOGS%","%SUMMARY_LOGS%") do (
	if not exist %%D mkdir %%D
)

:: Purpose:       Initializes Tron runtime environment. Called by Tron.bat at initial launch or by an individual sub-stage script when launched manually
::                This file determines Tron's overall project version and date
::                Do not edit this script
:: Requirements:  The ability to look and not touch
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
@echo off

:: Tron Project version and date. These two variables determine the overall project version and date
set TRON_VERSION=11.1.6
set TRON_DATE=2020-01-15

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
set WMIC=%SystemRoot%\System32\wbem\wmic.exe
set FIND=%SystemRoot%\System32\find.exe
set FINDSTR=%SystemRoot%\System32\findstr.exe
set REG=%SystemRoot%\System32\reg.exe


:: Get the date into ISO 8601 standard format (yyyy-mm-dd)
for /f %%a in ('^<NUL %WMIC% OS GET LocalDateTime ^| %FIND% "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%


:: Get Time Zone name and value
for /f "USEBACKQ skip=1 delims=" %%i IN (`^<NUL %WMIC% timezone get StandardName ^|findstr /b /r [a-z]`) DO set TIME_ZONE_NAME=%%i


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

:: French
reg query "hklm\system\controlset001\control\nls\language" /v Installlanguage | %FIND% /i "040C" >nul 2>&1
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
:: French
if %SYSTEM_LANGUAGE%==fr %WinDir%\system32\ipconfig /all | %FIND% /i "Masque de" >NUL 2>&1
if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no
:: Spanish
if %SYSTEM_LANGUAGE%==es %WinDir%\system32\ipconfig /all | %FIND% /i "de subred" >NUL 2>&1
if /i not %ERRORLEVEL%==0 set NETWORK_AVAILABLE=no


:: Build USERPROFILES variable which works across ALL versions of Windows for determining location of C:\Users or C:\Documents and Settings
pushd "%USERPROFILE%\.."
set USERPROFILES=%CD%
popd


:: Build log directories if they don't exist
for %%D in ("%LOGPATH%","%QUARANTINE_PATH%","%BACKUPS%","%RAW_LOGS%","%SUMMARY_LOGS%") do (
	if not exist %%D mkdir %%D
)

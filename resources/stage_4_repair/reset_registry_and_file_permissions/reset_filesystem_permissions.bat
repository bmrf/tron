:: Purpose:       Restores full rights to Administrator and SYSTEM accounts on everything in the Windows system directory
:: Requirements:  subinacl in the system path or system32 folder
:: Author:        reddit.com/user/vocatus ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
::                1.0.3-TRON * Add proper version-specifc commands to secedit database repair. Was incorrectly attempting to run Windows XP command on Windows 7 and up
::                           + Add /nostatistic flag to subinacl calls. This should suppress the red banner that appears and always made people think something was wrong
::                           + Add standalone execution support
::                           - Remove unecessary SETLOCAL command
::                           - Remove logging of filesystem permissions reset since it only produces a bunch of "access denied" log entries on protected files that we don't care about
::                1.0.2-TRON ! Add missing %RAW_LOGS%\ prefix to log compilation line. Thanks to /u/toomasmolder
::                1.0.1-TRON ! Add missing pushd statement
::                1.0.0-TRON / Modifications for Tron. Remove logging, CUR_DATE, and various other unnecessary code
::                1.0.0        Initial write
SETLOCAL


:::::::::::::::
:: VARIABLES :: -------------- These are the defaults. Change them if you so desire. --------- ::
:::::::::::::::
:: No user-set variables for this script


:: --------------------------- Don't edit anything below this line --------------------------- ::


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
@echo off
set SCRIPT_VERSION=1.0.3-TRON
set SCRIPT_UPDATED=2016-09-12

:: Only needed for standalone execution since subinacl.exe is in the same directory as this script
pushd "%~dp0"

:: Populate dependent variables if we didn't inherit them from Tron (standalone execution)
if /i "%LOGPATH%"=="" (
	set LOGPATH=%SystemDrive%\Logs
	set RAW_LOGS=%LOGPATH%\raw_logs
	for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| find "ProductName"') DO set WIN_VER=%%i %%j
	for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion ^| find "CurrentVersion"') DO set WIN_VER_NUM=%%i
)


:::::::::::::
:: EXECUTE ::
:::::::::::::
:: Filesystem permissions repair
subinacl /noverbose /nostatistic /subdirectories %WinDir% /grant=administrators=f >NUL
subinacl /noverbose /nostatistic /subdirectories %WinDir% /grant=system=f >NUL

:: Security database repair
:: Windows XP/2003
if %WIN_VER_NUM:~0,1%==5 secedit /configure /cfg %windir%\repair\secsetup.inf /db secsetup.sdb /verbose >> "%RAW_LOGS%\reset_filesystem_perms_secedit.log" 2>&1

:: Windows 7 and up
if %WIN_VER_NUM:~0,1% geq 6 secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose >> "%RAW_LOGS%\reset_filesystem_perms_secedit.log" 2>&1

:: Purpose:       Restores full rights to Administrator and SYSTEM accounts on everything in specified registry hives
:: Requirements:  subinacl in the system path or system32 folder
:: Author:        reddit.com/user/vocatus ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.4-TRON + Add /nostatistic flag to subinacl calls. This should suppress the red banner that appears and always made people think something was wrong
::                           + Add standalone execution support
::                           - Remove unnecessary SETLOCAL command
::                           - Remove logging of registry permissions reset since it only produces a bunch of "access denied" log entries on protected hives that we don't care about
::                1.0.3-TRON * Loopify the subinacl statements to reduce size of the script. No functionality change
::                1.0.2-TRON ! Add missing %RAW_LOGS%\ prefix to log compilation line. Thanks to /u/toomasmolder
::                1.0.1-TRON ! Add missing pushd statement
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
set SCRIPT_VERSION=1.0.4-TRON
set SCRIPT_UPDATED=2016-09-12


:: Populate dependent variables if we didn't inherit them from Tron (standalone execution)
if /i "%LOGPATH%"=="" (
	set LOGPATH=%SystemDrive%\Logs
	set RAW_LOGS=%LOGPATH%\raw_logs
	for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| find "ProductName"') DO set WIN_VER=%%i %%j
	for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion ^| find "CurrentVersion"') DO set WIN_VER_NUM=%%i
	pushd "%~dp0"
)

:: Get in the correct directory
pushd "%~dp0"

:::::::::::::
:: EXECUTE ::
:::::::::::::
:: Do the reset
for %%i in (HKEY_LOCAL_MACHINE,HKEY_CURRENT_USER,HKEY_CLASSES_ROOT) do (
	subinacl.exe /noverbose /nostatistic /subkeyreg %%i /grant=administrators=f >NUL
	subinacl.exe /noverbose /nostatistic /subkeyreg %%i /grant=system=f >NUL
)

popd

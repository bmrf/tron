:: Purpose:       Restores full rights to Administrator and SYSTEM accounts on everything in specified registry hives
:: Requirements:  subinacl in the system path or system32 folder
:: Author:        reddit.com/user/vocatus ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.3-TRON * Loopify the subinacl statements to reduce size of the script. No functionality change
::                1.0.2-TRON ! Add missing %RAW_LOGS%\ prefix to log compilation line. Thanks to /u/toomasmolder
::                1.0.1-TRON ! Add missing pushd statement
::                1.0.0-TRON / Modifications for Tron. Remove logging, CUR_DATE, and various other unnecessary code
::                1.0.0        Initial write
SETLOCAL


:::::::::::::::
:: VARIABLES ::
:::::::::::::::
:: no user-set variables for this script


::::::::::
:: Prep :: -- Don't change anything in this section
::::::::::
@echo off
SETLOCAL
set SCRIPT_VERSION=1.0.3-TRON
set SCRIPT_UPDATED=2016-08-13

:: We need this for Tron because subinacl.exe is in the same directory as this script
pushd %~dp0


:::::::::::::
:: EXECUTE ::
:::::::::::::
for %%i in (HKEY_LOCAL_MACHINE,HKEY_CURRENT_USER,HKEY_CLASSES_ROOT) do (
	subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_reg_reset_%%i.log /subkeyreg %%i /grant=administrators=f
	subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_reg_reset_%%i1.log /subkeyreg %%i /grant=system=f
)

:: Compile the logs
for %%i in (HKEY_LOCAL_MACHINE,HKEY_CURRENT_USER,HKEY_CLASSES_ROOT) do (
	type %RAW_LOGS%\subinacl_reg_reset_%%i1.log >> %RAW_LOGS%\subinacl_reg_reset_%%i.log
)


del /f /q *1.log >NUL 2>&1

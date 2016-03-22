:: Purpose:       Restores full rights to Administrator and SYSTEM accounts on everything in the Windows system directory
:: Requirements:  subinacl in the system path or system32 folder
:: Author:        reddit.com/user/vocatus ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
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
set SCRIPT_VERSION=1.0.2-TRON
set SCRIPT_UPDATED=2016-03-21

:: We need this for Tron because subinacl.exe is in the same directory as this script
pushd %~dp0


:::::::::::::
:: EXECUTE ::
:::::::::::::
subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_filesystem_reset.log /subdirectories %WinDir% /grant=administrators=f
subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_filesystem_reset1.log /subdirectories %WinDir% /grant=system=f

:: Security database repair
secedit /configure /cfg %windir%\repair\secsetup.inf /db secsetup.sdb /verbose >> "%RAW_LOGS%\secedit_filesystem_reset.log" 2>&1

:: Compile the logs
type %RAW_LOGS%\subinacl_filesystem_reset1.log >> %RAW_LOGS%\subinacl_filesystem_reset.log
del /f /q *1.log >NUL 2>&1

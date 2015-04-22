:: Purpose:       Restores full rights to Administrator and SYSTEM accounts on everything in specified registry hives
:: Requirements:  subinacl in the system path or system32 folder
:: Author:        reddit.com/user/vocatus ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
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
set SCRIPT_VERSION=1.0.1-TRON
set SCRIPT_UPDATED=2015-04-16

:: We need this for Tron because subinacl.exe is in the same directory as this script
pushd %~dp0


:::::::::::::
:: EXECUTE ::
:::::::::::::
subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_reg_reset_HKLM.log /subkeyreg HKEY_LOCAL_MACHINE /grant=administrators=f
subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_reg_reset_HKCU.log /subkeyreg HKEY_CURRENT_USER /grant=administrators=f
subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_reg_reset_HKCR.log /subkeyreg HKEY_CLASSES_ROOT /grant=administrators=f
subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_reg_reset_HKLM1.log /subkeyreg HKEY_LOCAL_MACHINE /grant=system=f
subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_reg_reset_HKCU1.log /subkeyreg HKEY_CURRENT_USER /grant=system=f
subinacl /noverbose /outputlog=%RAW_LOGS%\subinacl_reg_reset_HKCR1.log /subkeyreg HKEY_CLASSES_ROOT /grant=system=f

:: Compile the logs
type subinacl_reg_reset_HKLM1.log >> subinacl_reg_reset_HKLM.log
type subinacl_reg_reset_HKCU1.log >> subinacl_reg_reset_HKCU.log
type subinacl_reg_reset_HKCR1.log >> subinacl_reg_reset_HKCR.log
del /f /q *1.log >NUL 2>&1

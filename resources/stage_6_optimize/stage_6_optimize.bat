:: Purpose:       Sub-script containing all commands for Tron's Stage 6: Optimize stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is recommended but not required
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.7 * Improve standalone execution support. Can now execute by double-clicking icon vs. manually executing via CLI
::                1.0.6 * Preface WMIC calls with null input to ensure the pipe is closed, fixes issue with WMI hanging on WinXP machines. Thanks to github:salsifis
::                        Relevant pull: https://github.com/bmrf/tron/pull/108
::                1.0.5 * Update date/time logging functions to use new log_with_date.bat. Thanks to /u/DudeManFoo
::                1.0.4 * script: Update script to support standalone execution
::                1.0.3 * Clarify log messages if we're skipping defrag because of an error
::                1.0.2 + Add support for multiple SKIP_DEFRAG variable values
::                1.0.1 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_6_SCRIPT_VERSION=1.0.7
set STAGE_6_SCRIPT_DATE=2018-01-25

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	pushd "%~dp0"
	pushd ..
	
	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)



:::::::::::::::::::::::
:: STAGE 6: Optimize :: // Begin jobs
:::::::::::::::::::::::
call functions\log_with_date.bat "  stage_6_optimize begin..."


:: JOB: Reset the system page file settings
title Tron v%TRON_VERSION% [stage_6_optimize] [PageFileReset]
if /i %SKIP_PAGEFILE_RESET%==yes (
	call functions\log_with_date.bat "!  SKIP_PAGEFILE_RESET (-spr) set. Skipping page file reset."
) else (
	call functions\log_with_date.bat "   Resetting page file settings to Windows defaults..."
	if /i %DRY_RUN%==no <NUL %WMIC% computersystem where name="%computername%" set AutomaticManagedPagefile=True >> "%LOGPATH%\%LOGFILE%" 2>&1
	call functions\log_with_date.bat "   Done."
)


:: JOB: Check status of SKIP_DEFRAG and run defrag if no issues
if /i "%SKIP_DEFRAG%"=="yes" call functions\log_with_date.bat "!  SKIP_DEFRAG (-sd) set. Skipping defrag of %SystemDrive%."
if /i "%SKIP_DEFRAG%"=="yes_ssd" call functions\log_with_date.bat "   Solid State hard drive detected. Skipping defrag of %SystemDrive%."
if /i "%SKIP_DEFRAG%"=="yes_vm" call functions\log_with_date.bat "   Virtual Machine detected. Skipping defrag of %SystemDrive%."
if /i "%SKIP_DEFRAG%"=="yes_error" (
	call functions\log_with_date.bat "!  WARNING: Error reading %SystemDrive% disk stats. Skipping defrag as a precaution."
	set WARNINGS_DETECTED=yes
)
if /i "%SKIP_DEFRAG%"=="no" (
	title Tron v%TRON_VERSION% [stage_6_optimize] [Defrag]
	call functions\log_with_date.bat "   Launch job 'Defrag %SystemDrive%'..."
	if /i %DRY_RUN%==no stage_6_optimize\defrag\defraggler.exe %SystemDrive% /MinPercent 5
	call functions\log_with_date.bat "   Done."
)





:: Stage complete
call functions\log_with_date.bat "  stage_6_optimize complete."

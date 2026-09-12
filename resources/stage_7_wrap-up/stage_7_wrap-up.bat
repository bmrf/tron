:: Purpose:       Sub-script containing all commands for Tron's Stage 7: Wrap-up stage. Called by tron.bat and returns control when finished
:: Requirements:  Administrator access
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.5 + Add collection of AdwCleaner raw logs
::                1.0.4 - Remove post-run restore point creation, since there's really no point in creating it
::                1.0.3 / Change REMOVE_MALWAREBYTES switch to PRESERVE_MALWAREBYTES (-pmb) as the new default behavior is to remove it at the end of the run
::                1.0.2 + Add REMOVE_MALWAREBYTES (-rmb) switch to have Tron automatically remove Malwarebytes at the end of the run
::                      / Change the display output from disk space reclaimed calculation to assume GB's instead of MB's
::                1.0.1 ! Apply u/Paul_NZ's disk space calculation fix from prerun_checks_and_tasks.bat
::                1.0.0 + Initial break-out of code from tron.bat into discrete subscript
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_7_SCRIPT_VERSION=1.0.5
set STAGE_7_SCRIPT_DATE=2024-03-09

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
:: STAGE 7: Wrap-up  :: // Begin jobs
:::::::::::::::::::::::
call functions\log_with_date.bat "  stage_7_wrap-up begin..."


:: JOB: Reset power settings to Windows defaults
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Reset power settings]
if %PRESERVE_POWER_SCHEME%==yes (
	call functions\log_with_date.bat "!  PRESERVE_POWER_SCHEME (-p) set to "%PRESERVE_POWER_SCHEME%", skipping power settings reset."
) else (
	call functions\log_with_date.bat "   Resetting Windows power settings to defaults and re-enabling screensaver..."
	if %DRY_RUN%==no (
		REM Check for Windows Server 2003
		if %WIN_VER_NUM% lss 6.0 %WINDIR%\system32\powercfg.exe /RestoreDefaultPolicies >NUL 2>&1
		REM Run commands for all other versions of Windows
		%WINDIR%\system32\powercfg.exe -restoredefaultschemes >NUL 2>&1
)
call functions\log_with_date.bat "   Done."
)


:: JOB: Get post-Tron system state (installed programs, complete file list) and generate the summary logs
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Generate Summary Logs]
call functions\log_with_date.bat "   Calculating post-run results for summary logs..."
if /i %DRY_RUN%==no (
	:: Get list of installed programs
	%WMIC_COMPAT% ProductDump > "%RAW_LOGS%\installed-programs-after.txt" 2>NUL
	:: Get list of all files
	%WMIC_COMPAT% CreateFileList "%RAW_LOGS%\filelist-after.txt" %SystemDrive% >> "%LOGPATH%\%LOGFILE%" 2>&1
	%WMIC_COMPAT% GenerateSummaries "%RAW_LOGS%" "%SUMMARY_LOGS%" >> "%LOGPATH%\%LOGFILE%" 2>&1
)
call functions\log_with_date.bat "   Done. Summary logs are at "%SUMMARY_LOGS%\""


:: JOB: Collect misc logs and deposit them in the log folder
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Collect logs]
call functions\log_with_date.bat "   Saving misc logs to "%RAW_LOGS%\"..."
if /i %DRY_RUN%==no (
	if exist "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\logs" copy /Y "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\logs\*.xml" "%RAW_LOGS%\" >NUL
	if exist "%SystemDrive%\AdwCleaner\Logs" copy /Y "%SystemDrive%\AdwCleaner\Logs\*.txt" "%RAW_LOGS%\" >NUL
	if exist "%SystemDrive%\AdwCleaner" rmdir /s /q "%SystemDrive%\AdwCleaner" >NUL
	if exist "%LOGPATH%\mbam-log*" move /y "%LOGPATH%\mbam-log*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\protection-log*" move /y "%LOGPATH%\protection-log*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\jre*" move /y "%LOGPATH%\jre*" "%RAW_LOGS%\"
)
call functions\log_with_date.bat "   Done."


:: JOB: Skip removal of Malwarebytes if requested
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Remove Malwarebytes]
if %PRESERVE_MALWAREBYTES%==yes (
	call functions\log_with_date.bat "!  PRESERVE_MALWAREBYTES (-pmb) set to "%PRESERVE_MALWAREBYTES%", skipping removal."
) else (
	call functions\log_with_date.bat "   Uninstalling Malwarebytes..."
	if %DRY_RUN%==no (
		if exist "%ProgramFiles%\Malwarebytes\Anti-Malware\unins000.exe" "%ProgramFiles%\Malwarebytes\Anti-Malware\unins000.exe" /verysilent /suppressmsgboxes /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
		if exist "%ProgramFiles(x86)%\Malwarebytes\Anti-Malware\unins000.exe" "%ProgramFiles(x86)%\Malwarebytes\Anti-Malware\unins000.exe" /verysilent /suppressmsgboxes /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
		if exist "%ProgramFiles%\Malwarebytes Anti-Malware\" rmdir "%ProgramFiles%\Malwarebytes Anti-Malware\" /s /q >> "%LOGPATH%\%LOGFILE%" 2>&1
		if exist "%ProgramFiles(x86)%\Malwarebytes Anti-Malware\" rmdir "%ProgramFiles(x86)%\Malwarebytes Anti-Malware\" /s /q >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
call functions\log_with_date.bat "   Done."
)



:: JOB: Calculate saved disk space
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Calculate saved disk space]
for /f %%a in ('%WMIC_COMPAT% DriveFreeMb %SystemDrive%') do set FREE_SPACE_AFTER=%%a

:: Old method (broken in Win10 build 17763 (1809) and up)
:: for /F "tokens=2 delims=:" %%a in ('fsutil volume diskfree %SystemDrive% ^| %FIND% /i "avail free"') do set bytes=%%a

:: GB version of the calculation
::set /A FREE_SPACE_AFTER=%bytes:~0,-3%/1024*1000/1024/1024

:: MB version of the calculation
::set /a FREE_SPACE_AFTER=%bytes:~0,-3%/1024*1000/1024

:: Set the space for display
set /a FREE_SPACE_SAVED=%FREE_SPACE_AFTER% - %FREE_SPACE_BEFORE%




:: Stage complete
call functions\log_with_date.bat "  stage_7_wrap-up complete."

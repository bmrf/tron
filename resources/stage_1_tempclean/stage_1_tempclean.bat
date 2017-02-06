:: Purpose:       Sub-script containing all commands for Tron's Stage 1: Temp Cleanup stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is recommended but not required
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.7 * script:     Update script to support standalone execution
::                1.1.6 ! duplicates: Fix broken duplicate file cleanup of Downloads folder due to accidentally putting quote markes around the path to the profile list text file
::                1.1.5 ! ccleaner:   Add /f (force) switch to ccleaner task kill command. Thanks to /u/iseijin
::                1.1.4 ! ccleaner:   Remove /wait flag from start command so script continues immediately. Script now has hard-coded 180 second (3 minute) delay after which it will forcibly kill CCleaner. When running normally this should be plenty of time to complete, and this way the script won't stop if CCleaner stalls. Thanks to multiple users for reporting
::                1.1.3 ! Fix bug with CCleaner where "start /wait" wasn't properly waiting. Turns out ccleaner silently launches ccleaner64.exe on 64-bit systems, which closes the first file handle, which made "start /wait" think it exited and thus continues the script. Sneaky sneaky, Piriform
::                1.1.2 * Wrap all references to %TEMP% in quotes to account for possibility of a user account with special characters in it (e.g. "&")
::                1.1.1 / ccleaner:  Increase cooldown from 15 to 60 seconds to ensure it has time to finish before BleachBit launches
::                1.1.0 + Add job to delete duplicate files found in the "Downloads" folder of each user
::                1.0.2 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.1 * ccleaner:  Add note explaining that CCleaner doesn't support verbose output if VERBOSE (-v) flag is used. Thanks to /u/Forcen
::                      * bleachbit: Improve Bleachbit support for VERBOSE (-v) flag, now displays ALL Bleachbit output to console and log file if -v is used. Thanks to /u/Forcen
::                      - misc:      Remove unecessary window title reset after Tempfilecleanup
::                1.0.0 + Initial write
@echo off



:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_1_SCRIPT_VERSION=1.1.7
set STAGE_1_SCRIPT_DATE=2017-02-04

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)



::::::::::::::::::::::::
:: STAGE 1: TEMPCLEAN :: // Begin jobs
::::::::::::::::::::::::
call functions\log.bat "%CUR_DATE% %TIME%   stage_1_tempclean begin..."


:: JOB: Clean Internet Explorer; Windows built-in method. Only works on Vista and up
if %WIN_VER_NUM% geq 6.0 (
	title Tron v%TRON_VERSION% [stage_1_tempclean] [Clean Internet Explorer]
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Clean Internet Explorer'..."
	if /i %DRY_RUN%==no rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)


:: JOB: TempFileCleanup.bat
title Tron v%TRON_VERSION% [stage_1_tempclean] [TempFileCleanup]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'TempFileCleanup'..."
if /i %DRY_RUN%==no call stage_1_tempclean\tempfilecleanup\TempFileCleanup.bat >> "%LOGPATH%\%LOGFILE%" 2>NUL
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: CCleaner
:: Fun fact, if ccleaner64.exe is present and you call ccleaner.exe on a 64-bit system, CCleaner will silently abort the launch request and launch ccleaner64.exe instead
title Tron v%TRON_VERSION% [stage_1_tempclean] [CCleaner]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'CCleaner'..."
if /i %DRY_RUN%==no (
	if /i %VERBOSE%==yes call functions\log.bat "%CUR_DATE% %TIME% !  VERBOSE (-v) output requested but not supported by CCleaner. Sorry."
	if %PROCESSOR_ARCHITECTURE%==x86 start "" stage_1_tempclean\ccleaner\ccleaner.exe /auto>> "%LOGPATH%\%LOGFILE%" 2>NUL
	if %PROCESSOR_ARCHITECTURE%==AMD64 start "" stage_1_tempclean\ccleaner\ccleaner64.exe /auto>> "%LOGPATH%\%LOGFILE%" 2>NUL
	:: Hardcoded delay to let CCleaner finish
	ping 127.0.0.1 -n 180 > nul 2>&1
	:: Now we kill it in case it's hung
	if %PROCESSOR_ARCHITECTURE%==x86 taskkill /f /im ccleaner.exe >nul 2>&1
	if %PROCESSOR_ARCHITECTURE%==AMD64 taskkill /f /im ccleaner64.exe >nul 2>&1
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: BleachBit
title Tron v%TRON_VERSION% [stage_1_tempclean] [BleachBit]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'BleachBit'..."
if /i %DRY_RUN%==no (

	if %VERBOSE%==yes (
		:: OK yes, this is wonky. If verbose is requested we first dump all files to the screen, THEN dump them to the log, THEN do the actual clean
		:: Thanks Windows Batch for not having a TEE or equivalent
		stage_1_tempclean\bleachbit\bleachbit_console.exe --preset --preview
		stage_1_tempclean\bleachbit\bleachbit_console.exe --preset --preview>> "%LOGPATH%\%LOGFILE%" 2>NUL
	)

	stage_1_tempclean\bleachbit\bleachbit_console.exe --preset --clean >> "%LOGPATH%\%LOGFILE%" 2>NUL
	ping 127.0.0.1 -n 12 >NUL
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Delete duplicate files in the "Downloads" folder of each user profile
title Tron v%TRON_VERSION% [stage_1_tempclean] [Clean Duplicate Downloads]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Clean duplicate files from Download folders'..."
if %DRY_RUN%==no (
	REM We use Tron's USERPROFILES variable to account for possibilty of C:\Users (Vista and up) or C:\Documents and Settings (XP/2003)
	dir "%USERPROFILES%\" /B > "%TEMP%\userlist.txt"
	for /f "tokens=* delims= " %%i in (%TEMP%\userlist.txt) do (
		REM OK this is clumsy. We check three locations for Downloads, hence three sets of commands (three sets in the VERBOSE code, three sets in the non-VERBOSE code)
		if %VERBOSE%==yes (
			REM VERBOSE mode
			REM For each location:
			REM   1. Display files to be nuked
			REM   2. Dump the same list to the log
			REM   3. Do the actual deletion
			stage_1_tempclean\finddupe\finddupe.exe -z "%USERPROFILES%\%%i\Downloads\**"
			stage_1_tempclean\finddupe\finddupe.exe -z -p "%USERPROFILES%\%%i\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
			stage_1_tempclean\finddupe\finddupe.exe -z -p -del "%USERPROFILES%\%%i\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
			if exist "%USERPROFILES%\%%i\My Documents\Downloads" (
				stage_1_tempclean\finddupe\finddupe.exe -z "%USERPROFILES%\%%i\My Documents\Downloads\**"
				stage_1_tempclean\finddupe\finddupe.exe -z -p "%USERPROFILES%\%%i\My Documents\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
				stage_1_tempclean\finddupe\finddupe.exe -z -p -del "%USERPROFILES%\%%i\My Documents\Downloads\**" 2>NUL
			)
			if exist "%USERPROFILES%\%%i\Documents\Downloads" (
				stage_1_tempclean\finddupe\finddupe.exe -z -rdonly "%USERPROFILES%\%%i\Documents\Downloads\**"
				stage_1_tempclean\finddupe\finddupe.exe -z -rdonly -p "%USERPROFILES%\%%i\Documents\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
				stage_1_tempclean\finddupe\finddupe.exe -z -rdonly -p -del "%USERPROFILES%\%%i\Documents\Downloads\**" 2>NUL
			)
		) else (
			REM Non-VERBOSE mode. Simply perform deletion and pipe the output to the log
			stage_1_tempclean\finddupe\finddupe.exe -z -p -del "%USERPROFILES%\%%i\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
			if exist "%USERPROFILES%\%%i\Documents\Downloads" stage_1_tempclean\finddupe\finddupe.exe -z -p -del "%USERPROFILES%\%%i\Documents\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
			if exist "%USERPROFILES%\%%i\My Documents\Downloads" stage_1_tempclean\finddupe\finddupe.exe -z -p -del "%USERPROFILES%\%%i\My Documents\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
		)
	)
	del /s /q "%TEMP%\userlist.txt" >nul 2>&1
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: USB Device Cleanup
title Tron v%TRON_VERSION% [stage_1_tempclean] [USB Device Cleanup]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'USB Device Cleanup'..."
if /i %DRY_RUN%==no (
	if /i '%PROCESSOR_ARCHITECTURE%'=='AMD64' (
		if %VERBOSE%==yes "stage_1_tempclean\usb_cleanup\DriveCleanup x64.exe" -t -n
		"stage_1_tempclean\usb_cleanup\DriveCleanup x64.exe" -n >> "%LOGPATH%\%LOGFILE%" 2>NUL
	) else (
		if %VERBOSE%==yes "stage_1_tempclean\usb_cleanup\DriveCleanup x86.exe" -t -n
		"stage_1_tempclean\usb_cleanup\DriveCleanup x86.exe" -n >> "%LOGPATH%\%LOGFILE%" 2>NUL
	)
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Clear Windows event logs
title Tron v%TRON_VERSION% [stage_1_tempclean] [Clear Windows Event Logs]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Clear Windows event logs'..."
if /i %SKIP_EVENT_LOG_CLEAR%==yes (
	call functions\log.bat "%CUR_DATE% %TIME% ! SKIP_EVENT_LOG_CLEAR ^(-se^) set. Skipping Event Log clear."
	goto skip_event_log_clear
)
call functions\log.bat "%CUR_DATE% %TIME%     Saving logs to "%BACKUPS%" first..."
:: Backup all logs first. Redirect error output to NUL (2>nul) because due to the way WMI formats lists, there is
:: a trailing blank line which messes up the last iteration of the FOR loop, but we can safely suppress errors from it
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %DRY_RUN%==no for /f %%i in ('%WMIC% nteventlog where "filename like '%%'" list instance') do %WMIC% nteventlog where "filename like '%%%%i%%'" backupeventlog "%BACKUPS%\%%i.evt" >> "%LOGPATH%\%LOGFILE%" 2>NUL
ENDLOCAL DISABLEDELAYEDEXPANSION
call functions\log.bat "%CUR_DATE% %TIME%     Backups done, now clearing..."
:: Clear the logs
if /i %DRY_RUN%==no %WMIC% nteventlog where "filename like '%%'" cleareventlog >> "%LOGPATH%\%LOGFILE%"
:: Alternate Vista-and-up only method
:: if /i %DRY_RUN%==no for /f %%x in ('wevtutil el') do wevtutil cl "%%x" 2>NUL

call functions\log.bat "%CUR_DATE% %TIME%    Done."
:skip_event_log_clear



:: JOB: Clear Windows Update cache
title Tron v%TRON_VERSION% [stage_1_tempclean] [Clear Windows Update cache]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Clear Windows Update cache'..."
if /i %DRY_RUN%==no (
	:: Allow us to start the service in Safe Mode
	if %SAFE_MODE%==yes reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\WUAUSERV" /ve /t reg_sz /d Service /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	net stop WUAUSERV >> "%LOGPATH%\%LOGFILE%" 2>&1
	if exist %windir%\softwaredistribution\download rmdir /s /q %windir%\softwaredistribution\download >> "%LOGPATH%\%LOGFILE%" 2>&1
	net start WUAUSERV >> "%LOGPATH%\%LOGFILE%" 2>&1
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."



:: Stage complete
call functions\log.bat "%CUR_DATE% %TIME%   stage_1_tempclean complete."

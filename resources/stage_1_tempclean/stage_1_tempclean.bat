:: Purpose:       Sub-script containing all commands for Tron's Stage 1: Temp Cleanup stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
::                3. Called from tron.bat. If you try to run this script directly it will error out
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.0 + Add job to delete duplicate files found in the "Downloads" folder of each user
::                1.0.2 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.1 * ccleaner:  Add note explaining that CCleaner doesn't support verbose output if VERBOSE (-v) flag is used. Thanks to /u/Forcen
::                      * bleachbit: Improve Bleachbit support for VERBOSE (-v) flag, now displays ALL Bleachbit output to console and log file if -v is used. Thanks to /u/Forcen
::                      - misc:      Remove unecessary window title reset after Tempfilecleanup
::                1.0.0 + Initial write
@echo off



:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_1_SCRIPT_VERSION=1.1.0
set STAGE_1_SCRIPT_DATE=2016-01-26

:: Quick check to see if we inherited the appropriate variables from Tron.bat
if /i "%LOGFILE%"=="" (
	color 0c
	echo.
	echo  ERROR
	echo.
	echo   You cannot run this script directly - it must be
	echo   called from Tron.bat during a Tron run.
	echo.
	echo   Navigate to Tron's root folder and execute Tron.bat
	echo.
	pause
	exit /b 1
)



::::::::::::::::::::::::
:: STAGE 1: TEMPCLEAN :: // Begin jobs
::::::::::::::::::::::::
call functions\log.bat "%CUR_DATE% %TIME%   stage_1_tempclean begin..."


:: JOB: Clean Internet Explorer; Windows built-in method. Only works on Vista and up
if %WIN_VER_NUM% geq 6.0 (
	title Tron v%SCRIPT_VERSION% [stage_1_tempclean] [Clean Internet Explorer]
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Clean Internet Explorer'..."
	if /i %DRY_RUN%==no rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)


:: JOB: TempFileCleanup.bat
title Tron v%SCRIPT_VERSION% [stage_1_tempclean] [TempFileCleanup]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'TempFileCleanup'..."
if /i %DRY_RUN%==no call stage_1_tempclean\tempfilecleanup\TempFileCleanup.bat >> "%LOGPATH%\%LOGFILE%" 2>NUL
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: CCLeaner
title Tron v%SCRIPT_VERSION% [stage_1_tempclean] [CCleaner]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'CCleaner'..."
if /i %DRY_RUN%==no (
	if /i %VERBOSE%==yes call functions\log.bat "%CUR_DATE% %TIME% !  VERBOSE (-v) output requested but not supported by CCleaner."
	start "" /wait stage_1_tempclean\ccleaner\ccleaner.exe /auto>> "%LOGPATH%\%LOGFILE%" 2>NUL
	ping 127.0.0.1 -n 15 >NUL
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: BleachBit
title Tron v%SCRIPT_VERSION% [stage_1_tempclean] [BleachBit]
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


:: JOB: Delete duplicate files in the "Downloads" folder for each user
title Tron v%SCRIPT_VERSION% [stage_1_tempclean] [Clean Duplicate Downloads]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Clean duplicate files from Download folders'..."
if %DRY_RUN%==no(
	REM We use Tron's USERPROFILES variable to account for possibilty of C:\Users (Vista and up) or C:\Documents and Settings (XP/2003)
	dir "%USERPROFILES%\" /B > %TEMP%\userlist.txt
	for /f "tokens=* delims= " %%i in (%TEMP%\userlist.txt) do (
		if %VERBOSE%==yes (
			stage_1_tempclean\finddupe\finddupe.exe -v "%USERPROFILES%\%%i\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
			stage_1_tempclean\finddupe\finddupe.exe -v "%USERPROFILES%\%%i\My Douments\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
			stage_1_tempclean\finddupe\finddupe.exe -v -del "%USERPROFILES%\%%i\Downloads\**" 2>NUL
			stage_1_tempclean\finddupe\finddupe.exe -v -del "%USERPROFILES%\%%i\My Documents\Downloads\**" 2>NUL
		) else (
			stage_1_tempclean\finddupe\finddupe.exe -del "%USERPROFILES%\%%i\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
			stage_1_tempclean\finddupe\finddupe.exe -del "%USERPROFILES%\%%i\My Documents\Downloads\**" >> "%LOGPATH%\%LOGFILE%" 2>&1
		)
	)
	del /s /q "%TEMP%\userlist.txt" >nul 2>&1
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: USB Device Cleanup
title Tron v%SCRIPT_VERSION% [stage_1_tempclean] [USB Device Cleanup]
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
title Tron v%SCRIPT_VERSION% [stage_1_tempclean] [Clear Windows Event Logs]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Clear Windows event logs'..."
if /i %SKIP_EVENT_LOG_CLEAR%==yes (
	call functions\log.bat "%CUR_DATE% %TIME% ! SKIP_EVENT_LOG_CLEAR ^(-se^) set. Skipping Event Log clear."
	goto skip_event_log_clear
	)
call functions\log.bat "%CUR_DATE% %TIME%    Saving logs to "%BACKUPS%" first..."
:: Backup all logs first. Redirect error output to NUL (2>nul) because due to the way WMI formats lists, there is
:: a trailing blank line which messes up the last iteration of the FOR loop, but we can safely suppress errors from it
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %DRY_RUN%==no for /f %%i in ('%WMIC% nteventlog where "filename like '%%'" list instance') do %WMIC% nteventlog where "filename like '%%%%i%%'" backupeventlog "%BACKUPS%\%%i.evt" >> "%LOGPATH%\%LOGFILE%" 2>NUL
ENDLOCAL DISABLEDELAYEDEXPANSION
call functions\log.bat "%CUR_DATE% %TIME%    Backups done, now clearing..."
:: Clear the logs
if /i %DRY_RUN%==no %WMIC% nteventlog where "filename like '%%'" cleareventlog >> "%LOGPATH%\%LOGFILE%"
:: Alternate Vista-and-up only method
:: if /i %DRY_RUN%==no for /f %%x in ('wevtutil el') do wevtutil cl "%%x" 2>NUL

call functions\log.bat "%CUR_DATE% %TIME%    Done."
:skip_event_log_clear



:: JOB: Clear Windows Update cache
title Tron v%SCRIPT_VERSION% [stage_1_tempclean] [Clear Windows Update cache]
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

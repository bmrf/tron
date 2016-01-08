:: Purpose:       Sub-script containing all commands for Tron's Stage 4: Repair stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
::                3. Called from tron.bat. If you try to run this script directly it will error out
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.5 - Remove redundant Dism image store cleanup (code is also run in Stage 5)
::                1.0.4 - Move Windows 7/8/8.1 telemetry removal code into separate sub-script (similar to Win10)
::                1.0.3 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                      ! Fix incorrect file name in call to "disable_telemetry_registry_entries.reg"
::                1.0.2 ! Add KB3112336 to list of Win7/8/8.1 updates to block (was mistakenly not added)
::                1.0.1 + Add KB3112336 to list of Win7/8/8.1 updates to remove. Thanks to /u/Lolor-arros
::                      + Enable telemetry removal on Server 2012 platforms
::                      ! Remove redundant DRY_RUN check in call to Win10 telemetry removal script
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_4_SCRIPT_VERSION=1.0.5
set STAGE_4_SCRIPT_DATE=2016-01-08

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



:::::::::::::::::::::
:: STAGE 4: Repair :: // Begin jobs
:::::::::::::::::::::
call functions\log.bat "%CUR_DATE% %TIME%   stage_4_repair begin..."


:: JOB: Check Windows Image for corruptions before running SFC (Windows 8 and up)
title TRON v%SCRIPT_VERSION% [stage_4_repair] [DISM Check]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Dism Windows image check (Win8 and up)'..."
if /i %DRY_RUN%==yes goto skip_dism_image_check

:: Read WIN_VER and run the scan if we're on 8 or above
if %WIN_VER_NUM% geq 6.2 (
	Dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%LOGPATH%\tron_dism.log"
	type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	del /f /q "%LOGPATH%\tron_dism.log"
)

:: If we detect errors try to repair them
if /i not %ERRORLEVEL%==0 (
	title TRON v%SCRIPT_VERSION% [stage_3_disinfect] [DISM Repair]
	if %WIN_VER_NUM% geq 6.2 (
		call functions\log.bat "%CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair..."
		:: Add /LimitAccess flag to this command to prevent connecting to Windows Update for replacement files
		Dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%LOGPATH%\tron_dism.log"
		type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	) else (
		call functions\log.bat "%CUR_DATE% %TIME%    DISM: No image corruption detected."
	)
)

:skip_dism_image_check
call functions\log.bat "%CUR_DATE% %TIME%    Done."



:: JOB: Reset registry permissions
title TRON v%SCRIPT_VERSION% [stage_4_repair] [Reset registry permissions]
if /i %SKIP_REGPERMS_RESET%==no (
	call functions\log.bat "%CUR_DATE% %TIME%    Resetting registry permissions..."
	call functions\log.bat "%CUR_DATE% %TIME%    THIS WILL TAKE A LONG TIME - BE PATIENT"
	call functions\log.bat "%CUR_DATE% %TIME%    You can ignore errors here. Raw logs saved to "%RAW_LOGS%\""
	if /i %DRY_RUN%==no call "stage_4_repair\reset_registry_and_file_permissions\reset_registry_permissions.bat"
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
) else (
	call functions\log.bat "%CUR_DATE% %TIME% !  SKIP_REGPERMS_RESET (-srr) set. Skipping registry and file permissions reset"
)


:: JOB: Reset filesystem permissions
title TRON v%SCRIPT_VERSION% [stage_4_repair] [Reset filesystem permissions]
if /i %SKIP_FILEPERMS_RESET%==no (
	call functions\log.bat "%CUR_DATE% %TIME%    Resetting filesystem permissions in the Windows system directory..."
	call functions\log.bat "%CUR_DATE% %TIME%    THIS WILL TAKE A LONG TIME - BE PATIENT"
	call functions\log.bat "%CUR_DATE% %TIME%    You can ignore errors here. Raw logs saved to "%RAW_LOGS%\""
	if /i %DRY_RUN%==no call "stage_4_repair\reset_registry_and_file_permissions\reset_file_permissions.bat"
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
) else (
	call functions\log.bat "%CUR_DATE% %TIME% !  SKIP_FILEPERMS_RESET (-sfr) set. Skipping registry and file permissions reset"
)


:: JOB: System File Checker (SFC) scan
title TRON v%SCRIPT_VERSION% [stage_4_repair] [SFC Scan]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'System File Checker'..."
if /i %DRY_RUN%==yes goto skip_sfc
:: Basically this says "If OS is NOT XP or 2003, go ahead and run system file checker." We skip SFC on XP/2k3 because it forces a reboot
if %WIN_VER_NUM% geq 6.0 %SystemRoot%\System32\sfc.exe /scannow
%SystemRoot%\System32\findstr.exe /c:"[SR]" %SystemRoot%\logs\cbs\cbs.log>> "%LOGPATH%\%LOGFILE%" 2>NUL
:skip_sfc
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: chkdsk the system drive
title TRON v%SCRIPT_VERSION% [stage_4_repair] [chkdsk]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'chkdsk'..."
call functions\log.bat "%CUR_DATE% %TIME%    Checking %SystemDrive% for errors..."
:: Run a read-only scan and look for errors. Schedule a scan at next reboot if errors found
if /i %DRY_RUN%==no %SystemRoot%\System32\chkdsk.exe %SystemDrive%
if /i not %ERRORLEVEL%==0 (
	call functions\log.bat "%CUR_DATE% %TIME% !  Errors found on %SystemDrive%. Scheduling full chkdsk at next reboot."
	if /i %DRY_RUN%==no fsutil dirty set %SystemDrive%
) else (
	call functions\log.bat "%CUR_DATE% %TIME%    No errors found on %SystemDrive%. Skipping full chkdsk at next reboot."
	)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Kill Microsoft telemetry (user tracking)
title TRON v%SCRIPT_VERSION% [stage_4_repair] [kill-telemetry]
if /i %SKIP_TELEMETRY_REMOVAL%==yes (
	call functions\log.bat "%CUR_DATE% %TIME% !  SKIP_TELEMETRY_REMOVAL (-str) set. Disabling Microsoft telemetry (user tracking) instead of purging"
	REM Only disable telemetry, don't completely purge it
	reg import stage_4_repair\purge_windows_telemetry\disable_telemetry_registry_entries.reg >nul 2>&1
	regedit /S stage_4_repair\purge_windows_telemetry\disable_telemetry_registry_entries.reg >nul 2>&1
	goto skip_telem_removal
)

:: Windows 10 version
if /i "%WIN_VER:~0,9%"=="Windows 1" (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Kill Microsoft telemetry (user tracking) (Win10)'..."
	call functions\log.bat "%CUR_DATE% %TIME% !  THIS TAKES A WHILE - BE PATIENT!!"
	if /i %DRY_RUN%==no call stage_4_repair\purge_windows_telemetry\purge_windows_10_telemetry.bat >> "%LOGPATH%\%LOGFILE%" 2>NUL
	call functions\log.bat "%CUR_DATE% %TIME%    Done. Enjoy your privacy."
)

:: Spawn temporary variable to check for Win7 and 8. Ugly but at least it works
set RUN_7_OR_8_TELEM=no
if /i "%WIN_VER:~0,9%"=="Windows 7" set RUN_7_OR_8_TELEM=yes
if /i "%WIN_VER:~0,9%"=="Windows 8" set RUN_7_OR_8_TELEM=yes
if /i "%WIN_VER:~0,19%"=="Windows Server 2012" set RUN_7_OR_8_TELEM=yes
if /i "%RUN_7_OR_8_TELEM%"=="yes" (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Kill Microsoft telemetry (user tracking) (Win7/8/8.1)'..."
	if /i %DRY_RUN%==no call stage_4_repair\purge_windows_telemetry\purge_windows_7-8-81_telemetry.bat >> "%LOGPATH%\%LOGFILE%" 2>NUL
	call functions\log.bat "%CUR_DATE% %TIME%    Done. Enjoy your privacy."
)
:skip_telem_removal


:: JOB: Network repair (minor)
title TRON v%SCRIPT_VERSION% [stage_4_repair] [winsock_reset]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Network repair'..."
if /i %DRY_RUN%==no (
	ipconfig /flushdns >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Below command probably not necessary, but just in case there are dodgy static ARP entries
	netsh interface ip delete arpcache >> "%LOGPATH%\%LOGFILE%" 2>&1
	netsh winsock reset catalog >> "%LOGPATH%\%LOGFILE%" 2>&1
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Repair file extensions
title TRON v%SCRIPT_VERSION% [stage_4_repair] [repair file extensions]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Repair file extensions'..."
if /i %DRY_RUN%==no (
	setlocal
	call stage_4_repair\repair_file_extensions\repair_file_extensions.bat
	endlocal
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."





:: Stage complete
call functions\log.bat "%CUR_DATE% %TIME%   stage_4_repair complete."

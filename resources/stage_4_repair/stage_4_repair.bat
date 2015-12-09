:: Purpose:       Sub-script containing all commands for Tron's Stage 4: Repair stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
::                3. Called from tron.bat. If you try to run this script directly it will error out
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.3 - Remove interal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.2 ! Add KB3112336 to list of Win7/8/8.1 updates to block (was mistakenly not added)
::                1.0.1 + Add KB3112336 to list of Win7/8/8.1 updates to remove. Thanks to /u/Lolor-arros
::                      + Enable telemetry removal on Server 2012 platforms
::                      ! Remove redundant DRY_RUN check in call to Win10 telemetry removal script
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_4_SCRIPT_VERSION=1.0.3
set STAGE_4_SCRIPT_DATE=2015-12-09

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
if "%WIN_VER:~0,19%"=="Windows Server 2012" (
	Dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%LOGPATH%\tron_dism.log"
	type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	del /f /q "%LOGPATH%\tron_dism.log"
	)
if "%WIN_VER:~0,9%"=="Windows 8" (
	Dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%LOGPATH%\tron_dism.log"
	type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	del /f /q "%LOGPATH%\tron_dism.log"
	)
if "%WIN_VER:~0,9%"=="Windows 1" (
	Dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%LOGPATH%\tron_dism.log"
	type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	del /f /q "%LOGPATH%\tron_dism.log"
	)

:: If we detect errors try to repair them
if /i not %ERRORLEVEL%==0 (
	title TRON v%SCRIPT_VERSION% [stage_3_disinfect] [DISM Repair]
	if "%WIN_VER:~0,19%"=="Windows Server 2012" (
		call functions\log.bat "%CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair..."
		:: Add /LimitAccess flag to this command to prevent connecting to Windows Update for replacement files
		Dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%LOGPATH%\tron_dism.log"
		type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
		)
	if "%WIN_VER:~0,9%"=="Windows 8" (
		call functions\log.bat "%CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair..."
		:: Add /LimitAccess flag to this command to prevent connecting to Windows Update for replacement files
		Dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%LOGPATH%\tron_dism.log"
		type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
		)
	if "%WIN_VER:~0,9%"=="Windows 1" (
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
if /i not "%WIN_VER:~0,9%"=="Microsoft" %SystemRoot%\System32\sfc.exe /scannow
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

:: Spawn temporary variable to check for Win7 and 8. Ugly hack but at least it works
set RUN_7_OR_8_TELEM=no
if /i "%WIN_VER:~0,9%"=="Windows 7" set RUN_7_OR_8_TELEM=yes
if /i "%WIN_VER:~0,9%"=="Windows 8" set RUN_7_OR_8_TELEM=yes
if /i "%WIN_VER:~0,19%"=="Windows Server 2012" set RUN_7_OR_8_TELEM=yes
if /i "%RUN_7_OR_8_TELEM%"=="yes" (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Kill Microsoft telemetry (user tracking) (Win7/8/8.1)'..."
	if /i %DRY_RUN%==no (
		REM :::::::::::::::::::::::::::::::::::::::::::::
		REM UPDATES

		REM Windows Update Client for Windows 8.1 and Windows Server 2012 R2: December 2015
		REM Reported here: https://www.reddit.com/r/TronScript/comments/3v592f/tron_v800_20151202_modularize_entire_project_see/cxl6rko
		wusa /uninstall /kb:3112336 /quiet /norestart

		REM Compatibility update for Windows 8.1 and Windows 8
		wusa /uninstall /kb:2976978 /quiet /norestart

		REM New update client for Windows 8/8.1
		wusa /uninstall /kb:3083711 /quiet /norestart

		REM Update that enables you to upgrade from Windows 7 to a later version of Windows
		wusa /uninstall /kb:2990214 /quiet /norestart

		REM Customer Experience and Diagnostic Telemetry-related updates
		wusa /uninstall /kb:3022345 /quiet /norestart
		wusa /uninstall /kb:3068708 /quiet /norestart
		wusa /uninstall /kb:3080149 /quiet /norestart
		wusa /uninstall /kb:3021917 /quiet /norestart

		REM Adds telemetry points to consent.exe in Windows 8.1 and Windows 7
		wusa /uninstall /kb:3075249 /quiet /norestart
		wusa /uninstall /kb:3015249 /quiet /norestart

		REM "Get Windows 10" nagger in Windows 8.1 and Windows 7 SP1
		wusa /uninstall /kb:3035583 /quiet /norestart

		REM Enable upgrade from Windows 8.1 to Windows 10
		wusa /uninstall /kb:3044374 /quiet /norestart

		REM Compatibility update for Windows 7 (is a scanner)
		wusa /uninstall /kb:2977759 /quiet /norestart

		REM Compatibility update for Windows 7
		wusa /uninstall /kb:2952664 /quiet /norestart
		
		REM New update client for Windows 7
		wusa /uninstall /kb:3083710 /quiet /norestart
		
		REM Description of the update for Windows Activation Technologies
		wusa /uninstall /kb:971033 /quiet /norestart

		REM Descriptions not available, update was pulled by Microsoft
		wusa /uninstall /kb:2902907 /quiet /norestart
		wusa /uninstall /kb:2922324 /quiet /norestart


		REM :::::::::::::::::::::::::::::::::::::::::::::
		REM BLOCK BAD UPDATES
		start "" /b /wait cscript.exe "stage_4_repair\purge_windows_telemetry\block_windows_updates.vbs" 2977759 2952664 2976978 3083710 3083711 2990214 3022345 3068708 3080149 3021917 3075249 3015249 3035583 3044374 971033 2902907 2922324 3112336


		REM :::::::::::::::::::::::::::::::::::::::::::::
		REM SCHEDULED TASKS
		schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
		schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
		schtasks /delete /F /TN "\Microsoft\Windows\Autochk\Proxy"
		schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
		schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
		schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
		schtasks /delete /F /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
		schtasks /delete /F /TN "\Microsoft\Windows\PI\Sqm-Tasks"
		schtasks /delete /F /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
		schtasks /delete /F /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting"


		REM :::::::::::::::::::::::::::::::::::::::::::::
		REM SERVICES
		REM Diagnostic Tracking
		sc stop Diagtrack >nul 2>&1
		sc delete Diagtrack >nul 2>&1

		REM Remote Registry (disable only)
		sc config remoteregistry start= disabled >nul 2>&1
		sc stop remoteregistry >nul 2>&1


		REM :::::::::::::::::::::::::::::::::::::::::::::
		REM MISC
		REM Kill pending tracking reports
		if not exist %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\ mkdir %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\
		echo. > %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl 2>NUL
		echo y|cacls.exe "%programdata%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /d SYSTEM 2>NUL

		REM Disable telemetry via master registry key
		reg import stage_4_repair\purge_windows_telemetry\purge_windows_10_telemetry_registry_entries.reg >nul 2>&1
		regedit /S stage_4_repair\purge_windows_telemetry\purge_windows_10_telemetry_registry_entries.reg >nul 2>&1

	)
call functions\log.bat "%CUR_DATE% %TIME%    Done. Enjoy your privacy."
)

:skip_telem_removal


:: JOB: DISM cleanup. After this no updates or service packs can be uninstalled (new updates/SP's can still be installed)
if /i not "%WIN_VER:~0,9%"=="Microsoft" (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Run DISM cleanup against unused binaries'..."
	if /i %DRY_RUN%==no Dism /Online /Cleanup-Image /StartComponentCleanup /Logpath:"%LOGPATH%\tron_dism.log"
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)


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

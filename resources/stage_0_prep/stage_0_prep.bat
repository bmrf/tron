:: Purpose:       Sub-script containing all commands for Tron's Stage 0: Prep stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is recommended but not required
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.2.3 / Reduce output from Metro App dump since we don't care about the fully-qualified App name
::                1.2.2 + Add job to dump Metro apps on Windows 8+ and up. This is so they can be sent via -udl switch if used
::                1.2.1 + Add job to (temporarily) stop the Themes service
::                1.2.0 * Improve standalone execution support. Can now execute by double-clicking icon vs. manually executing via CLI
::                1.1.9 + Add killing of HelpPane.exe if it exists
::                1.1.8 * Preface WMIC calls with null input to ensure the pipe is closed, fixes issue with WMI hanging on WinXP machines. Thanks to github:salsifis
::                        Relevant pull: https://github.com/bmrf/tron/pull/108
::                1.1.7 * Update date/time logging functions to use new log_with_date.bat. Thanks to /u/DudeManFoo
::                1.1.6 * script: Update script to support standalone execution
::                      ! erunt:  Don't wait for ERUNT to finish; launch it, wait 15 seconds, then continue. This is to prevent getting stalled on a rare error which causes a popup msg on Win10
::                1.1.5 * Update NTP server commands with ,0x8 suffix to send standard client requests vs. symmetric active requests. Thanks to /u/webtroter
::                1.1.4 ! Don't attempt to create System Restore point on Windows 10 systems if in Safe Mode. Why? Because Win10 blocks system restore point creation in Safe Mode. Why? Because Microsoft
::                      * Add 500ms delay (0.5 seconds) to screenshot capture. Also capture contents of all monitors now vs. only the primary one
::                1.1.3 + Add job to capture desktop screenshot to the RAW_LOGS folder. Sometimes but a visual of the system is helpful so we capture one just in case some icons change
::                1.1.2 ! Prefix siv32x and siv64x commands with "start" instead of calling directly. Should prevent entire script stalling if SIV hangs. Thanks to /u/gameoftome
::                1.1.1 * Enable executing siv64x.exe instead of siv32x.exe on 64-bit systems. Thanks to /u/gameoftomes
::                1.1.0 ! Fix bug in GUID dump. Was trying to include the current time in the file name instead of the date
::                      ! Wrap all references to %TEMP% in quotes. Should help prevent crashing on systems where the username contains special characters (e.g. "&")
::                1.0.9 / Minor log message change
::                1.0.8 + Add task to perform a GUID dump prior to running. This way users will always have the GUID's of the system as they existed before Tron ran. Should make it easier to submit the lists for review
::                1.0.7 * Add check for .NET 3.5 installation before attempting to run McAfee Stinger, since it relies on it
::                1.0.6 * Expand 24 hour cooldown timer removal on system restore snapshots to include Windows 7/Server 2008 R2
::                1.0.5 + Disable 24 hour cooldown timer on System Restore point creation (added by Microsoft in Windows 8 and up)
::                      ! Win8 and up: Enable System Restore prior to attempting to create restore point, since it's disabled-by-default (wtf??)
::                1.0.4 ! Wrap references to WIN_VER in quotes to prevent crashing on Home OS's
::                1.0.3 / Rename folder created during registry backup from "tron_registry_backup" to "registry_backup"
::                1.0.2 ! Fix typo in log message
::                1.0.1 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_0_SCRIPT_VERSION=1.2.3
set STAGE_0_SCRIPT_DATE=2018-03-05

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	pushd "%~dp0"
	pushd ..
	
	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)



:::::::::::::::::::
:: STAGE 0: PREP :: // Begin jobs
:::::::::::::::::::
call functions\log_with_date.bat "  stage_0_prep begin..."


:: JOB: Temporarily stop "Themes" service
title Tron v%TRON_VERSION% [stage_0_prep] [stop_themes]
call functions\log_with_date.bat "   Temporarily stopping Themes service..."
if /i %DRY_RUN%==no (
	net stop themes >nul 2>&1
)
call functions\log_with_date.bat "   Done."

:: JOB (silent): Kill helppane.exe if it's running (Usually on Win10+ in safe mode)
taskkill /f /im HelpPane.exe /t >nul 2>&1


:: JOB: Create pre-run Restore Point so we can roll the system back if anything blows up
::      On Windows 7 and up, we have to manually enable System Restore (it's disabled by default...why?? because Microsoft)
::      as well as remove the 24 hour cooldown timer they brilliantly added in Windows 8 which prevents doing things like
::      creating a before/after restore point pair. Why? Because Microsoft. We also skip creating the restore point in Windows
::      10 if we're in Safe Mode, because it refuses to work in Safe Mode. Why? Because Microsoft.
title Tron v%TRON_VERSION% [stage_0_prep] [Create Restore Point]
if /i "%WIN_VER:~0,9%"=="Windows 1" (
	if  %SAFE_MODE%==yes (
		call functions\log_with_date.bat "!  WARNING: Windows 10 blocks creating SysRestore points in Safe Mode. Why? Because Microsoft."
		call functions\log_with_date.bat "   Skipping restore point creation. Reboot to Normal mode and re-run Tron if you absolutely require one."
		goto :skip_restore_point_creation
	)
)

if %WIN_VER_NUM% geq 6.0 (
	REM Win7 and up only: Remove the cooldown timer (via reg command) and enable System Restore
	if %WIN_VER_NUM% geq 6.1 (
		if /i %DRY_RUN%==no (
			reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /t reg_dword /v SystemRestorePointCreationFrequency /d 0 /f >nul 2>&1
			powershell "Enable-ComputerRestore -Drive "%SystemDrive%" | Out-Null" >> "%LOGPATH%\%LOGFILE%" 2>&1
		)
	)
  
	REM Create the restore point
	echo "%WIN_VER%" | findstr /i /c:"server" >NUL || (
		call functions\log_with_date.bat "   Creating pre-run Restore Point..."
		if /i %DRY_RUN%==no powershell "Checkpoint-Computer -Description 'TRON v%TRON_VERSION%: Pre-run checkpoint' | Out-Null" >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
call functions\log_with_date.bat "   OK."
)
:skip_restore_point_creation


:: JOB: Capture screenshot of the desktop. First hide all windows, then capture the screenshot, then restore all windows
title Tron v%TRON_VERSION% [stage_0_prep] [screenshot]
call functions\log_with_date.bat "   Saving desktop screenshot to "%RAW_LOGS%"..."
if /i %DRY_RUN%==no (
	stage_0_prep\capture_screenshot\nircmdc.exe sendkeypress rwin+m
	stage_0_prep\capture_screenshot\nircmdc.exe cmdwait 500 savescreenshotfull "%RAW_LOGS%\tron_%COMPUTERNAME%_pre-run_screenshot_%DTS:~0,12%.png"
	stage_0_prep\capture_screenshot\nircmdc.exe sendkeypress rwin+shift+m
)
call functions\log_with_date.bat "   Done."


:: JOB: rkill
title Tron v%TRON_VERSION% [stage_0_prep] [rkill]
call functions\log_with_date.bat "   Launch job 'rkill'..."
call functions\log_with_date.bat "   If script stalls 20 min or more, kill solitaire64.exe and solitaire.exe with Task Manager"
if /i %DRY_RUN%==no (
	stage_0_prep\rkill\solitaire.exe -s -l "%TEMP%\tron_rkill.log" -w "stage_0_prep\rkill\rkill_process_whitelist.txt"
	type "%TEMP%\tron_rkill.log" >> "%LOGPATH%\%LOGFILE%" 2>NUL
	del "%TEMP%\tron_rkill.log" 2>NUL
	if exist "%HOMEDRIVE%\%HOMEPATH%\Desktop\Rkill.txt" del "%HOMEDRIVE%\%HOMEPATH%\Desktop\Rkill.txt" 2>NUL
)
call functions\log_with_date.bat "   Done."


:: JOB: Get pre-run system state (installed programs, complete file list)
title Tron v%TRON_VERSION% [stage_0_prep] [Analyze System State]
call functions\log_with_date.bat "   Generating pre-run system profile..."
if /i %DRY_RUN%==no (
	:: Get list of installed programs
	if %PROCESSOR_ARCHITECTURE%==x86 start stage_0_prep\log_tools\siv\siv32x.exe -save=[software]="%RAW_LOGS%\installed-programs-before.txt"
	if %PROCESSOR_ARCHITECTURE%==AMD64 start stage_0_prep\log_tools\siv\siv64x.exe -save=[software]="%RAW_LOGS%\installed-programs-before.txt"
	:: Get list of all files on system
	stage_0_prep\log_tools\everything\everything.exe -create-filelist "%RAW_LOGS%\filelist-before.txt" %SystemDrive%
)
call functions\log_with_date.bat "   Done."


:: JOB: Do a GUID dump before kicking everything off
title Tron v%TRON_VERSION% [stage_0_prep] [GUID dump]
call functions\log_with_date.bat "   Dumping GUID list to "%RAW_LOGS%"..."
if /i %DRY_RUN%==no <NUL %WMIC% product get identifyingnumber,name,version /all > "%RAW_LOGS%\GUID_dump_%COMPUTERNAME%_%CUR_DATE%.txt" 2>NUL
call functions\log_with_date.bat "   Done."


:: JOB: Do a Metro app dump before kicking everything off (Win8+ only)
title Tron v%TRON_VERSION% [stage_0_prep] [Metro app dump]
if /i %WIN_VER_NUM% geq 6.2 (
	call functions\log_with_date.bat "   Dumping Metro app list to "%RAW_LOGS%"..."
	if /i %DRY_RUN%==no powershell "Get-AppxPackage -AllUsers | Select Name" > "%RAW_LOGS%\Metro_app_dump_%COMPUTERNAME%_%CUR_DATE%.txt" 2>NUL
	call functions\log_with_date.bat "   Done."
)


:: JOB: Disable system sleep and screen saver
if /i %DRY_RUN%==no (
	call functions\log_with_date.bat "   Launch job 'Temporarily disable system sleep and screensaver'..."
	title Tron v%TRON_VERSION% [stage_0_prep] [DisableSleepandScreensaver]
	:: Kill off any running Caffeine instances first (can happen if resuming from an interrupted run)
	taskkill /im "caffeine.exe" >nul 2>&1
	start "" stage_0_prep\caffeine\caffeine.exe -noicon
	call functions\log_with_date.bat "   Done."
)


:: JOB: ProcessKiller
title Tron v%TRON_VERSION% [stage_0_prep] [ProcessKiller]
call functions\log_with_date.bat "   Launch Job 'ProcessKiller'..."
pushd stage_0_prep\processkiller
if /i %DRY_RUN%==no start "" /wait ProcessKiller.exe /silent
popd
call functions\log_with_date.bat "   Done."


:: JOB: Set system clock via NTP
title Tron v%TRON_VERSION% [stage_0_prep] [SetSystemClock]
call functions\log_with_date.bat "   Launch Job 'Set system clock via NTP'..."
if /i %DRY_RUN%==no (
	:: Make sure time service is started, also force us to allow starting it in Safe Mode
	if %SAFE_MODE%==yes reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\w32time" /ve /t reg_sz /d Service /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config w32time start= auto >> "%LOGPATH%\%LOGFILE%" 2>&1
	net stop w32time >> "%LOGPATH%\%LOGFILE%" 2>&1
	w32tm /config /syncfromflags:manual /manualpeerlist:"2.pool.ntp.org,0x8 time.windows.com,0x8 time.nist.gov,0x8" >> "%LOGPATH%\%LOGFILE%" 2>&1
	net start w32time >> "%LOGPATH%\%LOGFILE%" 2>&1
	w32tm /resync /nowait >> "%LOGPATH%\%LOGFILE%" 2>&1
)
call functions\log_with_date.bat "   Done."


:: JOB: Check WMI and repair if necessary
title Tron v%TRON_VERSION% [stage_0_prep] [Check+Fix WMI]
call functions\log_with_date.bat "   Launch job 'Check WMI health'..."
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %DRY_RUN%==no (
	<NUL %WMIC% timezone >NUL
	if /i not !ERRORLEVEL!==0 (
		call functions\log_with_date.bat "!  WMI appears to be broken. Calling WMI repair sub-script."
		call functions\log_with_date.bat "              This will take time, please be patient..."
		call stage_0_prep\repair_wmi\repair_wmi.bat
	)
)
ENDLOCAL DISABLEDELAYEDEXPANSION
call functions\log_with_date.bat "   Done."


:: JOB: Backup registry
title Tron v%TRON_VERSION% [stage_0_prep] [Registry Backup]
call functions\log_with_date.bat "   Launch job 'Back up registry' to "%LOGPATH%"..."
if /i %DRY_RUN%==no (
	start "" stage_0_prep\backup_registry\erunt.exe "%LOGPATH%\registry_backup" /noconfirmdelete /noprogresswindow
	ping 127.0.0.1 -n 15 >nul
)
call functions\log_with_date.bat "   Done."


:: JOB: McAfee Stinger
:: First check if .NET 3.5 is installed, since Stinger relies on it
reg query "hklm\software\microsoft\net framework setup\ndp\v3.5" /v Install 2>nul | %FIND% /i "0x1" >nul 2>&1
if %ERRORLEVEL%==0 (
	title Tron v%TRON_VERSION% [stage_0_prep] [McAfee Stinger]
	call functions\log_with_date.bat "   Launch job 'McAfee Stinger'..."
	call functions\log_with_date.bat "   Stinger doesn't support text logs, saving HTML log to "%RAW_LOGS%\""
	if /i %DRY_RUN%==no start /wait stage_0_prep\mcafee_stinger\stinger32.exe --GO --SILENT --PROGRAM --REPORTPATH="%RAW_LOGS%" --DELETE
	call functions\log_with_date.bat "   Done."
) else (
	call functions\log_with_date.bat "   System is missing .NET 3.5, skipping McAfee Stinger scan."
)


:: JOB: TDSS Killer
title Tron v%TRON_VERSION% [stage_0_prep] [TDSS Killer]
call functions\log_with_date.bat "   Launch job 'TDSS Killer'..."
if /i %DRY_RUN%==no (
	"stage_0_prep\tdss_killer\TDSSKiller.exe" -l "%TEMP%\tdsskiller.log" -silent -tdlfs -dcexact -accepteula -accepteulaksn
	:: Dump TDSSKiller log into the main Tron log
	type "%TEMP%\tdsskiller.log" >> "%LOGPATH%\%LOGFILE%"
	del "%TEMP%\tdsskiller.log" 2>NUL
)
call functions\log_with_date.bat "   Done."


:: JOB: Purge oldest shadow copies
title Tron v%TRON_VERSION% [stage_0_prep] [Purge oldest shadow copies]
:: Only versions of Windows older than Vista had "Microsoft" as the first part of their title, so if
:: we don't find "Microsoft" in the first 9 characters we can safely assume we're not on XP/2k3
:: Then we check for Vista, because vssadmin on Vista doesn't support deleting old copies. Sigh.
if %WIN_VER_NUM% geq 6.1 (
	call functions\log_with_date.bat "   Launch job 'Purge oldest Shadow Copy set (Win7 and up)'..."
	if /i %DRY_RUN%==no (
		:: Force allow us to start VSS service in Safe Mode
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\VSS" /ve /t reg_sz /d Service /f >nul 2>&1
		net start VSS >nul 2>&1
		vssadmin delete shadows /for=%SystemDrive% /oldest /quiet >nul 2>&1
	)
	call functions\log_with_date.bat "   Done."
)


:: JOB: Reduce SysRestore space
title Tron v%TRON_VERSION% [stage_0_prep] [System Restore Modifications]
call functions\log_with_date.bat "   Reducing max allowed System Restore space to 7%%%% of disk..."
if /i %DRY_RUN%==no (
	%SystemRoot%\System32\reg.exe add "\\%COMPUTERNAME%\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DiskPercent /t REG_DWORD /d 00000007 /f>> "%LOGPATH%\%LOGFILE%"
	%SystemRoot%\System32\reg.exe add "\\%COMPUTERNAME%\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Cfg" /v DiskPercent /t REG_DWORD /d 00000007 /f>> "%LOGPATH%\%LOGFILE%"
)
call functions\log_with_date.bat "   Done."




:: Stage complete
call functions\log_with_date.bat "  stage_0_prep complete."

:: Purpose:       Sub-script containing all commands for Tron's Stage 0: Prep stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
::                3. Called from tron.bat. If you try to run this script directly it will error out
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.3 + Add job to capture desktop screenshot to the RAW_LOGS folder. Sometimes but a visual of the system is helpful so we capture one just in case some icons change
::                1.1.2 ! Prefix siv32x and siv64x commands with "start" instead of calling directly. Should prevent entire script stalling if SIV hangs. Thanks to /u/gameoftome
::                1.1.1 * Enable executing siv64x.exe instead of siv32x.exe on 64-bit systems. Thanks to /u/gameoftomes
::                1.1.0 ! Fix bug in GUID dump. Was trying to include the current time in the file name instead of the date
::                      ! Wrap all references to %TEMP% in quotes. Should help prevent crashing on systems where the username contains special characters (e.g. "&")
::                1.0.9 / Minor log message change
::                1.0.8 + Add task to perform a GUID dump prior to running. This way users will always have the GUID's of the system as they existed before Tron ran. Should make it easier to submit the lists for review
::                1.0.7 * Add check for .NET 3.5 installation before attempting to run McAfee Stinger, since it relies on it
::                1.0.6 * Expand 24 hour cooldown timer removal on system restore snapshots to include Windows 7/Server 2008 R2
::                1.0.5 + Remove 24 hour cooldown timer on System Restore point creation (added by Microsoft in Windows 8 and up)
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
set STAGE_0_SCRIPT_VERSION=1.1.3
set STAGE_0_SCRIPT_DATE=2016-10-27

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



:::::::::::::::::::
:: STAGE 0: PREP :: // Begin jobs
:::::::::::::::::::
call functions\log.bat "%CUR_DATE% %TIME%   stage_0_prep begin..."


:: JOB: Create pre-run Restore Point so we can roll the system back if anything blows up
::      On Windows 7 and up, we have to manually enable System Restore (it's disabled by default...why?? because Microsoft)
::      as well as remove the 24 hour cooldown timer they brilliantly added in Windows 8 which prevents doing things like
::      creating a before/after restore point pair. Why? Because Microsoft.
title Tron v%SCRIPT_VERSION% [stage_0_prep] [Create Restore Point]
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
		call functions\log.bat "%CUR_DATE% %TIME%    Creating pre-run Restore Point..."
		if /i %DRY_RUN%==no powershell "Checkpoint-Computer -Description 'TRON v%SCRIPT_VERSION%: Pre-run checkpoint' | Out-Null" >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
)
call functions\log.bat "%CUR_DATE% %TIME%    OK."


:: JOB: Capture screenshot of the desktop. First hide all windows, then capture the screenshot, then restore all windows
title Tron v%SCRIPT_VERSION% [stage_0_prep] [screenshot]
call functions\log.bat "%CUR_DATE% %TIME%    Saving screenshot of the desktop to "%RAW_LOGS%"..."
	stage_0_prep\capture_screenshot\nircmdc.exe sendkeypress rwin+m
	stage_0_prep\capture_screenshot\nircmdc.exe savescreenshot "%RAW_LOGS%\tron_pre-run_screenshot_%DTS:~0,12%.png"
	stage_0_prep\capture_screenshot\nircmdc.exe sendkeypress rwin+shift+m
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: rkill
title Tron v%SCRIPT_VERSION% [stage_0_prep] [rkill]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'rkill'..."
call functions\log.bat "%CUR_DATE% %TIME%    If script stalls 20 min or more, kill explorer64.exe and explorer.exe with Task Manager"
if /i %DRY_RUN%==no (
	stage_0_prep\rkill\explorer.exe -s -l "%TEMP%\tron_rkill.log" -w "stage_0_prep\rkill\rkill_process_whitelist.txt"
	type "%TEMP%\tron_rkill.log" >> "%LOGPATH%\%LOGFILE%" 2>NUL
	del "%TEMP%\tron_rkill.log" 2>NUL
	if exist "%HOMEDRIVE%\%HOMEPATH%\Desktop\Rkill.txt" del "%HOMEDRIVE%\%HOMEPATH%\Desktop\Rkill.txt" 2>NUL
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Get pre-run system state (installed programs, complete file list)
title Tron v%SCRIPT_VERSION% [stage_0_prep] [Analyze System State]
call functions\log.bat "%CUR_DATE% %TIME%    Generating pre-run system profile..."
if /i %DRY_RUN%==no (
	:: Get list of installed programs
	if %PROCESSOR_ARCHITECTURE%==x86 start stage_0_prep\log_tools\siv\siv32x.exe -save=[software]="%RAW_LOGS%\installed-programs-before.txt"
	if %PROCESSOR_ARCHITECTURE%==AMD64 start stage_0_prep\log_tools\siv\siv64x.exe -save=[software]="%RAW_LOGS%\installed-programs-before.txt"
	:: Get list of all files on system
	stage_0_prep\log_tools\everything\everything.exe -create-filelist "%RAW_LOGS%\filelist-before.txt" %SystemDrive%
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Do a GUID dump before kicking everything off to make it easier for users to submit them if they forgot to do it before running Tron
title Tron v%SCRIPT_VERSION% [stage_0_prep] [GUID dump]
call functions\log.bat "%CUR_DATE% %TIME%    Dumping GUID list to "%RAW_LOGS%"..."
if /i %DRY_RUN%==no %WMIC% product get identifyingnumber,name,version /all > "%RAW_LOGS%\GUID_dump_%COMPUTERNAME%_%CUR_DATE%.txt" 2>NUL
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Disable system sleep and screen saver
if /i %DRY_RUN%==no (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Temporarily disable system sleep and screensaver'..."
	title Tron v%SCRIPT_VERSION% [stage_0_prep] [DisableSleepandScreensaver]
	:: Kill off any running Caffeine instances first (can happen if resuming from an interrupted run)
	taskkill /im "caffeine.exe" > nul 2>&1
	start "" stage_0_prep\caffeine\caffeine.exe -noicon
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)


:: JOB: ProcessKiller
title Tron v%SCRIPT_VERSION% [stage_0_prep] [ProcessKiller]
call functions\log.bat "%CUR_DATE% %TIME%    Launch Job 'ProcessKiller'..."
pushd stage_0_prep\processkiller
if /i %DRY_RUN%==no start "" /wait ProcessKiller.exe /silent
popd
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Set system clock via NTP
title Tron v%SCRIPT_VERSION% [stage_0_prep] [SetSystemClock]
call functions\log.bat "%CUR_DATE% %TIME%    Launch Job 'Set system clock via NTP'..."
if /i %DRY_RUN%==no (
	:: Make sure time service is started, also force us to allow starting it in Safe Mode
	if %SAFE_MODE%==yes reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\w32time" /ve /t reg_sz /d Service /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config w32time start= auto >> "%LOGPATH%\%LOGFILE%" 2>&1
	net stop w32time >> "%LOGPATH%\%LOGFILE%" 2>&1
	w32tm /config /syncfromflags:manual /manualpeerlist:"2.pool.ntp.org time.windows.com time.nist.gov" >> "%LOGPATH%\%LOGFILE%" 2>&1
	net start w32time >> "%LOGPATH%\%LOGFILE%" 2>&1
	w32tm /resync /nowait >> "%LOGPATH%\%LOGFILE%" 2>&1
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Check WMI and repair if necessary
title Tron v%SCRIPT_VERSION% [stage_0_prep] [Check+Fix WMI]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Check WMI health'..."
setlocal enabledelayedexpansion
if /i %DRY_RUN%==no (
	%WMIC% timezone >NUL
	if /i not !ERRORLEVEL!==0 (
		call functions\log.bat "%CUR_DATE% %TIME% !  WMI appears to be broken. Calling WMI repair sub-script."
		call functions\log.bat "               This will take time, please be patient..."
		call stage_0_prep\repair_wmi\repair_wmi.bat
	)
)
setlocal disabledelayedexpansion
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Backup registry
title Tron v%SCRIPT_VERSION% [stage_0_prep] [Registry Backup]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Back up registry' to "%LOGPATH%"..."
if /i %DRY_RUN%==no stage_0_prep\backup_registry\erunt.exe "%LOGPATH%\registry_backup" /noconfirmdelete /noprogresswindow
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: McAfee Stinger
:: First check if .NET 3.5 is installed, since Stinger relies on it
reg query "hklm\software\microsoft\net framework setup\ndp\v3.5" /v Install 2>nul | %FIND% /i "0x1" >nul 2>&1
if %ERRORLEVEL%==0 (
	title Tron v%SCRIPT_VERSION% [stage_0_prep] [McAfee Stinger]
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'McAfee Stinger'..."
	call functions\log.bat "%CUR_DATE% %TIME%    Stinger doesn't support text logs, saving HTML log to "%RAW_LOGS%\""
	if /i %DRY_RUN%==no start /wait stage_0_prep\mcafee_stinger\stinger32.exe --GO --SILENT --PROGRAM --REPORTPATH="%RAW_LOGS%" --DELETE
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
) else (
	call functions\log.bat "%CUR_DATE% %TIME%    System is missing .NET 3.5, skipping McAfee Stinger scan."
)


:: JOB: TDSS Killer
title Tron v%SCRIPT_VERSION% [stage_0_prep] [TDSS Killer]
call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'TDSS Killer'..."
if /i %DRY_RUN%==no (
	"stage_0_prep\tdss_killer\TDSSKiller.exe" -l "%TEMP%\tdsskiller.log" -silent -tdlfs -dcexact -accepteula -accepteulaksn
	:: Dump TDSSKiller log into the main Tron log
	type "%TEMP%\tdsskiller.log" >> "%LOGPATH%\%LOGFILE%"
	del "%TEMP%\tdsskiller.log" 2>NUL
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Purge oldest shadow copies
title Tron v%SCRIPT_VERSION% [stage_0_prep] [Purge oldest shadow copies]
:: Only versions of Windows older than Vista had "Microsoft" as the first part of their title, so if
:: we don't find "Microsoft" in the first 9 characters we can safely assume we're not on XP/2k3
:: Then we check for Vista, because vssadmin on Vista doesn't support deleting old copies. Sigh.
if %WIN_VER_NUM% geq 6.1 (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job: 'Purge oldest Shadow Copy set (Win7 and up)'..."
	if /i %DRY_RUN%==no (
		:: Force allow us to start VSS service in Safe Mode
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\VSS" /ve /t reg_sz /d Service /f >nul 2>&1
		net start VSS >nul 2>&1
		vssadmin delete shadows /for=%SystemDrive% /oldest /quiet >nul 2>&1
	)
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)


:: JOB: Reduce SysRestore space
title Tron v%SCRIPT_VERSION% [stage_0_prep] [System Restore Modifications]
call functions\log.bat "%CUR_DATE% %TIME%    Reducing max allowed System Restore space to 7%%%% of disk..."
if /i %DRY_RUN%==no (
	%SystemRoot%\System32\reg.exe add "\\%COMPUTERNAME%\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DiskPercent /t REG_DWORD /d 00000007 /f>> "%LOGPATH%\%LOGFILE%"
	%SystemRoot%\System32\reg.exe add "\\%COMPUTERNAME%\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Cfg" /v DiskPercent /t REG_DWORD /d 00000007 /f>> "%LOGPATH%\%LOGFILE%"
)
call functions\log.bat "%CUR_DATE% %TIME%    Done."




:: Stage complete
call functions\log.bat "%CUR_DATE% %TIME%   stage_0_prep complete."

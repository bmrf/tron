:: Purpose:       Sub-script containing all commands for Tron's Stage 4: Repair stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is recommended but not required
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.2.7 + telemetry:   Add additional nvidia telemetry tasks to kill
::                1.2.6 * improvement: Use %REG% instead of relative calls. Helps on systems with a broken PATH variable
::                1.2.5 * improvement: Improve standalone execution support. Can now execute by double-clicking icon vs. manually executing via CLI
::                1.2.4 ! bugfix:      DISM cleanup wasn't skipped even if the -sdc switch was used. Thanks to u/HittingSmoke
::                1.2.3 * logging:     Update date/time logging functions to use new log_with_date.bat. Thanks to /u/DudeManFoo
::                1.2.2 * improvement: Update script to support standalone execution
::                1.2.1 + feature:     Add job 'Disable NVIDIA telemetry.' Thanks /u/TootZoot
::                1.2.0 - feature:     Remove job "Reset Filesystem permissions" and associated files
::                      - feature:     Remove job "Reset Registry permissions" and associated files
::                1.1.1 + feature:     Add job "MSI Installer Cleanup." Uses the Microsoft 'msizap' utility to remove orphaned MSI installer files from the cache
::                1.1.0 * improvement: Embed contents of 'disable_windows_10_upgrade_registry_entries.reg' directly into script. Removes dependence on an external .reg file
::                1.0.9 / misc:        Rename call to 'reset_file_permissions.bat' to 'reset_filesystem_permissions.bat' to reflect new file name
::                      / logging:     Remove mention about ignoring errors due to now-suppressed subinacl output
::                1.0.8 ! bugfix:      Remove redirection to log file on statements calling telemetry removal scripts. These scripts handle their own logging so this
::                                     was incorrectly suppressing all output
::                1.0.7 + feature:     Add job "Disable Windows 10 Upgrade" which flips all the registry bits to disable Win10 upgrade nagger stuff on Win7/8/8.1. Thanks to /u/ichbinsilky
::                      / misc:        Rename "purge_windows_telemetry" folder to "disable_windows_telemetry"
::                1.0.6 ! bugfix:dism: Numerous bugs with DISM check and repair, due to bad ERRORLEVEL check it would fail to trigger repairs when they were required
::                1.0.5 - cleanup:     Remove redundant DISM image store cleanup (move to Stage 5)
::                1.0.4 - cleanup:     Move Windows 7/8/8.1 telemetry removal code into separate sub-script
::                1.0.3 * logging:     Switch from internal log function to Tron's external logging function. Thanks to github:nemchik
::                      ! bugfix:      Fix incorrect file name in call to "disable_telemetry_registry_entries.reg"
::                1.0.2 ! improvement: Add KB3112336 to list of Win7/8/8.1 updates to block (was mistakenly not added)
::                1.0.1 + improvement: Add KB3112336 to list of Win7/8/8.1 updates to remove. Thanks to /u/Lolor-arros
::                      + feature:     Enable telemetry removal on Server 2012 platforms
::                      ! bugfix:      Remove redundant DRY_RUN check in call to Win10 telemetry removal script
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_4_SCRIPT_VERSION=1.2.7
set STAGE_4_SCRIPT_DATE=2018-10-02

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	pushd "%~dp0"
	pushd ..
	
	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)



:::::::::::::::::::::
:: STAGE 4: Repair :: // Begin jobs
:::::::::::::::::::::
call functions\log_with_date.bat "  stage_4_repair begin..."


:: JOB: MSI installer cleanup
title Tron v%TRON_VERSION% [stage_4_repair] [MSI installer cleanup]
call functions\log_with_date.bat "   Cleaning up orphaned MSI cache files..."
if /i %VERBOSE%==yes (
	if /i %DRY_RUN%==no stage_4_repair\msi_cleanup\msizap.exe G!
) else (
	if /i %DRY_RUN%==no stage_4_repair\msi_cleanup\msizap.exe G! >> "%LOGPATH%\%LOGFILE%" 2>&1
)
call functions\log_with_date.bat "   Done."


:: JOB: Check Windows Image for corruptions (Windows 8 and up)
if %WIN_VER_NUM% geq 6.2 (
	title Tron v%TRON_VERSION% [stage_4_repair] [DISM Check]
	
	:: Check if we were requested to skip DISM cleanup
	if /i %SKIP_DISM_CLEANUP%==yes (
		call functions\log_with_date.bat "!  SKIP_DISM_CLEANUP (-sdc) set. Skipping DISM cleanup."
		goto skip_dism_cleanup
		)
	
	call functions\log_with_date.bat "   Launch job 'DISM Windows image check'..."
	if /i %DRY_RUN%==yes goto skip_dism_cleanup
	dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%RAW_LOGS%\dism_check.log"
)

:: If we detect errors try to repair them
if not %ERRORLEVEL%==0 (
	title Tron v%TRON_VERSION% [stage_4_repair] [DISM Repair]
	if %WIN_VER_NUM% geq 6.2 (
		call functions\log_with_date.bat "!  DISM: Image corruption detected. Attempting repair..."
		:: Add /LimitAccess flag to this command to prevent connecting to Windows Update for replacement files
		dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%RAW_LOGS%\dism_repair.log"
	)
) else (
	call functions\log_with_date.bat "   DISM: No image corruption detected."
)

:: Add the DISM logs to the main Tron log
if %WIN_VER_NUM% gtr 6.2 (
	call functions\log_with_date.bat "   Compiling DISM logs into main Tron log..."
	if exist "%RAW_LOGS%\dism_check.log" type "%RAW_LOGS%\dism_check.log" >> "%LOGPATH%\%LOGFILE%"
	if exist "%RAW_LOGS%\dism_repair.log" type "%RAW_LOGS%\dism_repair.log" >> "%LOGPATH%\%LOGFILE%"
)

:skip_dism_cleanup
call functions\log_with_date.bat "   Done."


:: JOB: System File Checker (SFC) scan
title Tron v%TRON_VERSION% [stage_4_repair] [SFC Scan]
call functions\log_with_date.bat "   Launch job 'System File Checker'..."
if /i %DRY_RUN%==no (
	REM Basically this says "If OS is NOT XP or 2003, go ahead and run system file checker." We skip SFC on XP/2k3 because it forces a reboot
	if %WIN_VER_NUM% geq 6.0 (
		%SystemRoot%\System32\sfc.exe /scannow
		%SystemRoot%\System32\findstr.exe /c:"[SR]" %SystemRoot%\logs\cbs\cbs.log>> "%LOGPATH%\%LOGFILE%" 2>NUL
	)
)
call functions\log_with_date.bat "   Done."


:: JOB: chkdsk the system drive
title Tron v%TRON_VERSION% [stage_4_repair] [chkdsk]
call functions\log_with_date.bat "   Launch job 'chkdsk'..."
call functions\log_with_date.bat "   Checking %SystemDrive% for errors..."
:: Run a read-only scan and look for errors. Schedule a scan at next reboot if errors found
if /i %DRY_RUN%==no %SystemRoot%\System32\chkdsk.exe %SystemDrive%
if /i not %ERRORLEVEL%==0 (
	call functions\log_with_date.bat "!  Errors found on %SystemDrive%. Scheduling full chkdsk at next reboot."
	if /i %DRY_RUN%==no fsutil dirty set %SystemDrive%
) else (
	call functions\log_with_date.bat "   No errors found on %SystemDrive%. Skipping full chkdsk at next reboot."
)
call functions\log_with_date.bat "   Done."


:: JOB: Remove Microsoft telemetry (user tracking)
title Tron v%TRON_VERSION% [stage_4_repair] [disable MS telemetry]
if /i %SKIP_TELEMETRY_REMOVAL%==yes (
	call functions\log_with_date.bat "!  SKIP_TELEMETRY_REMOVAL (-str) set. Disabling instead of removing."
	REM Only disable telemetry, don't completely purge it
	if %VERBOSE%==yes (
		REM GPO options to disable telemetry
		%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
		%REG% add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
		
		REM Keylogger
		%REG% add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
		
		REM Wifi sense, a nasty one privacy-wise
		%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisensecredshared" /t REG_DWORD /d "0" /f
		%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisenseopen" /t REG_DWORD /d "0" /f
		
		REM Windows Defender sample reporting
		%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "spynetreporting" /t REG_DWORD /d "0" /f
		%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "submitsamplesconsent" /t REG_DWORD /d "0" /f
		
		REM SkyDrive
		%REG% add "HKLM\software\policies\microsoft\windows\skydrive" /v "disablefilesync" /t REG_DWORD /d "1" /f
		
		REM Kill OneDrive from hooking into Explorer even when disabled
		%REG% add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
		%REG% add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
		
		REM DiagTrack service
		%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
		
		REM "WAP Push Message Routing Service"
		%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
	) else (
		REM GPO options to disable telemetry
		%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		%REG% add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		
		REM Keylogger
		%REG% add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		
		REM Wifi sense, a nasty one privacy-wise
		%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisensecredshared" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisenseopen" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		
		REM Windows Defender sample reporting
		%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "spynetreporting" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "submitsamplesconsent" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		
		REM SkyDrive
		%REG% add "HKLM\software\policies\microsoft\windows\skydrive" /v "disablefilesync" /t REG_DWORD /d "1" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		
		REM Kill OneDrive from hooking into Explorer even when disabled
		%REG% add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		%REG% add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		
		REM DiagTrack service
		%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		
		REM "WAP Push Message Routing Service"
		%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
	goto skip_telem_removal
)

:: Windows 10 version
if /i "%WIN_VER:~0,9%"=="Windows 1" (
	call functions\log_with_date.bat "   Launch job 'Kill Microsoft telemetry (user tracking) (Win10)'..."
	call functions\log_with_date.bat "   THIS TAKES A WHILE - BE PATIENT!!"
	if /i %DRY_RUN%==no call stage_4_repair\disable_windows_telemetry\purge_windows_10_telemetry.bat
	call functions\log_with_date.bat "   Done. Enjoy your privacy."
)

:: Spawn temporary variable to check for Win7 and 8. Ugly hack but at least it works
set RUN_7_OR_8_TELEM=no
if /i "%WIN_VER:~0,9%"=="Windows 7" set RUN_7_OR_8_TELEM=yes
if /i "%WIN_VER:~0,9%"=="Windows 8" set RUN_7_OR_8_TELEM=yes
if /i "%WIN_VER:~0,19%"=="Windows Server 2012" set RUN_7_OR_8_TELEM=yes
if /i "%RUN_7_OR_8_TELEM%"=="yes" (
	call functions\log_with_date.bat "   Launch job 'Kill Microsoft telemetry (user tracking) (Win7/8/8.1)'..."
	if /i %DRY_RUN%==no call stage_4_repair\disable_windows_telemetry\purge_windows_7-8-81_telemetry.bat
	call functions\log_with_date.bat "   Done. Enjoy your privacy."
)
:skip_telem_removal


:: JOB: Disable Windows 10 Upgrade (Win7/8/8.1 only)
:: Just re-use the temp variable from the above job since it will tell us whether we're on 7 or 8
if /i "%RUN_7_OR_8_TELEM%"=="yes" (
	call functions\log_with_date.bat "   Launch job 'Disable Windows 10 Upgrade nagger (Win7/8/8.1)'..."
	if /i %DRY_RUN%==no ( 
		REM Only disable telemetry, don't completely purge it
		REM "DisableOSUpgrade" disables/hides the taskbar app to prevent users from making a reservation and upgrading manually
		REM  However, user can still get updated automatically with KB3146449
		%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /t REG_DWORD /d "1" /f
	
		REM "AllowOSUpgrade" is the holy grail that will actually prevent the upgrade from happening, even if Win10 is sitting in the update folder. 
		REM You can make a reservation, download it via updates, enable this option and windows will never automatically/manually update to Win10.
		REM "ReservationsAllowed" is a little more heavy handed and may not be neccessary. This actually prevents the user (or windows) from making a
		REM reservation and downloading the upgrade even remotely possible...but the upgrade can still happen if it's already downloaded. Usually done 
		REM on new installs as an extra preventative measure. The default value for this is 2. Setting it to 0 makes reservations impossible.
		%REG% add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "AllowOSUpgrade" /t REG_DWORD /d "0" /f
		%REG% add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" /t REG_DWORD /d "0" /f
	
		REM "DisableGWX" is the upgrade nagger/popup
		%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GWX" /v "DisableGWX" /t REG_DWORD /d "1" /f
	)
	call functions\log_with_date.bat "   Done."
)


:: JOB: Disable NVIDIA telemetry (sigh...)
title Tron v%TRON_VERSION% [stage_4_repair] [disable NVIDIA telemetry]
call functions\log_with_date.bat "   Launch job 'Disable NVIDIA telemetry'..."
if /i %DRY_RUN%==no (
	schtasks /delete /F /TN "\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\NvProfileUpdaterOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\NvProfileUpdaterDaily_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\NvTmRepCR1_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\NvTmRepCR2_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\NvTmRepCR3_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" >> "%LOGPATH%\%LOGFILE%" 2>&1
)
call functions\log_with_date.bat "   Done."


:: JOB: Network repair (minor)
title Tron v%TRON_VERSION% [stage_4_repair] [winsock_reset]
call functions\log_with_date.bat "   Launch job 'Network repair'..."
if /i %DRY_RUN%==no (
	ipconfig /flushdns >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Below command probably not necessary, but just in case there are dodgy static ARP entries
	netsh interface ip delete arpcache >> "%LOGPATH%\%LOGFILE%" 2>&1
	netsh winsock reset catalog >> "%LOGPATH%\%LOGFILE%" 2>&1
)
call functions\log_with_date.bat "   Done."


:: JOB: Repair file extensions
title Tron v%TRON_VERSION% [stage_4_repair] [repair file extensions]
call functions\log_with_date.bat "   Launch job 'Repair file extensions'..."
if /i %DRY_RUN%==no (
	setlocal
	call stage_4_repair\repair_file_extensions\repair_file_extensions.bat
	endlocal
)
call functions\log_with_date.bat "   Done."





:: Stage complete
call functions\log_with_date.bat "  stage_4_repair complete."

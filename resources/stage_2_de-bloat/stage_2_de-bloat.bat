:: Purpose:       Sub-script containing all commands for Tron's Stage 2: De-bloat. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
::                3. Called from tron.bat. If you try to run this script directly it will error out
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.3.2 ! Fix time logging on de-bloat (use !time! instead of %time%). Thanks to github: refnil
::                1.3.1 * Preface WMIC calls with null input to ensure the pipe is closed, fixes issue with WMI hanging on WinXP machines. Thanks to github:salsifis
::                        Relevant pull: https://github.com/bmrf/tron/pull/108
::                1.3.0 * Add new tick counter during GUID debloat that dumps progress to a log in the RAW_LOGS folder. 
::                        This way if the script hangs we can see which entry it hung on. Thanks to /u/madbomb122
::                      - Comment out the lines sent to console that explain where the de-bloat files are located
::                        Just cluttered up the screen and people who really want to customize Tron will be reading the readme/instructions anyway
::                1.2.9 - Remove OneDrive sync disabling fix; no longer necessary due to finding the solution related to O&OShutUp10's changes made in Stage 4. Thanks to /u/Gyllius
::                1.2.8 * Update date/time logging functions to use new log_with_date.bat. Thanks to /u/DudeManFoo
::                1.2.7 * script: Update script to support standalone execution
::                1.2.6 ! Fix for previous fix (shakes head at self), was accidentally disabling OneDrive sync instead of ENABLING. Thanks to /u/Gyllius
::                1.2.5 ! Fix for accidental disabling of OneDrive file sync in cases where OneDrive isn't removed. Thanks to /u/Gyllius
::                1.2.4 ! Fix for incorrect removal of OneDrive even when script was told not to. Was due to mistaken use of USERPROFILES variable instead of USERPROFILE, which threw off the in-use detection. Thanks to everyone who reported and helped troubleshoot this
::                      + Add additional OneDrive in-use check. Now detect if a custom folder has been set; if so, we automatically skip removal
::                1.2.3 ! Fix stall bug in by_guid loops due to missing /f switch on reg add statement. Thanks to /u/IAintShootinMister and /u/ SlimBackwater for reporting
::                1.2.2 + Add resetting of UpdateExeVolatile during by_guid debloat, another measure to help prevent blocked uninstallations due to pending reboot
::                1.2.1 / Change PendingFileRenameOperations_%COMPUTERNAME%_export.txt to PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt
::                1.2.0 + Add checks for existence of PendingFileRenameOperations registry entries. Entries here are responsible for the errors about not being able to remove a program due to needing a reboot.
::                        If we detect entries in this key, we export them to RAW_LOGS and then delete them before continuing on. This should allow Tron to continue removing programs without waiting for a reboot
::                1.1.7 * Significantly improve robustness of OneDrive checks. OneDrive now only removed if system is Win10, folder exists in default location, and is empty. Thanks to /u/ranger_dood
::                1.1.6 * Suppress output of by_name debloat by default, and add support for VERBOSE switch to affect this step and display output to the console instead of log file
::                1.1.5 / Swap order of Toolbar/BHO removal and by_name removal. Performing uninstalls by_name often forces a reboot so we do it last
::                      ! Correct a reference to USERPROFILE that should've used Tron's USERPROFILES instead
::                1.1.4 ! OneDrive: Minor logging fix, suppress an irrelevant error message
::                1.1.3 ! Safe Mode: Fix MSIServer service not starting in Safe Mode, which prevented removal of most "classic" programs. Thanks to https://github.com/Verteiron
::                1.1.2 * Metro: Add missing log message about use of -m switch
::                      ! OneDrive: Add missing check to skip actions if DRY_RUN (-d) switch is used
::                1.1.1 / OneDrive: Move code out of Metro debloat section into its own job
::                      * OneDrive: Don't remove OneDrive if any files are present in the default OneDrive folder
::                      * OneDrive: Disable links in Explorer side pane via registry keys instead of deleting the keys entirely
::                      * Metro: Fine-tune version checking to ensure we only run on Windows 8/8.1 and Windows 10
::                      - Metro: Remove redundant "net start AppXSVC" line prior to Metro de-bloat code
::                      ! Metro: Only set registry flag to allow starting AppX service in Safe Mode if the system is already in Safe Mode
::                1.1.0 * Move embedded Win10 metro de-bloat code to PowerShell sub-scripts
::                1.0.1 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_2_SCRIPT_VERSION=1.3.2
set STAGE_2_SCRIPT_DATE=2017-09-14

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	pushd ..

	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)


:::::::::::::::::::::::
:: STAGE 2: De-Bloat :: // Begin jobs
:::::::::::::::::::::::
call functions\log_with_date.bat "  stage_2_de-bloat begin..."

:: JOB: Enable MSIServer service if we're in Safe Mode. This allows us to perform uninstallation of "classic" (non-"Modern") Windows programs
if /i %SAFE_MODE%==yes (
	title Tron v%TRON_VERSION% [stage_2_de-bloat] [Enable MSIServer]
	call functions\log_with_date.bat "   Enabling MSIServer to allow program removal in Safe Mode..."
	if /i %DRY_RUN%==no (
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\MSIServer" /ve /t reg_sz /d Service /f >nul 2>&1
		net start MSIServer >nul 2>&1
	)
	call functions\log_with_date.bat "   Done."
)


:: JOB: Remove crapware programs, phase 1: by specific GUID
title Tron v%TRON_VERSION% [stage_2_de-bloat] [Remove bloatware by GUID]
call functions\log_with_date.bat "   Attempt junkware removal: Phase 1 (by specific GUID)..."
	:: Calculate how many GUIDs we're searching for
	set GUID_TOTAL=0
	set TICKER=1
	for /f %%i in ('findstr /R /N "^.*" stage_2_de-bloat\oem\programs_to_target_by_GUID.txt ^| FIND /C ":"') do set GUID_TOTAL=%%i
call functions\log_with_date.bat "   If script appears stalled, check the PROGRESS log in the RAW LOGS folder to be sure it is"
call functions\log_with_date.bat "   Searching for %GUID_TOTAL% GUIDs, please wait..."
if /i %DRY_RUN%==no (

	REM Stamp the raw log file that we use to track progress through the list
	echo %CUR_DATE% %TIME%   Attempt junkware removal: Phase 1 ^(by specific GUID^)...>> "%RAW_LOGS%\stage_2_de-bloat_progress_%COMPUTERNAME%_%CUR_DATE%.log" 2>&1

	REM This is required so we can check the errorlevel inside the FOR loop
	SETLOCAL ENABLEDELAYEDEXPANSION

	REM Verbose output check
	if /i %VERBOSE%==yes echo Looking for:

	REM Loop through the file...
	for /f %%i in (stage_2_de-bloat\oem\programs_to_target_by_GUID.txt) do (
		REM  ...and for each line: a. check if it is a comment or SET command and b. perform the removal if not
		if not %%i==:: (
		if not %%i==set (
			if /i %VERBOSE%==yes echo    !TICKER!/%GUID_TOTAL% %%i
			if /i %VERBOSE%==no title Tron v%TRON_VERSION% [GUID: %%i -- !TICKER!/%GUID_TOTAL%]

			start /wait msiexec /qn /norestart /x %%i >> "%LOGPATH%\%LOGFILE%" 2>nul

			REM Reset UpdateExeVolatile. I guess we could check to see if it's flipped, but eh, not really any point since we're just going to reset it anyway
			reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Updates" /v UpdateExeVolatile /d 0 /f >nul 2>&1

			REM Check if the uninstaller added entries to PendingFileRenameOperations. If it did, export the contents, nuke the key value, then continue on
			reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >nul 2>&1
			if !errorlevel!==0 (
				echo Offending GUID: %%i >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations>> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1
				if /i %VERBOSE%==yes echo %CUR_DATE% !TIME! ^^!  Filenames in PendingFileRenameOperations exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted.
				echo %CUR_DATE% !TIME! ^^!  Filenames in PendingFileRenameOperations exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted. >> "%LOGPATH%\%LOGFILE%"
				echo ------------------------------------------------------------------->> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				)

			REM Running tick counter to a separate raw log file so we can see if the script stalls on a particular GUID.
			REM Not displayed to console or dumped to main log to avoid cluttering them up
			echo %CUR_DATE% !TIME!    !TICKER!/%GUID_TOTAL%  %%i>> "%RAW_LOGS%\stage_2_de-bloat_progress_%COMPUTERNAME%_%CUR_DATE%.log" 2>&1
			set /a TICKER=!TICKER! + 1

			)
		)
	)
	ENDLOCAL DISABLEDELAYEDEXPANSION
)
call functions\log_with_date.bat "   Done."



:: JOB: Remove crapware programs, phase 2: unwanted toolbars and BHOs by GUID
title Tron v%TRON_VERSION% [stage_2_de-bloat] [Remove toolbars by GUID]
call functions\log_with_date.bat "   Attempt junkware removal: Phase 2 (toolbars by specific GUID)..."
	:: Calculate how many GUIDs we're searching for
	set GUID_TOTAL=0
	set TICKER=1
	for /f %%i in ('findstr /R /N "^.*" stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt ^| FIND /C ":"') do set GUID_TOTAL=%%i
call functions\log_with_date.bat "   Searching for %GUID_TOTAL% GUIDs, please wait..."
if /i %DRY_RUN%==no (

	REM Stamp the raw log file that we use to track progress through the list
	echo %CUR_DATE% %TIME%   Attempt junkware removal: Phase 2 ^(toolbars by specific GUID^)...>> "%RAW_LOGS%\stage_2_de-bloat_progress_%COMPUTERNAME%_%CUR_DATE%.log" 2>&1

	REM This is required so we can check errorlevel inside the FOR loop
	SETLOCAL ENABLEDELAYEDEXPANSION

	REM Verbose output check
	if /i %VERBOSE%==yes echo Looking for:

	REM Loop through the file...
	for /f %%i in (stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt) do (
		REM  ...and for each line: a. check if it is a comment or SET command and b. perform the removal if not
		if not %%i==:: (
		if not %%i==set (
			if /i %VERBOSE%==yes echo    %%i
			if /i %VERBOSE%==no title Tron v%TRON_VERSION% [GUID: %%i -- !TICKER!/%GUID_TOTAL%]

			start /wait msiexec /qn /norestart /x %%i >> "%LOGPATH%\%LOGFILE%" 2>nul

			REM Reset UpdateExeVolatile. I guess we could check to see if it's flipped, but eh, not really any point since we're just going to reset it anyway
			reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Updates" /v UpdateExeVolatile /d 0 /f >nul 2>&1

			REM Check if the uninstaller added entries to PendingFileRenameOperations if it did, export the contents, nuke the key value, then continue on
			reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >nul 2>&1
			if !errorlevel!==0 (
				echo Offending GUID: %%i >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1
				if /i %VERBOSE%==yes echo  ^^! Detected filenames in PendingFileRenameOperations. Entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted.
				echo  ^^! Detected filenames in PendingFileRenameOperations. Entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted. >> "%LOGPATH%\%LOGFILE%"
				echo ------------------------------------------------------------------- >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				)

			REM Running tick counter to a separate raw log file so we can see if the script stalls on a particular GUID.
			REM Not displayed to console or dumped to main log to avoid cluttering them up
			echo %CUR_DATE% !TIME!    !TICKER!/%GUID_TOTAL%  %%i>> "%RAW_LOGS%\stage_2_de-bloat_progress_%COMPUTERNAME%_%CUR_DATE%.log" 2>&1
			set /a TICKER=!TICKER! + 1

			)
		)
	)
	ENDLOCAL DISABLEDELAYEDEXPANSION
)
call functions\log_with_date.bat "   Done."



:: JOB: Remove crapware programs, phase 3: wildcard by name
title Tron v%TRON_VERSION% [stage_2_de-bloat] [Remove bloatware by name]
call functions\log_with_date.bat "   Attempt junkware removal: Phase 3 (wildcard by name)..."
:: call functions\log_with_date.bat "   Tweak here: \resources\stage_2_de-bloat\oem\programs_to_target_by_name.txt"
if /i %DRY_RUN%==no (

	REM Stamp the raw log file that we use to track progress through the list
	echo %CUR_DATE% %TIME%   Attempt junkware removal: Phase 3 ^(wildcard by name^)...>> "%RAW_LOGS%\stage_2_de-bloat_progress_%COMPUTERNAME%_%CUR_DATE%.log" 2>&1

	REM This is required so we can check errorlevel inside the FOR loop
	SETLOCAL ENABLEDELAYEDEXPANSION

	REM Verbose output check
	if /i %VERBOSE%==yes echo Looking for:

	REM Loop through the file...
	for /f %%i in (stage_2_de-bloat\oem\programs_to_target_by_name.txt) do (
		REM  ...and for each line: a. check if it is a comment or SET command and b. perform the removal if not
		if not %%i==:: (
		if not %%i==set (
			if /i %VERBOSE%==yes echo    %%i
			<NUL "%WMIC%" product where "name like '%%i'" uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"
			REM Check if the uninstaller added entries to PendingFileRenameOperations if it did, export the contents, nuke the key value, then continue on
			reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >nul 2>&1
			if !errorlevel!==0 (
				echo Offending entry: %%i >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1
				if /i %VERBOSE%==yes echo  ^^! Detected filenames in PendingFileRenameOperations. Entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted.
				echo  ^^! Detected filenames in PendingFileRenameOperations. Entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted. >> "%LOGPATH%\%LOGFILE%"
				echo ------------------------------------------------------------------- >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				)

			REM Running tracker a separate raw log file so we can see if the script stalls on a particular entry
			REM Not displayed to console or dumped to main log to avoid cluttering them up
			echo %CUR_DATE% !TIME!    %%i>> "%RAW_LOGS%\stage_2_de-bloat_progress_%COMPUTERNAME%_%CUR_DATE%.log" 2>&1

			)
		)
	)
	ENDLOCAL DISABLEDELAYEDEXPANSION
)
call functions\log_with_date.bat "   Done."



:: JOB: Remove default Metro apps (Windows 8 and up)
title Tron v%TRON_VERSION% [stage_2_de-bloat] [Remove default metro apps]
:: This command will re-install ALL default Windows 10 apps:
:: Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

:: Version checks
if %WIN_VER_NUM% geq 6.2 set TARGET_METRO=yes
if /i %PRESERVE_METRO_APPS%==yes set TARGET_METRO=no
if /i %TARGET_METRO%==yes (
	call functions\log_with_date.bat "   Windows 8 or higher detected, removing OEM Metro apps..."
	:: Force allowing us to start AppXSVC service in Safe Mode. AppXSVC is the MSI Installer equivalent for "apps" (vs. programs)
	if /i %DRY_RUN%==no (
		REM Enable starting AppXSVC in Safe Mode
		if /i "%SAFE_MODE%"=="yes" reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\AppXSVC" /ve /t reg_sz /d Service /f >nul 2>&1
		net start AppXSVC >nul 2>&1
		REM Enable scripts in PowerShell
		powershell "Set-ExecutionPolicy Unrestricted -force 2>&1 | Out-Null"

		REM Windows 8/8.1 version
		if /i "%WIN_VER:~0,9%"=="Windows 8" (
			REM In Windows 8/8.1 we can blast ALL AppX/Metro/"Modern App" apps because unlike in Windows 10, the "core" apps (calculator, paint, etc) aren't in the "modern" format
			powershell "Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"
		)
		REM Windows 10 version
		if /i "%WIN_VER:~0,9%"=="Windows 1" (
			REM Call the external PowerShell scripts to do removal of Microsoft and 3rd party OEM Modern Apps
			powershell -executionpolicy bypass -file ".\stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1"
			powershell -executionpolicy bypass -file ".\stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1"
		)
	)
	call functions\log_with_date.bat "   Done."
)


:: JOB: Remove forced OneDrive integration
:: This is the lazy way to do it but ....I just got back from Antarctica and am feeling tired and lazy so ¯\_(ツ)_/¯

:: This variable is just to detect if we removed OneDrive or not. If we DIDN'T then we use it to make sure file sync isn't disabled
set ONEDRIVE_REMOVED=no

:: 1. Are we on Windows 10? If not, skip removal
if /i not "%WIN_VER:~0,9%"=="Windows 1" goto :skip_onedrive_removal

:: 2. Was the PRESERVE_METRO_APPS (-m) switch used? If so, skip removal
if /i %PRESERVE_METRO_APPS%==yes (
	call functions\log_with_date.bat "!  PRESERVE_METRO_APPS (-m) set. Skipping OneDrive removal."
	goto :skip_onedrive_removal
)

:: 3. Does the folder exist in the default location? If not, skip removal
if not exist "%USERPROFILE%\OneDrive" (
	call functions\log_with_date.bat "!  OneDrive folder doesn't exist in the default location. Skipping removal."
	goto :skip_onedrive_removal
)

:: 4. Does the default folder have any files in it? If so, skip removal
call functions\log_with_date.bat "   Checking if OneDrive is in use, please wait..."
stage_2_de-bloat\onedrive_removal\diruse.exe /q:1 "%USERPROFILE%\OneDrive" >> "%LOGPATH%\%LOGFILE%" 2>&1
if /i not %ERRORLEVEL%==0 (
	call functions\log_with_date.bat "!  OneDrive appears to be in use. Skipping removal."
	goto :skip_onedrive_removal
)

:: 5. Does the registry indicate the OneDrive folder has been moved? If so, skip removal
set OneDrivePath=%USERPROFILE%\OneDrive
for /f "usebackq tokens=3*" %%a IN (`REG QUERY "HKCU\Environment" /v OneDrive 2^>nul`) DO (
    set OneDrivePath=%%a %%b
)
if /i not "%OneDrivePath%"=="%USERPROFILE%\OneDrive" (
	call functions\log_with_date.bat "!  Custom OneDrive folder location detected. Skipping removal."
	goto :skip_onedrive_removal
)

:: If none of the above triggered, we're safe to remove OneDrive
call functions\log_with_date.bat "   OneDrive doesn't appear to be in use. Removing..."
if %DRY_RUN%==no (
	taskkill /f /im OneDrive.exe >> "%LOGPATH%\%LOGFILE%" 2>&1
	ping 127.0.0.1 -n 4 > NUL 2>&1
	%SystemRoot%\System32\OneDriveSetup.exe /uninstall >> "%LOGPATH%\%LOGFILE%" >nul 2>&1
	%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall >> "%LOGPATH%\%LOGFILE%" >nul 2>&1
	ping 127.0.0.1 -n 12 > NUL 2>&1
	takeown /f "%LocalAppData%\Microsoft\OneDrive" /r /d y >> "%LOGPATH%\%LOGFILE%" 2>&1
	icacls "%LocalAppData%\Microsoft\OneDrive" /grant administrators:F /t >> "%LOGPATH%\%LOGFILE%" 2>&1
	rmdir /s /q "%LocalAppData%\Microsoft\OneDrive" >> "%LOGPATH%\%LOGFILE%" 2>&1
	rmdir /s /q "%ProgramData%\Microsoft OneDrive" >> "%LOGPATH%\%LOGFILE%" 2>&1
	rmdir /s /q "%SystemDrive%\OneDriveTemp" >> "%LOGPATH%\%LOGFILE%" 2>&1
	REM These two registry entries disable OneDrive links in the Explorer side pane
	reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	set ONEDRIVE_REMOVED=yes
)


call functions\log_with_date.bat "   Done."
:skip_onedrive_removal


:: Stage complete
call functions\log_with_date.bat "  stage_2_de-bloat complete."

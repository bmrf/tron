:: Purpose:       Sub-script containing all commands for Tron's Stage 2: De-bloat. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.4.6 ! bugfix:      Move OneDrive and SkyDrive (old OneDrive name) disabling code via registry from Stage 4 telemetry disable script into appropriate location in this script. Thanks to u/Tenelia
::                1.4.5 + feature:     Add support for new SKIP_ONEDRIVE_REMOVAL (-sor) switch. Thanks to github:ptrkhh
::                1.4.4 ! bugfix:      Add "delims=" to "for /f %%i" command on Programs to target by name section of debloat, to properly handle program names with spaces in them. Thanks to github:AndrewSav
::                1.4.3 + feature:     Add removal of Dell-branded WildTangent games
::                1.4.2 * improvement: Significantly improve debloat by GUID phases. Now only attempt to remove GUIDs that exist on the system, vs brute-forcing the entire list
::                      + feature:     Add disabling of "Occasionally show suggestions in Start" from purge_windows_10_telemetry.bat script
::                1.4.1 * improvement: Prefix Powershell calls with start /wait to prevent continuing script before they're finished executing. Thanks to github:madbomb122
::                      * improvement: Use %REG% instead of relative calls. Helps on systems with a broken PATH variable
::                      ! bugfix:      Path comparison bug in OneDrive removal
::                1.4.0 ! bugfix:      OneDrive folder-in-use detection due to Windows silently ignoring commands. Thanks to github:rasa
::                1.3.9 * improvement: Expand de-bloat phase 4 to include HP Games
::                1.3.8 - logging:     Disable stamping of stage 2 progress to its own log file, since we have the title bar ticker now
::                1.3.7 * improvement: Improve standalone execution support. Can now execute by double-clicking icon vs. manually executing via CLI
::                      ! bugfix:      Bloatware removal phase 3 (by name), account for spaces in program names. Thanks to github:YodaDaCoda
::                      ! bugfix:      Faulty OneDrive "in use" detection due to existence of desktop.ini in the default folder. Thanks to github:YodaDaCoda
::                1.3.6 + feature:     Add 4th stage to bloat scan, "Auxiliary WildTangent scan" to catch WildTangent games
::                1.3.5 ! bugfix:      Error where "Disable 'howto' tips" would incorrectly execute in dry run mode
::                1.3.4 + feature:     Add reg entry to disable "How-to Tips" appearing on Win8+
::                1.3.3 * improvement: Display current GUID, total # of GUIDs in search, and current line number in the window title during the by_guid search
::                                     sections. Big thanks to github:madbomb122 for contributing this code
::                1.3.2 ! bugfix:      Time logging on de-bloat (use !time! instead of %time%). Thanks to github: refnil
::                1.3.1 ! bugfix:      Preface WMIC calls with null input to ensure the pipe is closed, fixes WMI hanging on WinXP machines. Thanks to github:salsifis
::                1.3.0 * improvement: Add new tick counter during GUID debloat that dumps progress to a log in the RAW_LOGS folder.
::                                     This way if the script hangs we can see which entry it hung on. Thanks to u/madbomb122
::                      - logging:     Comment out the lines sent to console that explain where the de-bloat files are located
::                                     Just cluttered up the screen and people who really want to customize Tron will be reading the instructions anyway
::                1.2.9 - onedrive:    Remove sync disabling fix; no longer necessary due to solution related to O&OShutUp10 in Stage 4. Thanks to u/Gyllius
::                1.2.8 * logging:     Update date/time logging functions to use new log_with_date.bat. Thanks to u/DudeManFoo
::                1.2.7 * improvement: Update script to support standalone execution
::                1.2.6 ! bugfix:      Fix previous erroneous fix, was accidentally disabling OneDrive sync instead of ENABLING. Thanks to u/Gyllius
::                1.2.5 ! bugfix:      Accidental disabling of OneDrive file sync in cases where OneDrive isn't removed. Thanks to u/Gyllius
::                1.2.4 ! bugfix:      Incorrect removal of OneDrive even when script was told not to, due to mistaken use of USERPROFILES instead of USERPROFILE,
::                                     which threw off the in-use detection. Thanks to everyone who reported and helped troubleshoot this
::                      + improvement: Add additional OneDrive in-use check: skip removal if custom folder location has been set
::                1.2.3 ! bugfix:      Stall bug in by_guid loops due to missing /f switch on reg add statement. Thanks to u/IAintShootinMister and u/ SlimBackwater
::                1.2.2 + improvement: Reset UpdateExeVolatile during by_guid debloat, another measure to help prevent blocked uninstallations due to pending reboot
::                1.2.1 / misc:        Change PendingFileRenameOperations_%COMPUTERNAME%_export.txt to PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt
::                1.2.0 + improvement: Check for existence of PendingFileRenameOperations registry entries. Entries here are responsible for errors about not being
::                                     able to remove a program due to needing a reboot. If we detect entries in this key, export to RAW_LOGS and then delete them
::                                     before continuing on. This should allow Tron to continue removing programs without waiting for a reboot
::                1.1.7 * onedrive:    Significantly improve robustness of OneDrive checks. OneDrive now only removed if system is Win10, folder exists in default
::                                     location, and is empty. Thanks to u/ranger_dood
::                1.1.6 * logging:     Suppress output of by_name debloat by default, and add support for VERBOSE switch to this step
::                1.1.5 / improvement: Swap order of Toolbar/BHO removal and by_name removal. Performing uninstalls by_name often forces a reboot so we do it last
::                      ! bugfix:      Correct a reference to USERPROFILE that should've used Tron's USERPROFILES instead
::                1.1.4 ! logging:     Minor logging fix, suppress an irrelevant error message from OneDrive
::                1.1.3 ! bugfix:      Safe Mode: Fix MSIServer service not starting in Safe Mode, which prevented removal of most "classic" programs. Thanks to github:Verteiron
::                1.1.2 * metro:       Add missing log message about use of -m switch
::                      ! onedrive:    Add missing check to skip actions if DRY_RUN (-d) switch is used
::                1.1.1 / onedrive:    Move code out of Metro debloat section into its own job
::                      * onedrive:    Don't remove OneDrive if any files are present in the default OneDrive folder
::                      * onedrive:    Disable links in Explorer side pane via registry keys instead of deleting the keys entirely
::                      * metro:       Fine-tune version checking to ensure we only run on Windows 8/8.1 and Windows 10
::                      - metro:       Remove redundant "net start AppXSVC" line prior to Metro de-bloat code
::                      ! bugfix:      Only set registry switch to allow starting AppX service in Safe Mode if the system is already in Safe Mode
::                1.1.0 * improvement: Move embedded Win10 metro de-bloat code to PowerShell sub-scripts
::                1.0.1 * logging:     Switch from internal log function to Tron's external logging function. Thanks to github:nemchik
::                1.0.0 + Initial write
@echo off



:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_2_SCRIPT_VERSION=1.4.6
set STAGE_2_SCRIPT_DATE=2019-02-28
:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
set STANDALONE=no
if /i "%LOGFILE%"=="" (
	pushd "%~dp0"
	pushd ..

	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat

	set STANDALONE=yes
)
:: Do the GUID dump that some portions below rely on. We have to run the file through the 'type' command to convert the output from UCS-2 Little Endian to UTF-8/ANSI so the for loops below can read it
if %STANDALONE%==yes (
	<NUL %WMIC% product get identifyingnumber,name,version /all > "%TEMP%\wmic_dump_temp.txt" 2>NUL
	type "%TEMP%\wmic_dump_temp.txt" > "%RAW_LOGS%\GUID_dump_%COMPUTERNAME%_%CUR_DATE%.txt" 2>NUL
	del /f /q "%TEMP%\wmic_dump_temp.txt" 2>nul
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
		%REG% add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\MSIServer" /ve /t reg_sz /d Service /f >nul 2>&1
		net start MSIServer >nul 2>&1
	)
	call functions\log_with_date.bat "   Done."
)




:: JOB: Remove bloat, phase 1: by specific GUID
title Tron v%TRON_VERSION% [stage_2_de-bloat] [Remove bloatware by GUID]
call functions\log_with_date.bat "   Attempt junkware removal: Phase 1 (by specific GUID)..."
:: Calculate how many GUIDs we're searching for
set GUID_TOTAL=0
for /f %%i in ('%FINDSTR% /R /N "^{" stage_2_de-bloat\oem\programs_to_target_by_GUID.txt ^| %FIND% /C ":"') do set GUID_TOTAL=%%i
call functions\log_with_date.bat "   Comparing system GUID list against %GUID_TOTAL% blacklisted entries, please wait..."

if /i %DRY_RUN%==no (

	REM This is required so we can check the errorlevel inside the FOR loop
	SETLOCAL ENABLEDELAYEDEXPANSION

	REM Loop through the local GUID dump and see if any GUIDs match from the target list
	for /f "tokens=1" %%a in (%RAW_LOGS%\GUID_dump_%COMPUTERNAME%_%CUR_DATE%.txt) do (
		for /f "tokens=1" %%j in (stage_2_de-bloat\oem\programs_to_target_by_GUID.txt) do (
			if /i %%j==%%a (

				REM Log finding and perform the removal
				if /i %VERBOSE%==yes ( call functions\log.bat "%%a MATCH from target list, uninstalling..." ) else ( echo %%a MATCH from target list, uninstalling...>> "%LOGPATH%\%LOGFILE%")
				start /wait msiexec /qn /norestart /x %%a>> "%LOGPATH%\%LOGFILE%" 2>nul

				REM Reset UpdateExeVolatile. I guess we could check to see if it's flipped, but no point really since we're just going to reset it anyway
				%REG% add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Updates" /v UpdateExeVolatile /d 0 /f >nul 2>&1

				REM Check if the uninstaller added entries to PendingFileRenameOperations. If it did, export the contents, nuke the key value, then continue on
				%REG% query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >nul 2>&1
				if !errorlevel!==0 (
					echo Offending GUID: %%i >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
					%REG% query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations>> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
					%REG% delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1

				if /i %VERBOSE%==yes echo %CUR_DATE% !TIME! ^^!  PendingFileRenameOperations entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted.
					echo %CUR_DATE% !TIME! ^^!  PendingFileRenameOperations entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted. >> "%LOGPATH%\%LOGFILE%"
					echo ------------------------------------------------------------------->> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				)
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
	for /f %%i in ('%FINDSTR% /R /N "^{" stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt ^| FIND /C ":"') do set GUID_TOTAL=%%i
	call functions\log_with_date.bat "   Comparing system GUID list against %GUID_TOTAL% blacklisted entries, please wait..."

if /i %DRY_RUN%==no (

	REM This is required so we can check the errorlevel inside the FOR loop
	SETLOCAL ENABLEDELAYEDEXPANSION

	REM Loop through the local GUID dump and see if any GUIDs match from the target list
	for /f "tokens=1" %%a in (%RAW_LOGS%\GUID_dump_%COMPUTERNAME%_%CUR_DATE%.txt) do (
		for /f "tokens=1" %%j in (stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt) do (
			if /i %%j==%%a (

				REM Log finding and perform the removal
				if /i %VERBOSE%==yes ( call functions\log.bat "%%a MATCH from target list, uninstalling..." ) else ( echo %%a MATCH from target list, uninstalling...>> "%LOGPATH%\%LOGFILE%")
				start /wait msiexec /qn /norestart /x %%a>> "%LOGPATH%\%LOGFILE%" 2>nul

				REM Reset UpdateExeVolatile. I guess we could check to see if it's flipped, but no point really since we're just going to reset it anyway
				%REG% add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Updates" /v UpdateExeVolatile /d 0 /f >nul 2>&1

				REM Check if the uninstaller added entries to PendingFileRenameOperations. If it did, export the contents, nuke the key value, then continue on
				%REG% query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >nul 2>&1
				if !errorlevel!==0 (
					echo Offending GUID: %%i >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
					%REG% query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations>> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
					%REG% delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1

				if /i %VERBOSE%==yes echo %CUR_DATE% !TIME! ^^!  PendingFileRenameOperations entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted.
					echo %CUR_DATE% !TIME! ^^!  PendingFileRenameOperations entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted.>> "%LOGPATH%\%LOGFILE%"
					echo ------------------------------------------------------------------->> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				)
			)
		)
	)
	ENDLOCAL DISABLEDELAYEDEXPANSION
)
call functions\log_with_date.bat "   Done."



:: JOB: Remove crapware programs, phase 3: wildcard by name
title Tron v%TRON_VERSION% [stage_2_de-bloat] [Remove bloatware by name]
call functions\log_with_date.bat "   Attempt junkware removal: Phase 3 (wildcard by name)..."
call functions\log_with_date.bat "   Tron is NOT stalled here, this portion just takes a long time"
call functions\log_with_date.bat "   Errors about 'SHUTTING DOWN' are safe to ignore"
setlocal EnableExtensions EnableDelayedExpansion
if /i %DRY_RUN%==no (

	REM Stamp the raw log file that we use to track progress through the list
	REM this one is still enabled since we're not displaying the name to the title bar
	echo %CUR_DATE% %TIME%   Attempt junkware removal: Phase 3 ^(wildcard by name^)...>> "%RAW_LOGS%\stage_2_de-bloat_progress_%COMPUTERNAME%_%CUR_DATE%.log" 2>&1

	REM This is required so we can check errorlevel inside the FOR loop
	SETLOCAL ENABLEDELAYEDEXPANSION

	REM Verbose output check
	if /i %VERBOSE%==yes echo Looking for:

	REM Loop through the file...
	for /f "delims=" %%i in (stage_2_de-bloat\oem\programs_to_target_by_name.txt) do (
		REM  ...and for each line check if it is a comment or SET command and perform the removal if not
		if not %%i==:: (
		if not %%i==set (

			REM Do the removal
			if /i %VERBOSE%==yes echo    %%i
			<NUL "%WMIC%" product where "name like '%%i'" uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%" 2>&1

			REM Check if the uninstaller added entries to PendingFileRenameOperations. If it did, export the contents, nuke the key value, then continue on
			%REG% query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations >nul 2>&1
			if !errorlevel!==0 (
				echo Offending GUID: %%i >> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				%REG% query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations>> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
				%REG% delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1

			if /i %VERBOSE%==yes echo %CUR_DATE% !TIME! ^^!  PendingFileRenameOperations entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted.
				echo %CUR_DATE% !TIME! ^^!  PendingFileRenameOperations entries exported to "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" and deleted.>> "%LOGPATH%\%LOGFILE%"
				echo ------------------------------------------------------------------->> "%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt"
			)

			REM Dump to separate raw log so we can see if the script stalls on a particular entry
			REM Not displayed to console or dumped to main log to avoid cluttering them up
			echo %CUR_DATE% !TIME!    %%i>> "%RAW_LOGS%\stage_2_de-bloat_progress_%COMPUTERNAME%_%CUR_DATE%.log" 2>&1

			)
		)
	)
	ENDLOCAL DISABLEDELAYEDEXPANSION
)
endlocal DisableDelayedExpansion
call functions\log_with_date.bat "   Done."



:: JOB: Remove crapware programs, phase 4: auxiliary WildTangent and HP Games scans
title Tron v%TRON_VERSION% [stage_2_de-bloat] [auxiliary scans]
call functions\log_with_date.bat "   Attempt junkware removal: Phase 4 (auxiliary HP and Wild Tangent Games scans)..."
if /i %DRY_RUN%==no (
	REM Gateway Games (Gateway-branded WildTangent games)
	REM These two FOR loops should catch ALL Gateway games, in theory at least
	REM Basically, loop through the games subdirectory, and if an "Uninstall.exe" exists ANYWHERE, run it with the /silent switch
	if exist "%ProgramFiles%\Gateway Games" ( for /r "%ProgramFiles%\Gateway Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent ) )
	if exist "%ProgramFiles(x86)%\Gateway Games" ( for /r "%ProgramFiles(x86)%\Gateway Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent ) )

	REM HP Games
	REM These two FOR loops should catch ALL HP games, in theory at least
	REM Basically, loop through the HP Games subdirectory, and if an "Uninstall.exe" exists ANYWHERE, run it with the /silent switch
	if exist "%ProgramFiles%\HP Games" ( for /r "%ProgramFiles%\HP Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent ) )
	if exist "%ProgramFiles(x86)%\HP Games" ( for /r "%ProgramFiles(x86)%\HP Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent ) )
	
	REM Dell Games (Dell-branded WildTangent games)
	REM These two loops should catch all Dell games, in theory at least
	REM Basically, loop through the games subdirectory, and if an "Uninstall.exe" exists ANYWHERE, run it with the /silent switch
	for /r "%ProgramFiles%\WildTangent\Dell Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )
	for /r "%ProgramFiles(x86)%\WildTangent\Dell Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )
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
		if /i "%SAFE_MODE%"=="yes" %REG% add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\AppXSVC" /ve /t reg_sz /d Service /f >nul 2>&1
		net start AppXSVC >nul 2>&1
		REM Enable scripts in PowerShell
		powershell "Set-ExecutionPolicy Unrestricted -force 2>&1 | Out-Null"

		REM Windows 8/8.1 version
		if /i "%WIN_VER:~0,9%"=="Windows 8" (
			REM In Windows 8/8.1 we can blast ALL AppX/Metro/"Modern App" apps because unlike in Windows 10, the "core" apps (calculator, paint, etc) aren't in the "modern" format
			start /wait powershell "Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			start /wait powershell "Get-AppxPackage -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"
		)
		REM Windows 10 version
		if /i "%WIN_VER:~0,9%"=="Windows 1" (
			REM Call the external PowerShell scripts to do removal of Microsoft and 3rd party OEM Modern Apps
			start /wait powershell -executionpolicy bypass -file ".\stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1"
			start /wait powershell -executionpolicy bypass -file ".\stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1"
		)
	)
	call functions\log_with_date.bat "   Done."
)



:: JOB: Remove forced OneDrive integration
:: This is the lazy way to do it but ....I just got back from Antarctica and am feeling tired so ¯\_(ツ)_/¯


:: This variable is used later to make sure we don't disable file sync if OneDrive wasn't removed
set ONEDRIVE_REMOVED=no

:: 1. Are we on Windows 10? If not, skip removal
if /i not "%WIN_VER:~0,9%"=="Windows 1" goto :skip_onedrive_removal

:: 2. Was the SKIP_ONEDRIVE_REMOVAL (-sor) switch used? If so, skip removal
if /i %SKIP_ONEDRIVE_REMOVAL%==yes (
	call functions\log_with_date.bat "!  SKIP_ONEDRIVE_REMOVAL (-sor) set. Skipping OneDrive removal."
	goto :skip_onedrive_removal
)

:: 3. Does the folder exist in the default location? If not, skip removal
if not exist "%USERPROFILE%\OneDrive" (
	call functions\log_with_date.bat "!  OneDrive folder not in the default location. Skipping removal."
	goto :skip_onedrive_removal
)

:: 4. Does the default folder have any files in it? If so, skip removal
call functions\log_with_date.bat "   Checking if OneDrive is in use, please wait..."
::    First, delete desktop.ini so it doesn't incorrectly trip the 'onedrive is in use' check
if exist "%USERPROFILE%\OneDrive\desktop.ini" %SystemRoot%\System32\attrib.exe -s -h "%USERPROFILE%\OneDrive\desktop.ini" >nul 2>&1
if exist "%USERPROFILE%\OneDrive\desktop.ini" del /f /q "%USERPROFILE%\OneDrive\desktop.ini" >nul 2>&1
stage_2_de-bloat\onedrive_removal\diruse.exe /q:0.5 "%USERPROFILE%\OneDrive" >> "%LOGPATH%\%LOGFILE%" 2>&1
if /i not %ERRORLEVEL%==0 (
	call functions\log_with_date.bat "!  OneDrive appears to be in use (files exist in the OneDrive folder). Skipping removal."
	goto :skip_onedrive_removal
)

:: 5. Does the registry indicate the OneDrive folder has been moved? If so, skip removal
set ONEDRIVE_PATH=%USERPROFILE%\OneDrive
for /f "usebackq tokens=3*" %%a IN (`%REG% QUERY "HKCU\Environment" /v OneDrive 2^>nul`) DO (
    set ONEDRIVE_PATH=%%a %%b
)

:: the space after OneDrive is required because the %ONEDRIVE_PATH% gets built with a trailing space for some reason
if /i not "%ONEDRIVE_PATH%"=="%USERPROFILE%\OneDrive " (
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
	
	REM SkyDrive (former OneDrive name)
	%REG% add "HKLM\software\policies\microsoft\windows\skydrive" /v "disablefilesync" /t REG_DWORD /d "1" /f
	
	REM Kill OneDrive from hooking into Explorer even when disabled
	%REG% add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
	%REG% add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
	
	:: Use Microsoft/Sysinternals movefile if access was denied in the previous 3 commands
	if /i not %ERRORLEVEL%==0 (
		stage_2_de-bloat\movefile\movefile.exe "%LocalAppData%\Microsoft\OneDrive" "" /accepteula >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_2_de-bloat\movefile\movefile.exe "%ProgramData%\Microsoft OneDrive" "" /accepteula >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_2_de-bloat\movefile\movefile.exe "%SystemDrive%\OneDriveTemp" "" /accepteula >> "%LOGPATH%\%LOGFILE%" 2>&1
	)

	REM These two registry entries disable OneDrive links in the Explorer side pane
	%REG% add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	set ONEDRIVE_REMOVED=yes
)


call functions\log_with_date.bat "   Done."
:skip_onedrive_removal


:: JOB: Disable "how-to" tips and appearing in Win8+
if /i "%WIN_VER:~0,9%"=="Windows 1" (
	title Tron v%TRON_VERSION% [stage_2_de-bloat] [Disable how-to tips]
	call functions\log_with_date.bat "   Disabling 'howto' tips appearing..."
	if /i %DRY_RUN%==no (
		%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t reg_dword /d 1 /f>> "%LOGPATH%\%LOGFILE%" 2>&1
	)
	call functions\log_with_date.bat "   Done."
)

:: JOB: Disable "Occasionally show suggestions in Start"...sigh
title Tron v%TRON_VERSION% [stage_2_de-bloat] [Disable suggestions]
call functions\log_with_date.bat "   Disabling 'Occasionally show suggestions in Start'..."
if /i %DRY_RUN%==no (
	%REG% ADD HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f>> "%LOGPATH%\%LOGFILE%" 2>&1
)
call functions\log_with_date.bat "   Done."



:: Stage complete
call functions\log_with_date.bat "  stage_2_de-bloat complete."

:: pause if we're doing standalone execution
if %STANDALONE%==yes pause

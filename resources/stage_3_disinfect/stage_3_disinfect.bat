:: Purpose:       Sub-script containing all commands for Tron Stage 3: Disinfect. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is recommended but not required
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.3.1 + adwcleaner:  Add AdwCleaner job. Thanks to u/fr0stedfl4ke
::                1.3.0 + mbam:        Add "/NOICON" switch to MBAM install to prevent desktop icon. Thanks to github:numdouglas and github:DRCHRIS2
::                1.2.9 ! kvrt:        Update KVRT commandline since they randomly renamed "-dontcryptsupportinfo" to "-dontencrypt", causing a popup window to appear
::                1.2.8 ! mbam:        Fix 2nd edge case where %MBAM% wasn't getting set correctly
::                      - certcache:   Move job 'Clear CryptNet SSL certificate cache' to Stage 1: Tempclean, where it makes more sense
::                1.2.7 ! mbam:        Fix syntax error in if statement
::                1.2.6 ! mbam:        Fix error where we'd attempt to launch %MBAM% but the variable was empty. Thanks to u/thementallydeceased
::                1.2.5 * mbam:        Skip install of MBAM and directly launch if it already exists. Thanks to u/RedBaron2
::                1.2.4 ! sophos:      Fix (rare) bug where Sophos would fail to delete its service after running. Thanks to u/Nightfoxsd420
::                1.2.3 ! sophos:      Fix bug in Sophos code where we wouldn't download updates even if we have a network connection. Thanks to github:gkraker04
::                1.2.2 * mbam:        Update to v3.x and fix a couple bugs related to shortcut deletion. Thanks to u/CSI-Debug
::                                     Consider MBAM v2.x as "no MBAM installed" and run the v3 installer regardless whether v2 exists on the system
::                1.2.1 ! mbam:        Fix for MBAM not launching if it was already installed. Thanks to u/b_sen
::                      - script:      Remove deprecated Junkware Removal Tool code
::                1.2.0 * sophos:      Prevent Sophos from trying to update if a network connection isn't detected
::                1.1.9 * improvement: Improve standalone execution support. Can now execute by double-clicking icon vs. manually executing via CLI
::                1.1.8 * logging:     Update date/time logging functions to use new log_with_date.bat. Thanks to u/DudeManFoo
::                1.1.7 * mbam:        Improve pre-existing installation detection. Thanks to github:RedBaron2
::                1.1.6 * improvement: Update script to support standalone execution
::                1.1.5 ! mbam:        Fix MBAM not launching or installing bug
::                1.1.4 * mbam:        Update MBAM detection to include new v3.x series. Thanks to u/Phantop
::                1.1.3 + certcache:   Add job to clear the CryptNet SSL certificate cache (Vista and up). Thanks to github:Itsnothectic and github:alazare619
::                1.1.2 + jrt:         Add job "JRT" (Junkware Removal Tool by Malwarebytes). Currently disabled (pending troubleshooting)
::                      - roguekiller: Remove obsolete code for RogueKiller
::                1.1.1 ! mbam:        Clean up mbam launching routine. Should eliminate erroneous message about mbam.exe not being found
::                      ! bugfix:      Correct a reference to USERPROFILE that should've used Tron's USERPROFILES instead
::                1.1.0 + mbam:        Add installation of mbam2-rules.exe (offline definition file) to MBAM installation routine. Thanks to u/sofakingdead
::                1.0.2 * mbam:        Import pre-configured settings.conf that ticks the "scan for rootkits" option when installing MBAM. Thanks to u/staticextasy
::                1.0.1 * logging:     Switch from internal log function to Tron's external logging function. Thanks to github:nemchik
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_3_SCRIPT_VERSION=1.3.1
set STAGE_3_SCRIPT_DATE=2023-08-xx
:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	pushd "%~dp0"
	pushd ..

	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)



::::::::::::::::::::::::
:: STAGE 3: Disinfect :: // Begin jobs
::::::::::::::::::::::::
call functions\log_with_date.bat "  stage_3_disinfect begin..."


:: JOB: MBAM (Malwarebytes Anti-Malware)
:: This needs to be re-worked. In all scenarios we attempt to run MBAM, even if asked not to install it. Probably just need to skip entire section if -sm is used.
title Tron v%TRON_VERSION% [stage_3_disinfect] [Malwarebytes Anti-Malware]

:: MBAM install path changed v2 to v3, so we only check for v3 installation and skip installing if it exists. If v2 exists, we
:: run the v3 installation to get it up-to-date. tl;dr we consider MBAM v2 installation "not installed" for the purposes of Tron

set EXISTING_MBAM=no
if exist "%ProgramFiles%\Malwarebytes\Anti-Malware\mbam.exe" (
	set MBAM="%ProgramFiles%\Malwarebytes\Anti-Malware\mbam.exe"
	set EXISTING_MBAM=yes
)

if exist "%ProgramFiles(x86)%\Malwarebytes\Anti-Malware\mbam.exe" (
	set MBAM="%ProgramFiles(x86)%\Malwarebytes\Anti-Malware\mbam.exe"
	set EXISTING_MBAM=yes
)

if /i %EXISTING_MBAM%==yes (
	call functions\log_with_date.bat "   Existing MBAM installation detected. Skipping installation."
	goto mbam_run
)


:: Skip MBAM installation if requested, otherwise install and launch. In all scenarios, MBAM will still attempt to launch if it is detected
if /i %SKIP_MBAM_INSTALL%==yes (
	call functions\log_with_date.bat "! SKIP_MBAM_INSTALL (-sm) set. Skipping installation."
) else (
	call functions\log_with_date.bat "   Launch job 'Install Malwarebytes Anti-Malware'..."
	:: Install MBAM and remove desktop icon
	if /i %DRY_RUN%==no (
		"stage_3_disinfect\mbam\mb3-setup-54035.54035-3.6.1.2711-1.0.482-1.0.7469.exe" /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /NOCANCEL /NOICON

		:: Nuke MBAM which arrogantly auto-starts even though we didn't request it
		net stop mbamservice >> "%LOGPATH%\%LOGFILE%" 2>NUL
		taskkill /f /im mbamtray.exe >> "%LOGPATH%\%LOGFILE%" 2>NUL

		:: Nuke the desktop shortcut
		if exist "%USERPROFILE%\Desktop\Malwarebytes.lnk" del /f /q "%USERPROFILE%\Desktop\Malwarebytes.lnk"
		if exist "%USERPROFILE%\Public\Desktop\Malwarebytes.lnk" del /f /q "%USERPROFILE%\Public\Desktop\Malwarebytes.lnk"
		if exist "%USERPROFILE%\Default\Desktop\Malwarebytes.lnk" del /f /q "%USERPROFILE%\Default\Desktop\Malwarebytes.lnk"
		if exist "%ALLUSERSPROFILE%\Desktop\Malwarebytes.lnk" del /f /q "%ALLUSERSPROFILE%\Desktop\Malwarebytes.lnk"

		:: Install our config
		copy /y stage_3_disinfect\mbam\*.json "%ProgramData%\Malwarebytes\MBAMService\config\" >> "%LOGPATH%\%LOGFILE%" 2>NUL

		:: Install the bundled definitions file and integrate the log into Tron's log
		call functions\log_with_date.bat "   Loading bundled definitions package..."
		stage_3_disinfect\mbam\mbam2-rules.exe /sp- /verysilent /suppressmsgboxes /log="%RAW_LOGS%\mbam_rules_install.log" /norestart
		type "%RAW_LOGS%\mbam_rules_install.log" >> "%LOGPATH%\%LOGFILE%"
		call functions\log_with_date.bat "    Done."
	)
)

:mbam_run
REM Scan for and launch appropriate architecture version
if %DRY_RUN%==no (
	if exist ""%MBAM%"" (
		call functions\log_with_date.bat "   Launching MBAM, click 'scan' in the MBAM window."
		start "" ""%MBAM%""
		call functions\log_with_date.bat "   Done."
	)
)


:: JOB: Malwarebytes AdwCleaner
title Tron v%TRON_VERSION% [stage_3_disinfect] [Malwarebytes AdwCleaner]
if /i %SKIP_ADWCLEANER_SCAN%==yes (
	call functions\log_with_date.bat "! SKIP_ADWCLEANER_SCAN (-sac) set. Skipping AdwCleaner scan."
) else (
	call functions\log_with_date.bat "   Launch job 'Malwarebytes AdwCleaner'..."
	call functions\log_with_date.bat "   Tool-specific log will be saved to "%RAW_LOGS%\AdwCleaner""
	if /i %DRY_RUN%==no (
		start /wait stage_3_disinfect\malwarebytes_adwcleaner\adwcleaner.exe /eula /clean /noreboot /path "%RAW_LOGS%"
		start /wait stage_3_disinfect\malwarebytes_adwcleaner\adwcleaner.exe /uninstall
	)
	call functions\log_with_date.bat "   Done."
)


:: JOB: Kaspersky Virus Removal Tool (KVRT)
title Tron v%TRON_VERSION% [stage_3_disinfect] [Kaspersky VRT]
if /i %SKIP_KASPERSKY_SCAN%==yes (
	call functions\log_with_date.bat "! SKIP_KASPERSKY_SCAN (-sk) set. Skipping KVRT scan."
) else (
	call functions\log_with_date.bat "   Launch job 'Kaspersky Virus Removal Tool'..."
	call functions\log_with_date.bat "   Tool-specific log will be saved to "%RAW_LOGS%\Reports""
	if /i %DRY_RUN%==no (
		start /wait stage_3_disinfect\kaspersky_virus_removal_tool\KVRT.exe -d "%RAW_LOGS%" -accepteula -adinsilent -silent -processlevel 2 -dontencrypt
		if exist "%RAW_LOGS%\Legal notices" rmdir /s /q "%RAW_LOGS%\Legal notices" >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
	call functions\log_with_date.bat "   Done."
)


:: JOB: Sophos Virus Remover
title Tron v%TRON_VERSION% [stage_3_disinfect] [Sophos Virus Remover]
if /i %SKIP_SOPHOS_SCAN%==yes (
	call functions\log_with_date.bat "! SKIP_SOPHOS_SCAN (-ss) set. Skipping SAV scan."
) else (
	call functions\log_with_date.bat "   Launch job 'Sophos Virus Removal Tool' (slow, be patient)..."
	call functions\log_with_date.bat "   Scan output REDUCED by default (use -v to show full output)..."
	if /i %DRY_RUN%==no (
		echo.

		REM Check whether or not we have a network connection and activate the appropriate config file
		if exist stage_3_disinfect\sophos_virus_remover\config.xml del /f /q stage_3_disinfect\sophos_virus_remover\config.xml >> "%LOGPATH%\%LOGFILE%" 2>&1
		if /i %NETWORK_AVAILABLE%==no (
			copy /a /y stage_3_disinfect\sophos_virus_remover\config_network_connected_no.xml stage_3_disinfect\sophos_virus_remover\config.xml >> "%LOGPATH%\%LOGFILE%" 2>&1
		) else (
			copy /a /y stage_3_disinfect\sophos_virus_remover\config_network_connected_yes.xml stage_3_disinfect\sophos_virus_remover\config.xml >> "%LOGPATH%\%LOGFILE%" 2>&1
		)

		if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\logs\SophosVirusRemovalTool.log" del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\logs\SophosVirusRemovalTool.log" >nul 2>&1
		if /i %VERBOSE%==no	(
			stage_3_disinfect\sophos_virus_remover\svrtcli.exe -yes
		) else (
			stage_3_disinfect\sophos_virus_remover\svrtcli.exe -yes -debug
		)
		type "%ProgramData%\Sophos\Sophos Virus Removal Tool\logs\SophosVirusRemovalTool.log" >> "%LOGPATH%\%LOGFILE%" 2>&1
		if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\logs\SophosVirusRemovalTool.log" del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\logs\SophosVirusRemovalTool.log" >nul 2>&1
		del /f /q stage_3_disinfect\sophos_virus_remover\config.xml >> "%LOGPATH%\%LOGFILE%" 2>&1

		REM Rarely happens, but occasionally Sophos will terminate and fail to delete the service it loads. Run a delete op against it just in case it didn't get removed.
		sc delete SophosVirusRemovalTool >> "%LOGPATH%\%LOGFILE%" 2>NUL
		%REG% delete HKLM\SYSTEM\CurrentControlSet\Services\SophosVirusRemovalTool /f >> "%LOGPATH%\%LOGFILE%" 2>NUL


	)
	call functions\log_with_date.bat "   Done."
)



:: Stage complete
call functions\log_with_date.bat "  stage_3_disinfect complete."

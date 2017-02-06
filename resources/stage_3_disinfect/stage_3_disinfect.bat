:: Purpose:       Sub-script containing all commands for Tron's Stage 3: Disinfect stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is recommended but not required
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.6 * script:      Update script to support standalone execution
::                1.1.5 ! mbam:        Fix MBAM not launching or installing bug
::                1.1.4 * mbam:        Update MBAM detection to include new v3.x series. Thanks to /u/Phantop
::                1.1.3 + certcache:   Add job to clear the CryptNet SSL certificate cache (Vista and up). Thanks to github:Itsnothectic and github:alazare619
::                1.1.2 + jrt:         Add job "JRT" (Junkware Removal Tool by Malwarebytes). Currently disabled (pending troubleshooting)
::                      - roguekiller: Remove obsolete code for RogueKiller
::                1.1.1 ! mbam:        Clean up mbam launching routine. Should eliminate erroneous message about mbam.exe not being found
::                      ! Correct a reference to USERPROFILE that should've used Tron's USERPROFILES instead
::                1.1.0 + mbam: Add installation of mbam2-rules.exe (offline definition file) to MBAM installation routine. Thanks to /u/sofakingdead
::                1.0.2 * mbam: Import pre-configured settings.conf that ticks the "scan for rootkits" option when installing MBAM. Thanks to /u/staticextasy
::                1.0.1 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_3_SCRIPT_VERSION=1.1.6
set STAGE_3_SCRIPT_DATE=2017-02-04

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	pushd ..
	
	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)



::::::::::::::::::::::::
:: STAGE 3: Disinfect :: // Begin jobs
::::::::::::::::::::::::
call functions\log.bat "%CUR_DATE% %TIME%   stage_3_disinfect begin..."


REM :: JOB: JRT (Malwarebytes Junkware Removal Tool)
REM title Tron v%TRON_VERSION% [stage_3_disinfect] [Malwarebytes JRT]
REM call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Malwarebytes Junkware Removal Tool'..."
REM if /i %DRY_RUN%==no (
	REM call stage_3_disinfect\jrt\get.bat
REM )
REM call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Clear CryptNet SSL certificate cache (Vista and up)
if %WIN_VER_NUM% geq 6.0 (
	title Tron v%TRON_VERSION% [stage_3_disinfect] [Clear CryptNet SSL cache]
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Clear CryptNet SSL certificate cache'..."
	if /i %DRY_RUN%==no	certutil -URLcache * delete  >> "%LOGPATH%\%LOGFILE%" 2>NUL
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)

:: JOB: MBAM (Malwarebytes Anti-Malware)
title Tron v%TRON_VERSION% [stage_3_disinfect] [Malwarebytes Anti-Malware]
set EXISTING_MBAM=no
if exist "%ProgramFiles%\Malwarebytes Anti-Malware\mbam.exe" set EXISTING_MBAM=yes
if exist "%ProgramFiles(x86)%\Malwarebytes\Anti-Malware\mbam.exe" set EXISTING_MBAM=yes
if /i %EXISTING_MBAM%==yes (
	call functions\log.bat "%CUR_DATE% %TIME%    Existing MBAM installation detected. Skipping installation."
	goto skip_mbam
)
if /i %SKIP_MBAM_INSTALL%==yes (
	call functions\log.bat "%CUR_DATE% %TIME% ! SKIP_MBAM_INSTALL (-sm) set. Skipping MBAM installation."
) else (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Install Malwarebytes Anti-Malware'..."
	:: Install MBAM and remove desktop icon
	if /i %DRY_RUN%==no (
		REM "stage_3_disinfect\mbam\Malwarebytes Anti-Malware v3.0.4.1269.exe" /verysilent
		"stage_3_disinfect\mbam\Malwarebytes Anti-Malware v2.2.1.1043.exe" /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /NOCANCEL
		if exist "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk" del "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk"
		if exist "%USERPROFILES%\Desktop\Malwarebytes Anti-Malware.lnk" del "%USERPROFILES%\Desktop\Malwarebytes Anti-Malware.lnk"
		if exist "%ALLUSERSPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk" del "%ALLUSERSPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk"
		copy /y stage_3_disinfect\mbam\settings.conf "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Configuration\settings.conf" >> "%LOGPATH%\%LOGFILE%" 2>NUL

		:: Install the bundled definitions file and integrate the log into Tron's log
		call functions\log.bat "%CUR_DATE% %TIME%    Loading bundled definitions package..."
		stage_3_disinfect\mbam\mbam2-rules.exe /sp- /verysilent /suppressmsgboxes /log="%RAW_LOGS%\mbam_rules_install.log" /norestart
		type "%RAW_LOGS%\mbam_rules_install.log" >> "%LOGPATH%\%LOGFILE%"
		call functions\log.bat "%CUR_DATE% %TIME%     Done."

		:: Scan for and launch appropriate architecture version
		if exist "%ProgramFiles(x86)%\Malwarebytes Anti-Malware\mbam.exe" start "" "%ProgramFiles(x86)%\Malwarebytes Anti-Malware\mbam.exe"
		if exist "%ProgramFiles%\Malwarebytes Anti-Malware\mbam.exe" start "" "%ProgramFiles%\Malwarebytes Anti-Malware\mbam.exe"
	)
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
	call functions\log.bat "%CUR_DATE% %TIME% !  NOTE: You must manually click SCAN in the MBAM window!"
)
:skip_mbam


:: JOB: Kaspersky Virus Removal Tool (KVRT)
title Tron v%TRON_VERSION% [stage_3_disinfect] [Kaspersky VRT]
if /i %SKIP_KASPERSKY_SCAN%==yes (
	call functions\log.bat "%CUR_DATE% %TIME% ! SKIP_KASPERSKY_SCAN (-sk) set. Skipping KVRT scan."
) else (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Kaspersky Virus Removal Tool'..."
	call functions\log.bat "%CUR_DATE% %TIME%    Tool-specific log will be saved to "%RAW_LOGS%\Reports""
	if /i %DRY_RUN%==no (
		start /wait stage_3_disinfect\kaspersky_virus_removal_tool\KVRT.exe -d "%RAW_LOGS%" -accepteula -adinsilent -silent -processlevel 2 -dontcryptsupportinfo
		if exist "%RAW_LOGS%\Legal notices" rmdir /s /q "%RAW_LOGS%\Legal notices" >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)


:: JOB: Sophos Virus Remover
title Tron v%TRON_VERSION% [stage_3_disinfect] [Sophos Virus Remover]
if /i %SKIP_SOPHOS_SCAN%==yes (
	call functions\log.bat "%CUR_DATE% %TIME% ! SKIP_SOPHOS_SCAN (-ss) set. Skipping SAV scan."
) else (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Sophos Virus Removal Tool' (slow, be patient)..."
	call functions\log.bat "%CUR_DATE% %TIME%    Scanning output is REDUCED by default (use -v to show)..."
	if /i %DRY_RUN%==no (
		echo.
		if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" >nul 2>&1
		if /i %VERBOSE%==no	stage_3_disinfect\sophos_virus_remover\svrtcli.exe -yes
		if /i %VERBOSE%==yes stage_3_disinfect\sophos_virus_remover\svrtcli.exe -yes -debug
		type "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" >> "%LOGPATH%\%LOGFILE%"
		if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" >nul 2>&1
	)
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)



:: Stage complete
call functions\log.bat "%CUR_DATE% %TIME%   stage_3_disinfect complete."

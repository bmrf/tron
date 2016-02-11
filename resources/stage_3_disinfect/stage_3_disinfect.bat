:: Purpose:       Sub-script containing all commands for Tron's Stage 3: Disinfect stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
::                3. Called from tron.bat. If you try to run this script directly it will error out
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.2 * mbam: Import pre-configured settings.conf that ticks the "scan for rootkits" option when installing MBAM. Thanks to /u/staticextasy
::                1.0.1 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_3_SCRIPT_VERSION=1.0.2
set STAGE_3_SCRIPT_DATE=2015-12-15

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
:: STAGE 3: Disinfect :: // Begin jobs
::::::::::::::::::::::::
call functions\log.bat "%CUR_DATE% %TIME%   stage_3_disinfect begin..."


REM :: JOB: RogueKiller
REM title Tron v%SCRIPT_VERSION% [stage_3_disinfect] [RogueKiller]
REM call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'RogueKiller' (it is SLOW, be patient)..."
REM if /i %DRY_RUN%==no (
    REM start stage_3_disinfect\roguekiller\RogueKillerAutomation.exe
    REM if /i %VERBOSE%==yes stage_3_disinfect\roguekiller\RogueKillerCMD.exe -scan
    REM if /i %VERBOSE%==no stage_3_disinfect\roguekiller\RogueKillerCMD.exe -scan>> "%LOGPATH%\%LOGFILE%"
    REM )
REM call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: MBAM (MalwareBytes Anti-Malware)
title Tron v%SCRIPT_VERSION% [stage_3_disinfect] [Malwarebytes Anti-Malware]
if exist "%ProgramFiles(x86)%\Malwarebytes Anti-Malware\mbam.exe" (
	call functions\log.bat "%CUR_DATE% %TIME% !  Malwarebytes installation detected. Skipping MBAM installation."
	goto skip_mbam
)
if /i %SKIP_MBAM_INSTALL%==yes (
	call functions\log.bat "%CUR_DATE% %TIME% ! SKIP_MBAM_INSTALL (-sm) set. Skipping MBAM installation."
) else (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Install Malwarebytes Anti-Malware'..."
	:: Install MBAM & remove the desktop icon
	if /i %DRY_RUN%==no (
		"stage_3_disinfect\mbam\Malwarebytes Anti-Malware v2.2.0.1024.exe" /verysilent
		::"Malwarebytes Anti-Malware v1.75.0.1300.exe" /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /NOCANCEL
		if exist "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk" del "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk"
		if exist "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk" del "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk"
		if exist "%ALLUSERSPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk" del "%ALLUSERSPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk"
		copy /y stage_3_disinfect\mbam\settings.conf "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Configuration\settings.conf" >NUL
		
		
		:: Scan for and launch appropriate architecture version
		if exist "%ProgramFiles(x86)%\Malwarebytes Anti-Malware" (
			start "" "%ProgramFiles(x86)%\Malwarebytes Anti-Malware\mbam.exe"
		) else (
			start "" "%ProgramFiles%\Malwarebytes Anti-Malware\mbam.exe"
			)
	)
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
	call functions\log.bat "%CUR_DATE% %TIME% !  NOTE: You must manually click SCAN in the MBAM window!"
)
:skip_mbam


:: JOB: Kaspersky Virus Removal Tool (KVRT)
title Tron v%SCRIPT_VERSION% [stage_3_disinfect] [Kaspersky VRT]
if /i %SKIP_KASPERSKY_SCAN%==yes (
	call functions\log.bat "%CUR_DATE% %TIME% ! SKIP_KASPERSKY_SCAN (-sk) set. Skipping KVRT scan."
) else (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Kaspersky Virus Removal Tool'..."
	call functions\log.bat "%CUR_DATE% %TIME%    Tool-specific log saved to "%RAW_LOGS%\Reports""
	if /i %DRY_RUN%==no (
		start /wait stage_3_disinfect\kaspersky_virus_removal_tool\KVRT.exe -d "%RAW_LOGS%" -accepteula -adinsilent -silent -processlevel 2 -dontcryptsupportinfo
		if exist "%RAW_LOGS%\Legal notices" rmdir /s /q "%RAW_LOGS%\Legal notices"
		)
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)


:: JOB: Sophos Virus Remover
title Tron v%SCRIPT_VERSION% [stage_3_disinfect] [Sophos Virus Remover]
if /i %SKIP_SOPHOS_SCAN%==yes (
	call functions\log.bat "%CUR_DATE% %TIME% ! SKIP_SOPHOS_SCAN (-ss) set. Skipping SAV scan."
) else (
	call functions\log.bat "%CUR_DATE% %TIME%    Launch job 'Sophos Virus Removal Tool' (slow, be patient)..."
	call functions\log.bat "%CUR_DATE% %TIME%    Scanning. Output REDUCED by default (use -v to show)..."
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

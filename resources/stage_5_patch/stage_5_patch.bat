:: Purpose:       Sub-script containing all commands for Tron's Stage 5: Patch stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
::                3. Called from tron.bat. If you try to run this script directly it will error out
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_5_SCRIPT_VERSION=1.0.0
set STAGE_5_SCRIPT_DATE=2015-11-30

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
	
	
	
::::::::::::::::::::
:: STAGE 5: Patch :: // Begin jobs
::::::::::::::::::::
call :log "%CUR_DATE% %TIME%   stage_5_patch begin..."


:: Prep task: enable MSI installer in Safe Mode
title TRON v%SCRIPT_VERSION% [stage_5_patch] [Prep]
if /i %DRY_RUN%==no (
	if not "%SAFE_MODE%"=="" reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\MSIServer" /ve /t reg_sz /d Service /f >nul 2>&1
	net start msiserver >nul 2>&1
)

:: Check for skip patches (-sp) flag or variable and skip if used
if /i %SKIP_PATCHES%==yes (
	call :log "%CUR_DATE% %TIME% ! SKIP_PATCHES (-sp) set. Skipping app patches."
	goto skip_patches
)


:: JOB: 7-Zip
title TRON v%SCRIPT_VERSION% [stage_5_patch] [Update 7-Zip]
call :log "%CUR_DATE% %TIME%    Launch job 'Update 7-Zip'..."
:: Call the 7-Zip installer, which detects system architecture and installs appropriate version
if /i %DRY_RUN%==no (
	setlocal
	call "stage_5_patch\7-Zip\7-Zip Installer.bat"
	endlocal
)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Adobe Flash Player
title TRON v%SCRIPT_VERSION% [stage_5_patch] [Update Adobe Flash Player]
call :log "%CUR_DATE% %TIME%    Launch job 'Update Adobe Flash Player'..."
setlocal
if /i %DRY_RUN%==no call "stage_5_patch\adobe\flash_player\Adobe Flash Player Installer.bat"
endlocal
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Adobe Reader
title TRON v%SCRIPT_VERSION% [stage_5_patch] [Update Adobe Reader]
call :log "%CUR_DATE% %TIME%    Launch job 'Update Adobe Reader'..."
setlocal
if /i %DRY_RUN%==no call "stage_5_patch\adobe\reader\Adobe Reader.bat"
endlocal

call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Java Runtime update
title TRON v%SCRIPT_VERSION% [stage_5_patch] [Update Java Runtime Environment]
call :log "%CUR_DATE% %TIME%    Launch job 'Update Java Runtime Environment'..."
call :log "%CUR_DATE% %TIME%    Checking for and removing outdated installations first..."
if /i %DRY_RUN%==yes goto skip_jre_update
:: Okay, so all JRE runtimes (series 4-8) use product GUIDs, with certain numbers that increment with each new update (e.g. Update 25)
:: This makes it easy to catch ALL of them through liberal use of WMI wildcards ("_" is single character, "%" is any number of characters)
:: Additionally, JRE 6 introduced 64-bit runtimes, so in addition to the two-digit Update XX revision number, we also check for the architecture
:: type, which always equals '32' or '64'. The first wildcard is the architecture, the second is the revision/update number.

:: JRE 8
:: We skip JRE 8 because the JRE 8 update script automatically removes older versions, no need to do it twice

:: JRE 7
call :log "%CUR_DATE% %TIME%    JRE 7..."
%WMIC% product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F___170__FF}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: JRE 6
call :log "%CUR_DATE% %TIME%    JRE 6..."
:: 1st line is for updates 23-xx, after 64-bit runtimes were introduced.
:: 2nd line is for updates 1-22, before Oracle released 64-bit JRE 6 runtimes
%WMIC% product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F8__160__FF}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%" 2>NUL
%WMIC% product where "IdentifyingNumber like '{3248F0A8-6813-11D6-A77B-00B0D0160__0}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%" 2>NUL

:: JRE 5
call :log "%CUR_DATE% %TIME%    JRE 5..."
%WMIC% product where "IdentifyingNumber like '{3248F0A8-6813-11D6-A77B-00B0D0150__0}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%" 2>NUL

:: JRE 4
call :log "%CUR_DATE% %TIME%    JRE 4..."
%WMIC% product where "IdentifyingNumber like '{7148F0A8-6813-11D6-A77B-00B0D0142__0}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%" 2>NUL

call :log "%CUR_DATE% %TIME%    Done."


:: Install the latest version
call :log "%CUR_DATE% %TIME%    Installing latest JRE..."
setlocal
call "stage_5_patch\java\jre\jre-8-installer.bat"
endlocal

:skip_jre_update
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Skip point for if -sp (skip patches) flag was used
:skip_patches


:: JOB: Windows updates
title TRON v%SCRIPT_VERSION% [stage_5_patch] [Windows Updates]
call :log "%CUR_DATE% %TIME%    Launch job 'Install Windows updates'..."
if /i %SKIP_WINDOWS_UPDATES%==no (
	if /i %DRY_RUN%==no wuauclt /detectnow /updatenow
	call :log "%CUR_DATE% %TIME%    Done."
) else (
	call :log "%CUR_DATE% %TIME% !  SKIP_WINDOWS_UPDATES (-sw) set to "%SKIP_WINDOWS_UPDATES%", skipping Windows Updates."
)


:: JOB: Rebuild Windows Update base (deflates the SxS store; note that any Windows Updates installed prior to this point will become uninstallable)
:: Windows 8/2012 and up only
title TRON v%SCRIPT_VERSION% [stage_5_patch] [Rebuild Windows Update base]
call :log "%CUR_DATE% %TIME%    Launch job 'DISM base reset'..."
if /i %DRY_RUN%==no (
	if /i not "%WIN_VER:~0,9%"=="Microsoft" (
		if /i not "%WIN_VER:~0,11%"=="Windows V" (
			Dism /online /Cleanup-Image /StartComponentCleanup /ResetBase /Logpath:"%LOGPATH%\tron_dism_base_reset.log" >nul 2>&1
			type "%LOGPATH%\tron_dism_base_reset.log" >> "%LOGPATH%\%LOGFILE%"
			del /f /q "%LOGPATH%\tron_dism_base_reset.log"
		)
	)
)
call :log "%CUR_DATE% %TIME%    Done."




:: Stage complete
call :log "%CUR_DATE% %TIME%   stage_5_patch complete."




:::::::::::::::
:: FUNCTIONS ::
:::::::::::::::
:: We have to duplicate the log function since it doesn't get inherited from tron.bat when the script is called
:log
echo:%~1 >> "%LOGPATH%\%LOGFILE%"
echo:%~1
goto :eof

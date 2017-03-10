:: Purpose:       Sub-script containing all commands for Tron's Stage 5: Patch stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is recommended but not required
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.9 / Change wuauserv command in Windows Update section to set the service to AUTO instead of DEMAND. Thanks to /u/Star_9
::                1.1.8 ! Fix bug in WSUS Offline update code due to unused variable. Thanks to /u/gayuha
::                1.1.7 * Update date/time logging functions to use new log_with_date.bat. Thanks to /u/DudeManFoo
::                1.1.6 * Update script to support standalone execution
::                      + Add support for bundled WSUS Offline updates. Thanks to /u/TootZoot for initial template code
::                      / change :skip_updates and associated GOTO statements to :skip_application_updates
::                      / change various text and strings referring to SKIP_UPDATES to SKIP_APP_UPDATES
::                1.1.5 * Update verbage on installation of Adobe Reader to reflect new Reader DC installation
::                      ! Minor bug fix; don't display "done" message if no Java installation was detected or updated
::                1.1.4 * Improve Windows Update section; force start Windows Update service in case it's not running, prior to running the wuaserv command
::                1.1.3 ! Fix bug where 7ZIP_DETECTED variable would never get set because it started with a number. Rename to SEVENZIP_DETECTED. Thanks to /u/toomasmolder
::                      / Change some comments inside parentheses to use REM instead of ::. Thanks to /u/toomasmolder
::                1.1.2 + Import Windows Vista/2008 Dism component cleanup from Stage 4
::                      + Implement support for -sdc switch (SKIP_DISM_CLEANUP)
::                1.1.1 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.1.0 * Only patch each program if it already exists on the system. Thanks to /u/Tech604
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_5_SCRIPT_VERSION=1.1.9
set STAGE_5_SCRIPT_DATE=2017-03-10

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	pushd ..

	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)



::::::::::::::::::::
:: STAGE 5: Patch :: // Begin jobs
::::::::::::::::::::
call functions\log_with_date.bat "   stage_5_patch begin..."


:: Prep task: enable MSI installer in Safe Mode
title Tron v%TRON_VERSION% [stage_5_patch] [Prep]
if /i %DRY_RUN%==no (
	if not "%SAFE_MODE%"=="" reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\MSIServer" /ve /t reg_sz /d Service /f >nul 2>&1
	net start msiserver >nul 2>&1
)

:: Prep task: check for skip application patches (-sap) flag or variable and skip if used
if /i %SKIP_APP_PATCHES%==yes (
	call functions\log_with_date.bat " !  SKIP_APP_PATCHES (-sap) set. Skipping all application patches."
	goto skip_application_patches
)


:: JOB: 7-Zip
:: spawn SEVENZIP_DETECTED variable, flip it if an existing 7-Zip installation is detected
set SEVENZIP_DETECTED=no
if exist "%ProgramFiles(x86)%\7-Zip" set SEVENZIP_DETECTED=yes
if exist "%ProgramFiles%\7-Zip" set SEVENZIP_DETECTED=yes
if %SEVENZIP_DETECTED%==yes (
	title Tron v%TRON_VERSION% [stage_5_patch] [Update 7-Zip]
	call functions\log_with_date.bat "    7-Zip detected, updating..."
	call functions\log_with_date.bat "    Launch job 'Update 7-Zip'..."
	setlocal
	if /i %DRY_RUN%==no call "stage_5_patch\7-Zip\7-Zip Installer.bat"
	endlocal
	call functions\log_with_date.bat "    Done."
)


:: JOB: Adobe Flash Player
:: Basic check for existence of a Flash installation. If ANY Flash installation is detected, launch the update script
:: The update script has additional checks to only update existing versions (e.g. Chrome vs. Active X) if they exist on the machine
set FLASH_DETECTED=no
if exist "%windir%\SysWOW64\Macromed\Flash" set FLASH_DETECTED=yes
if exist "%windir%\System32\Macromed\Flash" set FLASH_DETECTED=yes
if %FLASH_DETECTED%==yes (
	title Tron v%TRON_VERSION% [stage_5_patch] [Update Adobe Flash Player]
	call functions\log_with_date.bat "    Adobe Flash detected, updating..."
	call functions\log_with_date.bat "    Launch job 'Update Adobe Flash Player'..."
	setlocal
	if /i %DRY_RUN%==no call "stage_5_patch\adobe\flash_player\Adobe Flash Player Installer.bat"
	endlocal
	call functions\log_with_date.bat "    Done."
)


:: JOB: Adobe Acrobat Reader DC
if exist "%ProgramFiles(x86)%\Adobe\Acrobat Reader DC*" (
	title Tron v%TRON_VERSION% [stage_5_patch] [Update Adobe Reader]
	call functions\log_with_date.bat "    Adobe Acrobat Reader DC detected, updating..."
	call functions\log_with_date.bat "    Launch job 'Update Acrobat Reader DC'..."
	setlocal
	if /i %DRY_RUN%==no call "stage_5_patch\adobe\reader_dc\Adobe Acrobat Reader DC.bat"
	endlocal
	call functions\log_with_date.bat "    Done."
)


:: JOB: Java Runtime update
:: spawn JAVA_DETECTED variable, flip it if an existing JRE installation is detected
:: We don't need to worry about architecture because the JRE installer script handles that
set JAVA_DETECTED=no
if exist "%ProgramFiles(x86)%\Java\jre*" set JAVA_DETECTED=yes
if exist "%ProgramFiles%\Java\jre*" set JAVA_DETECTED=yes
if %JAVA_DETECTED%==yes (
	title Tron v%TRON_VERSION% [stage_5_patch] [Update Java Runtime Environment]
	call functions\log_with_date.bat "    Java Runtime detected, updating..."
	call functions\log_with_date.bat "    Launch job 'Update Java Runtime Environment'..."
	call functions\log_with_date.bat "    Checking for and removing outdated installations first..."
	if /i "%DRY_RUN%"=="no" (
		REM EXPOSITION DUMP: OK, so all JRE runtimes (series 4-8) use certain GUIDs that increment with each new update (e.g. Update 66)
		REM This makes it easy to catch ALL of them through liberal use of WMI wildcards ("_" is single character, "%" is any number of characters)
		REM Additionally, JRE 6 introduced 64-bit runtimes, so in addition to the two-digit Update XX revision number, we also check for the architecture
		REM type, which always equals '32' or '64'. The first wildcard is the architecture, the second is the revision/update number.

		REM JRE 8
		REM Skip JRE 8 because the JRE 8 update script automatically removes older versions of 8, no need to do it twice

		REM JRE 7
		call functions\log_with_date.bat "    JRE 7..."
		%WMIC% product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F___170__FF}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL

		REM JRE 6
		call functions\log_with_date.bat "    JRE 6..."
		REM 1st line is for updates 23-xx, after Oracle introduced 64-bit runtimes
		REM 2nd line is for updates 1-22, before 64-bit JRE 6 runtimes existed
		%WMIC% product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F8__160__FF}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL
		%WMIC% product where "IdentifyingNumber like '{3248F0A8-6813-11D6-A77B-00B0D0160__0}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL

		REM JRE 5
		call functions\log_with_date.bat "    JRE 5..."
		%WMIC% product where "IdentifyingNumber like '{3248F0A8-6813-11D6-A77B-00B0D0150__0}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL

		REM JRE 4
		call functions\log_with_date.bat "    JRE 4..."
		%WMIC% product where "IdentifyingNumber like '{7148F0A8-6813-11D6-A77B-00B0D0142__0}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL

		call functions\log_with_date.bat "    Done."


		REM Install the latest version
		call functions\log_with_date.bat "    Installing latest JRE..."
		setlocal
		call "stage_5_patch\java\jre\jre-8-installer.bat"
		endlocal
	)
call functions\log_with_date.bat "    Done."
)


:: JOB: Skip point for if -sap (skip application patches) flag was used
:skip_application_patches


:: JOB: Windows updates
if /i %SKIP_WINDOWS_UPDATES%==no (
	title Tron v%TRON_VERSION% [stage_5_patch] [Windows Updates]
	call functions\log_with_date.bat "    Launch job 'Install Windows updates'..."

	:: Detect if bundled WSUS Offline updates are included. If so, execute those instead
	if exist stage_5_patch\wsus_offline\client\Update.cmd (
		if /i %SKIP_WSUS_OFFLINE%==no (
			title Tron v%TRON_VERSION% [stage_5_patch] [WSUS Offline Updates]
			call functions\log_with_date.bat " !  WSUS Offline updates detected. Using bundled update package..."
			if /i %DRY_RUN%==no call "stage_5_patch\wsus_offline\client\Update.cmd" >> "%LOGPATH%\%LOGFILE%" 2>&1
		) else (
			call functions\log_with_date.bat " !  WSUS Offline updates detected, but SKIP_WSUS_OFFLINE (-swo) set."
			call functions\log_with_date.bat "    Using regular online update method..."
			if /i %DRY_RUN%==no (
				sc config wuauserv start= auto>> "%LOGPATH%\%LOGFILE%" 2>NUL
				net start wuauserv >> "%LOGPATH%\%LOGFILE%" 2>NUL
				wuauclt /detectnow /updatenow >> "%LOGPATH%\%LOGFILE%" 2>NUL
				ping 127.0.0.1 -n 15 >nul
			)
		)
	)
	call functions\log_with_date.bat "    Done."
) else (
	call functions\log_with_date.bat " !  SKIP_WINDOWS_UPDATES (-swu) set. Skipping all Windows Update methods."
)


:: JOB: Rebuild Windows Update base (deflates the SxS store; note that any Windows Updates installed prior to this point will no longer be uninstallable)
:: Windows 8/2012 and up only
if %SKIP_DISM_CLEANUP%==no (
	title Tron v%TRON_VERSION% [stage_5_patch] [Rebuild Windows Update base]
	call functions\log_with_date.bat "    Launch job 'DISM base reset'..."
	if /i %DRY_RUN%==no (
		REM 7/2008R2 and up
		if %WIN_VER_NUM% geq 6.1 (
			Dism /online /Cleanup-Image /StartComponentCleanup /ResetBase /Logpath:"%LOGPATH%\dism_base_reset.log" >nul 2>&1
			type "%LOGPATH%\dism_base_reset.log" >> "%LOGPATH%\%LOGFILE%"
			del /f /q "%LOGPATH%\dism_base_reset.log"
		)
		REM Vista version
		if %WIN_VER_NUM% equ 6.0 (
			Dism /online /Cleanup-Image /StartComponentCleanup /Logpath:"%LOGPATH%\dism_base_reset.log" >nul 2>&1
			type "%LOGPATH%\dism_base_reset.log" >> "%LOGPATH%\%LOGFILE%"
			del /f /q "%LOGPATH%\dism_base_reset.log"
		)
	)
) else (
	call functions\log_with_date.bat " !  SKIP_DISM_CLEANUP (-sdc) set. Skipping DISM cleanup."
)

call functions\log_with_date.bat "    Done."




:: Stage complete
call functions\log_with_date.bat "   stage_5_patch complete."

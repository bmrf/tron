:: Purpose:       Sub-script containing all commands for Tron's Stage 5: Patch stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is recommended but not required
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.2.5 - feature:      Remove entire Java Runtime patching section
::                1.2.4 * improvement:  Use %REG% instead of relative calls. Helps on systems with a broken PATH variable
::                1.2.3 ! bugfix:       Remove dead code that was incorrectly attempting to install Acrobat Reader DC updates
::                1.2.2 * improvement:  Improve standalone execution support. Can now execute by double-clicking icon vs. manually executing via CLI
::                1.2.1 ! bugfix:       Update Windows Defender prior to Windows update. Fixes bug where sometimes Windows Update won't work until Defender update runs. Thanks to /u/bubonis
::                1.2.0 ! bugfix:       Preface WMIC calls with null input to ensure the pipe is closed, fixes WMI hanging on WinXP machines. Thanks to github:salsifis
::                1.1.9 / wsus:         Change wuauserv command to set the service to AUTO instead of DEMAND. Thanks to /u/Star_9
::                1.1.8 ! bugfix:       Fix in WSUS Offline update code due to an unused variable. Thanks to /u/gayuha
::                1.1.7 * logging:      Update date/time logging functions to use new log_with_date.bat. Thanks to /u/DudeManFoo
::                1.1.6 * improvement:  Update script to support standalone execution
::                      + feature:      Add support for bundled WSUS Offline updates. Thanks to /u/TootZoot for initial template code
::                      / misc:         change :skip_updates and associated GOTO statements to :skip_application_updates
::                      / misc:         change various text strings referring to SKIP_UPDATES to SKIP_APP_UPDATES
::                1.1.5 * adobe:        Update verbage on installation of Adobe Reader to reflect new Reader DC installation
::                      ! bugfix:       Don't display "done" message if no Java installation was detected or updated
::                1.1.4 * improvement:  Windows Update; force start Windows Update service in case it's not running, prior to running the wuaserv command
::                1.1.3 ! bugfix:       7ZIP_DETECTED would never get set because it started with a number. Rename to SEVENZIP_DETECTED. Thanks to /u/toomasmolder
::                      / misc:         Change some comments inside parentheses to use REM instead of ::. Thanks to /u/toomasmolder
::                1.1.2 + feature:      Import Windows Vista/2008 Dism component cleanup from Stage 4
::                      + feature:      Implement support for -sdc switch (SKIP_DISM_CLEANUP)
::                1.1.1 * logging:      Switch from internal log function to Tron's external logging function. Thanks to github:nemchik
::                1.1.0 * improvement:  Only patch each program if it already exists on the system. Thanks to /u/Tech604
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_5_SCRIPT_VERSION=1.2.5
set STAGE_5_SCRIPT_DATE=2019-02-07

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	pushd "%~dp0"
	pushd ..

	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)



::::::::::::::::::::
:: STAGE 5: Patch :: // Begin jobs
::::::::::::::::::::
call functions\log_with_date.bat "  stage_5_patch begin..."


:: Prep task: enable MSI installer in Safe Mode
title Tron v%TRON_VERSION% [stage_5_patch] [Prep]
if /i %DRY_RUN%==no (
	if not "%SAFE_MODE%"=="" %REG% add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\MSIServer" /ve /t reg_sz /d Service /f >nul 2>&1
	net start msiserver >nul 2>&1
)

:: Prep task: check for skip application patches (-sap) flag or variable and skip if used
if /i %SKIP_APP_PATCHES%==yes (
	call functions\log_with_date.bat "!  SKIP_APP_PATCHES (-sap) set. Skipping all application patches."
	goto skip_application_patches
)


:: JOB: 7-Zip
:: spawn SEVENZIP_DETECTED variable, flip it if an existing 7-Zip installation is detected
set SEVENZIP_DETECTED=no
if exist "%ProgramFiles(x86)%\7-Zip" set SEVENZIP_DETECTED=yes
if exist "%ProgramFiles%\7-Zip" set SEVENZIP_DETECTED=yes
if %SEVENZIP_DETECTED%==yes (
	title Tron v%TRON_VERSION% [stage_5_patch] [Update 7-Zip]
	call functions\log_with_date.bat "   7-Zip detected, updating..."
	call functions\log_with_date.bat "   Launch job 'Update 7-Zip'..."
	setlocal
	if /i %DRY_RUN%==no call "stage_5_patch\7-Zip\7-Zip Installer.bat"
	endlocal
	call functions\log_with_date.bat "   Done."
)


:: JOB: Adobe Flash Player
:: Basic check for existence of a Flash installation. If ANY Flash installation is detected, launch the update script
:: The update script has additional checks to only update existing versions (e.g. Chrome vs. Active X) if they exist on the machine
set FLASH_DETECTED=no
if exist "%windir%\SysWOW64\Macromed\Flash" set FLASH_DETECTED=yes
if exist "%windir%\System32\Macromed\Flash" set FLASH_DETECTED=yes
if %FLASH_DETECTED%==yes (
	title Tron v%TRON_VERSION% [stage_5_patch] [Update Adobe Flash Player]
	call functions\log_with_date.bat "   Adobe Flash detected, updating..."
	call functions\log_with_date.bat "   Launch job 'Update Adobe Flash Player'..."
	setlocal
	if /i %DRY_RUN%==no call "stage_5_patch\adobe\flash_player\Adobe Flash Player Installer.bat"
	endlocal
	call functions\log_with_date.bat "   Done."
)



:: JOB: Skip point for if -sap (skip application patches) flag was used
:skip_application_patches


:: JOB: Update Windows Defender
if exist "%ProgramFiles%\Windows Defender\mpcmdrun.exe" (
	title Tron v%TRON_VERSION% [stage_5_patch] [Update Windows Defender]
	call functions\log_with_date.bat "   Updating Windows Defender..."
	if /i %DRY_RUN%==no "%ProgramFiles%\Windows Defender\mpcmdrun.exe" -SignatureUpdate
	call functions\log_with_date.bat "   Done."
)


:: JOB: Windows updates
if /i %SKIP_WINDOWS_UPDATES%==no (
	title Tron v%TRON_VERSION% [stage_5_patch] [Windows Updates]
	call functions\log_with_date.bat "   Launch job 'Install Windows updates'..."

	:: Detect if bundled WSUS Offline updates are included. If so, execute those instead
	if exist stage_5_patch\wsus_offline\client\Update.cmd (
		if /i %SKIP_WSUS_OFFLINE%==no (
			title Tron v%TRON_VERSION% [stage_5_patch] [WSUS Offline Updates]
			call functions\log_with_date.bat "!  WSUS Offline updates detected. Using bundled update package..."
			if /i %DRY_RUN%==no call "stage_5_patch\wsus_offline\client\Update.cmd" >> "%LOGPATH%\%LOGFILE%" 2>&1
		) else (
			call functions\log_with_date.bat "!  WSUS Offline updates detected, but SKIP_WSUS_OFFLINE (-swo) set."
			call functions\log_with_date.bat "   Using regular online update method..."
			if /i %DRY_RUN%==no (
				sc config wuauserv start= auto>> "%LOGPATH%\%LOGFILE%" 2>NUL
				net start wuauserv >> "%LOGPATH%\%LOGFILE%" 2>NUL
				wuauclt /detectnow /updatenow >> "%LOGPATH%\%LOGFILE%" 2>NUL
				ping 127.0.0.1 -n 15 >nul
			)
		)
	)
	call functions\log_with_date.bat "   Done."
) else (
	call functions\log_with_date.bat "!  SKIP_WINDOWS_UPDATES (-swu) set. Skipping all Windows Update methods."
)


:: JOB: Rebuild Windows Update base (deflates the SxS store; note that any Windows Updates installed prior to this point will no longer be uninstallable)
:: Windows 8/2012 and up only
if %SKIP_DISM_CLEANUP%==no (
	title Tron v%TRON_VERSION% [stage_5_patch] [Rebuild Windows Update base]
	call functions\log_with_date.bat "   Launch job 'DISM base reset'..."
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
	call functions\log_with_date.bat "!  SKIP_DISM_CLEANUP (-sdc) set. Skipping DISM cleanup."
)

call functions\log_with_date.bat "   Done."




:: Stage complete
call functions\log_with_date.bat "  stage_5_patch complete."

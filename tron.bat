:: Purpose:       Runs a series of cleaners and anti-virus engines to clean up/disinfect a Windows PC. All Windows versions XP and up are supported
::                  Kevin Flynn:  "Who's that guy?"
::                  Program:      "That's Tron. He fights for the User."
:: Requirements:  1. Administrator access
::                2. Safe mode is recommended (though not required)
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.1 * Update date/time logging functions to use new log_with_date.bat. No functionality change but should help with code readability. Thanks to /u/DudeManFoo
::                1.0.0 * Major breaking changes; VERSION in this script now just refers to tron.bat and NOT the overall Tron project version
::                        Tron overall project version now resides in \resources\functions\initialize_environment.bat. See that file for more details
::                      + Add REPO_TRON_VERSION and REPO_TRON_DATE to config dump (-c) output
::                      + Add switch -scs and associated SKIP_CUSTOM_SCRIPTS variable to allow forcibly skipping Stage 8 (custom scripts). This only has
::                        effect if .bat files exist in the stage_8_custom_scripts directory. If nothing is there then this option has no effect
::                      + Add switch -swo and associated SKIP_WSUS_OFFLINE variable to allow forcibly skipping bundled WSUS Offline updates even if they're
::                        present in stage_5_patch\wsus_offline\client\Update.cmd. Online Windows Updates will still be attempted.
::                      / Change -sp switch and associated SKIP_PATCHES variable to -sap and SKIP_APP_PATCHES to be consistent with other skip switches
::                      / Change -sw switch (SKIP_WINDOWS_UPDATE) to -swu to be consistent with other skip switches
::                      - Move task "Enable F8 Key on Bootup" to prerun_checks_and_tasks.bat
::                      - Move task "Create log directories if they don't exist" to initialize_environment.bat
::                      * Update welcome screen with note about Stage 8: Custom scripts
:: Usage:         Run this script as an Administrator (Safe Mode preferred but not required), follow the prompts, and reboot when finished. That's it.
::
::                OPTIONAL Command-line switches (can be combined, none are required):
::                      -a   Automatic exection mode (no welcome screen or prompts; implies -e)
::                      -c   Config dump (display config. Can be used with other flags to see what
::                           WOULD happen, but script will never execute if this flag is used)
::                      -d   DrTRON_VERSIONy run (run through script without executing any jobs)
::                      -dev Override OS detection (allow running on unsupported Windows versions)
::                      -e   Accept EULA (suppress disclaimer warning screen)
::                      -er  Email a report when finished. Requires you to configure SwithMailSettings.xml
::                      -h   Display help text
::                      -m   Preserve OEM Metro apps (don't remove them)
::                      -np  Skip the pause at the end of script
::                      -o   Power off after running (overrides -r)
::                      -p   Preserve power settings (don't reset to Windows default)
::                      -r   Reboot automatically 15 seconds after script completion
::                      -sa  Skip ALL antivirus scans (KVRT, MBAM, SAV)
::                      -sap Skip application patches (don't patch 7-Zip, Java Runtime, Adobe Flash or Reader)
::                      -scs Skip custom scripts (has no effect if you haven't supplied custom scripts)
::                      -sdb Skip de-bloat (OEM bloatware removal; implies -m)
::                      -sd  Skip defrag (force Tron to ALWAYS skip Stage 5 defrag)
::                      -sdc Skip DISM Cleanup (SxS component store deflation)
::                      -sdu Skip debloat update. Prevent Tron from auto-updating the S2 debloat lists
::                      -se  Skip Event Log backup and clear (don't clear Windows Event Logs)
::                      -sk  Skip Kaspersky Virus Rescue Tool (KVRT) scan
::                      -sm  Skip Malwarebytes Anti-Malware (MBAM) installation
::                      -spr Skip page file settings reset (don't set to "Let Windows manage the page file")
::                      -ss  Skip Sophos Anti-Virus (SAV) scan
::                      -str Skip Telemetry Removal (just turn telemetry off instead of removing it)
::                      -swu Skip Windows Updates entirely (ignore both WSUS Offline and online methods)
::                      -swo Skip only bundled WSUS Offline updates (online updates still attempted)
::                      -udl Upload debug logs. Send tron.log and the system GUID dump to the Tron developer
::                      -v   Verbose. Show as much output as possible. NOTE: Significantly slower!
::                      -x   Self-destruct. Tron deletes itself after running and leaves logs intact
::
::                If you don't like Tron's defaults (and don't want to use the command-line) edit the settings in \tron\resources\functions\tron_settings.bat
::
::                "Do not withhold good from those to whom it is due, when it is in your power to act." -p3:27

@echo off && cls && echo. && echo   Loading...
SETLOCAL




:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
color 0f
set SCRIPT_VERSION=1.0.1
set SCRIPT_DATE=2017-03-07

:: Get in the correct drive (~d0) and path (~dp0). Sometimes needed when run from a network or thumb drive. 
:: We stay in the \resources directory for the rest of the script
%~d0 2>NUL
pushd "%~dp0" 2>NUL
pushd resources

:: Load the settings file
call functions\tron_settings.bat

:: Initialize the runtime environment
call functions\initialize_environment.bat
title Tron v%TRON_VERSION% (%TRON_DATE%)

:: Do the pre-run checks and tasks (Admin rights check, temp directory check, SSD check etc)
call functions\prerun_checks_and_tasks.bat

:: Parse command-line arguments. If used these will override related settings specified in tron_settings.bat.
call :parse_cmdline_args %*


:: Execute help if requested
if /i %HELP%==yes (
	cls
	echo.
	echo  Tron v%TRON_VERSION% ^(%TRON_DATE%^)
	echo  Author: vocatus on reddit.com/r/TronScript
	echo.
	echo   Usage: %0%.bat ^[-a -c -d -dev -e -er -m -np -o -p -r -sa -scs -sd -sdb -sdc -sdu
	echo                    -se -sk -sm -sap -spr -ss -str -swu -swo -udl -v -x^] ^| ^[-h^]
	echo.
	echo   Optional flags ^(can be combined^):
	echo    -a   Automatic execution mode ^(no welcome screen or prompts; implies -e^)
 	echo    -c   Config dump ^(display config. Can be used with other flags to see what
	echo         WOULD happen, but script will never execute if this flag is used^)
	echo    -d   Dry run ^(run through script but don't execute any jobs^)
	echo    -dev Override OS detection ^(allow running on unsupported Windows versions^)
	echo    -e   Accept EULA ^(suppress disclaimer warning screen^)
	echo    -er  Email a report when finished. Requires you to configure SwithMailSettings.xml
	echo    -m   Preserve OEM Metro apps ^(don't remove them^)
	echo    -np  Skip pause at the end of the script
	echo    -o   Power off after running ^(overrides -r^)
	echo    -p   Preserve power settings ^(don't reset to Windows default^)
	echo    -r   Reboot automatically 15 seconds after script completion
	echo    -sa  Skip ALL anti-virus scans ^(KVRT, MBAM, SAV^)
	echo    -scs Skip custom scripts ^(has no effect if you haven't supplied custom scripts^)
	echo    -sdb Skip de-bloat ^(OEM bloatware removal; implies -m^)
	echo    -sd  Skip defrag ^(force Tron to ALWAYS skip Stage 5 defrag^)
	echo    -sdc Skip DISM cleanup ^(SxS component store deflation^)
	echo    -sdu Skip debloat update. Prevent Tron from auto-updating the S2 debloat lists
	echo    -se  Skip Event Log backup and clear ^(don't clear Windows Event Logs^)
	echo    -sk  Skip Kaspersky Virus Rescue Tool ^(KVRT^) scan
	echo    -sm  Skip Malwarebytes Anti-Malware ^(MBAM^) installation
	echo    -sap Skip application patches ^(don't patch 7-Zip, Java Runtime, Adobe Flash or Reader^)
	echo    -spr Skip page file settings reset ^(don't set to "Let Windows manage the page file"^)
	echo    -ss  Skip Sophos Anti-Virus ^(SAV^) scan
	echo    -str Skip Telemetry Removal ^(just turn telemetry off instead of removing it^)
	echo    -swu Skip Windows Updates entirely ^(ignore both WSUS Offline and online methods^)
	echo    -swo Skip only bundled WSUS Offline updates ^(online updates still attempted^)
	echo    -udl Upload debug logs. Send tron.log and the system GUID dump to the Tron developer
	echo    -v   Verbose. Show as much output as possible. NOTE: Significantly slower!
	echo    -x   Self-destruct. Tron deletes itself after running and leaves logs intact
 	echo.
	echo   Misc flags ^(must be used alone^)
	echo    -h   Display this help text
	echo.
	exit /b 0
)


:: INTERNAL PREP: Check if we're resuming from a failed or incomplete previous run (often caused by forced reboots in stage_2_de-bloat)
:: Populate what stage we were on as well as what CLI flags were used. This could probably be a single IF block but I got lazy
:: trying to figure out all the annoying variable expansion parsing stuff. Oh well
if /i %RESUME_DETECTED%==yes (
	REM Quick check for a faulty resume detection
	if not exist tron_stage.txt (
		reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f /v "tron_resume" >nul 2>&1
		goto autorun_check
	)

	REM Read in the values from the previous run
	set /p RESUME_STAGE=<tron_stage.txt 2>NUL
	set /p RESUME_FLAGS=<tron_flags.txt 2>NUL
)
if /i %RESUME_DETECTED%==yes call :parse_cmdline_args %RESUME_FLAGS%
if /i %RESUME_DETECTED%==yes (
	call functions\log_with_date.bat " ! Incomplete run detected. Resuming at %RESUME_STAGE% using flags %RESUME_FLAGS%..."
	REM Reset the RunOnce flag in case we get interrupted again. Disabled for now, just to prevent resume-looping where we keep trying to resume
	REM even if a reboot didn't happen
	REM reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f /v "tron_resume" /t REG_SZ /d "%~dp0tron.bat %-resume" >NUL
	REM We can assume Caffeine isn't running (keeps system awake) if we're resuming, so go ahead and re-launch it before jumping to our stage
	start "" stage_0_prep\caffeine\caffeine.exe -noicon
	goto %RESUME_STAGE%
)


:: INTERNAL PREP: Check for active network connection
%WinDir%\system32\ipconfig /all | %FIND% /i "Subnet Mask" >NUL 2>&1
if /i not %ERRORLEVEL%==0 (
	call functions\log_with_date.bat " ! Tron doesn't think we have a network connection. Skipping update checks."
	set SKIP_CHECK_UPDATE=yes
	set WARNINGS_DETECTED=yes_check_update_skipped
)


:: INTERNAL PREP: Check for updates
if /i %DRY_RUN%==yes set SKIP_CHECK_UPDATE=yes
if /i %AUTORUN%==yes set SKIP_CHECK_UPDATE=yes
if /i %SKIP_CHECK_UPDATE%==no (
	cls
	echo.
	call functions\log.bat "   Checking repo for updated Tron version..."
	echo.
	call stage_0_prep\check_update\check_update.bat
	call functions\log.bat "   Done."
	echo.
	if /i %SKIP_DEBLOAT_UPDATE%==no (
		if /i %CONFIG_DUMP%==no (
			call functions\log.bat "   Downloading latest S2 debloat lists from Github..."
			echo.
			call stage_0_prep\check_update\check_update_debloat_lists.bat
			call functions\log.bat "   Done."
			echo.
		)
	)
)


:: INTERNAL PREP: Execute config dump if requested
if /i %CONFIG_DUMP%==yes (
	:: We need this set/endlocal pair because on Vista the OS name has "(TM)" in it, which breaks the script. Sigh
	SETLOCAL ENABLEDELAYEDEXPANSION
	cls
	echo.
	echo  Tron v%TRON_VERSION% ^(%TRON_DATE%^) config dump
	echo.
	echo  Command-line arguments:
	echo   %*
	echo.
	echo  User-set variables:
	echo    AUTORUN:                %AUTORUN%
	echo    AUTO_REBOOT_DELAY:      %AUTO_REBOOT_DELAY%
	echo    CONFIG_DUMP:            %CONFIG_DUMP%
	echo    AUTO_SHUTDOWN:          %AUTO_SHUTDOWN%
	echo    DRY_RUN:                %DRY_RUN%
	echo    DEV_MODE:               %DEV_MODE%
	echo    EMAIL_REPORT:           %EMAIL_REPORT%
	echo    EULA_ACCEPTED:          %EULA_ACCEPTED%
	echo    LOGPATH:                %LOGPATH%
	echo    LOGFILE:                %LOGFILE%
	echo    NO_PAUSE:               %NO_PAUSE%
	echo    PRESERVE_METRO_APPS:    %PRESERVE_METRO_APPS%
	echo    PRESERVE_POWER_SCHEME:  %PRESERVE_POWER_SCHEME%
	echo    QUARANTINE_PATH:        %QUARANTINE_PATH%
	echo    SELF_DESTRUCT:          %SELF_DESTRUCT%
	echo    SKIP_ANTIVIRUS_SCANS:   %SKIP_ANTIVIRUS_SCANS%
	echo    SKIP_APP_PATCHES:       %SKIP_APP_PATCHES%
	echo    SKIP_CUSTOM_SCRIPTS:    %SKIP_CUSTOM_SCRIPTS%
	echo    SKIP_DEBLOAT:           %SKIP_DEBLOAT%
	echo    SKIP_DEFRAG:            %SKIP_DEFRAG%
	echo    SKIP_DISM_CLEANUP:      %SKIP_DISM_CLEANUP%
	echo    SKIP_DEBLOAT_UPDATE:    %SKIP_DEBLOAT_UPDATE%
	echo    SKIP_EVENT_LOG_CLEAR:   %SKIP_EVENT_LOG_CLEAR%
	echo    SKIP_KASPERSKY_SCAN:    %SKIP_KASPERSKY_SCAN%
	echo    SKIP_MBAM_INSTALL:      %SKIP_MBAM_INSTALL%
	echo    SKIP_PAGEFILE_RESET:    %SKIP_PAGEFILE_RESET%
	echo    SKIP_SOPHOS_SCAN:       %SKIP_SOPHOS_SCAN%
	echo    SKIP_TELEMETRY_REMOVAL: %SKIP_TELEMETRY_REMOVAL%
	echo    SKIP_WINDOWS_UPDATES:   %SKIP_WINDOWS_UPDATES%
	echo    UPLOAD_DEBUG_LOGS:      %UPLOAD_DEBUG_LOGS%
	echo    UNICORN_POWER_MODE:     %UNICORN_POWER_MODE%
	echo    VERBOSE:                %VERBOSE%
	echo.
	echo  Script-internal variables:
	echo    CUR_DATE:               %CUR_DATE%
	echo    DTS:                    %DTS%
	echo    FIND:                   %FIND%
	echo    FINDSTR:                %FINDSTR%
	echo    FREE_SPACE_AFTER:       %FREE_SPACE_AFTER%
	echo    FREE_SPACE_BEFORE:      %FREE_SPACE_BEFORE%
	echo    FREE_SPACE_SAVED:       %FREE_SPACE_SAVED%
	echo    HELP:                   %HELP%
	echo    SAFE_MODE:              %SAFE_MODE%
	echo    SAFEBOOT_OPTION:        %SAFEBOOT_OPTION%
	echo    TEMP:                   !TEMP!
	echo    TARGET_METRO:           %TARGET_METRO%
	echo    TIME:                   %TIME%
	echo    TIME_ZONE_NAME:         !TIME_ZONE_NAME!
	echo    TRON_DATE:              %TRON_DATE%
	echo    TRON_VERSION:           %TRON_VERSION%
	echo    PROCESSOR_ARCHITECTURE: %PROCESSOR_ARCHITECTURE%
	echo    REPO_TRON_DATE:         %REPO_TRON_DATE%
	echo    REPO_TRON_VERSION:      %REPO_TRON_VERSION%
	echo    RESUME_DETECTED:        %RESUME_DETECTED%
	echo    RESUME_FLAGS:           %RESUME_FLAGS%
	echo    RESUME_STAGE:           %RESUME_STAGE%
	echo    WIN_VER:                !WIN_VER!
	echo    WMIC:                   %WMIC%
	ENDLOCAL DISABLEDELAYEDEXPANSION
	exit /b 0
)


:: INTERNAL PREP: Act on autorun flag. Skip safe mode, admin rights, and EULA checks. I assume if you use the auto flag (-a) you know what you're doing
:autorun_check
if /i %AUTORUN%==yes goto execute_jobs


:: INTERNAL PREP: Display the annoying disclaimer screen. Sigh
cls
SETLOCAL ENABLEDELAYEDEXPANSION
if /i not %EULA_ACCEPTED%==yes (
	color CF
	echo  ************************** ANNOYING DISCLAIMER **************************
	echo  * HEY^^! READ THE INSTRUCTIONS and understand what Tron does, because it  *
	echo  * does a lot of stuff that, while not harmful, can be annoying if not   *
	echo  * expected. e.g. wiping temp files, Local Store, cookies, etc. So if    *
	echo  * Tron does something you didn't expect and you didn't read the         *
	echo  * instructions, it is YOUR FAULT.                                       *
	echo  *                                                                       *
	echo  * tron.bat and the supporting code and scripts I've written are free    *
	echo  * and open-source under the MIT License. All 3rd-party tools Tron calls *
	echo  * ^(MBAM, KVRT, etc^) are bound by their respective licenses. It is       *
	echo  * YOUR RESPONSIBILITY to determine if you have the rights to use these  *
	echo  * tools in whatever environment you're in.                              *
	echo  *                                                                       *
	echo  * BOTTOM LINE: By running Tron you accept complete responsibility for   *
	echo  * anything that happens. There is NO WARRANTY, you run it at your OWN   *
	echo  * RISK and anything that happens, good or bad, is YOUR RESPONSIBILITY.  *
	echo  * If you don't agree to this then don't run Tron.                       *
	echo  *************************************************************************
	echo.
	echo  Type I AGREE ^(all caps^) to accept this and go to the main menu, or
	echo  press ctrl^+c to cancel.
	echo.
	:eula_prompt
	set /p CHOICE= Response:
	if not "!CHOICE!"=="I AGREE" echo You must type I AGREE to continue&& goto eula_prompt
	color 0f
	)
ENDLOCAL DISABLEDELAYEDEXPANSION


:: INTERNAL PREP: Check if we're in safe mode
SETLOCAL ENABLEDELAYEDEXPANSION
set CHOICE=y
if /i not "%SAFE_MODE%"=="yes" (
	color 0e
	cls
	echo.
	echo  NOTE
	echo.
	echo  The system isn't in Safe Mode. Safe Mode is NOT required,
	echo  and sometimes Tron can actually work as well or better in
	echo  "regular" mode, but generally I recommend first running in
	echo  Safe Mode, then if there are still issues, re-running in
	echo  "regular" mode.
	echo.
	set /p CHOICE=  Reboot into "Safe Mode with Networking" now? [Y/n] 
	if /i "!CHOICE!"=="y" (
		echo.
		echo  Rebooting system to Safe Mode in 7 seconds...
		bcdedit /set {current} safeboot network
		shutdown -r -f -t 7
		pause
		exit
	) else (
		echo.
		echo  Tron will still function, but if you have problems
		echo  after running, I recommend re-running in Safe Mode.
		echo.
		pause
		cls
	)
)
ENDLOCAL DISABLEDELAYEDEXPANSION

:: INTERNAL PREP: Check if we're in Safe Mode without Network support
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" (
	cls
	color 0e
	echo.
	echo  NOTE
	echo.
	echo  The system is in Safe Mode without Network support.
	echo  Tron functions best in "Safe Mode with Networking" in
	echo  order to download Windows and anti-virus updates.
	echo.
	echo  Tron will still function, but rebooting to "Safe Mode
	echo  with Networking" is recommended.
	echo.
	pause
	cls
)


:: INTERNAL PREP: UPM detection circuit
if /i %UNICORN_POWER_MODE%==on (color DF) else (color 0f)


:: INTERNAL PREP: Welcome screen
cls
echo  **********************  TRON v%TRON_VERSION% (%TRON_DATE%)  *********************
echo  * Script to automate a series of cleanup/disinfection tools           *
echo  * Author: vocatus on reddit.com/r/TronScript                          *
echo  *                                                                     *
echo  * Stage:        Tools:                                                *
echo  *  0 Prep:      Create SysRestore point/Rkill/ProcessKiller/Stinger/  *
echo  *               TDSSKiller/registry backup/clean oldest VSS set       *
echo  *  1 TempClean: TempFileClean/BleachBit/CCleaner/IE ^& EvtLogs clean   *
echo  *  2 De-bloat:  Remove OEM bloatware, remove Metro bloatware          *
echo  *  3 Disinfect: Sophos/KVRT/MBAM/DISM repair                          *
echo  *  4 Repair:    MSIcleanup/PageFileReset/chkdsk/SFC/telemetry removal *
echo  *  5 Patch:     Update 7-Zip/Java/Flash/Windows, DISM base cleanup    *
echo  *  6 Optimize:  defrag %SystemDrive% (mechanical only, SSDs skipped)             *
echo  *  7 Wrap-up:   collect logs, send email report (if requested)        *
echo  *  8 Custom:    If present, execute user-provided custom scripts      *
echo  *                                                                     *
echo  * \tron\resources\stage_9_manual_tools contains other useful utils    *
echo  ***********************************************************************
:: So ugly
echo  Current settings (run tron.bat -c to dump full config):
echo    Log location:            %LOGPATH%\%LOGFILE%
if "%AUTO_REBOOT_DELAY%"=="0" (
	echo    Auto-reboot delay:       disabled
) else (
	echo    Auto-reboot delay:       %AUTO_REBOOT_DELAY% seconds
)
if /i "%SKIP_DEFRAG%"=="yes_ssd" echo    Skip defrag?             %SKIP_DEFRAG% ^(SSD detected^)
if /i "%SKIP_DEFRAG%"=="yes_vm" echo    Skip defrag?             %SKIP_DEFRAG% ^(VM detected^)
if /i "%SKIP_DEFRAG%"=="yes_error" echo    Skip defrag?             %SKIP_DEFRAG% ^(error reading disk stats^)
if /i "%SKIP_DEFRAG%"=="yes" echo    Skip defrag?             %SKIP_DEFRAG% ^(user set^)
if /i "%SKIP_DEFRAG%"=="no" echo    Skip defrag?             %SKIP_DEFRAG%
if /i "%SAFE_MODE%"=="no" echo    Safe mode?               %SAFE_MODE%
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" echo    Safe mode?               %SAFE_MODE%, without Networking
if /i "%SAFEBOOT_OPTION%"=="NETWORK" echo    Safe mode?               %SAFE_MODE%, with Networking ^(ideal^)
if /i "%SKIP_DEFRAG:~0,3%"=="yes" (
	echo    Runtime estimate:        4-6 hours
) else (
	echo    Runtime estimate:        7-9 hours
)

if /i %DRY_RUN%==yes echo  ! DRY_RUN set; will not execute any jobs
if /i %DEV_MODE%==yes echo  ! DEV_MODE set; unsupported OS detection overridden
if /i %UNICORN_POWER_MODE%==on echo  !! UNICORN POWER MODE ACTIVATED !!
echo.
:welcome_screen_trailer
pause
cls


:: INTERNAL PREP: Email report check
:: If -er flag was used or EMAIL_REPORT was set to yes, check for a correctly configured SwithMailSettings.xml
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %EMAIL_REPORT%==yes (
	%FINDSTR% /i "YOUR-EMAIL-ADDRESS" stage_7_wrap-up\email_report\SwithMailSettings.xml >NUL
	if !ERRORLEVEL!==0 (
		color cf
		cls
		echo.
		echo  ERROR
		echo.
		echo  You requested an email report ^(used the -er flag or set
		echo  the EMAIL_REPORT variable to "yes"^) but didn't configure
		echo  the settings file with your information. Update the following
		echo  file with your SMTP username, password, etc:
		echo.
		echo  \resources\stage_7_wrap-up\email_report\SwithMailSettings.xml
		echo.
		echo  Alternatively you can run SwithMail.exe to have the GUI generate
		echo  a config file for you.
		echo.
		pause
	)
)
ENDLOCAL DISABLEDELAYEDEXPANSION




::::::::::::::::::
:: EXECUTE JOBS ::
::::::::::::::::::
:execute_jobs
:: Add a RunOnce entry to relaunch Tron if it gets interrupted by a reboot. This is deleted at the end of the script if nothing went wrong
if /i %DRY_RUN%==no reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f /v "tron_resume" /t REG_SZ /d "%~dp0tron.bat %-resume" >nul 2>&1


:: Check if autorun (-a) flag was used but we're NOT in Safe Mode. If true, reboot.
if /i %AUTORUN%==yes (
	if /i not "%SAFE_MODE%"=="yes" (
		call functions\log.bat " ! Autorun flag used, but we're not in Safe Mode. Rebooting in 15 seconds."
		if /i %DRY_RUN%==no (
			bcdedit /set {default} safeboot network
			shutdown -r -f -t 15
			pause
			exit
		)
	)
)


:: UPM detection circuit #2
if /i %UNICORN_POWER_MODE%==on (color DF) else (color 0f)


:: Expand the scrollback buffer if VERBOSE (-v) was used. This way we don't lose any output on the screen
:: We'll also display a message below, since using the MODE command flushes the scrollback and we don't want to lose the header
if /i %VERBOSE%==yes mode con:lines=9000


:: Create log header and dump all run-time variables to the log file, but skip if we're resuming from an interrupted run
cls
if /i %RESUME_DETECTED%==no (
	echo. > "%LOGPATH%\%LOGFILE%"
	call functions\log.bat "-------------------------------------------------------------------------------"
	call functions\log.bat "   Tron v%TRON_VERSION% (%TRON_DATE%)"
	call functions\log.bat "                          %WIN_VER% (%PROCESSOR_ARCHITECTURE%)"
	call functions\log.bat "                          Executing as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%"
	call functions\log.bat "                          Logfile: %LOGPATH%\%LOGFILE%"
	call functions\log.bat "                          Command-line switches: %*"
	call functions\log.bat "                          Time zone: %TIME_ZONE_NAME%"
	call functions\log.bat "                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%"
	call functions\log.bat "                          Free space before Tron run: %FREE_SPACE_BEFORE% MB"
	call functions\log.bat "-------------------------------------------------------------------------------"
)


:: If verbose (-v) was used, notify that we expanded the scrollback buffer
if /i %VERBOSE%==yes call functions\log_with_date.bat " !  VERBOSE (-v) output requested. All commands will display verbose output when possible."
if /i %VERBOSE%==yes call functions\log_with_date.bat "    Expanded the scrollback buffer to accomodate increased output."


:: INTERNAL PREP: Tell us if the update check failed or was skipped
if %WARNINGS_DETECTED%==yes_check_update_failed call functions\log_with_date.bat " ! WARNING: Tron update check failed."
if %WARNINGS_DETECTED%==yes_check_update_skipped call functions\log_with_date.bat " ! NOTE: Tron doesn't think the system has a network connection. Update checks were skipped."


:: PREP: Run a quick SMART check and notify if there are any drives with problems
set WARNING_LIST=(Error Degraded Unknown PredFail Service Stressed NonRecover)
for /f %%i in ('%WMIC% diskdrive get status') do echo %%i|%FINDSTR% /i "%WARNING_LIST:~1,-1%" && (
	call functions\log.bat " ^^^! WARNING: SMART check indicates at least one drive with '%%i' status"
	call functions\log.bat " SMART errors can mean a drive is close to failure"
	call functions\log.bat " Recommend you back the system up BEFORE running Tron."
	color 0e
	set WARNINGS_DETECTED=yes
)


:: INTERNAL PREP: If we're in Safe Mode, set the system to permanently boot into Safe Mode in case we get interrupted by a reboot
:: We undo this at the end of the script. Only works on Vista and up
if /i "%SAFE_MODE%"=="yes" (
	if %WIN_VER_NUM% geq 6.0 (
		title Tron v%TRON_VERSION% [stage_0_prep] [safeboot]
		call functions\log_with_date.bat "    Setting system to always boot to Safe Mode w/ Networking..."
		call functions\log_with_date.bat "    Will re-enable regular boot when Tron is finished."
		if /i %DRY_RUN%==no bcdedit /set {default} safeboot network >> "%LOGPATH%\%LOGFILE%"
		call functions\log_with_date.bat "    Done."
	)
)



:::::::::::::::::::
:: STAGE 0: PREP ::
:::::::::::::::::::
:stage_0_prep
:: Stamp current stage and CLI flags so we can resume if we get interrupted by a reboot
:: Don't stamp anything to the flags file if no CLI flags were used
echo stage_0_prep>tron_stage.txt
if /i not "%*"=="" echo %*> tron_flags.txt
title Tron v%TRON_VERSION% [stage_0_prep]
echo.
call stage_0_prep\stage_0_prep.bat



::::::::::::::::::::::::
:: STAGE 1: TEMPCLEAN ::
::::::::::::::::::::::::
:stage_1_tempclean
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_1_tempclean>tron_stage.txt
title Tron v%TRON_VERSION% [stage_1_tempclean]
call stage_1_tempclean\stage_1_tempclean.bat



:::::::::::::::::::::::
:: STAGE 2: De-Bloat ::
:::::::::::::::::::::::
:stage_2_de-bloat
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_2_de-bloat>tron_stage.txt
title Tron v%TRON_VERSION% [stage_2_de-bloat]
if /i %SKIP_DEBLOAT%==no (
	call stage_2_de-bloat\stage_2_de-bloat.bat
) else (
	call functions\log_with_date.bat " ! SKIP_DEBLOAT (-sdb) set, skipping Stage 2..."
)



::::::::::::::::::::::::
:: STAGE 3: Disinfect ::
::::::::::::::::::::::::
:stage_3_disinfect
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_3_disinfect>tron_stage.txt
title Tron v%TRON_VERSION% [stage_3_disinfect]
if /i %SKIP_ANTIVIRUS_SCANS%==no (
	call stage_3_disinfect\stage_3_disinfect.bat
) else (
	call functions\log_with_date.bat " ! SKIP_ANTIVIRUS_SCANS (-sa) set. Skipping Stage 3 (Sophos, KVRT, MBAM)."
)

:: Since this whole section takes a long time to run, set the date again in case we crossed over midnight during the scans
call :set_cur_date



:::::::::::::::::::::
:: STAGE 4: Repair ::
:::::::::::::::::::::
:stage_4_repair
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_4_repair>tron_stage.txt
title Tron v%TRON_VERSION% [stage_4_repair]
call stage_4_repair\stage_4_repair.bat

:: Set current date again, since Stage 4 can take quite a while to run
call :set_cur_date



::::::::::::::::::::::
:: STAGE 5: Patches ::
::::::::::::::::::::::
:stage_5_patch
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_5_patch>tron_stage.txt
title Tron v%TRON_VERSION% [stage_5_patch]
call stage_5_patch\stage_5_patch.bat



:::::::::::::::::::::::
:: STAGE 6: Optimize ::
:::::::::::::::::::::::
:stage_6_optimize
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_6_optimize>tron_stage.txt
title Tron v%TRON_VERSION% [stage_6_optimize]
call stage_6_optimize\stage_6_optimize.bat



::::::::::::::::::::::
:: STAGE 7: Wrap-up ::
::::::::::::::::::::::
:stage_7_wrap-up
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_7_wrap-up>tron_stage.txt
call functions\log_with_date.bat "   stage_7_wrap-up begin..."


:: JOB: Reset power settings to Windows defaults
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Reset power settings]
if %PRESERVE_POWER_SCHEME%==yes (
	call functions\log_with_date.bat " !  PRESERVE_POWER_SCHEME (-p) set to "%PRESERVE_POWER_SCHEME%", skipping power settings reset."
) else (
	call functions\log_with_date.bat "    Resetting Windows power settings to defaults and re-enabling screensaver..."
	if %DRY_RUN%==no (
		REM Check for Windows XP/2k3
		if %WIN_VER_NUM% lss 6.0 %WINDIR%\system32\powercfg.exe /RestoreDefaultPolicies >NUL 2>&1
		REM Run commands for all other versions of Windows
		%WINDIR%\system32\powercfg.exe -restoredefaultschemes >NUL 2>&1
)
call functions\log_with_date.bat "    Done."
)


:: JOB: Get post-Tron system state (installed programs, complete file list) and generate the summary logs
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Generate Summary Logs]
call functions\log_with_date.bat "    Calculating post-run results for summary logs..."
if /i %DRY_RUN%==no (
	:: Get list of installed programs
	stage_0_prep\log_tools\siv\siv32x.exe -save=[software]="%RAW_LOGS%\installed-programs-after.txt"
	:: Get list of all files
	stage_0_prep\log_tools\everything\everything.exe -create-filelist %RAW_LOGS%\filelist-after.txt %SystemDrive%
	:: Parse everything
		REM Step 1: Find FILES that were deleted (second line is to strip everything trailing the first comma from the output)
		stage_0_prep\log_tools\comm\comm.exe -23 %RAW_LOGS%\filelist-before.txt %RAW_LOGS%\filelist-after.txt | %FIND% /i /v "$RECYCLE" | %FIND% /i /v "AppData\" | %FIND% /i /v "ntuser.dat" > "%TEMP%\temp.txt"
		for /f "tokens=1 delims=," %%a in ("%TEMP%\temp.txt") do echo %%a >> %SUMMARY_LOGS%\tron_removed_files.txt

		REM Step 2: Find PROGRAMS that were removed. This is super ugly and complicated, but lets us avoid bundling another external utility
		REM Compact the files by removing blank lines, stripping top 4 lines off file, then last two lines, then output to the final text file for comparison
		copy /y %RAW_LOGS%\installed-programs-before.txt %RAW_LOGS%\before.txt >NUL
		for /f "delims=" %%a in (%RAW_LOGS%\before.txt) do echo %%a>> %RAW_LOGS%\before1.txt
		more +3 %RAW_LOGS%\before1.txt >> %RAW_LOGS%\before2.txt
		%FINDSTR% /v /i "[==" %RAW_LOGS%\before2.txt > %RAW_LOGS%\installed-programs-before.txt

		REM AFTER: Compact the files by removing blank lines, stripping top 4 lines off file, then last two lines, then output to the final text file for comparison
		copy /y %RAW_LOGS%\installed-programs-after.txt %RAW_LOGS%\after.txt >NUL
		for /f "delims=" %%a in (%RAW_LOGS%\after.txt) do echo %%a>> %RAW_LOGS%\after1.txt
		more +3 %RAW_LOGS%\after1.txt >> %RAW_LOGS%\after2.txt
		%FINDSTR% /v /i "[==" %RAW_LOGS%\after2.txt > %RAW_LOGS%\installed-programs-after.txt

		REM Calculate differences, using GnuWin32 coreutil's comm.exe
		stage_0_prep\log_tools\comm\comm.exe -23 %RAW_LOGS%\installed-programs-before.txt %RAW_LOGS%\installed-programs-after.txt > %SUMMARY_LOGS%\tron_removed_programs.txt

		REM If the parsed file is the same as the original, we can assume nothing was removed, so just echo that into the file
		fc /b %RAW_LOGS%\installed-programs-before.txt %RAW_LOGS%\installed-programs-after.txt >NUL
		if %ERRORLEVEL%==0 echo No programs were removed.> %SUMMARY_LOGS%\tron_removed_programs.txt

		REM Cleanup
		del /f /q "%TEMP%\temp.txt" 2>NUL
		del /f /q %RAW_LOGS%\before*txt 2>NUL
		del /f /q %RAW_LOGS%\after*txt 2>NUL
	)
call functions\log_with_date.bat "    Done. Summary logs are at "%SUMMARY_LOGS%\""


:: JOB: Collect misc logs and deposit them in the log folder
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Collect logs]
call functions\log_with_date.bat "    Saving misc logs to "%RAW_LOGS%\"..."
if /i %DRY_RUN%==no (
	if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs" copy /Y "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\*.l*" "%RAW_LOGS%" >NUL
	if exist "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Logs" copy /Y "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Logs\*.xml" "%RAW_LOGS%" >NUL
	if exist "%LOGPATH%\mbam-log*" move /y "%LOGPATH%\mbam-log*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\Sophos*" move /y "%LOGPATH%\Sophos*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\protection-log*" move /y "%LOGPATH%\protection-log*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\jre*" move /y "%LOGPATH%\jre*" "%RAW_LOGS%\"
)
call functions\log_with_date.bat "    Done."


:: JOB: Create post-run Restore Point
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Create Restore Point]
if %WIN_VER_NUM% geq 6.0 (
	REM Remove the stupid restore point creation 24 hour cooldown timer Microsoft brilliantly introduced in Windows 8 and up
	if %WIN_VER_NUM% geq 6.2 reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /t reg_dword /v SystemRestorePointCreationFrequency /d 0 /f >nul 2>&1
	REM Create the restore point
	echo "%WIN_VER%" | %FINDSTR% /i /c:"server" >NUL || (
		call functions\log_with_date.bat "    Creating post-run Restore Point..."
		if /i %DRY_RUN%==no	powershell "Checkpoint-Computer -Description 'TRON v%TRON_VERSION%: Post-run checkpoint' | Out-Null" >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
)
call functions\log_with_date.bat "    OK."


:: JOB: Calculate saved disk space
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Calculate saved disk space]
for /F "tokens=2 delims=:" %%a in ('fsutil volume diskfree %SystemDrive% ^| %FIND% /i "avail free"') do set bytes=%%a
:: GB version
::set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024/1024
:: MB version
set /A FREE_SPACE_AFTER=%bytes:~0,-3%/1024*1000/1024
set /a FREE_SPACE_SAVED=%FREE_SPACE_AFTER% - %FREE_SPACE_BEFORE%

call functions\log_with_date.bat "   stage_7_wrap-up complete."



:::::::::::::::::::::::::::::
:: STAGE 8: Custom Scripts ::
:::::::::::::::::::::::::::::
:stage_8_custom_scripts
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_8_custom_scripts>tron_stage.txt
if /i %SKIP_CUSTOM_SCRIPTS%==yes (
	call functions\log_with_date.bat " ! SKIP_CUSTOM_SCRIPTS (-scs) set to "%SKIP_CUSTOM_SCRIPTS%", skipping..."
) else (
	if exist stage_8_custom_scripts\*.bat (
		echo stage_8_custom_scripts>tron_stage.txt
		call functions\log_with_date.bat " ! Custom scripts detected, executing now..."
		call functions\log_with_date.bat "   stage_8_custom_scripts begin..."
		if %DRY_RUN%==no for %%i in (stage_8_custom_scripts\*.bat) do (
			call functions\log_with_date.bat "    Executing %%i..."
			call %%i
			call functions\log_with_date.bat "    %%i done."
		)
		call functions\log_with_date.bat "   stage_8_custom_scripts complete."
	)
)


::::::::::::::::::::::
:: Post-run Cleanup ::
::::::::::::::::::::::
:: JOB: Remove resume-related files, registry entry, boot flag, and other misc files
call functions\log_with_date.bat "    Doing miscellaneous clean up..."
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f /v "tron_resume" >nul 2>&1
	del /f /q tron_flags.txt >nul 2>&1
	del /f /q tron_stage.txt >nul 2>&1
	:: Skip these during a dry run because they toss errors to the log file. Not actually a problem, just an annoyance
	if %DRY_RUN%==no (
		bcdedit /deletevalue {current} safeboot >nul 2>&1
		bcdedit /deletevalue {default} safeboot >nul 2>&1
		bcdedit /deletevalue safeboot >nul 2>&1
	)
	del /f /q "%TEMP%\tron_smart_results.txt" 2>NUL
call functions\log_with_date.bat "    Done."


:: JOB: Shut down Caffeine which has kept the system awake during the Tron run
stage_0_prep\caffeine\caffeine.exe -appexit


:: Notify of Tron completion
title Tron v%TRON_VERSION% (%TRON_DATE%) [DONE]
call functions\log_with_date.bat "   TRON RUN COMPLETE."
call functions\log_with_date.bat "   Use \tron\resources\stage_9_manual_tools if further action is required."


:: Check if auto-reboot was requested
if "%AUTO_REBOOT_DELAY%"=="0" (
	call functions\log_with_date.bat "   Auto-reboot (-r) not selected. Reboot as soon as possible."
) else (
	call functions\log_with_date.bat " ! Auto-reboot selected. Rebooting in %AUTO_REBOOT_DELAY% seconds."
)


:: Check if shutdown was requested
if /i %AUTO_SHUTDOWN%==yes call functions\log_with_date.bat " ! Auto-shutdown selected. Shutting down in %AUTO_REBOOT_DELAY% seconds."


:: Notify that we're going to email the log file
if /i %EMAIL_REPORT%==yes call functions\log_with_date.bat "   Email report requested. Will email logs in a few moments."


:: Upload logs if the switch was used
if /i %UPLOAD_DEBUG_LOGS%==yes call functions\log_with_date.bat "   Debug log upload enabled (thank-you!). Will upload logs in a few moments."


:: Check if self-destruct was set
if /i %SELF_DESTRUCT%==yes (
	call functions\log_with_date.bat " ! Self-destruct selected. De-rezzing self. Goodbye..."
)


:: Error checking. Color the window based on run results so we can see at a glance if it's done
color 2f
:: Were warnings detected?
if /i not %WARNINGS_DETECTED%==no (
	color e0
	call functions\log_with_date.bat " ! WARNINGS were detected (%WARNINGS_DETECTED%). Recommend reviewing the log file."
)
:: Were errors detected?
if /i not %ERRORS_DETECTED%==no (
	color cf
	call functions\log_with_date.bat " ! ERRORS were detected (%ERRORS_DETECTED%). Review the log file."
)

:: Display and log the job summary
echo.
call functions\log.bat "-------------------------------------------------------------------------------"
call functions\log.bat "   TRON v%TRON_VERSION% (%TRON_DATE%) complete"
call functions\log.bat "                          %WIN_VER% (%PROCESSOR_ARCHITECTURE%)"
call functions\log.bat "                          Executed as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%"
call functions\log.bat "                          Command-line switches: %*"
call functions\log.bat "                          Time zone: %TIME_ZONE_NAME%"
call functions\log.bat "                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%"
call functions\log.bat "                          Free space before Tron run: %FREE_SPACE_BEFORE% MB"
call functions\log.bat "                          Free space after Tron run:  %FREE_SPACE_AFTER% MB"
call functions\log.bat "                          Disk space reclaimed:       %FREE_SPACE_SAVED% MB *"
call functions\log.bat "                          Logfile: %LOGPATH%\%LOGFILE%"
call functions\log.bat ""
call functions\log.bat "     * If you see negative disk space don't panic. Due to how some of Tron's"
call functions\log.bat "       functions work, actual disk space reclaimed will not be visible until"
call functions\log.bat "       after a reboot."
call functions\log.bat "-------------------------------------------------------------------------------"


:: JOB: Send the email report if requested
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %EMAIL_REPORT%==yes (
	if /i %DRY_RUN%==no (
		stage_7_wrap-up\email_report\SwithMail.exe /s /x "stage_7_wrap-up\email_report\SwithMailSettings.xml" /l "%RAW_LOGS%\swithmail.log" /a "%LOGPATH%\%LOGFILE%|%SUMMARY_LOGS%\tron_removed_files.txt|%SUMMARY_LOGS%\tron_removed_programs.txt" /p1 "Tron v%TRON_VERSION% (%TRON_DATE%) executed as %USERDOMAIN%\%USERNAME%" /p2 "%LOGPATH%\%LOGFILE%" /p3 "%SAFE_MODE% %SAFEBOOT_OPTION%" /p4 "%FREE_SPACE_BEFORE%/%FREE_SPACE_AFTER%/%FREE_SPACE_SAVED%" /p5 "%CLI_ARGUMENTS%"

		if !ERRORLEVEL!==0 (
			call functions\log_with_date.bat "   Done."
		) else (
			call functions\log_with_date.bat " ^! Something went wrong, email may not have gone out. Check your settings."
		)
	)
)
ENDLOCAL DISABLEDELAYEDEXPANSION


:: JOB: Upload debug logs if requested
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %UPLOAD_DEBUG_LOGS%==yes (
	if /i %DRY_RUN%==no (
		stage_7_wrap-up\email_report\SwithMail.exe /s /x "stage_7_wrap-up\email_report\debug_log_upload_settings.xml" /l "%userprofile%\desktop\swithmail.log" /a "%LOGPATH%\%LOGFILE%|%RAW_LOGS%\GUID_dump_%COMPUTERNAME%_%CUR_DATE%.txt|%RAW_LOGS%\PendingFileRenameOperations_%COMPUTERNAME%_%CUR_DATE%.txt" /p1 "Tron v%TRON_VERSION% (%TRON_DATE%) executed as %USERDOMAIN%\%USERNAME%" /p2 "%LOGPATH%\%LOGFILE%" /p3 "%SAFE_MODE% %SAFEBOOT_OPTION%" /p4 "%FREE_SPACE_BEFORE%/%FREE_SPACE_AFTER%/%FREE_SPACE_SAVED%" /p5 "%CLI_ARGUMENTS%"

		if !ERRORLEVEL!==0 (
			call functions\log_with_date.bat "   Done."
		) else (
			call functions\log_with_date.bat " ^! Something went wrong, logs may not have uploaded. Please notify Vocatus."
		)
	)
)
ENDLOCAL DISABLEDELAYEDEXPANSION


:: Skip everything below here if we're doing a dry run
if /i %DRY_RUN%==yes goto end_and_skip_shutdown

:: Perform reboot if requested
if /i not "%AUTO_REBOOT_DELAY%"=="0" shutdown -r -f -t %AUTO_REBOOT_DELAY% -c "Rebooting in %AUTO_REBOOT_DELAY% seconds to finish cleanup."

:: Perform shutdown if requested
if /i %AUTO_SHUTDOWN%==yes shutdown -f -t %AUTO_REBOOT_DELAY% -s

:: De-rez self if requested
set CWD=%CD%
if /i %SELF_DESTRUCT%==yes (
	cd ..
	del /f /q tron.bat >NUL 2>&1
	%SystemDrive%
	cd \
	rmdir /s /q "%CWD%"
	exit
)

:end_and_skip_shutdown
echo.
if /i %NO_PAUSE%==no pause
ENDLOCAL
exit /B
:: That's all, folks




:::::::::::::::
:: FUNCTIONS ::
:::::::::::::::
:: Get the date into ISO 8601 standard format (yyyy-mm-dd) so we can use it
:set_cur_date
for /f %%a in ('%WMIC% OS GET LocalDateTime ^| %FIND% "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%
goto :eof

:: Parse CLI arguments and flip the appropriate variables
:parse_cmdline_args
:: This line required for Swithmail. We use CLI_ARGUMENTS instead of %* because Swithmail chokes if %* is empty. 
:: CLI_ARGUMENTS is used in three places: The two Swithmail jobs (upload debug logs and email report) and to dump the list of CLI arguments to the log file at the beginning
if /i not "%*"=="" (set CLI_ARGUMENTS=%*) else (set CLI_ARGUMENTS=No CLI switches used)
for %%i in (%*) do (
	if /i %%i==-a set AUTORUN=yes
	if /i %%i==-c set CONFIG_DUMP=yes
	if /i %%i==-d set DRY_RUN=yes
	if /i %%i==-dev set DEV_MODE=yes
	if /i %%i==-e set EULA_ACCEPTED=yes
	if /i %%i==-er set EMAIL_REPORT=yes
	if /i %%i==-h set HELP=yes
	if /i %%i==-m set PRESERVE_METRO_APPS=yes
	if /i %%i==-np set NO_PAUSE=yes
	if /i %%i==-o set AUTO_SHUTDOWN=yes
	if /i %%i==-p set PRESERVE_POWER_SCHEME=yes
	if /i %%i==-r set AUTO_REBOOT_DELAY=15
	if /i %%i==-sa set SKIP_ANTIVIRUS_SCANS=yes
	if /i %%i==-scs set SKIP_CUSTOM_SCRIPTS=yes
	if /i %%i==-sdb set SKIP_DEBLOAT=yes
	if /i %%i==-sd set SKIP_DEFRAG=yes
	if /i %%i==-sdc set SKIP_DISM_CLEANUP=yes
	if /i %%i==-sdu set SKIP_DEBLOAT_UPDATE=yes
	if /i %%i==-se set SKIP_EVENT_LOG_CLEAR=yes
	if /i %%i==-sk set SKIP_KASPERSKY_SCAN=yes
	if /i %%i==-sm set SKIP_MBAM_INSTALL=yes
	if /i %%i==-sap set SKIP_APP_PATCHES=yes
	if /i %%i==-spr set SKIP_PAGEFILE_RESET=yes
	if /i %%i==-str set SKIP_TELEMETRY_REMOVAL=yes
	if /i %%i==-ss set SKIP_SOPHOS_SCAN=yes
	if /i %%i==-swu set SKIP_WINDOWS_UPDATES=yes
	if /i %%i==-swo set SKIP_WSUS_OFFLINE=yes
	if /i %%i==-udl set UPLOAD_DEBUG_LOGS=yes
	if /i %%i==-upm set UNICORN_POWER_MODE=on
	if /i %%i==-v set VERBOSE=yes
	if /i %%i==-x set SELF_DESTRUCT=yes
)
goto :eof
:eof

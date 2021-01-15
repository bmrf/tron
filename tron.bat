:: Purpose:       Runs a series of cleaners and anti-virus engines to clean up/disinfect a Windows PC. All Windows versions XP and up are supported
::                  Kevin Flynn:  "Who's that guy?"
::                  Program:      "That's Tron. He fights for the User."
:: Requirements:  Run from the current users desktop. Run as Administrator.
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.2.1 - Remove references to Adobe Flash
::                1.2.0 / Change REMOVE_MALWAREBYTES to PRESERVE_MALWAREBYTES (-pmb)
::                1.1.9 + Add REMOVE_MALWAREBYTES (-rmb) switch to have Tron automatically remove Malwarebytes at the end of the run. Thanks to tbr:greg
::                      + Add SKIP_COOKIE_CLEANUP (-scc) switch to have Tron preserve ALL cookies. Thanks to tbr:sebastian
::                1.1.8 / Rename all instances of "argument(s)" to "switch(es)" to maintain project consistency
::                1.1.7 + Add value of WIN_VER_NUM to -c output
::                1.1.6 + Add support for new SKIP_ONEDRIVE_REMOVAL (-sor) switch. Thanks to github:ptrkhh
::                1.1.5 - Remove references to patching Java due to removal of that functionality
::                1.1.4 - Remove auto-relaunch on reboot if the script was interrupted. Just couldn't get it working reliably with UAC. Thanks to u/bubonis
::                1.1.3 ! Move prerun checks and tasks to after parse_commandline_switches, to allow -dev switch to function correctly. Thanks to github:justinhachemeister
::                      * Replace all relative references to reg.exe with hard-coded %REG% (set in initialize_environment.bat). Thanks to u/SkyPork for reporting
::                1.1.2 / Move SMART error detection code to prerun_checks_and_tasks.bat
::                1.1.1 + Add upload of Metro app list dump if -udl switch is used
::                      / Move Stage 7 code out of tron.bat into it's own discrete script
::                1.1.0 / Move network connection detection code into initialize_environment.bat
::                      + Add display of whether or not warnings and errors were detected to end-screen
::                1.0.9 + Add support for detection of Internet connection on French language systems. Thanks to u/mr_marmotte
::                1.0.8 * Improve network detection routine to address possibility of multiple languages in ipconfig output
::                1.0.7 * Improve network detection routine to work on German-language systems. Thanks to u/smokie12
::                1.0.6 ! Bugfixes for -a and -asm switches. Thanks to u/agent-squirrel
::                1.0.5 * Update code to support new -asm switch and alter original -a switch behavior (no longer auto-reboot into safe mode, unless -asm is used along with -a)
::                      - Remove "System is not in Safe Mode" warning. Tron is shifting emphasis away from running in Safe Mode since it's not technically required
::                      * Move help output (-h) to it's own function at the bottom of the script instead of cluttering up the pre-run section
::                1.0.4 ! Fix bug in debug log upload code
::                1.0.3 / Debug Log Upload: Replace PendingFileRename attachment with the system desktop screenshot instead, since this is often more helpful in troubleshooting
::                        BE AWARE A SCREENSHOT OF THE DESKTOP CAN CONTAIN PERSONAL INFORMATION, ONLY USE THE -UDL SWITCH IF YOU'RE AWARE OF THIS!
::                1.0.2 * Preface WMIC calls with null input to ensure the pipe is closed, fixes issue with WMI hanging on WinXP machines. Thanks to github:salsifis
::                        Relevant pull: https://github.com/bmrf/tron/pull/108
::                1.0.1 * Update date/time logging functions to use new log_with_date.bat. No functionality change but should help with code readability. Thanks to /u/DudeManFoo
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
::                Read the included instructions file for information on changing the default run options, using command-line switches, bundling your own scripts, and much more.
::
::                "Do not withhold good from those to whom it is due, when it is in your power to act." -p3:27

@echo off && cls && echo. && echo   Loading...
SETLOCAL




:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
color 0f
set SCRIPT_VERSION=1.2.1
set SCRIPT_DATE=2021-01-15

:: Get in the correct drive (~d0) and path (~dp0). Sometimes needed when run from a network or thumb drive.
:: We stay in the \resources directory for the rest of the script
%~d0 2>NUL
pushd "%~dp0" 2>NUL
pushd resources

:: Load the settings file
call functions\tron_settings.bat

:: Initialize the runtime environment
:: We need to pass all CLI switches (%*) so that if we're resuming and -resume is used, initialize_environment.bat has access to it to detect a resume state
call functions\initialize_environment.bat %*

:: Show help if requested
for %%i in (%*) do ( if /i %%i==-h ( call :display_help && exit /b 0) )

:: Parse command-line switches. If used these will override related settings specified in tron_settings.bat.
call :parse_cmdline_args %*

:: Do the pre-run checks and tasks (Admin rights check, temp directory check, SSD check etc)
call functions\prerun_checks_and_tasks.bat

:: Make sure user didn't pass -a and -asm together
if /i %AUTORUN%==yes (
if /i %AUTORUN_IN_SAFE_MODE%==yes ( cls && echo. && echo ERROR: You cannot use -a and -asm together. Pick one or the other. && exit /b 1 ) )

:: INTERNAL PREP: Check if we're resuming from a failed or incomplete previous run (often caused by forced reboots in stage_2_de-bloat)
:: Populate what stage we were on as well as what CLI switches were used. This could probably be a single IF block but I got lazy
:: trying to figure out all the annoying variable expansion parsing stuff. Oh well
if exist tron_stage.txt (
	REM Read in the values from the previous run
	set /p RESUME_STAGE=<tron_stage.txt 2>NUL
	set /p RESUME_SWITCHES=<tron_switches.txt 2>NUL		
)
if exist tron_stage.txt call :parse_cmdline_args %RESUME_SWITCHES%
if exist tron_stage.txt (
	call functions\log_with_date.bat "! Incomplete run detected. Resuming at %RESUME_STAGE% using switches %RESUME_SWITCHES%..."
	REM We can assume Caffeine isn't running (keeps system awake) if we're resuming, so go ahead and re-launch it before jumping to our stage
	start "" stage_0_prep\caffeine\caffeine.exe -noicon
	goto %RESUME_STAGE%
)


:: INTERNAL PREP: Skip update check if we don't have a network connection
if /i %NETWORK_AVAILABLE%==no (
	call functions\log_with_date.bat "! Tron doesn't think we have a network connection. Skipping update checks."
	set SKIP_CHECK_UPDATE=yes
	set WARNINGS_DETECTED=yes_check_update_skipped
)


:: INTERNAL PREP: Check for updates
if /i %DRY_RUN%==yes set SKIP_CHECK_UPDATE=yes
if /i %AUTORUN%==yes set SKIP_CHECK_UPDATE=yes
if /i %AUTORUN_IN_SAFE_MODE%==yes set SKIP_CHECK_UPDATE=yes
if /i %SKIP_CHECK_UPDATE%==no (
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
	echo  Command-line switches:
	echo   %*
	echo.
	echo  User-set variables:
	echo    AUTORUN:                %AUTORUN%
	echo    AUTORUN_IN_SAFE_MODE:   %AUTORUN_IN_SAFE_MODE%
	echo    AUTO_REBOOT_DELAY:      %AUTO_REBOOT_DELAY%
	echo    AUTO_SHUTDOWN:          %AUTO_SHUTDOWN%
	echo    CONFIG_DUMP:            %CONFIG_DUMP%
	echo    DEV_MODE:               %DEV_MODE%
	echo    DRY_RUN:                %DRY_RUN%
	echo    EMAIL_REPORT:           %EMAIL_REPORT%
	echo    EULA_ACCEPTED:          %EULA_ACCEPTED%
	echo    LOGFILE:                %LOGFILE%
	echo    LOGPATH:                %LOGPATH%
	echo    NO_PAUSE:               %NO_PAUSE%
	echo    PRESERVE_METRO_APPS:    %PRESERVE_METRO_APPS%
	echo    PRESERVE_POWER_SCHEME:  %PRESERVE_POWER_SCHEME%
	echo    PRESERVE_MALWAREBYTES:  %PRESERVE_MALWAREBYTES%
	echo    QUARANTINE_PATH:        %QUARANTINE_PATH%
	echo    SELF_DESTRUCT:          %SELF_DESTRUCT%
	echo    SKIP_ANTIVIRUS_SCANS:   %SKIP_ANTIVIRUS_SCANS%
	echo    SKIP_APP_PATCHES:       %SKIP_APP_PATCHES%
	echo    SKIP_CUSTOM_SCRIPTS:    %SKIP_CUSTOM_SCRIPTS%
	echo    SKIP_DEBLOAT:           %SKIP_DEBLOAT%
	echo    SKIP_DEBLOAT_UPDATE:    %SKIP_DEBLOAT_UPDATE%
	echo    SKIP_DEFRAG:            %SKIP_DEFRAG%
	echo    SKIP_DISM_CLEANUP:      %SKIP_DISM_CLEANUP%
	echo    SKIP_EVENT_LOG_CLEAR:   %SKIP_EVENT_LOG_CLEAR%
	echo    SKIP_KASPERSKY_SCAN:    %SKIP_KASPERSKY_SCAN%
	echo    SKIP_MBAM_INSTALL:      %SKIP_MBAM_INSTALL%
	echo    SKIP_ONEDRIVE_REMOVAL:  %SKIP_ONEDRIVE_REMOVAL%
	echo    SKIP_PAGEFILE_RESET:    %SKIP_PAGEFILE_RESET%
	echo    SKIP_SOPHOS_SCAN:       %SKIP_SOPHOS_SCAN%
	echo    SKIP_TELEMETRY_REMOVAL: %SKIP_TELEMETRY_REMOVAL%
	echo    SKIP_WINDOWS_UPDATES:   %SKIP_WINDOWS_UPDATES%
	echo    SKIP_WSUS_OFFLINE:      %SKIP_WSUS_OFFLINE%
	echo    UNICORN_POWER_MODE:     %UNICORN_POWER_MODE%
	echo    UPLOAD_DEBUG_LOGS:      %UPLOAD_DEBUG_LOGS%
	echo    VERBOSE:                %VERBOSE%
	echo.
	echo  Script-internal variables:
	echo    BAD_RUNPATH:            %BAD_RUNPATH%
	echo    CUR_DATE:               %CUR_DATE%
	echo    DTS:                    %DTS%
	echo    FIND:                   %FIND%
	echo    FINDSTR:                %FINDSTR%
	echo    FREE_SPACE_AFTER:       %FREE_SPACE_AFTER%
	echo    FREE_SPACE_BEFORE:      %FREE_SPACE_BEFORE%
	echo    FREE_SPACE_SAVED:       %FREE_SPACE_SAVED%
	echo    HELP:                   %HELP%
	echo    NETWORK_AVAILABLE:      %NETWORK_AVAILABLE%
	echo    REG:                    %REG%
	echo    SAFE_MODE:              %SAFE_MODE%
	echo    SAFEBOOT_OPTION:        %SAFEBOOT_OPTION%
	echo    SMART_PROBLEM_CODE:     %SMART_PROBLEM_CODE%
	echo    SYSTEM_LANGUAGE:        %SYSTEM_LANGUAGE%
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
	echo    RESUME_SWITCHES:        %RESUME_SWITCHES%
	echo    RESUME_STAGE:           %RESUME_STAGE%
	echo    WIN_VER:                !WIN_VER!
	echo    WIN_VER_NUM:            %WIN_VER_NUM%
	echo    WMIC:                   %WMIC%
	ENDLOCAL DISABLEDELAYEDEXPANSION
	exit /b 0
)


:: INTERNAL PREP: Autorun check. Skip EULA, Safe Mode but no Network, Welcome Screen and Email Report checks.
::                I assume if you use either of the auto switches (-a, -asm) you know what you're doing
:autorun_check
if /i %AUTORUN%==yes goto execute_jobs
if /i %AUTORUN_IN_SAFE_MODE%==yes goto execute_jobs



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
	echo  * tron.bat and the supporting code and scripts are free and open-source *
	echo  * under the MIT License. All 3rd-party tools Tron calls ^(MBAM, KVRT,    *
	echo  * etc^) are bound by their respective licenses. It is YOUR               *
	echo  * RESPONSIBILITY to determine if you have the rights to use these tools *
	echo  * in whatever environment you're in.                                    *
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


:: INTERNAL PREP: Check if we're in Safe Mode without Network support
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" (
	cls
	color 0e
	echo.
	echo  NOTE
	echo.
	echo  The system is in Safe Mode without Network support.
	echo  Tron functions best in regular boot mode or 
	echo  "Safe Mode with Networking" in order to download 
	echo  Windows and anti-virus definition file updates.
	echo.
	echo  Tron will still function, but rebooting to regular
	echo  mode or "Safe Mode with Networking" is recommended.
	echo.
	pause
	cls
)


:: INTERNAL PREP: UPM detection circuit
if /i %UNICORN_POWER_MODE%==on (color DF) else (color 0f)


:: INTERNAL PREP: Welcome screen
cls
echo  *********************  TRON v%TRON_VERSION% (%TRON_DATE%)  *********************
echo  * Script to automate a series of cleanup/disinfection tools           *
echo  * Author: vocatus on reddit.com/r/TronScript                          *
echo  *                                                                     *
echo  * Stage:        Tools:                                                *
echo  *  0 Prep:      Create SysRestore point/Rkill/ProcessKiller/Stinger/  *
echo  *               TDSSKiller/registry backup/clean oldest VSS set       *
echo  *  1 TempClean: TempFileClean/CCleaner/IE ^& Event Logs clean          *
echo  *  2 De-bloat:  Remove OEM bloatware, remove Metro bloatware          *
echo  *  3 Disinfect: Sophos/KVRT/MBAM/DISM repair                          *
echo  *  4 Repair:    MSIcleanup/PageFileReset/chkdsk/SFC/telemetry removal *
echo  *  5 Patch:     Update 7-Zip/Windows, DISM base cleanup               *
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
:: If -er switch was used or EMAIL_REPORT was set to yes, check for a correctly configured SwithMailSettings.xml
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %EMAIL_REPORT%==yes (
	%FINDSTR% /i "YOUR-EMAIL-ADDRESS" stage_7_wrap-up\email_report\SwithMailSettings.xml >NUL
	if !ERRORLEVEL!==0 (
		color cf
		cls
		echo.
		echo  ERROR
		echo.
		echo  You requested an email report ^(used the -er switch or set
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
echo execute_jobs>tron_stage.txt
:: Stamp CLI switches so we can resume if we get interrupted by a reboot
if /i not "%*"=="" echo %*> tron_switches.txt


:: Make sure we're actually in Safe Mode if AUTORUN_IN_SAFE_MODE was requested
if /i %AUTORUN_IN_SAFE_MODE%==yes (
	if /i not "%SAFE_MODE%"=="yes" (
		cls
		echo.
		call functions\log.bat " ! AUTORUN_IN_SAFE_MODE (-asm) used, but we're not in Safe Mode. Rebooting in 10 seconds."
		echo.
		if /i %DRY_RUN%==no (
			bcdedit /set {default} safeboot network >nul 2>&1
			shutdown -r -f -t 10 >nul 2>&1
			pause
			exit 4
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
	call functions\log.bat " Tron v%TRON_VERSION% (%TRON_DATE%)"
	call functions\log.bat "                          %WIN_VER% (%PROCESSOR_ARCHITECTURE%)"
	call functions\log.bat "                          Executing as "%USERDOMAIN%\%USERNAME%" on %COMPUTERNAME%"
	call functions\log.bat "                          Logfile: %LOGPATH%\%LOGFILE%"
	call functions\log.bat "                          Command-line switches: %*"
	call functions\log.bat "                          Time zone: %TIME_ZONE_NAME%"
	call functions\log.bat "                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%"
	call functions\log.bat "                          Free space before Tron run: %FREE_SPACE_BEFORE% MB"
	call functions\log.bat "-------------------------------------------------------------------------------"
)


:: If verbose (-v) was used, notify that we expanded the scrollback buffer
if /i %VERBOSE%==yes call functions\log_with_date.bat "!  VERBOSE (-v) output requested. All commands will display verbose output when possible."
if /i %VERBOSE%==yes call functions\log_with_date.bat "   Expanded the scrollback buffer to accomodate increased output."


:: INTERNAL PREP: Tell us if the update check failed or was skipped
if %WARNINGS_DETECTED%==yes_check_update_failed call functions\log_with_date.bat "! WARNING: Tron update check failed."
if %WARNINGS_DETECTED%==yes_check_update_skipped call functions\log_with_date.bat "! NOTE: Tron doesn't think the system has a network connection. Update checks were skipped."


:: INTERNAL PREP: Check if we had SMART disk errors and warn about it if so. This is detected in prerun_checks_and_tasks.bat
if /i not %SMART_PROBLEM_CODE%==undetected (
	call functions\log_with_date.bat "! WARNING: SMART check indicated at least one drive with '%SMART_PROBLEM_CODE%' status"
	call functions\log.bat "                                  SMART errors can mean a drive is close to failure"
	call functions\log.bat "                                  Recommend you back the system up BEFORE running Tron"
	call functions\log.bat "                                  Defrag will be skipped as a precaution"
	color 0e
)


:: INTERNAL PREP: If we're in Safe Mode, set the system to permanently boot into Safe Mode in case we get interrupted by a reboot
:: We undo this at the end of the script. Only works on Vista and up
if /i "%SAFE_MODE%"=="yes" (
	if %WIN_VER_NUM% geq 6.0 (
		title Tron v%TRON_VERSION% [stage_0_prep] [safeboot]
		call functions\log_with_date.bat "   Setting system to always boot to Safe Mode w/ Networking..."
		call functions\log_with_date.bat "   Will re-enable regular boot when Tron is finished."
		if /i %DRY_RUN%==no bcdedit /set {default} safeboot network >> "%LOGPATH%\%LOGFILE%"
		call functions\log_with_date.bat "   Done."
	)
)



:::::::::::::::::::
:: STAGE 0: PREP ::
:::::::::::::::::::
:stage_0_prep
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_0_prep>tron_stage.txt
title Tron v%TRON_VERSION% [stage_0_prep]
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
	call functions\log_with_date.bat "! SKIP_DEBLOAT (-sdb) set, skipping Stage 2..."
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
	call functions\log_with_date.bat "! SKIP_ANTIVIRUS_SCANS (-sa) set. Skipping Stage 3 (Sophos, KVRT, MBAM)."
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
title Tron v%TRON_VERSION% [stage_7_wrap-up]
call stage_7_wrap-up\stage_7_wrap-up.bat



:::::::::::::::::::::::::::::
:: STAGE 8: Custom Scripts ::
:::::::::::::::::::::::::::::
:stage_8_custom_scripts
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_8_custom_scripts>tron_stage.txt
if /i %SKIP_CUSTOM_SCRIPTS%==yes (
	call functions\log_with_date.bat "! SKIP_CUSTOM_SCRIPTS (-scs) set to "%SKIP_CUSTOM_SCRIPTS%", skipping..."
) else (
	if exist stage_8_custom_scripts\*.bat (
		echo stage_8_custom_scripts>tron_stage.txt
		call functions\log_with_date.bat "! Custom scripts detected, executing now..."
		call functions\log_with_date.bat "  stage_8_custom_scripts begin..."
		if %DRY_RUN%==no for %%i in (stage_8_custom_scripts\*.bat) do (
			call functions\log_with_date.bat "   Executing %%i..."
			call %%i
			call functions\log_with_date.bat "   %%i done."
		)
		call functions\log_with_date.bat "  stage_8_custom_scripts complete."
	)
)


::::::::::::::::::::::
:: Post-run Cleanup ::
::::::::::::::::::::::
:: JOB: Remove resume-related files, registry entry, boot switch, and other misc files
call functions\log_with_date.bat "   Doing miscellaneous clean up..."
	del /f /q tron_switches.txt >nul 2>&1
	del /f /q tron_stage.txt >nul 2>&1
	:: Skip these during a dry run because they toss errors. Not actually a problem, just an annoyance
	if %DRY_RUN%==no (
		bcdedit /deletevalue {current} safeboot >nul 2>&1
		bcdedit /deletevalue {default} safeboot >nul 2>&1
		bcdedit /deletevalue safeboot >nul 2>&1
	)
	del /f /q "%TEMP%\tron_smart_results.txt" >nul 2>&1
    del /f /q OOSU10.ini >nul 2>&1
    del /f /q SIV_DBGOUT.log >nul 2>&1
call functions\log_with_date.bat "   Done."


:: JOB: Shut down Caffeine which has kept the system awake during the Tron run
stage_0_prep\caffeine\caffeine.exe -appexit


:: Notify of Tron completion
title Tron v%TRON_VERSION% (%TRON_DATE%) [DONE]
call functions\log_with_date.bat "  TRON RUN COMPLETE. Use \resources\stage_9_manual_tools if further action is required."


:: Check if auto-reboot was requested
if "%AUTO_REBOOT_DELAY%"=="0" (
	call functions\log_with_date.bat "  Auto-reboot (-r) not selected. Reboot as soon as possible."
) else (
	call functions\log_with_date.bat "! Auto-reboot selected. Rebooting in %AUTO_REBOOT_DELAY% seconds."
)


:: Check if shutdown was requested
if /i %AUTO_SHUTDOWN%==yes call functions\log_with_date.bat "! Auto-shutdown selected. Shutting down in %AUTO_REBOOT_DELAY% seconds."


:: Notify that we're going to email the log file
if /i %EMAIL_REPORT%==yes call functions\log_with_date.bat "  Email report requested. Will email logs in a few moments."


:: Upload logs if the switch was used
if /i %UPLOAD_DEBUG_LOGS%==yes call functions\log_with_date.bat "  Debug log upload enabled (thank-you!). Will upload logs in a few moments."


:: Check if self-destruct was set
if /i %SELF_DESTRUCT%==yes (
	call functions\log_with_date.bat "! Self-destruct selected. De-rezzing self. Goodbye..."
)


:: Error checking. Color the window based on run results so we can see at a glance if it's done
color 2f
:: Were warnings detected?
if /i not %WARNINGS_DETECTED%==no (
	color e0
	call functions\log_with_date.bat "! WARNINGS were detected (%WARNINGS_DETECTED%). Recommend reviewing the log file."
)
:: Were errors detected?
if /i not %ERRORS_DETECTED%==no (
	color cf
	call functions\log_with_date.bat "! ERRORS were detected (%ERRORS_DETECTED%). Review the log file."
)

:: UPM detection circuit
if /i %UNICORN_POWER_MODE%==on color DF

:: Display and log the job summary
echo.
call functions\log.bat "-------------------------------------------------------------------------------"
call functions\log.bat " Tron v%TRON_VERSION% (%TRON_DATE%) complete"
call functions\log.bat "                          %WIN_VER% (%PROCESSOR_ARCHITECTURE%)"
call functions\log.bat "                          Executed as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%"
call functions\log.bat "                          Command-line switches: %*"
call functions\log.bat "                          Time zone: %TIME_ZONE_NAME%"
call functions\log.bat "                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%"
call functions\log.bat "                          Logfile: %LOGPATH%\%LOGFILE%"
call functions\log.bat "                          Warnings detected?:   %WARNINGS_DETECTED%"
call functions\log.bat "                          Debug logs uploaded?: %UPLOAD_DEBUG_LOGS%"
call functions\log.bat "                          Free space before Tron run: %FREE_SPACE_BEFORE% MB"
call functions\log.bat "                          Free space after Tron run:  %FREE_SPACE_AFTER% MB"
call functions\log.bat "                          Disk space reclaimed:       %FREE_SPACE_SAVED% MB *"
call functions\log.bat ""
call functions\log.bat "     * If you see negative disk space don't panic. Due to how some of Tron's"
call functions\log.bat "       functions work, actual space reclaimed will not be visible until after"
call functions\log.bat "       a reboot."
call functions\log.bat "-------------------------------------------------------------------------------"


:: JOB: Send the email report if requested
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %EMAIL_REPORT%==yes (
	if /i %DRY_RUN%==no (
		stage_7_wrap-up\email_report\SwithMail.exe /s /x "stage_7_wrap-up\email_report\SwithMailSettings.xml" /l "%RAW_LOGS%\swithmail.log" /a "%LOGPATH%\%LOGFILE%|%SUMMARY_LOGS%\tron_removed_files.txt|%SUMMARY_LOGS%\tron_removed_programs.txt" /p1 "Tron v%TRON_VERSION% (%TRON_DATE%) executed as %USERDOMAIN%\%USERNAME%" /p2 "%LOGPATH%\%LOGFILE%" /p3 "%SAFE_MODE% %SAFEBOOT_OPTION%" /p4 "%FREE_SPACE_BEFORE%/%FREE_SPACE_AFTER%/%FREE_SPACE_SAVED%" /p5 "%CLI_switches%"

		if !ERRORLEVEL!==0 (
			call functions\log_with_date.bat "  Done."
		) else (
			call functions\log_with_date.bat "^! Something went wrong, email may not have gone out. Check your settings."
		)
	)
)
ENDLOCAL DISABLEDELAYEDEXPANSION


:: JOB: Upload debug logs if requested
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %UPLOAD_DEBUG_LOGS%==yes (
	if /i %DRY_RUN%==no (

		if /i %WIN_VER_NUM% GEQ 6.2 stage_7_wrap-up\email_report\SwithMail.exe /s /x "stage_7_wrap-up\email_report\debug_log_upload_settings.xml" /l "%USERPROFILE%\desktop\swithmail.log" /a "%LOGPATH%\%LOGFILE%|%RAW_LOGS%\GUID_dump_%COMPUTERNAME%_%CUR_DATE%.txt|%RAW_LOGS%\Metro_app_dump_%COMPUTERNAME%_%CUR_DATE%.txt|%RAW_LOGS%\tron_%COMPUTERNAME%_pre-run_screenshot*.png" /p1 "Tron v%TRON_VERSION% (%TRON_DATE%) executed as %USERDOMAIN%\%USERNAME%" /p2 "%LOGPATH%\%LOGFILE%" /p3 "%SAFE_MODE% %SAFEBOOT_OPTION%" /p4 "%FREE_SPACE_BEFORE%/%FREE_SPACE_AFTER%/%FREE_SPACE_SAVED%" /p5 "%CLI_switches%"
		if /i %WIN_VER_NUM% LSS 6.2 stage_7_wrap-up\email_report\SwithMail.exe /s /x "stage_7_wrap-up\email_report\debug_log_upload_settings.xml" /l "%USERPROFILE%\desktop\swithmail.log" /a "%LOGPATH%\%LOGFILE%|%RAW_LOGS%\GUID_dump_%COMPUTERNAME%_%CUR_DATE%.txt|%RAW_LOGS%\tron_%COMPUTERNAME%_pre-run_screenshot*.png" /p1 "Tron v%TRON_VERSION% (%TRON_DATE%) executed as %USERDOMAIN%\%USERNAME%" /p2 "%LOGPATH%\%LOGFILE%" /p3 "%SAFE_MODE% %SAFEBOOT_OPTION%" /p4 "%FREE_SPACE_BEFORE%/%FREE_SPACE_AFTER%/%FREE_SPACE_SAVED%" /p5 "%CLI_switches%"

		if !ERRORLEVEL!==0 (
			call functions\log_with_date.bat "  Done."
		) else (
			call functions\log_with_date.bat "^! Something went wrong, logs may not have uploaded. Please notify Vocatus."
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
	exit 0
)

:end_and_skip_shutdown
echo.
if /i %NO_PAUSE%==no pause
if /i not %ERRORS_DETECTED%==no exit /b 1
if /i not %WARNINGS_DETECTED%==no exit /b 2
exit /b 0
ENDLOCAL
:: That's all, folks




:::::::::::::::
:: FUNCTIONS ::
:::::::::::::::
:: Get the date into ISO 8601 standard format (yyyy-mm-dd) so we can use it
:set_cur_date
for /f %%a in ('^<NUL %WMIC% OS GET LocalDateTime ^| %FIND% "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%
goto :eof

:: Parse CLI switches and flip the appropriate variables
:parse_cmdline_args
:: This line required for Swithmail. We use CLI_switches instead of %* because Swithmail chokes if %* is empty.
:: CLI_switches is used in three places: The two Swithmail jobs (upload debug logs and email report) and to dump the list of CLI switches to the log file at the beginning
if /i not "%*"=="" (set CLI_switches=%*) else (set CLI_switches=No CLI switches used)
for %%i in (%*) do (
	if /i %%i==-a set AUTORUN=yes
	if /i %%i==-asm set AUTORUN_IN_SAFE_MODE=yes
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
	if /i %%i==-pmb set PRESERVE_MALWAREBYTES=yes
	if /i %%i==-r set AUTO_REBOOT_DELAY=15
	if /i %%i==-sa set SKIP_ANTIVIRUS_SCANS=yes
	if /i %%i==-sap set SKIP_APP_PATCHES=yes
	if /i %%i==-scs set SKIP_CUSTOM_SCRIPTS=yes
	if /i %%i==-scc set SKIP_COOKIE_CLEANUP=yes
	if /i %%i==-sd set SKIP_DEFRAG=yes
	if /i %%i==-sdb set SKIP_DEBLOAT=yes
	if /i %%i==-sdc set SKIP_DISM_CLEANUP=yes
	if /i %%i==-sdu set SKIP_DEBLOAT_UPDATE=yes
	if /i %%i==-se set SKIP_EVENT_LOG_CLEAR=yes
	if /i %%i==-sk set SKIP_KASPERSKY_SCAN=yes
	if /i %%i==-sm set SKIP_MBAM_INSTALL=yes
	if /i %%i==-sor set SKIP_ONEDRIVE_REMOVAL=yes
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

:: Show help if requested
:display_help
	cls
	echo.
	echo  Tron v%TRON_VERSION% ^(%TRON_DATE%^)
	echo  Author: vocatus on old.reddit.com/r/TronScript
	echo.
	echo   Usage: tron.bat ^[ ^[-a^|-asm^] -c -d -dev -e -er -m -np -o -p -pmb -r -sa -sap -scc -scs -sd
	echo                    -sdb -sdc -sdu -se -sk -sm -sor -spr -ss -str -swu -swo -udl -v -x^] ^| ^[-h^]
	echo.
	echo   Optional switches ^(can be combined^):
	echo    -a   Automatic mode ^(no welcome screen or prompts; implies -e^)
	echo    -asm Automatic mode ^(no welcome screen or prompts; implies -e; reboots to Safe Mode first^)
	echo    -c   Config dump ^(display config. Can be used with other switches to see what
	echo         WOULD happen, but script will never execute if this switch is used^)
	echo    -d   Dry run ^(run through script but don't execute any jobs^)
	echo    -dev Override OS detection ^(allow running on unsupported Windows versions^)
	echo    -e   Accept EULA ^(suppress disclaimer warning screen^)
	echo    -er  Email a report when finished. Requires you to configure SwithMailSettings.xml
	echo    -m   Preserve OEM Metro apps ^(don't remove them^)
	echo    -np  Skip pause at the end of the script
	echo    -o   Power off after running ^(overrides -r^)
	echo    -p   Preserve power settings ^(don't reset to Windows default^)
	echo    -pmb Preserve Malwarebytes ^(don't uninstall it^) after Tron is complete
	echo    -r   Reboot automatically 15 seconds after script completion
	echo    -sa  Skip ALL anti-virus scans ^(KVRT, MBAM, SAV^)
	echo    -sap Skip application patches ^(don't patch 7-Zip^)
	echo    -scs Skip custom scripts ^(has no effect if you haven't supplied custom scripts^)
	echo    -scc Skip cookie cleanup ^(not recommended, Tron auto-preserves most common login cookies^)
	echo    -sd  Skip defrag ^(force Tron to ALWAYS skip Stage 6 defrag^)
	echo    -sdb Skip de-bloat ^(entire OEM bloatware removal process; implies -m^)
	echo    -sdc Skip DISM cleanup ^(SxS component store deflation^)
	echo    -sdu Skip debloat update. Prevent Tron from auto-updating the S2 debloat lists
	echo    -se  Skip Event Log clear ^(don't backup then wipe Windows Event Logs^)
	echo    -sk  Skip Kaspersky Virus Rescue Tool ^(KVRT^) scan
	echo    -sm  Skip Malwarebytes Anti-Malware ^(MBAM^) installation
	echo    -sor Skip OneDrive removal regardless whether it's in use or not
	echo    -spr Skip page file settings reset ^(don't set to "Let Windows manage the page file"^)
	echo    -ss  Skip Sophos Anti-Virus ^(SAV^) scan
	echo    -str Skip Telemetry Removal ^(just turn telemetry off instead of removing it^)
	echo    -swu Skip Windows Updates entirely ^(ignore both WSUS Offline and online methods^)
	echo    -swo Skip user-supplied WSUS Offline updates ^(if they exist; online updates still attempted^)
	echo    -udl Upload debug logs. Send tron.log and the system GUID dump to the Tron developer
	echo    -v   Verbose. Show as much output as possible. NOTE: Significantly slower!
	echo    -x   Self-destruct. Tron deletes itself after running and leaves logs intact
	echo.
	echo   Misc switches ^(must be used alone^)
	echo    -h   Display this help text
	echo.
	goto :eof

:eof

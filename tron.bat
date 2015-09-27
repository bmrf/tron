:: Purpose:       Runs a series of cleaners and anti-virus engines to clean up/disinfect a Windows PC (all Windows versions XP and up are supported)
::                  Kevin Flynn:  "Who's that guy?"
::                  Program:      "That's Tron. He fights for the User."
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       6.7.1 + tron.bat:prep:             Check to see if Tron is running from Windows TEMP folder, alert the user if so, and then exit. Thanks to /u/ALittleFunInTheSun
::                6.7.0 + stage_4_repair:telemetry:  Add purging of Windows 10 telemetry! NOTE: This is a working first attempt; PLEASE review the code or
::                                                   run it on Win10 systems and give feedback if anything breaks so I can fix it ASAP! Big, big thanks 
::                                                   to the win10-unf**k Github project, the voat.co Aegis project, and many other random places around the web
::                      * stage_4_repair:dism_store: Expand Dism image repair to include Windows 10
::                      ! stage_4_repair:dism_store: Fix long-time bug where Dism image repair and cleanup wasn't running on Server 2012
::                      * stage_2_de-bloat:metro:    Expand OEM Metro app purge to include Windows 10
::                      * stage_2_de-bloat:oem:      Switch order of debloat operations to target specific GUIDs first and run wildcard as catch-all afterwards.
::                                                   The system can't be force-rebooted when targeting a GUID specifically, but it CAN be when targeting with a 
::                                                   wildcard. So, we first try and catch everything we know of in hopes that we'll eliminiate some of the GUIDs
::                                                   that force a reboot in wildcard mode. TL;DR: should be less forced reboots in stage 2.
::                      ! stage_1_tempclean:ie:      Move IE ClearMyTracksByProcess to Vista and up section (does not run on XP/2003)
:: Usage:         Run this script in Safe Mode as an Administrator, follow the prompts, and reboot when finished. That's it.
::
::                OPTIONAL command-line flags (can be combined, none are required):
::                      -a   Automatic mode (no welcome screen or prompts; implies -e)
::                      -c   Config dump (display config. Can be used with other flags to see what
::                           WOULD happen, but script will never execute if this flag is used)
::                      -d   Dry run (run through script without executing any jobs)
::                      -e   Accept EULA (suppress disclaimer warning screen)
::                      -er  Email a report when finished. Requires you to configure SwithMailSettings.xml
::                      -h   Display help text
::                      -m   Preserve OEM Metro apps (don't remove them)
::                      -np  Skip the pause at the end of script
::                      -o   Power off after running (overrides -r)
::                      -p   Preserve power settings (don't reset to Windows default)
::                      -r   Reboot (auto-reboot 15 seconds after completion)
::                      -sa  Skip ALL antivirus scans (KVRT, MBAM, SAV)
::                      -sb  Skip de-bloat (OEM bloatware removal; implies -m)
::                      -sd  Skip defrag (force Tron to ALWAYS skip Stage 5 defrag)
::                      -se  Skip Event Log clearing
::                      -sfr Skip filesystem permissions reset (saves time if you're in a hurry)
::                      -sk  Skip Kaspersky Virus Rescue Tool (KVRT) scan
::                      -sm  Skip Malwarebytes Anti-Malware (MBAM) installation
::                      -sp  Skip patches (do not patch 7-Zip, Java Runtime, Adobe Flash or Reader)
::                      -spr Skip page file settings reset (don't set to "Let Windows manage the page file")
::                      -srr Skip registry permissions reset (saves time if you're in a hurry)
::                      -ss  Skip Sophos Anti-Virus (SAV) scan
::                      -str Skip Telemetry Removal (don't remove Windows user tracking, Win7 and up only)
::                      -sw  Skip Windows Updates (do not attempt to run Windows Update)
::                      -v   Verbose. Show as much output as possible. NOTE: Significantly slower!
::                      -x   Self-destruct. Tron deletes itself after running and leaves logs intact
::
::                If you don't like the defaults and don't want to use the command-line, edit the variables below to change the script defaults.
::
::                "Do not withold good from those who deserve it, when it is in your power to act." -p3:27
SETLOCAL
@echo off
:: Get the date into ISO 8601 standard date format (yyyy-mm-dd) so we can use it
call :set_cur_date



:::::::::::::::
:: VARIABLES :: ---------------- These are the defaults. Change them if you want ------------------- ::
:::::::::::::::
:: Rules for variables:
::  * NO quotes!                    (bad:  "c:\directory\path"       )
::  * NO trailing slashes on paths! (bad:   c:\directory\            )
::  * Spaces are okay               (okay:  c:\my folder\with spaces )
::  * Network paths are okay        (okay:  \\server\share name      )

:: By DEFAULT, LOGPATH is the parent directory for all of Tron's output (logs, backups, etc). Tweak the paths below to your liking if you want to change it
:: If you want a separate directory generated per Tron run (for example when doing multiple runs for testing), use something like this:
::   set LOGPATH=%SystemDrive%\Logs\tron\%computername%_%DTS%
set LOGPATH=%SystemDrive%\Logs\tron

:: Master log file. To differentiate logfiles if you're doing multiple runs, you can set this to something like:
::  set LOGFILE=tron_%COMPUTERNAME%_%DTS%.log
set LOGFILE=tron.log

:: Where Tron should save files that the various virus scanners put in quarantine. Currently unused (created, but nothing is stored here)
set QUARANTINE=%LOGPATH%\quarantine

:: Registry, Event Logs, and power scheme backups are all saved here
set BACKUPS=%LOGPATH%\backups

:: Where to save raw unprocessed logs from the various sub-tools
set RAW_LOGS=%LOGPATH%\raw_logs

:: Where to save the summary logs
set SUMMARY_LOGS=%LOGPATH%\summary_logs


:::::::::::::::::::::
:: SCRIPT DEFAULTS ::
:::::::::::::::::::::
:: ! All defaults here are overridden if their respective command-line flag is used
::   If you use a CLI flag and Tron encounters a reboot, the CLI flag will be honored when the script resumes
:: AUTORUN                (-a)   = Automatic execution (no welcome screen or prompts), implies -e
:: DRY_RUN                (-d)   = Run through script but skip all actual actions (test mode)
:: EULA_ACCEPTED          (-e)   = Accept EULA (suppress disclaimer warning screen)
:: EMAIL_REPORT           (-er)  = Email post-run report with log file. Requires you to have configured SwithMailSettings.xml prior to running
:: PRESERVE_METRO_APPS    (-m)   = Don't remove OEM Metro apps
:: NO_PAUSE               (-np)  = Set to yes to skip pause at the end of the script
:: AUTO_SHUTDOWN          (-o)   = Shutdown after the finishing. Overrides auto-reboot
:: PRESERVE_POWER_SCHEME  (-p)   = Preserve active power scheme. Default is to reset power scheme to Windows defaults at the end of Tron
:: AUTO_REBOOT_DELAY      (-r)   = Post-run delay (in seconds) before rebooting. Set to 0 to disable auto-reboot
:: SKIP_ANTIVIRUS_SCANS   (-sa)  = Skip ALL antivirus scans (KVRT, MBAM, SAV). Use per-scanner flags to individually toggle usage
:: SKIP_DEBLOAT           (-sb)  = Set to yes to skip de-bloat section (OEM bloat removal). Implies -m
:: SKIP_DEFRAG            (-sd)  = Set to yes to skip defrag regardless whether the system drive is an SSD or not. When set to "no" the script will auto-detect SSDs and skip defrag if one is detected
:: SKIP_EVENT_LOG_CLEAR   (-se)  = Set to yes to skip Event Log clearing
:: SKIP_FILEPERMS_RESET   (-sfr) = Set to yes to skip filesystem permissions reset in the Windows system directory. Can save a lot of time if you're in a hurry
:: SKIP_KASKPERSKY_SCAN   (-sk)  = Set to yes to skip Kaspersky Virus Rescue Tool scan
:: SKIP_MBAM_INSTALL      (-sm)  = Set to yes to skip Malwarebytes Anti-Malware installation
:: SKIP_PATCHES           (-sp)  = Set to yes to skip patches (do not patch 7-Zip, Java Runtime, Adobe Flash Player and Adobe Reader)
:: SKIP_PAGEFILE_RESET    (-spr) = Skip page file settings reset (don't set to "Let Windows manage the page file")
:: SKIP_REGPERMS_RESET    (-srr) = Set to yes to skip registry permissions reset. Can save a lot of time if you're in a hurry
:: SKIP_SOPHOS_SCAN       (-ss)  = Set to yes to skip Sophos Anti-Virus scan
:: SKIP_TELEMETRY_REMOVAL (-str) = Set to yes to skip removal of Windows "telemetry" (user tracking) related upates
:: SKIP_WINDOWS_UPDATES   (-sw)  = Set to yes to skip Windows Updates
:: VERBOSE                (-v)   = When possible, show as much output as possible from each program Tron calls (e.g. Sophos, KVRT, etc). NOTE: This is often much slower
:: SELF_DESTRUCT          (-x)   = Set to yes to have Tron automatically delete itself after running. Leaves logs intact
set AUTORUN=no
set DRY_RUN=no
set EULA_ACCEPTED=no
set EMAIL_REPORT=no
set PRESERVE_METRO_APPS=no
set NO_PAUSE=no
set AUTO_SHUTDOWN=no
set PRESERVE_POWER_SCHEME=no
set AUTO_REBOOT_DELAY=0
set SKIP_ANTIVIRUS_SCANS=no
set SKIP_DEBLOAT=no
set SKIP_DEFRAG=no
set SKIP_EVENT_LOG_CLEAR=no
set SKIP_FILEPERMS_RESET=no
set SKIP_KASPERSKY_SCAN=no
set SKIP_MBAM_INSTALL=no
set SKIP_PATCHES=no
set SKIP_PAGEFILE_RESET=no
set SKIP_REGPERMS_RESET=no
set SKIP_SOPHOS_SCAN=no
set SKIP_TELEMETRY_REMOVAL=no
set SKIP_WINDOWS_UPDATES=no
set UNICORN_POWER_MODE=off
set VERBOSE=no
set SELF_DESTRUCT=no





:: --------------------------------------------------------------------------------------------------- ::
:: ----------------- Don't edit anything below this line lest you awaken the Balrog ------------------ ::
:: --------------------------------------------------------------------------------------------------- ::





:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
cls
color 0f
set SCRIPT_VERSION=6.7.1
set SCRIPT_DATE=2015-09-xx
title TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%)

:: Initialize script-internal variables. Most of these get clobbered later so don't change them here
set CONFIG_DUMP=no
set REPO_URL=https://www.bmrf.org/repos/tron
set REPO_BTSYNC_KEY=BYQYYECDOJPXYA2ZNUDWDN34O2GJHBM47
set REPO_SCRIPT_DATE=0
set REPO_SCRIPT_VERSION=0
set HELP=no
set TARGET_METRO=no
set FREE_SPACE_AFTER=0
set FREE_SPACE_BEFORE=0
set FREE_SPACE_SAVED=0
set SAFE_MODE=no
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" set SAFE_MODE=yes
if /i "%SAFEBOOT_OPTION%"=="NETWORK" set SAFE_MODE=yes
:: Stuff related to resuming from an interrupted run
set RESUME_STAGE=0
set RESUME_FLAGS=0
set RESUME_DETECTED=no
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce\ /v "tron_resume" >nul 2>&1
if %ERRORLEVEL%==0 set RESUME_DETECTED=yes
if /i "%1"=="-resume" set RESUME_DETECTED=yes


:: Make sure we're not running from the %TEMP% directory
if "%~dp0"=="%TEMP%\" (
	color 0c
	cls
	echo.
	echo  ERROR
	echo.
	echo  Tron is running from the Windows TEMP directory. Tron 
	echo  cannot run from the TEMP directory as it's one of the 
	echo  first places to get wiped when Tron starts. Run Tron
	echo  from another location ^(directly from the Desktop is 
	echo  the recommended location^).
	echo.
	echo  Tron will now quit.
	echo.
	pause
	cls
	goto :eof
)


:: Get in the correct drive (~d0). This is sometimes needed when running from a thumb drive
%~d0 2>NUL
:: Get in the correct path (~dp0). This is useful if we start from a network share, it converts CWD to a drive letter
pushd %~dp0 2>NUL


:: PREP: Parse command-line arguments (functions are at bottom of script)
call :parse_cmdline_args %*


:: PREP: Execute help if requested
if /i %HELP%==yes (
	::cls
	echo.
	echo  Tron v%SCRIPT_VERSION% ^(%SCRIPT_DATE%^)
	echo  Author: vocatus on reddit.com/r/TronScript
	echo.
	echo   Usage: %0% ^[-a -c -d -e -er -m -o -p -r -sa -sb -sd -se -sfr -sk
	echo                -sm -sp -spr -srr -ss -str -sw -v -x^] ^| ^[-h^]
	echo.
	echo   Optional flags ^(can be combined^):
	echo    -a   Automatic mode ^(no welcome screen or prompts; implies -e^)
 	echo    -c   Config dump ^(display config. Can be used with other flags to see what
	echo         WOULD happen, but script will never execute if this flag is used^)
	echo    -d   Dry run ^(run through script but don't execute any jobs^)
	echo    -e   Accept EULA ^(suppress disclaimer warning screen^)
	echo    -er  Email a report when finished. Requires you to configure SwithMailSettings.xml
	echo    -m   Preserve OEM Metro apps ^(don't remove them^)
	echo    -np  Skip pause at the end of the script
	echo    -o   Power off after running ^(overrides -r^)
	echo    -p   Preserve power settings ^(don't reset to Windows default^)
	echo    -r   Reboot automatically ^(auto-reboot 15 seconds after completion^)
	echo    -sa  Skip ALL anti-virus scans ^(KVRT, MBAM, SAV^)
	echo    -sb  Skip de-bloat ^(OEM bloatware removal; implies -m^)
	echo    -sd  Skip defrag ^(force Tron to ALWAYS skip Stage 5 defrag^)
	echo    -se  Skip Event Log clearing
	echo    -sfr Skip filesystem permissions reset ^(saves time if you're in a hurry^)
	echo    -sk  Skip Kaspersky Virus Rescue Tool ^(KVRT^) scan
	echo    -sm  Skip Malwarebytes Anti-Malware ^(MBAM^) installation
	echo    -sp  Skip patches ^(do not patch 7-Zip, Java Runtime, Adobe Flash or Reader^)
	echo    -spr Skip page file settings reset ^(don't set to "Let Windows manage the page file"^)
	echo    -srr Skip registry permissions reset ^(saves time if you're in a hurry^)
	echo    -ss  Skip Sophos Anti-Virus ^(SAV^) scan
	echo    -str Skip Telemetry Removal ^(don't remove Windows user tracking, Win7 and up only^)
	echo    -sw  Skip Windows Updates ^(do not attempt to run Windows Update^)
	echo    -v   Verbose. Show as much output as possible. NOTE: Significantly slower!
	echo    -x   Self-destruct. Tron deletes itself after running and leaves logs intact
 	echo.
	echo   Misc flags ^(must be used alone^)
	echo    -h   Display this help text
	echo.
	exit /b 0
	)


:: PREP: Get in the resources sub-directory. We stay here for the rest of the script
pushd resources


:: PREP: Force WMIC location in case the system PATH is messed up
set WMIC=%SystemRoot%\system32\wbem\wmic.exe


:: PREP: Detect the version of Windows we're on. This determines a few things later in the script, such as which versions of SFC and powercfg.exe we run, as well as whether or not to attempt removal of Windows 8/8.1 metro apps
set WIN_VER=undetected
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| Find "ProductName"') DO set WIN_VER=%%i %%j


:: PREP: Detect Solid State hard drives (determines if post-run defrag executes or not)
:: Basically we use a trick to set the global SSD_DETECTED variable outside of the setlocal block by stacking it on the same line so it gets executed along with ENDLOCAL
:: Big time thanks to reddit.com/user/Suddenly_Engineer and reddit.com/user/Aberu for helping with this
set SSD_DETECTED=no
SETLOCAL ENABLEDELAYEDEXPANSION
for /f "tokens=1" %%i in ('stage_6_optimize\defrag\smartctl.exe --scan') do (
	stage_6_optimize\defrag\smartctl.exe %%i -a | find /i "Solid State" >NUL
	if "!ERRORLEVEL!"=="0" ENDLOCAL DISABLEDELAYEDEXPANSION && set SSD_DETECTED=yes&& goto freespace_check
	)
for /f "tokens=1" %%i in ('stage_6_optimize\defrag\smartctl.exe --scan') do (
	stage_6_optimize\defrag\smartctl.exe %%i -a | find /i "SSD" >NUL
	if "!ERRORLEVEL!"=="0" ENDLOCAL DISABLEDELAYEDEXPANSION && set SSD_DETECTED=yes&& goto freespace_check
	)
for /f "tokens=1" %%i in ('stage_6_optimize\defrag\smartctl.exe --scan') do (
	stage_6_optimize\defrag\smartctl.exe %%i -a | find /i "RAID" >NUL
	if "!ERRORLEVEL!"=="0" ENDLOCAL DISABLEDELAYEDEXPANSION && set SSD_DETECTED=yes&& goto freespace_check
	)
for /f "tokens=1" %%i in ('stage_6_optimize\defrag\smartctl.exe --scan') do (
	stage_6_optimize\defrag\smartctl.exe %%i -a | find /i "SandForce" >NUL
	if "!ERRORLEVEL!"=="0" ENDLOCAL DISABLEDELAYEDEXPANSION && set SSD_DETECTED=yes&& goto freespace_check
	)
ENDLOCAL DISABLEDELAYEDEXPANSION


:: PREP: Get free space on the system drive and stash it for comparison later
:: Thanks to Stack Overflow user Aacini in this post: http://stackoverflow.com/a/20392479/1347428
:freespace_check
for /F "tokens=2 delims=:" %%a in ('fsutil volume diskfree %SystemDrive% ^| find /i "avail free"') do set bytes=%%a
:: GB version
::set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024/1024
:: MB version
set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024


:: PREP: Check if we're resuming from a failed or incomplete previous run (often caused by forced reboots in stage_3_de-bloat)
:: Populate what stage we were on as well as what CLI flags were used. This could probably be a single IF block but I got lazy
:: trying to figure out all the annoying variable expansion parsing stuff. Oh well
if /i %RESUME_DETECTED%==yes (
	REM Quick check for a faulty resume detection
	if not exist tron_stage.txt (
		reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f /v "tron_resume" >nul 2>&1
		REM Bail out
		goto detect_win_ver
		)

	:: Otherwise read in the values from the previous run
	set /p RESUME_STAGE=<tron_stage.txt 2>NUL
	set /p RESUME_FLAGS=<tron_flags.txt 2>NUL
)
if /i %RESUME_DETECTED%==yes call :parse_cmdline_args %RESUME_FLAGS%
if /i %RESUME_DETECTED%==yes (
	:: Notify and jump
	call :log "%CUR_DATE% %TIME% ! Incomplete run detected. Resuming at %RESUME_STAGE% using flags %RESUME_FLAGS%..."
	:: Reset the RunOnce flag in case we get interrupted again. Disabled for now, just to resume-looping where we keep trying to resume
	:: even if a reboot didn't happen
	::reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f /v "tron_resume" /t REG_SZ /d "%~dp0tron.bat %-resume" >NUL
	goto %RESUME_STAGE%
)


:: PREP: Re-enable the standard "F8" key functionality for choosing bootup options (Microsoft disables it by default starting in Windows 8 and up)
:: Read WIN_VER and run the scan if we're on some derivative of 8. We don't need to check for Server 2012 because it's set to "legacy" by default.
:detect_win_ver
if "%WIN_VER:~0,9%"=="Windows 8" (
	bcdedit /set {default} bootmenupolicy legacy
	)


:: PREP: Update check
:: Skip this job if we're doing a dry run or if AUTORUN is set
if /i %DRY_RUN%==yes goto skip_update_check
if /i %AUTORUN%==yes goto skip_update_check
:: Use wget to fetch sha256sums.txt from the repo and parse through it. Extract latest version number and release date from last line (which is always the latest release)
stage_0_prep\check_update\wget.exe --no-check-certificate %REPO_URL%/sha256sums.txt -O %TEMP%\sha256sums.txt 2>NUL
:: Assuming there was no error, go ahead and extract version number into REPO_SCRIPT_VERSION, and release date into REPO_SCRIPT_DATE
if /i %ERRORLEVEL%==0 (
	for /f "tokens=1,2,3 delims= " %%a in (%TEMP%\sha256sums.txt) do set WORKING=%%b
	for /f "tokens=4 delims=,()" %%a in (%TEMP%\sha256sums.txt) do set WORKING2=%%a
	)
if /i %ERRORLEVEL%==0 (
	set REPO_SCRIPT_VERSION=%WORKING:~1,6%
	set REPO_SCRIPT_DATE=%WORKING2%
	)

:: Reset window title since wget clobbers it
title TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%)

:: Notify if an update was found
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %SCRIPT_VERSION% LSS %REPO_SCRIPT_VERSION% (
	set CHOICE=y
	color 8a
	cls
	echo.
	echo  ^^! A newer version of Tron is available on the official repo.
	echo.
	echo    Your version:   %SCRIPT_VERSION% ^(%SCRIPT_DATE%^)
	echo    Latest version: %REPO_SCRIPT_VERSION% ^(%REPO_SCRIPT_DATE%^)
	echo.
	echo    Option 1: Sync directly from repo using BT Sync read-only key:
	echo     %REPO_BTSYNC_KEY%
	echo.
	echo    Option 2: Download the latest self-extracting .exe yourself:
	echo     %REPO_URL%
	echo.
	echo    Option 3: Automatically download latest .exe to the desktop
	echo              ^(This copy of Tron will self-destruct afterwards^)
	echo.
	set /p CHOICE= Auto-download latest version now? [Y/n]:
	if !CHOICE!==y (
		color 8B
		cls
		echo.
		echo %TIME%   Downloading new version to the desktop, please wait...
		echo.
		stage_0_prep\check_update\wget.exe --no-check-certificate "%REPO_URL%/Tron v%REPO_SCRIPT_VERSION% (%REPO_SCRIPT_DATE%).exe" -O "%USERPROFILE%\Desktop\Tron v%REPO_SCRIPT_VERSION% (%REPO_SCRIPT_DATE%).exe"
		echo.
		echo %TIME%   Download finished.
		echo.
		echo %TIME%   Verifying SHA256 pack integrity, please wait...
		echo.
		stage_0_prep\check_update\hashdeep.exe -s -e -b -v -a -k %TEMP%\sha256sums.txt "%USERPROFILE%\Desktop\Tron*.exe" | find /i "Files matched: 1"
		if !ERRORLEVEL!==0 (
			echo %TIME%   SHA256 pack integrity verified. The new version is on your desktop.
			echo.
			echo %TIME%   This copy of Tron will now self-destruct.
			echo.
			popd
			pause
			echo. && ENDLOCAL DISABLEDELAYEDEXPANSION && set SELF_DESTRUCT=yes&& goto self_destruct
		) else (
			color 0c
			echo %TIME% ^^! ERROR: Download FAILED the integrity check. Recommend manually
			echo                      downloading latest version. Will delete failed file and
			echo                      exit.
			echo.
			pause
			REM Clean up after ourselves
			del /f /q "%USERPROFILE%\Desktop\Tron v%REPO_SCRIPT_VERSION% (%REPO_SCRIPT_DATE%).exe"
			del /f /q %TEMP%\sha256sums.txt
			exit
		)
	)
	color 0f
)
ENDLOCAL DISABLEDELAYEDEXPANSION
:: Clean up after ourselves
if exist "%TEMP%\*sums.txt" del "%TEMP%\*sums.txt"
:skip_update_check



:: PREP: Execute config dump if requested
if /i %CONFIG_DUMP%==yes (
	cls
	echo.
	echo  Tron v%SCRIPT_VERSION% ^(%SCRIPT_DATE%^) config dump
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
	echo    SKIP_DEBLOAT:           %SKIP_DEBLOAT%
	echo    SKIP_DEFRAG:            %SKIP_DEFRAG%
	echo    SKIP_EVENT_LOG_CLEAR:   %SKIP_EVENT_LOG_CLEAR%
	echo    SKIP_FILEPERMS_RESET:   %SKIP_FILEPERMS_RESET%
	echo    SKIP_KASPERSKY_SCAN:    %SKIP_KASPERSKY_SCAN%
	echo    SKIP_MBAM_INSTALL:      %SKIP_MBAM_INSTALL%
	echo    SKIP_PATCHES:           %SKIP_PATCHES%
	echo    SKIP_PAGEFILE_RESET:    %SKIP_PAGEFILE_RESET%
	echo    SKIP_REGPERMS_RESET:    %SKIP_REGPERMS_RESET%
	echo    SKIP_SOPHOS_SCAN:       %SKIP_SOPHOS_SCAN%
	echo	SKIP_TELEMETRY_REMOVAL: %SKIP_TELEMETRY_REMOVAL%
	echo    SKIP_WINDOWS_UPDATES:   %SKIP_WINDOWS_UPDATES%
	echo    UNICORN_POWER_MODE:     %UNICORN_POWER_MODE%
	echo    VERBOSE:                %VERBOSE%
	echo.
	echo  Script-internal variables:
	echo    CUR_DATE:               %CUR_DATE%
	echo    DTS:                    %DTS%
	echo    FREE_SPACE_AFTER:       %FREE_SPACE_AFTER%
	echo    FREE_SPACE_BEFORE:      %FREE_SPACE_BEFORE%
	echo    FREE_SPACE_SAVED:       %FREE_SPACE_SAVED%
	echo    HELP:                   %HELP%
	echo    SAFE_MODE:              %SAFE_MODE%
	echo    SAFEBOOT_OPTION:        %SAFEBOOT_OPTION%
	echo    SSD_DETECTED:           %SSD_DETECTED%
	echo    TEMP:                   %TEMP%
	echo    TIME:                   %TIME%
	echo    PROCESSOR_ARCHITECTURE: %PROCESSOR_ARCHITECTURE%
	echo    REPO_BTSYNC_KEY:        %REPO_BTSYNC_KEY%
	echo    REPO_URL:               %REPO_URL%
	echo    REPO_SCRIPT_VERSION:    %REPO_SCRIPT_VERSION%
	echo    REPO_SCRIPT_DATE:       %REPO_SCRIPT_DATE%
	echo    RESUME_DETECTED:        %RESUME_DETECTED%
	echo    RESUME_FLAGS:           %RESUME_FLAGS%
	echo    RESUME_STAGE:           %RESUME_STAGE%
	echo    SCRIPT_VERSION:         %SCRIPT_VERSION%
	echo    SCRIPT_DATE:            %SCRIPT_DATE%
	:: We need this set/endlocal pair because on Vista the OS name has "(TM)" in it, which breaks the script. Sigh
	SETLOCAL ENABLEDELAYEDEXPANSION
	echo    WIN_VER:                !WIN_VER!
	ENDLOCAL DISABLEDELAYEDEXPANSION
	echo    WMIC:                   %WMIC%
	echo.
	exit /b 0
)


:: PREP: Act on autorun flag. Skips safe mode checks, admin rights check, and EULA check. I assume if you use the auto flag (-a) you know what you're doing
if /i %AUTORUN%==yes goto execute_jobs


::::::::::::::::::::::::
:: ADMIN RIGHTS CHECK ::
::::::::::::::::::::::::
:: We skip this check if we're in Safe Mode because Safe Mode command prompt always starts with Admin rights
SETLOCAL ENABLEDELAYEDEXPANSION
if /i not "%SAFE_MODE%"=="yes" (
	fsutil dirty query %systemdrive% >NUL
	:: Previous method
	::net session >nul 2>&1
	if /i not !ERRORLEVEL!==0 (
		color cf
		cls
		echo.
		echo  ERROR
		echo.
		echo  Tron doesn't think it is running as an Administrator.
		echo  Tron MUST be run with full Administrator rights to
		echo  function correctly.
		echo.
		echo  Close this window and re-run Tron as an Administrator.
		echo  ^(right-click Tron.bat and click "Run as Administrator"^)
		echo.
		pause
		exit /b 1
	)
)
SETLOCAL DISABLEDELAYEDEXPANSION


:: PREP: Display the annoying disclaimer screen. Sigh
cls
SETLOCAL ENABLEDELAYEDEXPANSION
if /i not %EULA_ACCEPTED%==yes (
	color CF
	echo  ************************** ANNOYING DISCLAIMER **************************
	echo  * NOTE^^! By running Tron you accept COMPLETE responsibility for ANYTHING *
	echo  * that happens. Although the chance of something bad happening due to   *
	echo  * Tron is pretty remote, it's always a possibility, and Tron has ZERO   *
	echo  * WARRANTY for ANY purpose. READ THE INSTRUCTIONS and understand what   *
	echo  * Tron does, because you run it AT YOUR OWN RISK.                       *
	echo  *                                                                       *
	echo  * Tron.bat and the supporting code and scripts I've written are free    *
	echo  * and open-source under the MIT License. All 3rd-party tools Tron calls *
	echo  * ^(MBAM, KVRT, etc^) are bound by their respective licenses. It is        *
	echo  * YOUR RESPONSIBILITY to determine if you have the rights to use these  *
	echo  * tools in whatever environment you're in.                              *
	echo  *                                                                       *
	echo  * BOTTOM LINE: there is NO WARRANTY, you are ON YOUR OWN, and anything  *
	echo  * that happens, good or bad, is YOUR RESPONSIBILITY.                    *
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


::::::::::::::::::::::
:: SAFE MODE CHECKS ::
::::::::::::::::::::::
:: Check if we're in safe mode
SETLOCAL ENABLEDELAYEDEXPANSION
set CHOICE=y
if /i not "%SAFE_MODE%"=="yes" (
	color 0c
	cls
	echo.
	echo  WARNING
	echo.
	echo  The system is not in safe mode. Tron functions best
	echo  in "Safe Mode with Networking" in order to download
	echo  Windows and anti-virus definition updates.
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

:: Check if we have network support
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" (
	color 0e
	cls
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


:: PREP: UPM detection circuit
if /i %UNICORN_POWER_MODE%==on (color DF) else (color 0f)


::::::::::::::::::::
:: WELCOME SCREEN ::
::::::::::::::::::::
cls
echo  **********************  TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%)  *********************
echo  * Script to automate a series of cleanup/disinfection tools           *
echo  * Author: vocatus on reddit.com/r/TronScript                          *
echo  *                                                                     *
echo  * Stage:        Tools:                                                *
echo  *  0 Prep:      Create SysRestore point/Rkill/ProcessKiller/Stinger/  *
echo  *               TDSSKiller/registry backup/clean oldest VSS set       *
echo  *  1 TempClean: TempFileClean/BleachBit/CCleaner/IE ^& EvtLogs clean   *
echo  *  2 De-bloat:  Remove OEM bloatware, remove Metro bloatware          *
echo  *  3 Disinfect: Sophos/KVRT/MBAM/DISM repair                          *
echo  *  4 Repair:    Reg and File Perms reset/chkdsk/SFC/telemetry removal *
echo  *  5 Patch:     Update 7-Zip/Java/Flash/Windows, reset DISM base      *
echo  *  6 Optimize:  defrag %SystemDrive% (mechanical only, SSDs skipped)             *
echo  *  7 Wrap-up:   collect logs, send email report (if requested)        *
echo  *                                                                     *
echo  * \resources\stage_8_manual_tools contains additional manual tools    *
echo  ***********************************************************************
:: So ugly
echo  Current settings (run tron.bat -c to dump full config):
echo    Log location:            %LOGPATH%\%LOGFILE%
if "%AUTO_REBOOT_DELAY%"=="0" (echo    Auto-reboot delay:       disabled) else (echo    Auto-reboot delay:      %AUTO_REBOOT_DELAY% seconds)
if "%SSD_DETECTED%"=="yes" (echo    SSD detected?            %SSD_DETECTED% ^(defrag skipped^) ) else (echo    SSD detected?            %SSD_DETECTED%)
if "%SAFE_MODE%"=="no" (
		echo    Safe mode?               %SAFE_MODE% ^(not ideal^)
	) else (
		if "%SAFEBOOT_OPTION%"=="MINIMAL" echo    Safe mode?               %SAFE_MODE%, without Networking
		if "%SAFEBOOT_OPTION%"=="NETWORK" echo    Safe mode?               %SAFE_MODE%, with Networking ^(ideal^)
	)
if /i not "%SKIP_DEFRAG%"=="no" (
	echo  ! SKIP_DEFRAG set^; skipping stage 5 defrag
	echo    Runtime estimate:        4-6 hours
	goto welcome_screen_trailer
	)
if "%SSD_DETECTED%"=="yes" (echo    Runtime estimate:        4-6 hours) else (echo    Runtime estimate:        7-9 hours)
if /i %DRY_RUN%==yes echo  ! DRY_RUN set; will not execute any jobs
if /i %UNICORN_POWER_MODE%==on echo  !! UNICORN POWER MODE ACTIVATED !!
echo.
:welcome_screen_trailer
pause


::::::::::::::::::::::::
:: EMAIL CONFIG CHECK ::
::::::::::::::::::::::::
:: If -er flag was used or EMAIL_REPORT was set to yes, check for a correctly configured SwithMailSettings.xml
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %EMAIL_REPORT%==yes (
	findstr /i "YOUR-EMAIL-ADDRESS" stage_7_wrap-up\email_report\SwithMailSettings.xml >NUL
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

:: Make log file and directories if they don't already exist
for %%D in ("%LOGPATH%","%QUARANTINE%","%BACKUPS%","%RAW_LOGS%","%SUMMARY_LOGS%") do (
    if not exist %%D mkdir %%D
)


:: If we're resuming from a script interruption we don't want to wipe the log, so check for that here before creating the new log
if /i %RESUME_DETECTED%==no echo. > "%LOGPATH%\%LOGFILE%"


:: Add a RunOnce entry to relaunch Tron if it gets interrupted by a reboot. This is deleted at the end of the script if nothing went wrong
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f /v "tron_resume" /t REG_SZ /d "%~dp0tron.bat %-resume" >nul 2>&1


:: UPM detection circuit #2
if /i %UNICORN_POWER_MODE%==on (color DF) else (color 0f)


:: Create log header
cls
call :log "-------------------------------------------------------------------------------"
call :log "%CUR_DATE% %TIME%   TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%), %PROCESSOR_ARCHITECTURE% architecture"
call :log "                          Executing as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%
call :log "                          Logfile: %LOGPATH%\%LOGFILE%"
call :log "                          Command-line flags: %*"
call :log "                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%"
call :log "                          Free space before Tron run: %FREE_SPACE_BEFORE% MB"
call :log "-------------------------------------------------------------------------------"


:::::::::::::::::::
:: STAGE 0: PREP ::
:::::::::::::::::::
:stage_0_prep
:: Stamp current stage and CLI flags so we can resume if we get interrupted by a reboot
echo stage_0_prep>tron_stage.txt
echo %*> tron_flags.txt


:: JOB: Run a quick SMART check and notify if there are any drives with problems
setlocal enabledelayedexpansion
%WMIC% diskdrive get status > %TEMP%\tron_smart_results.txt
for %%i in (Error,Degraded,Unknown,PredFail,Service,Stressed,NonRecover) do (
	findstr /C:"%%i" %TEMP%\tron_smart_results.txt
	if !ERRORLEVEL!==0 (
		call :log "%CUR_DATE% %TIME% ! WARNING! SMART check indicates at least one drive with %%i status"
		call :log "%CUR_DATE% %TIME%   SMART errors can mean a drive is close to failure, be careful"
		call :log "%CUR_DATE% %TIME%   running disk-intensive operations like defrag."
		)
)
endlocal disabledelayedexpansion


:: JOB: Set the system to permanently boot into Safe Mode in case we interrupted by a reboot
:: We undo this at the end of the script. Only works on Vista and up
if /i not "%WIN_VER:~0,9%"=="Microsoft" (
	title TRON v%SCRIPT_VERSION% [stage_0_prep] [safeboot]
	call :log "%CUR_DATE% %TIME%    Enabling Safe Mode w/ Network on reboot (Vista and up only)..."
	call :log "%CUR_DATE% %TIME%    Will re-enable regular boot when Tron is finished."
	if /i %DRY_RUN%==no bcdedit /set {default} safeboot network >> "%LOGPATH%\%LOGFILE%"
	call :log "%CUR_DATE% %TIME%    Done."
)

title TRON v%SCRIPT_VERSION% [stage_0_prep]
call :log "%CUR_DATE% %TIME%   stage_0_prep jobs begin..."


:: JOB: Create pre-run Restore Point so we can roll the system back if anything blows up
:: Note, there is a (stupid) limitation in Windows 8 and up that will only let you create
:: one restore point every 24 hours. If you create another one, it deletes the previous one.
:: So unfortunately we can't take a before/after pair.
title TRON v%SCRIPT_VERSION% [stage_0_prep] [Create Restore Point]
if /i not "%WIN_VER:~0,9%"=="Microsoft" (
	if /i not "%WIN_VER:~0,14%"=="Windows Server" (
		call :log "%CUR_DATE% %TIME%    Attempting to create pre-run Restore Point (Vista and up only)..."
		if /i %DRY_RUN%==no (
			powershell "Checkpoint-Computer -Description 'TRON v%SCRIPT_VERSION%: Pre-run checkpoint' | Out-Null" >> "%LOGPATH%\%LOGFILE%" 2>&1
		)
	)
)
call :log "%CUR_DATE% %TIME%    OK."


:: JOB: rkill
title TRON v%SCRIPT_VERSION% [stage_0_prep] [rkill]
call :log "%CUR_DATE% %TIME%    Launch job 'rkill'..."
call :log "%CUR_DATE% %TIME% !  If script stalls here, kill explorer.exe with Task Manager
if /i %DRY_RUN%==no (
	stage_0_prep\rkill\explorer.exe -s -l "%TEMP%\tron_rkill.log" -w "stage_0_prep\rkill\rkill_process_whitelist.txt"
	type "%TEMP%\tron_rkill.log" >> "%LOGPATH%\%LOGFILE%" 2>NUL
	del "%TEMP%\tron_rkill.log" 2>NUL
	if exist "%HOMEDRIVE%\%HOMEPATH%\Desktop\Rkill.txt" del "%HOMEDRIVE%\%HOMEPATH%\Desktop\Rkill.txt" 2>NUL
	)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Get pre-Tron system state (installed programs, complete file list). Thanks to /u/Reverent for building this section
title TRON v%SCRIPT_VERSION% [stage_0_prep] [Analyze System State]
call :log "%CUR_DATE% %TIME%    Generating pre-run system profile..."
if /i %DRY_RUN%==no (
	:: Get list of installed programs
	stage_0_prep\log_tools\siv\siv32x.exe -save=[software]="%RAW_LOGS%\installed-programs-before.txt"
	:: Get list of all files on system
	stage_0_prep\log_tools\everything\everything.exe -create-filelist "%RAW_LOGS%\filelist-before.txt" %SystemDrive%
)
call :log "%CUR_DATE% %TIME%    Done."



:: JOB: Disable mode and disable screen saver
if /i %DRY_RUN%==no (
		call :log "%CUR_DATE% %TIME%    Disabling sleep and screensaver temporarily..."
		title TRON v%SCRIPT_VERSION% [stage_0_prep] [DisableSleepandScreensaver]
		start "" stage_0_prep\caffeine\caffeine.exe -noicon
		call :log "%CUR_DATE% %TIME%    Done."
)


:: JOB: ProcessKiller
title TRON v%SCRIPT_VERSION% [stage_0_prep] [ProcessKiller]
call :log "%CUR_DATE% %TIME%    Launch Job 'ProcessKiller'..."
pushd stage_0_prep\processkiller
if /i %DRY_RUN%==no start "" /wait ProcessKiller.exe /silent
popd
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Set system clock via NTP
title TRON v%SCRIPT_VERSION% [stage_0_prep] [SetSystemClock]
call :log "%CUR_DATE% %TIME%    Launch Job 'Set system clock via NTP'..."
if /i %DRY_RUN%==no (
	:: Make sure time service is started, also force us to allow starting it in Safe Mode
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\w32time" /ve /t reg_sz /d Service /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config w32time start= auto >> "%LOGPATH%\%LOGFILE%" 2>&1
	net stop w32time >> "%LOGPATH%\%LOGFILE%" 2>&1
	w32tm /config /syncfromflags:manual /manualpeerlist:"time.nist.gov 3.pool.ntp.org time.windows.com" >> "%LOGPATH%\%LOGFILE%" 2>&1
	net start w32time >> "%LOGPATH%\%LOGFILE%" 2>&1
	w32tm /resync /nowait >> "%LOGPATH%\%LOGFILE%" 2>&1
)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Check WMI and repair if necessary
title TRON v%SCRIPT_VERSION% [stage_0_prep] [Check+Fix WMI]
call :log "%CUR_DATE% %TIME%    Checking WMI..."
if /i %DRY_RUN%==yes goto skip_repair_wmi
%WMIC% timezone >NUL
if /i not %ERRORLEVEL%==0 (
    call :log "%CUR_DATE% %TIME% ! WMI appears to be broken. Running WMI repair. This might take a minute, please be patient..."
    net stop winmgmt
    pushd %SystemRoot%\system32\wbem
    for %%i in (*.dll) do RegSvr32 -s %%i
    :: Kill this random window that pops up
    tskill wbemtest /a 2>NUL
    scrcons.exe /RegServer
    unsecapp.exe /RegServer
    start "" wbemtest.exe /RegServer
    tskill wbemtest /a 2>NUL
    tskill wbemtest /a 2>NUL
    :: winmgmt.exe /resetrepository       -- optional; force full rebuild instead of repair like the line below this. Enable if you're feeling REAAAALLY crazy
    winmgmt.exe /salvagerepository /resyncperf
    wmiadap.exe /RegServer
    wmiapsrv.exe /RegServer
    wmiprvse.exe /RegServer
    :: Get the 64-bit versions if they exist
	if exist %SystemRoot%\SysWOW64\wbem (
		pushd %SystemRoot%\SysWOW64\wbem
		for %%j in (*.dll) do RegSvr32 -s %%j
		winmgmt.exe /salvagerepository /resyncperf
		wmiadap.exe /RegServer
		wmiprvse.exe /RegServer
		popd
		)
	net start winmgmt
	popd
    )

:skip_repair_wmi
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Backup registry
title TRON v%SCRIPT_VERSION% [stage_0_prep] [Registry Backup]
call :log "%CUR_DATE% %TIME%    Backing up registry to "%LOGPATH%"..."
if /i %DRY_RUN%==no stage_0_prep\backup_registry\erunt.exe "%LOGPATH%\tron_registry_backup" /noconfirmdelete /noprogresswindow
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: McAfee Stinger
title TRON v%SCRIPT_VERSION% [stage_0_prep] [McAfee Stinger]
call :log "%CUR_DATE% %TIME%    Launch job 'McAfee Stinger'..."
call :log "%CUR_DATE% %TIME%    Stinger doesn't support text logs, saving HTML log to "%RAW_LOGS%\""
if /i %DRY_RUN%==no (
	start /wait stage_0_prep\mcafee_stinger\stinger32.exe --GO --SILENT --PROGRAM --REPORTPATH="%RAW_LOGS%" --DELETE
	)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: TDSS Killer
title TRON v%SCRIPT_VERSION% [stage_0_prep] [TDSS Killer]
call :log "%CUR_DATE% %TIME%    Launch job 'TDSS Killer'..."
if /i %DRY_RUN%==no (
	"stage_0_prep\tdss_killer\TDSSKiller.exe" -l %TEMP%\tdsskiller.log -silent -tdlfs -dcexact -accepteula -accepteulaksn
	:: Copy TDSSKiller log into the main Tron log
	type "%TEMP%\tdsskiller.log" >> "%LOGPATH%\%LOGFILE%"
	del "%TEMP%\tdsskiller.log" 2>NUL
	)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Purge oldest shadow copies
title TRON v%SCRIPT_VERSION% [stage_0_prep] [Purge oldest shadow copies]
:: Read 9 characters into the WIN_VER variable. Only versions of Windows older than Vista had "Microsoft" as the first part of their title,
:: so if we don't find "Microsoft" in the first 9 characters we can safely assume we're not on XP/2k3
:: Then we check for Vista, because vssadmin on Vista doesn't support deleting old copies. Sigh.
if /i not "%WIN_VER:~0,9%"=="Microsoft" (
	if /i not "%WIN_VER:~0,9%"=="Windows V" (
		call :log "%CUR_DATE% %TIME%    Purging oldest Shadow Copy set (Win7 and up)..."
		if /i %DRY_RUN%==no (
			:: Force allow us to start VSS service in Safe Mode
			reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\VSS" /ve /t reg_sz /d Service /f >nul 2>&1
			net start VSS >nul 2>&1
			vssadmin delete shadows /for=%SystemDrive% /oldest /quiet >nul 2>&1
		)
		call :log "%CUR_DATE% %TIME%    Done."
	)
)


:: JOB: Reduce SysRestore space
title TRON v%SCRIPT_VERSION% [stage_0_prep] [System Restore Modifications]
call :log "%CUR_DATE% %TIME%    Reducing max allowed System Restore space to 7%%%% of disk..."
if /i %DRY_RUN%==no (
	%SystemRoot%\System32\reg.exe add "\\%COMPUTERNAME%\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DiskPercent /t REG_DWORD /d 00000007 /f>> "%LOGPATH%\%LOGFILE%"
	%SystemRoot%\System32\reg.exe add "\\%COMPUTERNAME%\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Cfg" /v DiskPercent /t REG_DWORD /d 00000007 /f>> "%LOGPATH%\%LOGFILE%"
	)
call :log "%CUR_DATE% %TIME%    Done."
call :log "%CUR_DATE% %TIME%   stage_0_prep jobs complete."



::::::::::::::::::::::::
:: STAGE 1: TEMPCLEAN ::
::::::::::::::::::::::::
:stage_1_tempclean
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_1_tempclean>tron_stage.txt
title TRON v%SCRIPT_VERSION% [stage_1_tempclean]
call :log "%CUR_DATE% %TIME%   stage_1_tempclean jobs begin..."


:: JOB: Clean Internet Explorer; Windows built-in method. Only works on Vista and up
if /i not "%WIN_VER:~0,9%"=="Microsoft" (
	title TRON v%SCRIPT_VERSION% [stage_1_tempclean] [Clean Internet Explorer]
	call :log "%CUR_DATE% %TIME%    Launch job 'Clean Internet Explorer'..."
	if /i %DRY_RUN%==no rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351
	call :log "%CUR_DATE% %TIME%    Done."
)



:: JOB: TempFileCleanup.bat
title TRON v%SCRIPT_VERSION% [stage_1_tempclean] [TempFileCleanup]
call :log "%CUR_DATE% %TIME%    Launch job 'TempFileCleanup'..."
if /i %DRY_RUN%==no call stage_1_tempclean\tempfilecleanup\TempFileCleanup.bat >> "%LOGPATH%\%LOGFILE%" 2>NUL
:: Reset window title since TempFileCleanup clobbers it
title TRON v%SCRIPT_VERSION% [stage_1_tempclean]
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: CCLeaner
title TRON v%SCRIPT_VERSION% [stage_1_tempclean] [CCleaner]
call :log "%CUR_DATE% %TIME%    Launch job 'CCleaner'..."
if /i %DRY_RUN%==no (
	stage_1_tempclean\ccleaner\ccleaner.exe /auto>> "%LOGPATH%\%LOGFILE%" 2>NUL
	ping 127.0.0.1 -n 12 >NUL
	)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: BleachBit
title TRON v%SCRIPT_VERSION% [stage_1_tempclean] [BleachBit]
call :log "%CUR_DATE% %TIME%    Launch job 'BleachBit'..."
if /i %DRY_RUN%==no (
	if %VERBOSE%==yes stage_1_tempclean\bleachbit\bleachbit_console.exe -p --preset
	stage_1_tempclean\bleachbit\bleachbit_console.exe --preset -c >> "%LOGPATH%\%LOGFILE%" 2>NUL
	ping 127.0.0.1 -n 12 >NUL
	)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: USB Device Cleanup
title TRON v%SCRIPT_VERSION% [stage_1_tempclean] [USB Device Cleanup]
call :log "%CUR_DATE% %TIME%    Launch job 'USB Device Cleanup'..."
if /i %DRY_RUN%==no (
if /i '%PROCESSOR_ARCHITECTURE%'=='AMD64' (
	if %VERBOSE%==yes "stage_1_tempclean\usb_cleanup\DriveCleanup x64.exe" -t -n
	"stage_1_tempclean\usb_cleanup\DriveCleanup x64.exe" -n >> "%LOGPATH%\%LOGFILE%" 2>NUL
) else (
	if %VERBOSE%==yes "stage_1_tempclean\usb_cleanup\DriveCleanup x86.exe" -t -n
	"stage_1_tempclean\usb_cleanup\DriveCleanup x86.exe" -n >> "%LOGPATH%\%LOGFILE%" 2>NUL
	)
)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Clear Windows event logs
title TRON v%SCRIPT_VERSION% [stage_1_tempclean] [Clear Windows Event Logs]
call :log "%CUR_DATE% %TIME%    Launch job 'Clear Windows event logs'..."
if /i %SKIP_EVENT_LOG_CLEAR%==yes (
	call :log "%CUR_DATE% %TIME% ! SKIP_EVENT_LOG_CLEAR ^(-se^) set. Skipping Event Log clear."
	goto skip_event_log_clear
	)
call :log "%CUR_DATE% %TIME%    Saving logs to "%BACKUPS%" first..."
:: Backup all logs first. Redirect error output to NUL (2>nul) because due to the way WMI formats lists, there is
:: a trailing blank line which messes up the last iteration of the FOR loop, but we can safely suppress errors from it
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %DRY_RUN%==no for /f %%i in ('%WMIC% nteventlog where "filename like '%%'" list instance') do %WMIC% nteventlog where "filename like '%%%%i%%'" backupeventlog "%BACKUPS%\%%i.evt" >> "%LOGPATH%\%LOGFILE%" 2>NUL
ENDLOCAL DISABLEDELAYEDEXPANSION
call :log "%CUR_DATE% %TIME%    Backups done, now clearing..."
:: Clear the logs
if /i %DRY_RUN%==no %WMIC% nteventlog where "filename like '%%'" cleareventlog >> "%LOGPATH%\%LOGFILE%"
:: Alternate Vista-and-up only method
:: if /i %DRY_RUN%==no for /f %%x in ('wevtutil el') do wevtutil cl "%%x" 2>NUL

call :log "%CUR_DATE% %TIME%    Done."
:skip_event_log_clear



:: JOB: Clear Windows Update cache
title TRON v%SCRIPT_VERSION% [stage_1_tempclean] [Clear Windows Update cache]
call :log "%CUR_DATE% %TIME%    Launch job 'Clear Windows Update cache'..."
if /i %DRY_RUN%==no (
	:: Allow us to start the service in Safe Mode. Thanks to /u/GrizzlyWinter
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\WUAUSERV" /ve /t reg_sz /d Service /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	net stop WUAUSERV >> "%LOGPATH%\%LOGFILE%" 2>&1
	if exist %windir%\softwaredistribution\download rmdir /s /q %windir%\softwaredistribution\download >> "%LOGPATH%\%LOGFILE%" 2>&1
	net start WUAUSERV >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
call :log "%CUR_DATE% %TIME%    Done."


call :log "%CUR_DATE% %TIME%   stage_1_tempclean jobs complete."



:::::::::::::::::::::::
:: STAGE 2: De-Bloat ::
:::::::::::::::::::::::
:stage_2_de-bloat
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_2_de-bloat>tron_stage.txt
title TRON v%SCRIPT_VERSION% [stage_2_de-bloat]
if /i %SKIP_DEBLOAT%==yes (
	call :log "%CUR_DATE% %TIME% ! SKIP_DEBLOAT (-sb) set, skipping Stage 2 jobs..."
	goto skip_debloat
	)

call :log "%CUR_DATE% %TIME%   stage_2_de-bloat begin..."


:: JOB: Remove crapware programs, phase 1 (by specific GUID)
title TRON v%SCRIPT_VERSION% [stage_2_de-bloat] [Remove bloatware by GUID]
call :log "%CUR_DATE% %TIME%    Attempt junkware removal: Phase 1 (by specific GUID)..."
call :log "%CUR_DATE% %TIME%    Customize here: \resources\stage_2_de-bloat\oem\programs_to_target_by_GUID.bat"
if /i %DRY_RUN%==no call stage_2_de-bloat\oem\programs_to_target_by_GUID.bat >> "%LOGPATH%\%LOGFILE%" 2>&1
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Remove crapware programs, phase 2 (wildcard by name)
title TRON v%SCRIPT_VERSION% [stage_2_de-bloat] [Remove bloatware by name]
call :log "%CUR_DATE% %TIME%    Attempt junkware removal: Phase 2 (wildcard by name)..."
call :log "%CUR_DATE% %TIME%    Customize here: \resources\stage_2_de-bloat\oem\programs_to_target_by_name.txt"
:: Search through the list of programs in "programs_to_target.txt" file and uninstall them one-by-one
if /i %DRY_RUN%==no FOR /F "tokens=*" %%i in (stage_2_de-bloat\oem\programs_to_target_by_name.txt) DO echo   %%i && echo   %%i...>> "%LOGPATH%\%LOGFILE%" && %WMIC% product where "name like '%%i'" uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Remove default Metro apps (Windows 8 and up). Thanks to https://keybase.io/exabrial
title TRON v%SCRIPT_VERSION% [stage_2_de-bloat] [Remove default metro apps]
:: Read nine characters into the WIN_VER variable (starting at position 0 on the left) to check for Windows 8; 16 characters in to check for Server 2012.
:: The reason we read partially into the variable instead of comparing the whole thing is because we don't care what sub-version of 8/2012 we're on.
:: Also I'm lazy and don't want to write ten different comparisons for all the random sub-versions MS churns out with inconsistent names.
if "%WIN_VER:~0,9%"=="Windows 8" set TARGET_METRO=yes
if "%WIN_VER:~0,9%"=="Windows 1" set TARGET_METRO=yes
if "%WIN_VER:~0,18%"=="Windows Server 201" set TARGET_METRO=yes
:: Check if we're forcefully skipping Metro de-bloat. Thanks to /u/swtester for the suggestion
if %PRESERVE_METRO_APPS%==yes set TARGET_METRO=no
if /i %TARGET_METRO%==yes (
	call :log "%CUR_DATE% %TIME%    Windows 8 or higher detected, removing OEM Metro apps..."
	:: Force allowing us to start AppXSVC service in Safe Mode. AppXSVC is the MSI Installer equivalent for "apps" (vs. programs)
	if /i %DRY_RUN%==no (
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\AppXSVC" /ve /t reg_sz /d Service /f >nul 2>&1
		net start AppXSVC
		:: Enable scripts in PowerShell
		powershell "Set-ExecutionPolicy Unrestricted -force 2>&1 | Out-Null"
		:: Call PowerShell to run the commands
		powershell "Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
		powershell "Get-AppxPackage -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"
		)
	call :log "%CUR_DATE% %TIME%    Running DISM cleanup against unused App binaries..."
	:: Thanks to reddit.com/user/nommaddave
	if /i %DRY_RUN%==no Dism /Online /Cleanup-Image /StartComponentCleanup /Logpath:"%LOGPATH%\tron_dism.log"
	call :log "%CUR_DATE% %TIME%    Done."
)


call :log "%CUR_DATE% %TIME%   stage_2_de-bloat jobs complete."
:skip_debloat



::::::::::::::::::::::::
:: STAGE 3: Disinfect ::
::::::::::::::::::::::::
:stage_3_disinfect
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_3_disinfect>tron_stage.txt
title TRON v%SCRIPT_VERSION% [stage_3_disinfect]
call :log "%CUR_DATE% %TIME%   stage_3_disinfect jobs begin..."


:: JOB: Check for -sa flag (skip ALL antivirus scans) and skip RogueKiller, Sophos, KVRT and MBAM if it was used
if /i %SKIP_ANTIVIRUS_SCANS%==yes (
	call :log "%CUR_DATE% %TIME% ! SKIP_ANTIVIRUS_SCANS ^(-sa^) set. Skipping Sophos, KVRT and MBAM scans."
	goto skip_antivirus_scans
	)


REM :: JOB: RogueKiller
REM title TRON v%SCRIPT_VERSION% [stage_3_disinfect] [RogueKiller]
REM call :log "%CUR_DATE% %TIME%    Launch job 'RogueKiller' (it is SLOW, be patient)..."
REM if /i %DRY_RUN%==no (
    REM start stage_3_disinfect\roguekiller\RogueKillerAutomation.exe
    REM if /i %VERBOSE%==yes stage_3_disinfect\roguekiller\RogueKillerCMD.exe -scan
    REM if /i %VERBOSE%==no stage_3_disinfect\roguekiller\RogueKillerCMD.exe -scan>> "%LOGPATH%\%LOGFILE%"
    REM )
REM call :log "%CUR_DATE% %TIME%    Done."


:: JOB: MBAM (MalwareBytes Anti-Malware)
title TRON v%SCRIPT_VERSION% [stage_3_disinfect] [Malwarebytes Anti-Malware]
if exist "%ProgramFiles(x86)%\Malwarebytes Anti-Malware\mbam.exe" (
	call :log "%CUR_DATE% %TIME% !  Malwarebytes installation detected. Skipping MBAM installation."
	goto skip_mbam
)
if /i %SKIP_MBAM_INSTALL%==yes (
	call :log "%CUR_DATE% %TIME% ! SKIP_MBAM_INSTALL (-sm) set. Skipping MBAM installation."
) else (
	call :log "%CUR_DATE% %TIME%    Launch job 'Install Malwarebytes Anti-Malware'..."
	:: Install MBAM & remove the desktop icon
	if /i %DRY_RUN%==no (
		"stage_3_disinfect\mbam\Malwarebytes Anti-Malware v2.1.8.1057.exe" /verysilent
		::"Malwarebytes Anti-Malware v1.75.0.1300.exe" /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /NOCANCEL
		if exist "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk" del "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk"
		if exist "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk" del "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk"
		if exist "%ALLUSERSPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk" del "%ALLUSERSPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk"

		:: Scan for and launch appropriate architecture version
		if exist "%ProgramFiles(x86)%\Malwarebytes Anti-Malware" (
			start "" "%ProgramFiles(x86)%\Malwarebytes Anti-Malware\mbam.exe"
		) else (
			start "" "%ProgramFiles%\Malwarebytes Anti-Malware\mbam.exe"
			)
	)
	call :log "%CUR_DATE% %TIME%    Done."
	call :log "%CUR_DATE% %TIME% !  NOTE: You must manually click SCAN in the MBAM window!"
)
:skip_mbam


:: JOB: Kaspersky Virus Removal Tool (KVRT)
title TRON v%SCRIPT_VERSION% [stage_3_disinfect] [Kaspersky VRT]
if /i %SKIP_KASPERSKY_SCAN%==yes (
	call :log "%CUR_DATE% %TIME% ! SKIP_KASPERSKY_SCAN (-sk) set. Skipping KVRT scan."
) else (
	call :log "%CUR_DATE% %TIME%    Launch job 'Kaspersky Virus Removal Tool'..."
	call :log "%CUR_DATE% %TIME%    Tool-specific log saved to "%RAW_LOGS%\Reports""
	if /i %DRY_RUN%==no (
		start /wait stage_3_disinfect\kaspersky_virus_removal_tool\KVRT.exe -d "%RAW_LOGS%" -accepteula -adinsilent -silent -processlevel 2 -dontcryptsupportinfo
		if exist "%RAW_LOGS%\Legal notices" rmdir /s /q "%RAW_LOGS%\Legal notices"
		)
	call :log "%CUR_DATE% %TIME%    Done."
)


:: JOB: Sophos Virus Remover
title TRON v%SCRIPT_VERSION% [stage_3_disinfect] [Sophos Virus Remover]
if /i %SKIP_SOPHOS_SCAN%==yes (
	call :log "%CUR_DATE% %TIME% ! SKIP_SOPHOS_SCAN (-ss) set. Skipping SAV scan."
) else (
	call :log "%CUR_DATE% %TIME%    Launch job 'Sophos Virus Removal Tool' (slow, be patient)..."
	call :log "%CUR_DATE% %TIME%    Scanning. Output REDUCED by default (use -v to show)..."
	if /i %DRY_RUN%==no (
		echo.
		if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" >nul 2>&1
		if /i %VERBOSE%==no	stage_3_disinfect\sophos_virus_remover\svrtcli.exe -yes
		if /i %VERBOSE%==yes stage_3_disinfect\sophos_virus_remover\svrtcli.exe -yes -debug
		type "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" >> "%LOGPATH%\%LOGFILE%"
		if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" >nul 2>&1
		)
	call :log "%CUR_DATE% %TIME%    Done."
)

:: AV scans finished
:skip_antivirus_scans
call :log "%CUR_DATE% %TIME%   stage_3_disinfect jobs complete."

:: Since this whole section takes a long time to run, set the date again in case we crossed over midnight during the scans
:: This is a half-hearted fix for now. Thanks to /u/ScubaSteve for finding the bug
call :set_cur_date



:::::::::::::::::::::
:: STAGE 4: Repair ::
:::::::::::::::::::::
:stage_4_repair
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_4_repair>tron_stage.txt
title TRON v%SCRIPT_VERSION% [stage_4_repair]
call :log "%CUR_DATE% %TIME%   stage_4_repair jobs begin..."


:: JOB: Check Windows Image for corruptions before running SFC (Windows 8 and up)
:: Thanks to /u/nomaddave
title TRON v%SCRIPT_VERSION% [stage_3_disinfect] [DISM Check]
call :log "%CUR_DATE% %TIME%    Launch job 'Dism Windows image check (Win8 and up)'..."
if /i %DRY_RUN%==yes goto skip_dism_image_check

:: Read WIN_VER and run the scan if we're on 8 or above
if "%WIN_VER:~0,19%"=="Windows Server 2012" (
	Dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%LOGPATH%\tron_dism.log"
	type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	del /f /q "%LOGPATH%\tron_dism.log"
	)
if "%WIN_VER:~0,9%"=="Windows 8" (
	Dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%LOGPATH%\tron_dism.log"
	type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	del /f /q "%LOGPATH%\tron_dism.log"
	)
if "%WIN_VER:~0,9%"=="Windows 1" (
	Dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%LOGPATH%\tron_dism.log"
	type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	del /f /q "%LOGPATH%\tron_dism.log"
	)

:: If we detect errors try to repair them
if /i not %ERRORLEVEL%==0 (
	title TRON v%SCRIPT_VERSION% [stage_3_disinfect] [DISM Repair]
	if "%WIN_VER:~0,19%"=="Windows Server 2012" (
		call :log "%CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair..."
		:: Add /LimitAccess flag to this command to prevent connecting to Windows Update for replacement files
		Dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%LOGPATH%\tron_dism.log"
		type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
		)
	if "%WIN_VER:~0,9%"=="Windows 8" (
		call :log "%CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair..."
		:: Add /LimitAccess flag to this command to prevent connecting to Windows Update for replacement files
		Dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%LOGPATH%\tron_dism.log"
		type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
		)
	if "%WIN_VER:~0,9%"=="Windows 1" (
		call :log "%CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair..."
		:: Add /LimitAccess flag to this command to prevent connecting to Windows Update for replacement files
		Dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%LOGPATH%\tron_dism.log"
		type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	) else (
		call :log "%CUR_DATE% %TIME%    DISM: No image corruption detected."
	)
)

:skip_dism_image_check
call :log "%CUR_DATE% %TIME%    Done."



:: JOB: Reset registry permissions
title TRON v%SCRIPT_VERSION% [stage_4_repair] [Reset registry permissions]
if /i %SKIP_REGPERMS_RESET%==no (
	call :log "%CUR_DATE% %TIME%    Resetting registry permissions..."
	call :log "%CUR_DATE% %TIME%    THIS WILL TAKE A WHILE - BE PATIENT"
	call :log "%CUR_DATE% %TIME%    You can ignore errors here. Raw logs saved to "%RAW_LOGS%\""
	if /i %DRY_RUN%==no call "stage_4_repair\reset_registry_and_file_permissions\reset_registry_permissions.bat"
	call :log "%CUR_DATE% %TIME%    Done."
) else (
	call :log "%CUR_DATE% %TIME% !  SKIP_REGPERMS_RESET (-srr) set. Skipping registry and file permissions reset"
)


:: JOB: Reset filesystem permissions
title TRON v%SCRIPT_VERSION% [stage_4_repair] [Reset filesystem permissions]
if /i %SKIP_FILEPERMS_RESET%==no (
	call :log "%CUR_DATE% %TIME%    Resetting filesystem permissions in the Windows system directory..."
	call :log "%CUR_DATE% %TIME%    THIS WILL TAKE A WHILE - BE PATIENT"
	call :log "%CUR_DATE% %TIME%    You can ignore errors here. Raw logs saved to "%RAW_LOGS%\""
	if /i %DRY_RUN%==no call "stage_4_repair\reset_registry_and_file_permissions\reset_file_permissions.bat"
	call :log "%CUR_DATE% %TIME%    Done."
) else (
	call :log "%CUR_DATE% %TIME% !  SKIP_FILEPERMS_RESET (-sfr) set. Skipping registry and file permissions reset"
)


:: JOB: System File Checker (SFC) scan
title TRON v%SCRIPT_VERSION% [stage_4_repair] [SFC Scan]
call :log "%CUR_DATE% %TIME%    Launch job 'System File Checker'..."
if /i %DRY_RUN%==yes goto skip_sfc
:: Basically this says "If OS is NOT XP or 2003, go ahead and run system file checker"
if /i not "%WIN_VER:~0,9%"=="Microsoft" %SystemRoot%\System32\sfc.exe /scannow
:: Dump the SFC log into the Tron log. Thanks to reddit.com/user/adminhugh
%SystemRoot%\System32\findstr.exe /c:"[SR]" %SystemRoot%\logs\cbs\cbs.log>> "%LOGPATH%\%LOGFILE%" 2>NUL
:skip_sfc
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: chkdsk the system drive
title TRON v%SCRIPT_VERSION% [stage_4_repair] [chkdsk]
call :log "%CUR_DATE% %TIME%    Launch job 'chkdsk'..."
call :log "%CUR_DATE% %TIME%    Checking %SystemDrive% for errors..."
:: Run a read-only scan and look for errors. Schedule a scan at next reboot if errors found
if /i %DRY_RUN%==no %SystemRoot%\System32\chkdsk.exe %SystemDrive%
if /i not %ERRORLEVEL%==0 (
	call :log "%CUR_DATE% %TIME% !  Errors found on %SystemDrive%. Scheduling full chkdsk at next reboot."
	if /i %DRY_RUN%==no fsutil dirty set %SystemDrive%
) else (
	call :log "%CUR_DATE% %TIME%    No errors found on %SystemDrive%. Skipping full chkdsk at next reboot."
	)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Kill Microsoft telemetry (user tracking)
title TRON v%SCRIPT_VERSION% [stage_4_repair] [kill-telemetry]
if /i %SKIP_TELEMETRY_REMOVAL%==yes (
	call :log "%CUR_DATE% %TIME% !  SKIP_TELEMETRY_REMOVAL (-str) set. Disabling Microsoft telemetry (user tracking) instead of purging"
	REM Only disable telemetry, don't completely purge it
	reg import stage_4_repair\purge_windows_telemetry\disable_telemetry_registry_entries.reg >nul 2>&1
	regedit /S stage_4_repair\purge_windows_telemetry\disable_telemetry_registry_entries.reg >nul 2>&1
	goto skip_telem_removal
)
if /i "%WIN_VER:~0,9%"=="Windows 1" (
	call :log "%CUR_DATE% %TIME%    Launch job 'Kill Microsoft telemetry (user tracking) (Win10)'..."
	call :log "%CUR_DATE% %TIME% !  THIS TAKES A WHILE - BE PATIENT!!"
	if /i %DRY_RUN%==no (

		REM Call sub-script to kill Windows 10 telemetry
		REM Normally I try to embed everything directly, but it was quite a bit of code so I put it in an external script to avoid bloating tron.bat too much
		if /i %DRY_RUN%==no call stage_4_repair\purge_windows_telemetry\purge_windows_10_telemetry.bat >> "%LOGPATH%\%LOGFILE%" 2>NUL
	)
) else (
	call :log "%CUR_DATE% %TIME%    Launch job 'Kill Microsoft telemetry (user tracking) (Win7/8/8.1)'..."
	if /i %DRY_RUN%==no (
		REM :::::::::::::::::::::::::::::::::::::::::::::
		REM UPDATES
		REM Compatibility update for Windows 7
		wusa /uninstall /kb:2952664 /quiet /norestart

		REM Compatibility update for Windows 8.1 and Windows 8
		wusa /uninstall /kb:2976978 /quiet /norestart

		REM Update that enables you to upgrade from Windows 7 to a later version of Windows
		wusa /uninstall /kb:2990214 /quiet /norestart

		REM Customer Experience and Diagnostic Telemetry-related updates
		wusa /uninstall /kb:3022345 /quiet /norestart
		wusa /uninstall /kb:3068708 /quiet /norestart
		wusa /uninstall /kb:3080149 /quiet /norestart
		wusa /uninstall /kb:3021917 /quiet /norestart

		REM Adds telemetry points to consent.exe in Windows 8.1 and Windows 7
		wusa /uninstall /kb:3075249 /quiet /norestart
		wusa /uninstall /kb:3015249 /quiet /norestart

		REM "Get Windows 10" nagger in Windows 8.1 and Windows 7 SP1
		wusa /uninstall /kb:3035583 /quiet /norestart

		REM Enable upgrade from Windows 8.1 to Windows 10
		wusa /uninstall /kb:3044374 /quiet /norestart

		REM Description of the update for Windows Activation Technologies
		wusa /uninstall /kb:971033 /quiet /norestart

		REM Descriptions not available, update was pulled by Microsoft
		wusa /uninstall /kb:2902907 /quiet /norestart
		wusa /uninstall /kb:2922324 /quiet /norestart


		REM :::::::::::::::::::::::::::::::::::::::::::::
		REM SCHEDULED TASKS
		schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
		schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
		schtasks /delete /F /TN "\Microsoft\Windows\Autochk\Proxy"
		schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
		schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
		schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
		schtasks /delete /F /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
		schtasks /delete /F /TN "\Microsoft\Windows\PI\Sqm-Tasks"
		schtasks /delete /F /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
		schtasks /delete /F /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting"


		REM :::::::::::::::::::::::::::::::::::::::::::::
		REM SERVICES
		REM Diagnostic Tracking
		sc stop Diagtrack >nul 2>&1
		sc delete Diagtrack >nul 2>&1

		REM Remote Registry (disable only)
		sc config remoteregistry start= disabled >nul 2>&1
		sc stop remoteregistry >nul 2>&1


		REM :::::::::::::::::::::::::::::::::::::::::::::
		REM MISC
		REM Kill pending tracking reports
		if not exist %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\ mkdir %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\
		echo. > %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl 2>NUL
		echo y|cacls.exe "%programdata%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /d SYSTEM 2>NUL

		REM Disable telemetry via master registry key
		reg import stage_4_repair\purge_windows_telemetry\purge_windows_10_telemetry_registry_entries.reg >nul 2>&1
		regedit /S stage_4_repair\purge_windows_telemetry\purge_windows_10_telemetry_registry_entries.reg >nul 2>&1

	)
)
:skip_telem_removal
call :log "%CUR_DATE% %TIME%    Done. Enjoy your privacy."



call :log "%CUR_DATE% %TIME%   stage_4_repair jobs complete."



::::::::::::::::::::::
:: STAGE 5: Patches ::
::::::::::::::::::::::
:stage_5_patch
:: Set current date again, since Stage 4 can take quite a while to run
call :set_cur_date
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_5_patch>tron_stage.txt
title TRON v%SCRIPT_VERSION% [stage_5_patch]
call :log "%CUR_DATE% %TIME%   stage_5_patch jobs begin..."


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
:: Check if we're on 32-bit Windows and run the appropriate architecture installer
if /i %DRY_RUN%==yes goto skip_7-Zip
if /i '%PROCESSOR_ARCHITECTURE%'=='x86' (
	setlocal
	call "stage_5_patch\7-Zip\v9.38\x86\7-Zip v9.38 x86.bat"
	endlocal
) else (
	setlocal
	call "stage_5_patch\7-Zip\v9.38\x64\7-Zip v9.38 x64.bat"
	endlocal
	)
:skip_7-Zip

call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Adobe Flash Player
title TRON v%SCRIPT_VERSION% [stage_5_patch] [Update Adobe Flash Player]
call :log "%CUR_DATE% %TIME%    Launch job 'Update Adobe Flash Player (Firefox)'..."
setlocal
if /i %DRY_RUN%==no call "stage_5_patch\adobe\flash_player\firefox\Adobe Flash Player (Firefox).bat"
endlocal
call :log "%CUR_DATE% %TIME%    Done."
call :log "%CUR_DATE% %TIME%    Launch job 'Update Adobe Flash Player (IE)'..."
setlocal
if /i %DRY_RUN%==no call "stage_5_patch\adobe\flash_player\ie\Adobe Flash Player (IE).bat"
endlocal
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Adobe Reader
title TRON v%SCRIPT_VERSION% [stage_5_patch] [Update Adobe Reader]
call :log "%CUR_DATE% %TIME%    Launch job 'Update Adobe Reader'..."
setlocal
if /i %DRY_RUN%==no call "stage_5_patch\adobe\reader\x86\Adobe Reader.bat"
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


call :log "%CUR_DATE% %TIME%    Installing latest JRE..."
:: Check if we're on 32-bit Windows and run the appropriate installer
if /i '%PROCESSOR_ARCHITECTURE%'=='x86' (
	call :log "%CUR_DATE% %TIME%    x86 architecture detected, installing x86 version..."
	setlocal
	call "stage_5_patch\java\jre\8\x86\jre-8-i586.bat"
	endlocal
) else (
	call :log "%CUR_DATE% %TIME%    x64 architecture detected, installing x64 version..."
	setlocal
	call "stage_5_patch\java\jre\8\x64\jre-8-x64.bat"
	endlocal
	)

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

call :log "%CUR_DATE% %TIME%   stage_5_patch jobs complete."



:::::::::::::::::::::::
:: STAGE 6: Optimize ::
:::::::::::::::::::::::
:stage_6_optimize
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_6_optimize>tron_stage.txt
title TRON v%SCRIPT_VERSION% [stage_6_optimize]
call :log "%CUR_DATE% %TIME%   stage_6_optimize jobs begin..."


:: JOB: Reset the system page file settings
title TRON v%SCRIPT_VERSION% [stage_6_optimize] [pageReset]
if /i not %SKIP_PAGEFILE_RESET%==yes (
	call :log "%CUR_DATE% %TIME%    Resetting page file settings to Windows defaults..."
	if /i %DRY_RUN%==no %WMIC% computersystem where name="%computername%" set AutomaticManagedPagefile=True >> "%LOGPATH%\%LOGFILE%" 2>&1
	call :log "%CUR_DATE% %TIME%    Done."
) else (
	call :log "%CUR_DATE% %TIME% !  SKIP_PAGEFILE_RESET (-spr) set. Skipping page file reset"
)


:: Check if we are supposed to run a defrag before doing the section below
if "%SKIP_DEFRAG%"=="yes" (
	call :log "%CUR_DATE% %TIME%    SKIP_DEFRAG (-sd) set. Skipping defrag."
	call :log "%CUR_DATE% %TIME%   stage_6_optimize jobs complete."
	goto stage_7_wrap-up
	)

:: Check if a Solid State hard drive was detected before doing the section below
if "%SSD_DETECTED%"=="yes" (
	call :log "%CUR_DATE% %TIME%    Solid State hard drive detected. Skipping job 'Defrag %SystemDrive%'."
	call :log "%CUR_DATE% %TIME%   stage_6_optimize jobs complete."
	goto stage_7_wrap-up
	)

:: JOB: Defrag the system drive
if "%SSD_DETECTED%"=="no" (
	title TRON v%SCRIPT_VERSION% [stage_6_optimize] [Defrag]
	call :log "%CUR_DATE% %TIME%    Launch job 'Defrag %SystemDrive%'..."
	if /i %DRY_RUN%==no stage_6_optimize\defrag\defraggler.exe %SystemDrive% /MinPercent 5
	call :log "%CUR_DATE% %TIME%    Done."
	call :log "%CUR_DATE% %TIME%   stage_6_optimize jobs complete."
	)


::::::::::::::::::::::
:: STAGE 7: Wrap-up ::
::::::::::::::::::::::
:stage_7_wrap-up
:: Stamp current stage so we can resume if we get interrupted by a reboot
echo stage_7_wrap-up>tron_stage.txt
call :log "%CUR_DATE% %TIME%   stage_7_wrap-up jobs begin..."



:: JOB: Reset power settings to Windows defaults
title TRON v%SCRIPT_VERSION% [stage_7_wrap-up] [Reset power settings]
if %PRESERVE_POWER_SCHEME%==yes (
	call :log "%CUR_DATE% %TIME% !  PRESERVE_POWER_SCHEME (-p) set to "%PRESERVE_POWER_SCHEME%", skipping Windows power settings reset."
) else (
	call :log "%CUR_DATE% %TIME%    Resetting Windows power settings to defaults and re-enabling screensaver..."
	if %DRY_RUN%==no (
		REM Check for Windows XP/2k3
		if /i "%WIN_VER:~0,9%"=="Microsoft" %WINDIR%\system32\powercfg.exe /RestoreDefaultPolicies >NUL 2>&1
		REM Run commands for all other versions of Windows
		%WINDIR%\system32\powercfg.exe -restoredefaultschemes >NUL 2>&1
		REM Shut down Caffeine which has kept the system awake during the Tron run
		stage_0_prep\caffeine\caffeine.exe -appexit
	)
call :log "%CUR_DATE% %TIME%    Done."
)


:: JOB: Get post-Tron system state (installed programs, complete file list) and generate the summary logs
title TRON v%SCRIPT_VERSION% [stage_7_wrap-up] [Generate Summary Logs]
call :log "%CUR_DATE% %TIME%    Calculating post-run results for summary logs..."
if /i %DRY_RUN%==no (
	:: Get list of installed programs
	stage_0_prep\log_tools\siv\siv32x.exe -save=[software]="%RAW_LOGS%\installed-programs-after.txt"
	:: Get list of all files
	stage_0_prep\log_tools\everything\everything.exe -create-filelist %RAW_LOGS%\filelist-after.txt %SystemDrive%
	:: Parse everything
		REM Step 1: Find FILES that were deleted (second line is to strip everything trailing the first comma from the output)
		stage_0_prep\log_tools\comm\comm.exe -23 %RAW_LOGS%\filelist-before.txt %RAW_LOGS%\filelist-after.txt | find /i /v "$RECYCLE" | find /i /v "AppData\" | find /i /v "ntuser.dat" > %TEMP%\temp.txt
		for /f "tokens=1 delims=," %%a in (%TEMP%\temp.txt) do echo %%a >> %SUMMARY_LOGS%\tron_removed_files.txt

		REM Step 2: Find PROGRAMS that were removed. This is super ugly and complicated, but lets us avoid bundling another external utility
		REM Compact the files by removing blank lines, stripping top 4 lines off file, then last two lines, then output to the final text file for comparison
		copy /y %RAW_LOGS%\installed-programs-before.txt %RAW_LOGS%\before.txt >NUL
		for /f "delims=" %%a in (%RAW_LOGS%\before.txt) do echo %%a>> %RAW_LOGS%\before1.txt
		more +3 %RAW_LOGS%\before1.txt >> %RAW_LOGS%\before2.txt
		findstr /v /i "[==" %RAW_LOGS%\before2.txt > %RAW_LOGS%\installed-programs-before.txt

		REM AFTER: Compact the files by removing blank lines, stripping top 4 lines off file, then last two lines, then output to the final text file for comparison
		copy /y %RAW_LOGS%\installed-programs-after.txt %RAW_LOGS%\after.txt >NUL
		for /f "delims=" %%a in (%RAW_LOGS%\after.txt) do echo %%a>> %RAW_LOGS%\after1.txt
		more +3 %RAW_LOGS%\after1.txt >> %RAW_LOGS%\after2.txt
		findstr /v /i "[==" %RAW_LOGS%\after2.txt > %RAW_LOGS%\installed-programs-after.txt

		REM Calculate differences, using GnuWin32 coreutil's comm.exe
		stage_0_prep\log_tools\comm\comm.exe -23 %RAW_LOGS%\installed-programs-before.txt %RAW_LOGS%\installed-programs-after.txt > %SUMMARY_LOGS%\tron_removed_programs.txt

		REM If the parsed file is the same as the original, we can assume nothing was removed, so just echo that into the file
		fc /b %RAW_LOGS%\installed-programs-before.txt %RAW_LOGS%\installed-programs-after.txt >NUL
		if !ERRORLEVEL!==0 echo No programs were removed.> %SUMMARY_LOGS%\tron_removed_programs.txt

		REM Cleanup
		del /f /q %TEMP%\temp.txt 2>NUL
		del /f /q %RAW_LOGS%\before*txt 2>NUL
		del /f /q %RAW_LOGS%\after*txt 2>NUL
	)
call :log "%CUR_DATE% %TIME%    Done. Summary logs are at "%SUMMARY_LOGS%\"


:: JOB: Collect misc logs and deposit them in the log folder. Thanks to /u/swtester
title TRON v%SCRIPT_VERSION% [stage_7_wrap-up] [Collect logs]
call :log "%CUR_DATE% %TIME%    Saving misc logs to "%RAW_LOGS%\"..."
if /i %DRY_RUN%==no (
	if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs" copy /Y "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\*.l*" "%RAW_LOGS%" >NUL
	if exist "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Logs" copy /Y "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Logs\*.xml" "%RAW_LOGS%" >NUL
	if exist "%LOGPATH%\mbam-log*" move /y "%LOGPATH%\mbam-log*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\Sophos*" move /y "%LOGPATH%\Sophos*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\protection-log*" move /y "%LOGPATH%\protection-log*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\jre*" move /y "%LOGPATH%\jre*" "%RAW_LOGS%\"
)
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Remove resume-related files, registry entry, and boot flag
title TRON v%SCRIPT_VERSION% [stage_7_wrap-up] [Remove resume files]
call :log "%CUR_DATE% %TIME%    Removing resume-support files and Safeboot flag..."
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f /v "tron_resume" >nul 2>&1
	del /f /q tron_flags.txt >nul 2>&1
	del /f /q tron_stage.txt >nul 2>&1
	bcdedit /deletevalue {current} safeboot >> "%LOGPATH%\%LOGFILE%" 2>nul
	bcdedit /deletevalue {default} safeboot >> "%LOGPATH%\%LOGFILE%" 2>nul
	bcdedit /deletevalue safeboot >> "%LOGPATH%\%LOGFILE%" 2>nul
call :log "%CUR_DATE% %TIME%    Done."


:: JOB: Calculate saved disk space
title TRON v%SCRIPT_VERSION% [stage_7_wrap-up] [Calculate saved disk space]
for /F "tokens=2 delims=:" %%a in ('fsutil volume diskfree %SystemDrive% ^| find /i "avail free"') do set bytes=%%a
:: GB version
::set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024/1024
:: MB version
set /A FREE_SPACE_AFTER=%bytes:~0,-3%/1024*1000/1024
set /a FREE_SPACE_SAVED=%FREE_SPACE_AFTER% - %FREE_SPACE_BEFORE%


:: Notify of Tron completion
title TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%) [DONE]
call :log "%CUR_DATE% %TIME%   DONE. Use \resources\stage_8_manual_tools if further cleaning is required."


:: Check if auto-reboot was requested
if "%AUTO_REBOOT_DELAY%"=="0" (
	call :log "%CUR_DATE% %TIME% ! Auto-reboot disabled. Recommend rebooting as soon as possible."
) else (
	call :log "%CUR_DATE% %TIME% ! Auto-reboot selected. Rebooting in %AUTO_REBOOT_DELAY% seconds."
	)


:: Check if shutdown was requested
if /i %AUTO_SHUTDOWN%==yes call :log "%CUR_DATE% %TIME% ! Auto-shutdown selected. Shutting down in %AUTO_REBOOT_DELAY% seconds.


:: Pretend to send the email report. We don't actually send the report since we need the log trailer which is created below,
:: so we just pretend to send it then actually send it after the log trailer has been created
if /i %EMAIL_REPORT%==yes (
	call :log "%CUR_DATE% %TIME%   Email report requested. Sending report now..."
	ping localhost -n 5 >NUL
	call :log "%CUR_DATE% %TIME%   Done."
)


:: Check if self-destruct was set
if /i %SELF_DESTRUCT%==yes (
	call :log "%CUR_DATE% %TIME% ! Self-destruct selected. De-rezzing self. Goodbye..."
)


:: Display and log the job summary
:: Turn the window green so we can see at a glance if it's done
color 2F
call :log "-------------------------------------------------------------------------------"
call :log "%CUR_DATE% %TIME%   TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%) complete"
call :log "                          Executed as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%
call :log "                          Command-line flags: %*"
call :log "                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%"
call :log "                          Free space before Tron run: %FREE_SPACE_BEFORE% MB"
call :log "                          Free space after Tron run:  %FREE_SPACE_AFTER% MB"
call :log "                          Disk space reclaimed:       %FREE_SPACE_SAVED% MB *"
call :log "                          Logfile: %LOGPATH%\%LOGFILE%"
call :log ""
call :log "     * If you see negative disk space don't panic. Due to how some of Tron's"
call :log "       functions work, actual disk space reclaimed will not be visible until"
call :log "       after a reboot."
call :log "-------------------------------------------------------------------------------"


:: JOB: Actually send the email report if it was requested
:: This line needed for param5 (/p5) argument sent to SwithMail. It populates a list of command-line flags that were used
set ARGUMENTS='%*'
SETLOCAL ENABLEDELAYEDEXPANSION
if /i %EMAIL_REPORT%==yes (
	if /i %DRY_RUN%==no (
		stage_7_wrap-up\email_report\SwithMail.exe /s /x "stage_7_wrap-up\email_report\SwithMailSettings.xml" /a "%LOGPATH%\%LOGFILE%|%SUMMARY_LOGS%\tron_removed_files.txt|%SUMMARY_LOGS%\tron_removed_programs.txt" /p1 "Tron v%SCRIPT_VERSION% (%SCRIPT_DATE%) executed as %USERDOMAIN%\%USERNAME%" /p2 "%LOGPATH%\%LOGFILE%" /p3 "%SAFE_MODE% %SAFEBOOT_OPTION%" /p4 "%FREE_SPACE_BEFORE%/%FREE_SPACE_AFTER%/%FREE_SPACE_SAVED%" /p5 "%ARGUMENTS%"

		if !ERRORLEVEL!==0 (
			call :log "%CUR_DATE% %TIME%   Done."
		) else (
			call :log "%CUR_DATE% %TIME% ! Something went wrong, email may not have gone out. Check your settings."
		)
	)
)
ENDLOCAL DISABLEDELAYEDEXPANSION

:: Skip this last bit if we're doing a dry run
if /i %DRY_RUN%==yes goto end_and_skip_shutdown

:: Perform reboot if requested
if /i not "%AUTO_REBOOT_DELAY%"=="0" shutdown -r -f -t %AUTO_REBOOT_DELAY% -c "Rebooting in %AUTO_REBOOT_DELAY% seconds to finish cleanup."

:: Perform shutdown if requested
if /i %AUTO_SHUTDOWN%==yes shutdown -f -t %AUTO_REBOOT_DELAY% -s

:: De-rez self if requested
:self_destruct
set CWD=%CD%
if /i %SELF_DESTRUCT%==yes (
	%SystemDrive%
	cd \
	rmdir /s /q "%CWD%"
	exit
	)

:end_and_skip_shutdown
if /i %NO_PAUSE%==no pause
ENDLOCAL
color
exit /B
:: That's all, folks



:::::::::::::::
:: FUNCTIONS ::
:::::::::::::::
:: Thanks to /u/douglas_swehla for helping here
:: Since no new variable names are defined, there's no need for SETLOCAL.
:: The %1 reference contains the first argument passed to the function. When the
:: whole argument string is wrapped in double quotes, it is sent as on argument.
:: The tilde syntax (%~1) removes the double quotes around the argument.
:log
echo:%~1 >> "%LOGPATH%\%LOGFILE%"
echo:%~1
goto :eof


:: Get the date into ISO 8601 standard date format (yyyy-mm-dd) so we can use it
:set_cur_date
for /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%
goto :eof


:: Parse CLI arguments and flip the appropriate variables. Thanks to /u/douglas_swehla for conversion to function
:parse_cmdline_args
for %%i in (%*) do (
	if /i %%i==-a set AUTORUN=yes
	if /i %%i==-c set CONFIG_DUMP=yes
	if /i %%i==-d set DRY_RUN=yes
	if /i %%i==-e set EULA_ACCEPTED=yes
	if /i %%i==-er set EMAIL_REPORT=yes
	if /i %%i==-h set HELP=yes
	if /i %%i==-m set PRESERVE_METRO_APPS=yes
	if /i %%i==-np set NO_PAUSE=yes
	if /i %%i==-o set AUTO_SHUTDOWN=yes
	if /i %%i==-p set PRESERVE_POWER_SCHEME=yes
	if /i %%i==-r set AUTO_REBOOT_DELAY=15
	if /i %%i==-sa set SKIP_ANTIVIRUS_SCANS=yes
	if /i %%i==-sb set SKIP_DEBLOAT=yes
	if /i %%i==-sd set SKIP_DEFRAG=yes
	if /i %%i==-se set SKIP_EVENT_LOG_CLEAR=yes
	if /i %%i==-sfr set SKIP_FILEPERMS_RESET=yes
	if /i %%i==-sk set SKIP_KASPERSKY_SCAN=yes
	if /i %%i==-sm set SKIP_MBAM_INSTALL=yes
	if /i %%i==-sp set SKIP_PATCHES=yes
	if /i %%i==-spr set SKIP_PAGEFILE_RESET=yes
	if /i %%i==-srr set SKIP_REGPERMS_RESET=yes
	if /i %%i==-str set SKIP_TELEMETRY_REMOVAL=yes
	if /i %%i==-ss set SKIP_SOPHOS_SCAN=yes
	if /i %%i==-sw set SKIP_WINDOWS_UPDATES=yes
	if /i %%i==-v set VERBOSE=yes
	if /i %%i==-x set SELF_DESTRUCT=yes
	if %%i==-UPM set UNICORN_POWER_MODE=on
	)
goto :eof
:eof

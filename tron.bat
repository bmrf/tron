:: Purpose:       Runs a series of cleaners and anti-virus engines to clean up/disinfect a PC
::                  Kevin Flynn:  "Who's that guy?"
::                  Program:      "That's Tron. He fights for the User."
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
:: Author:        vocatus on reddit.com/r/sysadmin ( vocatus.gate@gmail.com ) // PGP key ID: 0x82A211A2
:: Version:       4.1.1 - feature: Remove Notepad++ installation. While it's a great text editor not everyone wants it on their PC, so we just stick to updating common vulnerable apps (Java,Reader,Flash). Thanks to /u/SubtleContradiction
::
:: Usage:         Run this script in Safe Mode as an Administrator and reboot when finished. That's it.
::
::                OPTIONAL command-line flags (can be combined, none are required):
::                      -a  Automatic mode (no welcome screen or prompts; implies -e)
::                      -c  Config dump (display config. Can be used with other flags to see what
::                          WOULD happen, but script will never execute if this flag is used)
::                      -d  Dry run (run through script without executing any jobs)
::                      -e  Accept EULA (suppress display of disclaimer warning screen)
::                      -h  Display help text
::                      -m  Preserve default Metro apps (don't remove them)
::                      -o  Power off after running (overrides -r)
::                      -p  Preserve power settings (don't reset power settings to default)
::                      -r  Reboot (auto-reboot 30 seconds after completion)
::                      -sa Skip anti-virus scans (Sophos, Vipre, MBAM)
::                      -sd Skip defrag (force Tron to ALWAYS skip Stage 5 defrag)
::                      -sp Skip patches (do not patch 7-Zip, Java Runtime, Adobe Flash and Reader)
::                      -v  Verbose. Show as much output as possible. NOTE: Significantly slower!
::                      -x  Self-destruct. Tron deletes itself after running and leaves logs intact
::
::                If you don't like the defaults and don't want to use the command-line, edit the variables below to change the script defaults.

::                U.S. Army Warrant Officer Corps - Quiet Professionals
SETLOCAL
@echo off




:::::::::::::::
:: VARIABLES :: ---------------- These are the defaults. Change them if you want ------------------- ::
:::::::::::::::
:: Rules for variables:
::  * NO quotes!                    (bad:  "c:\directory\path"       )
::  * NO trailing slashes on paths! (bad:   c:\directory\            )
::  * Spaces are okay               (okay:  c:\my folder\with spaces )
::  * Network paths are okay        (okay:  \\server\share name      )

:: Log settings and quarantined files path (note: quarantined files path is currently unused by Tron)
set LOGPATH=%SystemDrive%\Logs
set LOGFILE=tron.log
set QUARANTINE_PATH=%LOGPATH%\tron_quarantined_files

:: ! All variables here are overridden if their respective command-line flag is used
:: AUTORUN               (-a)  = Automatic execution (no welcome screen or prompts)
:: DRY_RUN               (-d)  = Run through script but skip all actual actions (test mode)
:: EULA_ACCEPTED         (-e)  = Accept EULA (suppress display of disclaimer warning screen)
:: PRESERVE_METRO_APPS   (-m)  = Don't remove stock Metro apps 
:: AUTO_SHUTDOWN         (-o)  = Shutdown after the finishing. Overrides auto-reboot
:: PRESERVE_POWER_SCHEME (-p)  = Preserve the active power scheme. Default is to reset power scheme to Windows defaults at the end of Tron
:: AUTO_REBOOT_DELAY     (-r)  = Post-run delay (in seconds) before rebooting. Set to 0 to disable auto-reboot
:: SKIP_ANTIVIRUS_SCANS  (-sa) = Set to yes to skip Stage 3 (Sophos, Vipre, MBAM, DISM repair)
:: SKIP_DEFRAG           (-sd) = Set to yes to skip defrag regardless whether the system drive is an SSD or not. When set to "no" the script will auto-detect SSDs and skip defrag if one is detected
:: SKIP_PATCHES          (-sp) = Set to yes to skip patches (do not patch 7-Zip, Java Runtime, Adobe Flash Player and Reader)
:: VERBOSE               (-v)  = When possible, show as much output as possible from each program Tron calls (e.g. Sophos, Vipre, etc). NOTE: This is often much slower
:: SELF_DESTRUCT         (-x)  = Set to yes to have Tron automatically delete itself after running. Leaves logs intact
set AUTORUN=no
set DRY_RUN=no
set EULA_ACCEPTED=no
set PRESERVE_METRO_APPS=no
set AUTO_SHUTDOWN=no
set PRESERVE_POWER_SCHEME=no
set AUTO_REBOOT_DELAY=0
set SKIP_ANTIVIRUS_SCANS=no
set SKIP_DEFRAG=no
set SKIP_PATCHES=no
set VERBOSE=no
set SELF_DESTRUCT=no





:: ------------------------------------------------------------------------------------------------- ::
:: ---------------- Don't edit anything below this line lest you awaken the Balrog ----------------- ::
:: ------------------------------------------------------------------------------------------------- ::





:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
cls
color 0f
set SCRIPT_VERSION=4.1.1
set SCRIPT_DATE=2014-11-19
title TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%)

:: Get the date into ISO 8601 standard date format (yyyy-mm-dd) so we can use it 
FOR /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%

:: Initialize script-internal variables. Most of these get clobbered later so don't change them here
set CONFIG_DUMP=no
set REPO_URL=http://bmrf.org/repos/tron
set REPO_BTSYNC_KEY=BYQYYECDOJPXYA2ZNUDWDN34O2GJHBM47
set REPO_SCRIPT_DATE=0
set REPO_SCRIPT_VERSION=0
set HELP=no
set TARGET_METRO=no
set FREE_SPACE_AFTER=0
set FREE_SPACE_BEFORE=0
set FREE_SPACE_SAVED=0
set UNICORN_POWER_MODE=off


:: Get in the correct drive (~d0). This is sometimes needed when running from a thumb drive
%~d0 2>NUL
:: Get in the correct path (~dp0). This is useful if we start from a network share, it converts CWD to a drive letter
pushd %~dp0 2>NUL


:: PREP JOB: Parse command-line arguments
for %%i in (%*) do (
	if /i %%i==-a set AUTORUN=yes
	if /i %%i==-c set CONFIG_DUMP=yes
	if /i %%i==-d set DRY_RUN=yes
	if /i %%i==-e set EULA_ACCEPTED=yes
	if /i %%i==-h set HELP=yes
	if /i %%i==-m set PRESERVE_METRO_APPS=yes
	if /i %%i==-o set AUTO_SHUTDOWN=yes
	if /i %%i==-p set PRESERVE_POWER_SCHEME=yes
	if /i %%i==-r set AUTO_REBOOT_DELAY=30
	if /i %%i==-sa set SKIP_ANTIVIRUS_SCANS=yes
	if /i %%i==-sd set SKIP_DEFRAG=yes
	if /i %%i==-sp set SKIP_PATCHES=yes
	if /i %%i==-v set VERBOSE=yes
	if /i %%i==-x set SELF_DESTRUCT=yes
	if %%i==-UPM set UNICORN_POWER_MODE=on
	)


:: PREP JOB: Execute help if requested
if /i %HELP%==yes (
	::cls
	echo. 
	echo  Tron v%SCRIPT_VERSION% ^(%SCRIPT_DATE%^)
	echo  Author: vocatus on reddit.com/r/sysadmin
	echo.
	echo   Usage: %0%.bat ^[-a -c -d -e -m -o -p -r -sa -sd -sp -v -x^] ^| ^[-h^]
	echo.
	echo   Optional flags ^(can be combined^):
	echo    -a  Automatic mode ^(no welcome screen or prompts; implies -e^)
 	echo    -c  Config dump ^(display config. Can be used with other flags to see what
	echo        WOULD happen, but script will never execute if this flag is used^)
	echo    -d  Dry run ^(run through script but don't execute any jobs^)
	echo    -e  Accept EULA ^(suppress display of disclaimer warning screen^)
	echo    -m  Preserve default Metro apps ^(don't remove them^)
	echo    -o  Power off after running ^(overrides -r^)
	echo    -p  Preserve power settings ^(don't reset power settings to default^)
	echo    -r  Reboot automatically ^(auto-reboot 30 seconds after completion^)
	echo    -sa Skip anti-virus scans ^(Sophos, Vipre, MBAM^)
	echo    -sd Skip defrag ^(force Tron to ALWAYS skip Stage 5 defrag^)
	echo    -sp Skip patches ^(do not patch 7-Zip, Java Runtime, Adobe Flash or Reader^)
	echo    -v  Verbose. Show as much output as possible. NOTE: Significantly slower!
	echo    -x  Self-destruct. Tron deletes itself after running and leaves logs intact
 	echo.
	echo   Misc flags ^(must be used alone^)
	echo    -h  Display this help text
	echo.
	exit /b 0
	)


:: PREP JOB: Force WMIC location in case the system PATH is messed up
set WMIC=%SystemRoot%\system32\wbem\wmic.exe


:: PREP JOB: Detect the version of Windows we're on. This determines a few things later in the script, such as which versions of SFC and powercfg.exe we run, as well as whether or not to attempt removal of Windows 8/8.1 metro apps
set WIN_VER=undetected
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| Find "ProductName"') DO set WIN_VER=%%i %%j


:: PREP JOB: Detect Solid State hard drives (determines if post-run defrag executes or not)
:: Basically we use a trick to set the global SSD_DETECTED variable outside of the setlocal block by stacking it on the same line so it gets executed along with ENDLOCAL
:: Big time thanks to reddit.com/user/Suddenly_Engineer and reddit.com/user/Aberu for helping with this
pushd resources\stage_5_optimize\defrag
set SSD_DETECTED=no
setlocal enabledelayedexpansion
for /f "tokens=1" %%i in ('smartctl --scan') do (
	smartctl %%i -a | find /i "Solid State" >NUL
	if "!ERRORLEVEL!"=="0" endlocal disabledelayedexpansion && set SSD_DETECTED=yes&& goto detect_safe_mode
	)

for /f "tokens=1" %%i in ('smartctl --scan') do (
	smartctl %%i -a | find /i "SSD" >NUL
	if "!ERRORLEVEL!"=="0" endlocal disabledelayedexpansion && set SSD_DETECTED=yes&& goto detect_safe_mode
	)

for /f "tokens=1" %%i in ('smartctl --scan') do (
	smartctl %%i -a | find /i "RAID" >NUL
	if "!ERRORLEVEL!"=="0" endlocal disabledelayedexpansion && set SSD_DETECTED=yes&& goto detect_safe_mode
	)
endlocal disabledelayedexpansion


:: PREP JOB: Detect if the system is in Safe Mode
:detect_safe_mode
popd
set SAFE_MODE=no
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" set SAFE_MODE=yes
if /i "%SAFEBOOT_OPTION%"=="NETWORK" set SAFE_MODE=yes


:: PREP JOB: Get free space on the system drive and stash it for comparison later
:: Thanks to Stack Overflow user Aacini in this post: http://stackoverflow.com/a/20392479/1347428
for /F "tokens=2 delims=:" %%a in ('fsutil volume diskfree %SystemDrive% ^| find /i "avail free"') do set bytes=%%a
:: GB version
::set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024/1024
:: MB version
set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024


:: PREP JOB: Re-enable the standard "F8" key functionality for choosing bootup options (Microsoft disables it by default starting in Windows 8 and up)
:: Read WIN_VER and run the scan if we're on some derivative of 8. We don't need to check for Server 2012 because it's set to "legacy" by default.
if "%WIN_VER:~0,9%"=="Windows 8" (
	bcdedit /set {default} bootmenupolicy legacy
	)


:: PREP JOB: Update check
pushd resources\stage_0_prep\check_update
:: Skip this job if we're doing a dry run
if /i %DRY_RUN%==yes goto skip_update_check

:: We use wget to fetch md5sums.txt from the repo and parse through it, extracting the latest version number and release date from last line of the file (which is always the latest release)
:: Get the file from the repo
wget %REPO_URL%/md5sums.txt -O %TEMP%\md5sums.txt 2>NUL
:: Assuming there was no error, go ahead and extract version number into REPO_SCRIPT_VERSION, and release date into REPO_SCRIPT_DATE
if /i %ERRORLEVEL%==0 (
	for /f "tokens=1,2,3 delims= " %%a in (%TEMP%\md5sums.txt) do set WORKING=%%c
	for /f "tokens=1,2,3,4 delims= " %%a in (%TEMP%\md5sums.txt) do set WORKING2=%%d
	)
if /i %ERRORLEVEL%==0 (
	set REPO_SCRIPT_VERSION=%WORKING:~1,6%
	set REPO_SCRIPT_DATE=%WORKING2:~1,10%
	)

:: clean up and reset the window title since wget clobbers it
if exist %TEMP%\md5sum* del %TEMP%\md5sum*
title TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%)

:: Notify if an update was found
if /i %SCRIPT_VERSION% LSS %REPO_SCRIPT_VERSION% (
	color 8a
	cls
	echo.
	echo  ! A newer version of Tron is available on the official repo.
	echo.
	echo    Your version:   %SCRIPT_VERSION% ^(%SCRIPT_DATE%^)
	echo    Latest version: %REPO_SCRIPT_VERSION% ^(%REPO_SCRIPT_DATE%^)
	echo.
	echo    Strongly recommend grabbing latest version before continuing.
	echo.
	echo    Option 1: Sync directly from repo using BT Sync read-only key:
	echo     %REPO_BTSYNC_KEY%
	echo.
	echo    Option 2: Download the latest .7z static pack:
	echo     %REPO_URL%
	echo.
	pause
	color 0f
	)
	
:skip_update_check
popd


:: PREP JOB: Execute config dump if requested
if /i %CONFIG_DUMP%==yes (
	cls
	echo.
	echo   Tron v%SCRIPT_VERSION% ^(%SCRIPT_DATE%^) config dump
	echo.
	echo   Command-line arguments:
	echo    %*
	echo.
	echo   Variables ^(user-set^):
	echo    AUTORUN:                %AUTORUN%
	echo    AUTO_REBOOT_DELAY:      %AUTO_REBOOT_DELAY%
	echo    CONFIG_DUMP:            %CONFIG_DUMP%
	echo    AUTO_SHUTDOWN:          %AUTO_SHUTDOWN%
	echo    DRY_RUN:                %DRY_RUN%
	echo    EULA_ACCEPTED:          %EULA_ACCEPTED%
	echo    LOGPATH:                %LOGPATH%
	echo    LOGFILE:                %LOGFILE%
	echo    PRESERVE_METRO_APPS:    %PRESERVE_METRO_APPS%
	echo    PRESERVE_POWER_SCHEME:  %PRESERVE_POWER_SCHEME%
	echo    QUARANTINE_PATH:        %QUARANTINE_PATH%
	echo    SELF_DESTRUCT:          %SELF_DESTRUCT%
	echo    SKIP_ANTIVIRUS_SCANS    %SKIP_ANTIVIRUS_SCANS%
	echo    SKIP_DEFRAG:            %SKIP_DEFRAG%
	echo    SKIP_PATCHES:           %SKIP_PATCHES%
	echo    UNICORN_POWER_MODE:     %UNICORN_POWER_MODE%
	echo    VERBOSE:                %VERBOSE%
	echo.
	echo   Variables ^(script-internal^):
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
	echo    SCRIPT_VERSION:         %SCRIPT_VERSION%
	echo    SCRIPT_DATE:            %SCRIPT_DATE%
	:: We need this setlocal/endlocal pair because on Vista the OS name has "(TM)" in it, which breaks the script. Sigh
	setlocal enabledelayedexpansion
	echo    WIN_VER:                !WIN_VER!
	endlocal disabledelayedexpansion
	echo    WMIC:                   %WMIC%
	echo.
	exit /b 0
	)


:: PREP JOB: Act on autorun flag. Skips safe mode checks, admin rights check, and EULA check. I assume if you use the auto flag (-a) you know what you're doing
if /i %AUTORUN%==yes goto execute_jobs


:: PREP JOB: Display the annoying disclaimer screen. Sigh
cls
if /i not %EULA_ACCEPTED%==yes (
	color CF
	echo  ************************** ANNOYING DISCLAIMER **************************
	echo  * NOTE! By running Tron you accept COMPLETE responsibility for ANYTHING *
	echo  * that happens. Although the chance of something bad happening due to   *
	echo  * Tron is pretty remote, it's always a possibility, and Tron has ZERO   *
	echo  * WARRANTY for ANY purpose. READ THE INSTRUCTIONS and understand you    *
	echo  * run it AT YOUR OWN RISK.                                              *
	echo  *                                                                       *
	echo  * Tron.bat and all supporting code and scripts I've written are free    *
	echo  * and open-source under the MIT License. All 3rd-party tools Tron calls *
	echo  * ^(MBAM, TDSSK, etc^) are bound by their respective licenses. It is      *
	echo  * YOUR RESPONSIBILITY to determine if you have the rights to use these  *
	echo  * tools in whatever environment you use Tron in.                        *
	echo  *                                                                       *
	echo  * The bottom line is there is NO WARRANTY, you are ON YOUR OWN, and     *
	echo  * anything that happens, good or bad, is YOUR RESPONSIBILITY.           *
	echo  *************************************************************************
	echo.
	echo  Type I AGREE ^(all caps^) to accept this agreement and start Tron, or press
	echo  ctrl^+c to cancel.
	echo.
	:eula_prompt
	set /p CHOICE= Response: 
	if not "%CHOICE%"=="I AGREE" echo You must type I AGREE to continue&& goto eula_prompt
	color 0f
	)


:: PREP JOB: UPM detection circuit #1
if /i %UNICORN_POWER_MODE%==on (color DF) else (color 0f)


::::::::::::::::::::
:: WELCOME SCREEN ::
::::::::::::::::::::
cls
echo  **********************  TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%)  *********************
echo  * Script to automate a series of cleanup/disinfect tools              *
echo  * Author: vocatus on reddit.com/r/sysadmin                            *
echo  *                                                                     *
echo  * Stage:        Tools:                                                *
echo  * ------------------------------------------------------------------- *
echo  *  0 Prep:      rkill, PrcsKillr, TDSSK, reg bckup, SysRstr/VSS clean *
echo  *  1 TempClean: TempFileCleanup, BlchBit, CCleaner,IE ^& EvtLogs clean *
echo  *  2 De-bloat:  Remove OEM bloatware, remove Metro bloatware          *
echo  *  3 Disinfect: RogueKiller, Sophos, Vipre, MBAM, DISM repair, SFC    *
echo  *  4 Patch:     Update 7-Zip/Java/Flash/Windows, reset DISM base      *
echo  *  5 Optimize:  chkdsk, defrag %SystemDrive% (mechanical disks only, no SSDs)    *
echo  *                                                                     *
echo  * \resources\stage_6_manual_tools contains additional tools which may *
echo  * be run manually if necessary.                                       *
echo  ***********************************************************************
:: So ugly
echo  Current settings (run tron.bat -c to see FULL config):
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
	echo  ! SKIP_DEFRAG set^; skipping stage_5_optimize ^(defrag^)
	echo    Runtime estimate:        4-6 hours
	goto welcome_screen_trailer
	)
if "%SSD_DETECTED%"=="yes" (echo    Runtime estimate:        4-6 hours) else (echo    Runtime estimate:        6-8 hours)
if /i %DRY_RUN%==yes echo  ! DRY_RUN set; will not execute any jobs
if /i %UNICORN_POWER_MODE%==on echo  ! UNICORN POWER MODE ACTIVATED !!
echo.
:welcome_screen_trailer
pause

:::::::::::::::::::::
:: SAFE MODE CHECK ::
:::::::::::::::::::::
:: Check if we're in safe mode
if /i not "%SAFE_MODE%"=="yes" (
		color 0c
		cls
		echo.
		echo  WARNING
		echo.
		echo  The system is not in safe mode. Tron functions best
		echo  in "Safe Mode with Networking" in order to download
		echo  Windows and anti-virus updates.
		echo.
		echo  Tron should still run OK, but if you have infections
		echo  or problems after running, recommend booting to
		echo  "Safe Mode with Networking" and re-running.
		echo.
		pause
		cls
		)

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
		
::::::::::::::::::::::::
:: ADMIN RIGHTS CHECK ::
::::::::::::::::::::::::
:: thanks to /u/agent-squirrel
:: We skip this check if we're in Safe Mode because Safe Mode command prompts always start with Admin rights
if /i not "%SAFE_MODE%"=="yes" (
	net session >nul 2>&1
	if /i not "%ERRORLEVEL%"=="0" (
		color cf
		cls
		echo.
		echo  ERROR
		echo.
		echo  Tron doesn't think it is running as an Administrator.
		echo  Tron MUST be run with full Administrator rights to 
		echo  function correctly.
		echo.
		pause
	)
)


::::::::::::::::::
:: EXECUTE JOBS ::
::::::::::::::::::
:execute_jobs
cls
title TRON v%SCRIPT_VERSION% [stage_0_prep]

:: Make the log and quarantine directories and file if they don't already exist
if /i not exist "%LOGPATH%" mkdir "%LOGPATH%"
if /i not exist "%LOGPATH%\%LOGFILE%" echo. > "%LOGPATH%\%LOGFILE%"
:: Creation of the QUARANTINE_PATH is disabled for now
::if /i not exist "%QUARANTINE_PATH%" mkdir "%QUARANTINE_PATH%"

:: UPM detection circuit #2
if /i %UNICORN_POWER_MODE%==on (color DF) else (color 0f)

:: Create log header for this job
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------
echo  %CUR_DATE% %TIME%  TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%), %PROCESSOR_ARCHITECTURE% architecture>> %LOGPATH%\%LOGFILE%
echo  %CUR_DATE% %TIME%  TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%), %PROCESSOR_ARCHITECTURE% architecture
echo                          Executing as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%>> %LOGPATH%\%LOGFILE%
echo                          Executing as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%
echo                          Logfile:   %LOGPATH%\%LOGFILE%>> %LOGPATH%\%LOGFILE%
echo                          Logfile:   %LOGPATH%\%LOGFILE%
echo                          Command-line flags: %*>> %LOGPATH%\%LOGFILE%
echo                          Command-line flags: %*
echo                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%>> %LOGPATH%\%LOGFILE%
echo                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%
echo                          Free space before Tron run: %FREE_SPACE_BEFORE% MB>> %LOGPATH%\%LOGFILE%
echo                          Free space before Tron run: %FREE_SPACE_BEFORE% MB
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------


:::::::::::::::::::
:: STAGE 0: PREP ::
:::::::::::::::::::
:stage_0_prep
pushd resources\stage_0_prep
echo %CUR_DATE% %TIME%   Launch stage_0_prep jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launch stage_0_prep jobs...


:: JOB: rkill
echo %CUR_DATE% %TIME%    Launch job 'rkill'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'rkill'...
pushd rkill
if /i %DRY_RUN%==no (
	if /i '%PROCESSOR_ARCHITECTURE%'=='AMD64' rkill64.com -s -l "%TEMP%\tron_rkill.log"
	if /i '%PROCESSOR_ARCHITECTURE%'=='x86' rkill.com -s -l "%TEMP%\tron_rkill.log"
	type "%TEMP%\tron_rkill.log" >> "%LOGPATH%\%LOGFILE%"
	del "%TEMP%\tron_rkill.log"
	if exist "%HOMEDRIVE%\%HOMEPATH%\Desktop\Rkill.txt" del "%HOMEDRIVE%\%HOMEPATH%\Desktop\Rkill.txt" 2>NUL
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: ProcessKiller
echo %CUR_DATE% %TIME%    Launch Job 'ProcessKiller'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch Job 'ProcessKiller'...
pushd processkiller
if /i %DRY_RUN%==no ProcessKiller.exe
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Backup registry
echo %CUR_DATE% %TIME%    Backing up registry to "%LOGPATH%"...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Backing up registry to "%LOGPATH%"...
pushd backup_registry
if /i %DRY_RUN%==no erunt "%LOGPATH%\tron_registry_backup" /noconfirmdelete /noprogresswindow
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: TDSS Killer
echo %CUR_DATE% %TIME%    Launch job 'TDSSKiller'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'TDSSKiller'...
pushd tdss_killer
if /i %DRY_RUN%==no (
	"TDSSKiller v3.0.0.41.exe" -l %TEMP%\tdsskiller.log -silent -tdlfs -dcexact -accepteula -accepteulaksn
	:: Copy TDSSKiller log into the main Tron log
	type "%TEMP%\tdsskiller.log" >> "%LOGPATH%\%LOGFILE%"
	del "%TEMP%\tdsskiller.log" 2>NUL
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Purge oldest shadow copies
echo %CUR_DATE% %TIME%    Purging oldest Shadow Copy set (7 and up)...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Purging oldest Shadow Copy set (7 and up)...
pushd purge_shadow_copies
:: Read 9 characters into the WIN_VER variable. Only versions of Windows older than Vista had "Microsoft" as the first part of their title,
:: So if we don't find "Microsoft" in the first 9 characters we can safely assume we're not on XP/2k3
:: Then we check for Vista, because vssadmin on Vista doesn't support deleting old copies. Sigh. 
if /i not "%WIN_VER:~0,9%"=="Microsoft" (
	if /i not "%WIN_VER:~0,9%"=="Windows V" (
		if /i %DRY_RUN%==no (
			:: Force allow us to start VSS service in Safe Mode
			reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\VSS" /ve /t reg_sz /d Service /f 2>NUL
			net start VSS
			vssadmin delete shadows /for=%SystemDrive% /oldest /quiet 2>NUL
			)
		)
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Disable sleep mode
echo %CUR_DATE% %TIME%    Disabling Sleep mode...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Disabling Sleep mode...
pushd disable_sleep
if /i %DRY_RUN%==yes goto skip_disable_sleep

echo %CUR_DATE% %TIME%    Exporting current power scheme and switching to Always On...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Exporting current power scheme and switching to Always On...

:: Export the current power scheme to a file. Thanks to reddit.com/user/GetOnMyAmazingHorse
setlocal enabledelayedexpansion
:: Windows XP version
if "%WIN_VER%"=="Microsoft Windows XP" (
	:: Extract the line containing the current power GUID
	for /f "delims=^T" %%i in ('powercfg -query ^| find /i "Name"') do (set t=%%i)
	:: Parse out just the name and stash it in a variable
	set POWER_SCHEME=!t:~27!
	:: Export the power scheme based on this GUID
	powercfg /EXPORT "!POWER_SCHEME!" /FILE %LOGPATH%\tron_power_config_backup.pow
	:: Set the "High Performance" scheme active
	powercfg /SETACTIVE "Always On"
	) 

:: Windows Server 2003 version
if "%WIN_VER%"=="Microsoft Windows Server 2003" (
	:: Extract the line containing the current power GUID
	for /f "delims=^T" %%i in ('powercfg -query ^| find /i "Name"') do (set t=%%i)
	:: Parse out just the name and stash it in a variable
	set POWER_SCHEME=!t:~27!
	:: Export the power scheme based on this GUID
	powercfg /EXPORT "!POWER_SCHEME!" /FILE %LOGPATH%\tron_power_config_backup.pow
	:: Set the "High Performance" scheme active
	powercfg /SETACTIVE "Always On"
) else (
	:: This version of the command executes if we're not on XP or Server 2003
	:: Extract the line containing the current power GUID
	for /f "delims=" %%i in ('powercfg -list ^| find "*"') do (set t=%%i)
	:: Parse out just the GUID and stash it in a variable
	set POWER_SCHEME=!t:~19,36!
	:: Export the power scheme based on this GUID
	powercfg /EXPORT %LOGPATH%\tron_power_config_backup.pow !POWER_SCHEME!
	:: Set the "High Performance" scheme active
	powercfg /SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
	)

:: This cheats a little bit by stacking the set command on the same line as the endlocal so it executes immediately after ENDLOCAL but before the variable gets wiped out by the endlocal. Kind of a little trick to get a SETLOCAL-internal variable exported to a global script-wide variable.
:: We need the POWER_SCHEME GUID for later when we re-import everything
endlocal disabledelayedexpansion && set POWER_SCHEME=%POWER_SCHEME%

echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.

:skip_disable_sleep
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Check and Repair WMI if it's broken
echo %CUR_DATE% %TIME%    Checking WMI...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Checking WMI...
pushd repair_wmi
if /i %DRY_RUN%==yes goto skip_repair_wmi

:: Do a quick check to make sure WMI is working, and if not, repair it
%WMIC% timezone >NUL
if /i not %ERRORLEVEL%==0 (
    echo %CUR_DATE% %TIME% !  WMI appears to be broken. Running WMI repair. This might take a minute, please be patient...>> "%LOGPATH%\%LOGFILE%"
    echo %CUR_DATE% %TIME% !  WMI appears to be broken. Running WMI repair. This might take a minute, please be patient...
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
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.

:: JOB: Reduce SysRestore space
echo %CUR_DATE% %TIME%    Reducing max allowed System Restore space to 7%% of disk...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Reducing max allowed System Restore space to 7%% of disk...
pushd reduce_system_restore
if /i %DRY_RUN%==no (
	%SystemRoot%\System32\reg.exe add "\\%COMPUTERNAME%\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DiskPercent /t REG_DWORD /d 00000007 /f
	%SystemRoot%\System32\reg.exe add "\\%COMPUTERNAME%\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Cfg" /v DiskPercent /t REG_DWORD /d 00000007 /f
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


popd
echo %CUR_DATE% %TIME%   Completed stage_0_prep jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_0_prep jobs.


::::::::::::::::::::::::
:: STAGE 1: TEMPCLEAN ::
::::::::::::::::::::::::
:stage_1_tempclean
title TRON v%SCRIPT_VERSION% [stage_1_tempclean]
pushd resources\stage_1_tempclean
echo %CUR_DATE% %TIME%   Launch stage_1_tempclean jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launch stage_1_tempclean jobs...


:: JOB: Clean Internet Explorer; Windows' built-in method
echo %CUR_DATE% %TIME%    Launch job 'Clean Internet Explorer'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Clean Internet Explorer'...
pushd clean_internet_explorer
if /i %DRY_RUN%==no rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: TempFileCleanup.bat
echo %CUR_DATE% %TIME%    Launch job 'TempFileCleanup'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'TempFileCleanup'...
pushd tempfilecleanup
if /i %DRY_RUN%==no call TempFileCleanup.bat>> "%LOGPATH%\%LOGFILE%" 2>NUL
:: Reset window title since TempeFileCleanup clobbers it
title TRON v%SCRIPT_VERSION% [stage_1_tempclean]
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: CCLeaner
echo %CUR_DATE% %TIME%    Launch job 'CCleaner'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'CCleaner'...
pushd ccleaner
if /i %DRY_RUN%==no (
	ccleaner.exe /auto>> "%LOGPATH%\%LOGFILE%" 2>NUL
	ping 127.0.0.1 -n 12 >NUL
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: BleachBit
echo %CUR_DATE% %TIME%    Launch job 'BleachBit'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'BleachBit'...
pushd bleachbit
if /i %DRY_RUN%==no (
	bleachbit_console.exe --preset -c>> "%LOGPATH%\%LOGFILE%" 2>NUL
	ping 127.0.0.1 -n 12 >NUL
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Clear Windows event logs
echo %CUR_DATE% %TIME%    Launch job 'Clear Windows event logs'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Clear Windows event logs'...
pushd backup_and_clear_windows_event_logs
:: Make a subdirectory in the logpath for the Windows event log backups
if /i not exist "%LOGPATH%\tron_event_log_backups" mkdir "%LOGPATH%\tron_event_log_backups"
echo %CUR_DATE% %TIME%    Saving logs to "%LOGPATH%\tron_event_log_backups" first...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Saving logs to "%LOGPATH%\tron_event_log_backups" first...
:: Backup all logs first. We redirect error output to NUL (2>nul) because due to the way WMI formats lists, there is
:: a trailing blank line which messes up the last iteration of the FOR loop, but we can safely suppress errors from it
setlocal enabledelayedexpansion
if /i %DRY_RUN%==no for /f %%i in ('%WMIC% nteventlog where "filename like '%%'" list instance') do %WMIC% nteventlog where "filename like '%%%%i%%'" backupeventlog "%LOGPATH%\tron_event_log_backups\%%i.evt" >> "%LOGPATH%\%LOGFILE%" 2>NUL
endlocal disabledelayedexpansion
echo %CUR_DATE% %TIME%    Backups done, now clearing...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Backups done, now clearing...
:: Now we clear the logs
if /i %DRY_RUN%==no %WMIC% nteventlog where "filename like '%%'" cleareventlog >> "%LOGPATH%\%LOGFILE%"
:: Alternate Vista-and-up only method
:: if /i %DRY_RUN%==no for /f %%x in ('wevtutil el') do wevtutil cl "%%x" 2>NUL

popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Clear Windows Update cache
echo %CUR_DATE% %TIME%    Launch job 'Clear Windows Update cache'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Clear Windows Update cache'...
pushd clear_windows_update_cache
if /i %DRY_RUN%==no (
	:: Allow us to start the service in Safe Mode. Thanks to /u/GrizzlyWinter
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\WUAUSERV" /ve /t reg_sz /d Service /f 2>NUL
	net stop WUAUSERV >> "%LOGPATH%\%LOGFILE%"
	if exist %windir%\softwaredistribution\download rmdir /s /q %windir%\softwaredistribution\download >> "%LOGPATH%\%LOGFILE%"
	net start WUAUSERV >> "%LOGPATH%\%LOGFILE%"
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.
	
	
popd
echo %CUR_DATE% %TIME%   Completed stage_1_tempclean jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_1_tempclean jobs.


:::::::::::::::::::::::
:: STAGE 2: De-Bloat ::
:::::::::::::::::::::::
:stage_2_de-bloat
title TRON v%SCRIPT_VERSION% [stage_2_de-bloat]
pushd resources\stage_2_de-bloat
echo %CUR_DATE% %TIME%   Launch stage_2_de-bloat jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launch stage_2_de-bloat jobs...

:: JOB: Remove crapware programs
pushd oem
echo %CUR_DATE% %TIME%    Attempting to remove common OEM junkware programs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Attempting to remove common OEM junkware programs...
echo %CUR_DATE% %TIME%    Customize list here: \resources\stage_2_de-bloat\oem\programs_to_target.txt>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Customize list here: \resources\stage_2_de-bloat\oem\programs_to_target.txt
:: This searches through the list of programs in "programs_to_target.txt" file and uninstalls them one-by-one
if /i %DRY_RUN%==no FOR /F "tokens=*" %%i in (programs_to_target.txt) DO echo   %%i && echo   %%i...>> "%LOGPATH%\%LOGFILE%" && %WMIC% product where "name like '%%i'" uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"

popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Remove default Metro apps (Windows 8/8.1/2012/2012-R2 only). Thanks to https://keybase.io/exabrial
pushd win8_metro_apps
:: Read nine characters into the WIN_VER variable (starting at position 0 on the left) to check for Windows 8; 16 characters in to check for Server 2012.
:: The reason we read partially into the variable instead of comparing the whole thing is because we don't care what sub-version of 8/2012 we're on. 
:: Also I'm lazy and don't want to write ten different comparisons for all the random sub-versions MS churns out with inconsistent names.
if "%WIN_VER:~0,9%"=="Windows 8" set TARGET_METRO=yes
if "%WIN_VER:~0,18%"=="Windows Server 201" set TARGET_METRO=yes
:: Check if we're forcefully skipping Metro de-bloat. Thanks to /u/swtester for the suggestion
if %PRESERVE_METRO_APPS%==yes set TARGET_METRO=no
if /i %TARGET_METRO%==yes (
	echo %CUR_DATE% %TIME%    "%WIN_VER%" detected, removing default Metro apps...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    "%WIN_VER%" detected, removing default Metro apps...
	:: Force allowing us to start AppXSVC service in Safe Mode. AppXSVC is the MSI Installer equivalent for "apps" (vs. programs)
	if /i %DRY_RUN%==no (
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\AppXSVC" /ve /t reg_sz /d Service /f
		net start AppXSVC
		:: Enable scripts in PowerShell
		powershell "Set-ExecutionPolicy Unrestricted -force 2>&1 | Out-Null"
		:: Call PowerShell to run the commands
		powershell "Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
		powershell "Get-AppxPackage -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"
		)
	echo %CUR_DATE% %TIME%    Running DISM cleanup against unused App binaries...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    Running DISM cleanup against unused App binaries...
	:: Thanks to reddit.com/user/nommaddave
	if /i %DRY_RUN%==no Dism /Online /Cleanup-Image /StartComponentCleanup /Logpath:"%LOGPATH%\tron_dism.log"
	echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    Done.	
	)
	popd


popd
echo %CUR_DATE% %TIME%   Completed stage_2_de-bloat jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_2_de-bloat jobs.


::::::::::::::::::::::::
:: STAGE 3: Disinfect ::
::::::::::::::::::::::::
:stage_3_disinfect
title TRON v%SCRIPT_VERSION% [stage_3_disinfect]
pushd resources\stage_3_disinfect
echo %CUR_DATE% %TIME%   Launch stage_3_disinfect jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launch stage_3_disinfect jobs...


:: JOB: RogueKiller
:: Thanks to /u/bodkov for suggestion
echo %CUR_DATE% %TIME%    Launch job 'RogueKiller' (slow, be patient)...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'RogueKiller' (slow, be patient)...
pushd roguekiller
if /i %DRY_RUN%==no (
	if /i %VERBOSE%==yes echo remove| RogueKillerCMD.exe -scan remove
	if /i %VERBOSE%==no echo remove| RogueKillerCMD.exe -scan remove >> "%LOGPATH%\%LOGFILE%"
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Check for the -sa flag (skip antivirus scans) and skip Sophos, Vipre and MBAM if used
if /i %SKIP_ANTIVIRUS_SCANS%==yes (
	echo %CUR_DATE% %TIME%   SKIP_ANTIVIRUS_SCANS set. Skipping Sophos, Vipre and MBAM scans...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%   SKIP_ANTIVIRUS_SCANS set. Skipping Sophos, Vipre and MBAM scans...
	goto skip_antivirus_scans
	)


:: JOB: Sophos Virus Remover
echo %CUR_DATE% %TIME%    Launch job 'Sophos Virus Removal Tool' (slow, be patient)...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Sophos Virus Removal Tool' (slow, be patient)...
pushd sophos_virus_remover
if /i %DRY_RUN%==no (
	if exist %ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log del /f /q %ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log 2>NUL
	if /i %VERBOSE%==no	svrtcli.exe -yes
	if /i %VERBOSE%==yes svrtcli.exe -yes -debug
	type %ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log >> "%LOGPATH%\%LOGFILE%"
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: VIPRE Rescue
:: Haven't been able to figure out where Vipre saves its log file to, so we can't grab it like with do with Sophos above
echo %CUR_DATE% %TIME%    Launch job 'Vipre rescue scanner' (slow, be patient)...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Vipre rescue scanner' (slow, be patient)...
pushd vipre_rescue
if /i %DRY_RUN%==no ( 
	if /i %VERBOSE%==no VipreRescueScanner.exe /nolog
	if /i %VERBOSE%==yes VipreRescueScanner.exe
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: MBAM (MalwareBytes Anti-Malware)
echo %CUR_DATE% %TIME%    Launch job 'Malwarebytes Anti-Malware', continuing other jobs...>>"%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Malwarebytes Anti-Malware', continuing other jobs...
pushd mbam
:: Install MBAM & remove the desktop icon
if /i %DRY_RUN%==no ( 
	"Malwarebytes Anti-Malware v2.0.3.1025.exe" /verysilent
	::"Malwarebytes Anti-Malware v1.75.0.1300.exe" /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /NOCANCEL
	if exist "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk" del "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk"
	if exist "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk" del "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk"
	if exist "%ALLUSERSPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk" del "%ALLUSERSPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk"

	:: Scan for and launch appropriate architecture version
	if exist "%ProgramFiles(x86)%\Malwarebytes Anti-Malware" (
		pushd "%ProgramFiles(x86)%\Malwarebytes Anti-Malware"
	) else (
		pushd "%ProgramFiles%\Malwarebytes Anti-Malware"
		)
	start "" "mbam.exe"
	popd
)


popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.
:skip_antivirus_scans


:: JOB: Check Windows Image for corruptions before running SFC (Windows 8/2012 only)
:: Thanks to /u/nomaddave
echo %CUR_DATE% %TIME%    Launch job 'Dism Windows image check (Win8/2012 only)'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Dism Windows image check (Win8/2012 only)'...
pushd dism_image_check
if /i %DRY_RUN%==yes goto skip_dism_image_check

:: Read WIN_VER and run the scan if we're on some derivative of 8 or 2012
if "%WIN_VER:~0,9%"=="Windows Server 2012" (
	Dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%LOGPATH%\tron_dism.log"
	type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	)
if "%WIN_VER:~0,9%"=="Windows 8" (
	Dism /Online /NoRestart /Cleanup-Image /ScanHealth /Logpath:"%LOGPATH%\tron_dism.log"
	type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	)

:: If we detect errors, try to repair them
if /i not %ERRORLEVEL%==0 (
	if "%WIN_VER:~0,9%"=="Windows Server 2012" (
		echo %CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair...>> "%LOGPATH%\%LOGFILE%"
		echo %CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair...
		:: Add /LimitAccess flag to this command to prevent connecting to Windows Update for replacement files
		Dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%LOGPATH%\tron_dism.log"
		type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
		)
	if "%WIN_VER:~0,9%"=="Windows 8" (
		echo %CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair...>> "%LOGPATH%\%LOGFILE%"
		echo %CUR_DATE% %TIME% !  DISM: Image corruption detected. Attempting repair...
		:: Add /LimitAccess flag to this command to prevent connecting to Windows Update for replacement files
		Dism /Online /NoRestart /Cleanup-Image /RestoreHealth /Logpath:"%LOGPATH%\tron_dism.log"
		type "%LOGPATH%\tron_dism.log" >> "%LOGPATH%\%LOGFILE%"
	) else (
		echo %CUR_DATE% %TIME%    DISM: No image corruption detected.>> "%LOGPATH%\%LOGFILE%"
		echo %CUR_DATE% %TIME%    DISM: No image corruption detected.
		)
	)

:skip_dism_image_check
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: System File Checker (SFC) scan
echo %CUR_DATE% %TIME%    Launch job 'System File Checker'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'System File Checker'...
pushd sfc
if /i %DRY_RUN%==yes goto skip_sfc
:: Basically this says "If OS is NOT XP or 2003, go ahead and run system file checker"
if /i not "%WIN_VER:~0,9%"=="Microsoft" %SystemRoot%\System32\sfc.exe /scannow
:: Dump the SFC log into the Tron log. Thanks to reddit.com/user/adminhugh
%SystemRoot%\System32\findstr.exe /c:"[SR]" %SystemRoot%\logs\cbs\cbs.log>> "%LOGPATH%\%LOGFILE%"
:skip_sfc
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


popd
echo %CUR_DATE% %TIME%   Completed stage_3_disinfect jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_3_disinfect jobs.


:: Since this whole section takes a long time to run, set the date again in case we crossed over midnight during the scans.
:: This is a half-hearted fix for now. Thanks to /u/ScubaSteve for finding the bug.
FOR /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%


::::::::::::::::::::::
:: STAGE 4: Patches ::
::::::::::::::::::::::
:stage_4_patch
title TRON v%SCRIPT_VERSION% [stage_4_patch]
pushd resources\stage_4_patch
echo %CUR_DATE% %TIME%   Launch stage_4_patch jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launch stage_4_patch jobs...


:: Prep task: enable MSI installer in Safe Mode
if /i %DRY_RUN%==no (
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\MSIServer" /ve /t reg_sz /d Service /f
	net start msiserver
	)

	
:: Check for skip patches (-sp) flag or variable and skip to Windows Update if used
if /i %SKIP_PATCHES%==yes (
	echo %CUR_DATE% %TIME%    SKIP_PATCHES set to "%SKIP_DEFRAG%". Skipping app patches...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    SKIP_PATCHES set to "%SKIP_DEFRAG%". Skipping app patches...
	goto skip_patches
	)
	

:: JOB: 7-Zip
echo %CUR_DATE% %TIME%    Launch job 'Update 7-Zip'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Update 7-Zip'...

:: Check if we're on 32-bit Windows and run the appropriate architecture installer
if /i %DRY_RUN%==yes goto skip_7-Zip
if /i '%PROCESSOR_ARCHITECTURE%'=='x86' (
	pushd 7-Zip\v9.20\x86
	setlocal
	call "7-Zip v9.20 x86.bat"
	endlocal
	popd
) else (
	pushd 7-Zip\v9.20\x64
	setlocal
	call "7-Zip v9.20 x64.bat"
	endlocal
	popd
	)
:skip_7-Zip
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.

:: JOB: Adobe Flash Player
echo %CUR_DATE% %TIME%    Launch job 'Update Adobe Flash Player'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Update Adobe Flash Player'...
pushd "adobe\flash_player\firefox"
setlocal
if /i %DRY_RUN%==no call "Adobe Flash Player (Firefox).bat"
endlocal
popd
pushd "adobe\flash_player\internet explorer"
setlocal
if /i %DRY_RUN%==no call "Adobe Flash Player (IE).bat"
endlocal
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.

:: JOB: Adobe Reader
echo %CUR_DATE% %TIME%    Launch job 'Update Adobe Reader'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Update Adobe Reader'...
pushd adobe\reader\x86
setlocal
if /i %DRY_RUN%==no call "Adobe Reader.bat"
endlocal
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.

:: JOB: Remove outdated JRE runtimes (security risk)
echo %CUR_DATE% %TIME%    Checking and removing outdated JRE installations...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Checking and removing outdated JRE installations...
if /i %DRY_RUN%==yes goto skip_jre_update
:: Okay, so all JRE runtimes (series 4-8) use product GUIDs, with certain numbers that increment with each new update (e.g. Update 25)
:: This makes it easy to catch ALL of them through liberal use of WMI wildcards ("_" is single character, "%" is any number of characters)
:: Additionally, JRE 6 introduced 64-bit runtimes, so in addition to the two-digit Update XX revision number, we also check for the architecture 
:: type, which always equals '32' or '64'. The first wildcard is the architecture, the second is the revision/update number.

:: JRE 8
:: we skip JRE 8 because the JRE 8 updater automatically removes older versions, no need to do it twice

:: JRE 7
echo %CUR_DATE% %TIME%    JRE 7...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    JRE 7...
%WMIC% product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F___170__FF}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%"

:: JRE 6
echo %CUR_DATE% %TIME%    JRE 6...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    JRE 6...
:: 1st line is for updates 23-xx, after 64-bit runtimes were introduced.
:: 2nd line is for updates 1-22, before Oracle released 64-bit JRE 6 runtimes
%WMIC% product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F8__160__FF}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"
%WMIC% product where "IdentifyingNumber like '{3248F0A8-6813-11D6-A77B-00B0D0160__0}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"

:: JRE 5
echo %CUR_DATE% %TIME%    JRE 5...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    JRE 5...
%WMIC% product where "IdentifyingNumber like '{3248F0A8-6813-11D6-A77B-00B0D0150__0}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"

:: JRE 4
echo %CUR_DATE% %TIME%    JRE 4...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    JRE 4...
%WMIC% product where "IdentifyingNumber like '{7148F0A8-6813-11D6-A77B-00B0D0142__0}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"

echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.

:: JOB: Java Runtime 8
echo %CUR_DATE% %TIME%    Launch job 'Update Java Runtime Environment'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Update Java Runtime Environment'...

:: Check if we're on 32-bit Windows and run the appropriate installer
if /i '%PROCESSOR_ARCHITECTURE%'=='x86' (
	echo %CUR_DATE% %TIME%    x86 architecture detected, installing x86 version...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    x86 architecture detected, installing x86 version...
	pushd java\jre\8\x86
	setlocal
	call "jre-8-i586.bat"
	endlocal
	popd
) else (
	echo %CUR_DATE% %TIME%    x64 architecture detected, installing x64 version...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    x64 architecture detected, installing x64 version...
	pushd java\jre\8\x64
	setlocal
	call "jre-8-x64.bat"
	endlocal
	popd
	)

:skip_jre_update
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Skip point for if -sp (skip patches) flag was used
:skip_patches


:: JOB: Windows updates
echo %CUR_DATE% %TIME%    Launch job 'Install Windows updates'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'Install Windows updates'...
pushd windows_updates
if /i %DRY_RUN%==no wuauclt /detectnow /updatenow
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: JOB: Rebuild Windows Update base (deflates the SxS store; note that any Windows Updates installed prior to this point will become uninstallable)
:: Windows 8/2012 and up only
echo %CUR_DATE% %TIME%    Launch job 'DISM base reset'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'DISM base reset'...
pushd dism_base_reset
if /i %DRY_RUN%==no (
	if /i not "%WIN_VER:~0,9%"=="Microsoft" (
		if /i not "%WIN_VER:~0,11%"=="Windows V" (
			Dism /online /Cleanup-Image /StartComponentCleanup /ResetBase /Logpath:"%LOGPATH%\tron_dism_base_reset.log"
			type "%LOGPATH%\tron_dism_base_reset.log" >> "%LOGPATH%\%LOGFILE%"
			)
		)
	)
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.

popd
echo %CUR_DATE% %TIME%   Completed stage_4_patch jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_4_patch jobs.


:::::::::::::::::::::::
:: STAGE 5: Optimize ::
:::::::::::::::::::::::
:stage_5_optimize
title TRON v%SCRIPT_VERSION% [stage_5_optimize]
pushd resources\stage_5_optimize
echo %CUR_DATE% %TIME%   Launch stage_5_optimize jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launch stage_5_optimize jobs...

:: JOB: chkdsk the system drive
echo %CUR_DATE% %TIME%    Launch job 'chkdsk'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Launch job 'chkdsk'...
pushd chkdsk
echo %CUR_DATE% %TIME%    Checking %SystemDrive% for errors...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Checking %SystemDrive% for errors...

:: Run a read-only scan and look for errors. Schedule a scan at next reboot if errors found
if /i %DRY_RUN%==no %SystemRoot%\System32\chkdsk.exe %SystemDrive%
if /i not %ERRORLEVEL%==0 ( 
	echo %CUR_DATE% %TIME% !  Errors found on %SystemDrive%. Scheduling full chkdsk at next reboot.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME% !  Errors found on %SystemDrive%. Scheduling full chkdsk at next reboot.
	if /i %DRY_RUN%==no fsutil dirty set %SystemDrive%
) else (
	echo %CUR_DATE% %TIME%    No errors found on %SystemDrive%. Skipping full chkdsk at next reboot.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    No errors found on %SystemDrive%. Skipping full chkdsk at next reboot.
	)
	
popd
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.


:: Check if we are supposed to run a defrag before doing this section
if "%SKIP_DEFRAG%"=="yes" (
	echo %CUR_DATE% %TIME%    SKIP_DEFRAG set to "%SKIP_DEFRAG%". Skipping defrag.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    SKIP_DEFRAG set to "%SKIP_DEFRAG%". Skipping defrag.
	popd
	goto :wrap-up
	)

:: Check if a Solid State hard drive was detected before doing this section
if "%SSD_DETECTED%"=="yes" (
	echo %CUR_DATE% %TIME%    Solid State hard drive detected. Skipping job 'Defrag %SystemDrive%'.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    Solid State hard drive detected. Skipping job 'Defrag %SystemDrive%'.
	popd
	goto :wrap-up
	)

:: JOB: Defrag the system drive
if "%SSD_DETECTED%"=="no" (
	echo %CUR_DATE% %TIME%    Launch job 'Defrag %SystemDrive%'...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    Launch job 'Defrag %SystemDrive%'...
	pushd defrag
	if /i %DRY_RUN%==no defraggler.exe %SystemDrive%
	popd
	echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    Done.
	)

popd
echo %CUR_DATE% %TIME%   Completed stage_5_optimize jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_5_optimize jobs.


:::::::::::::
:: Wrap-up ::
:::::::::::::
:wrap-up
echo %CUR_DATE% %TIME%   Wrapping up...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Wrapping up...

:: If selected, import the original power settings, re-activate them, and delete the backup
:: Otherwise, just reset the power settings back to their defaults
if "%PRESERVE_POWER_SCHEME%"=="yes" (
	echo %CUR_DATE% %TIME%    Restoring power settings to previous values...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    Restoring power settings to previous values...
	:: Check for Windows XP
	if "%WIN_VER%"=="Microsoft Windows XP" (
		if /i %DRY_RUN%==no powercfg /import "%POWER_SCHEME%" /file %LOGPATH%\tron_power_config_backup.pow
		if /i %DRY_RUN%==no powercfg /setactive "%POWER_SCHEME%"
	) 
	:: Check for Windows Server 2003
	if "%WIN_VER%"=="Microsoft Windows Server 2003" (
			if /i %DRY_RUN%==no powercfg /import "%POWER_SCHEME%" /file %LOGPATH%\tron_power_config_backup.pow
			if /i %DRY_RUN%==no powercfg /setactive "%POWER_SCHEME%"
	) else (
		REM if we made it this far we're not on XP or 2k3 and we can run the standard commands
		if /i %DRY_RUN%==no powercfg /import %LOGPATH%\tron_power_config_backup.pow %POWER_SCHEME% 2>NUL
		if /i %DRY_RUN%==no powercfg /setactive %POWER_SCHEME% 
	)
	:: cleanup
	del %LOGPATH%\tron_power_config_backup.pow 2>NUL
) else (
	echo %CUR_DATE% %TIME%    Resetting Windows power settings to defaults...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%    Resetting Windows power settings to defaults...
	:: Check for Windows XP
	if "%WIN_VER%"=="Microsoft Windows XP" (
		if /i %DRY_RUN%==no powercfg /RestoreDefaultPolicies
	) 
	:: check for Windows Server 2003
	if "%WIN_VER%"=="Microsoft Windows Server 2003" (
		if /i %DRY_RUN%==no powercfg /RestoreDefaultPolicies
	) else (
		REM if we made it this far we're not on XP or 2k3 and we can run the standard commands
		if /i %DRY_RUN%==no powercfg -restoredefaultschemes
	)
)

echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.

:: Collect misc logs and deposit them in the log folder. Thanks to /u/swtester
echo %CUR_DATE% %TIME%    Collecting misc logs and dumping them in "%LOGPATH%"...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Collecting misc logs and dumping them in "%LOGPATH%"
if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs" copy /Y "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\*.l*" "%LOGPATH%" >NUL
if exist "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Logs" copy /Y "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Logs\*.xml" "%LOGPATH%" >NUL
echo %CUR_DATE% %TIME%    Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%    Done.
	
title TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%) [DONE]

echo %CUR_DATE% %TIME%   DONE. Use tools in resources\stage_6_manual_tools if further cleaning is required.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   DONE. Use tools in resources\stage_6_manual_tools if further cleaning is required.

:: Check if auto-reboot was requested
if "%AUTO_REBOOT_DELAY%"=="0" (
	echo %CUR_DATE% %TIME% ! Auto-reboot disabled. Recommend rebooting as soon as possible.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME% ! Auto-reboot disabled. Recommend rebooting as soon as possible.
) else (
	echo %CUR_DATE% %TIME% ! Auto-reboot selected. Rebooting in %AUTO_REBOOT_DELAY% seconds.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME% ! Auto-reboot selected. Rebooting in %AUTO_REBOOT_DELAY% seconds.
	)

:: Check if shutdown was requested
if /i %AUTO_SHUTDOWN%==yes (
	echo %CUR_DATE% %TIME% ! Auto-shutdown selected. Shutting down in %AUTO_REBOOT_DELAY% seconds.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME% ! Auto-shutdown selected. Shutting down in %AUTO_REBOOT_DELAY% seconds.
)

:: Check if self-destruct was set
if /i %SELF_DESTRUCT%==yes (
	echo %CUR_DATE% %TIME% ! Self-destruct selected. De-rezzing self. Goodbye...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME% ! Self-destruct selected. De-rezzing self. Goodbye...
)

:: Calculate saved disk space
for /F "tokens=2 delims=:" %%a in ('fsutil volume diskfree %SystemDrive% ^| find /i "avail free"') do set bytes=%%a
:: GB version
::set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024/1024
:: MB version
set /A FREE_SPACE_AFTER=%bytes:~0,-3%/1024*1000/1024
set /a FREE_SPACE_SAVED=%FREE_SPACE_AFTER% - %FREE_SPACE_BEFORE%

:: Display and log the job summary
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------
echo  %CUR_DATE% %TIME%  TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%) complete>> %LOGPATH%\%LOGFILE%
echo  %CUR_DATE% %TIME%  TRON v%SCRIPT_VERSION% (%SCRIPT_DATE%) complete
echo                          Executed as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%>> %LOGPATH%\%LOGFILE%
echo                          Executed as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%
echo                          Logfile: %LOGPATH%\%LOGFILE%>> %LOGPATH%\%LOGFILE%
echo                          Logfile: %LOGPATH%\%LOGFILE%
echo                          Command-line flags: %*>> %LOGPATH%\%LOGFILE%
echo                          Command-line flags: %*
echo                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%>> %LOGPATH%\%LOGFILE%
echo                          Safe Mode: %SAFE_MODE% %SAFEBOOT_OPTION%
echo                          Free space before Tron run: %FREE_SPACE_BEFORE% MB>> %LOGPATH%\%LOGFILE%
echo                          Free space before Tron run: %FREE_SPACE_BEFORE% MB
echo                          Free space after Tron run:  %FREE_SPACE_AFTER% MB>> %LOGPATH%\%LOGFILE%
echo                          Free space after Tron run:  %FREE_SPACE_AFTER% MB
echo                          Disk space reclaimed:       %FREE_SPACE_SAVED% MB>> %LOGPATH%\%LOGFILE%
echo                          Disk space reclaimed:       %FREE_SPACE_SAVED% MB
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------


:: Skip all this if we're doing a dry run
if /i %DRY_RUN%==yes goto end_and_skip_shutdown

:: Perform reboot if requested
if /i not "%AUTO_REBOOT_DELAY%"=="0" shutdown -r -f -t %AUTO_REBOOT_DELAY% -c "Rebooting in %AUTO_REBOOT_DELAY% seconds to finish cleanup."

:: Perform shutdown if requested
if /i %AUTO_SHUTDOWN%==yes shutdown -f -t %AUTO_REBOOT_DELAY% -s

:: De-rez self if requested
if /i %SELF_DESTRUCT%==yes (
	set CWD=%CD%
	cd ..
	rmdir /s /q %CWD%
	)

:end_and_skip_shutdown
pause
color

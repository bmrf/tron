:: Purpose:       Runs a series of cleaners and anti-virus engines to clean up/disinfect a PC
::                  Kevin Flynn:  "Who's that guy?"
::                  Program:      "That's Tron. He fights for the Users."
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended
:: Author:        vocatus on reddit.com/r/sysadmin ( vocatus.gate@gmail.com ) // PGP key ID: 0x82A211A2
:: Version:       1.8.1 * tron.bat: bugfix:  Fixed incorrect "pushd" entry (was wmi_repair; supposed to be repair_rmi)
::                1.8.0 * prep and checks:   Overhauled Date/Time conversion so we can handle all versions of Windows using any local date-time format.
::                                           Thanks to reddit.com/user/daafe
::                       * prep and checks:   Possibly fixed Windows 8/8.1 Administrator rights check. Just in case, switched the Administrator rights check to warning-only (removed forced exit). Thanks to reddit.com/user/domz128
::                      * stage_0_prep:      rkill improvements; now executes silently (no popup window) and logs to the standard log file along with everything else
::                      + stage_1_tempclean: Added job to clear Windows event logs
::                1.7.4 * prep and checks:   Fixed incorrectly-placed popd statement at beginning of :detect_safe_mode block. Thanks to reddit.com/user/Eschmacher
::                1.7.3 * prep and checks:   Think we finally fixed SSD detection. Please test and report if it fails on your drive
::                      * prep and checks:   Renamed all instances of REBOOT_DELAY to AUTO_REBOOT_DELAY
::                1.7.2 * tron.bat:          Script now accepts "--auto" and "-a" as flags for automatic unattended execution
::                      + tron.bat:          Re-added check for Administrator rights using more reliable method for Windows 2000 through Windows 8. Thanks to stackoverflow.com/users/3198799/and31415 for fix.
::                      * tron.bat:          Reverted SSD check to something more reliable
::                      / tron.bat:          Moved all but most recent changelog entries to the standalone changelog file, to avoid cluttering up script header
:: Usage:         Run this script in Safe Mode as an Administrator and reboot when finished
::                Run with "-a" or "--auto" to execute silently (no welcome screen)
::                Edit the four variables below (LOGPATH, LOGFILE, AUTO_REBOOT_DELAY, and SKIP_DEFRAG) if you don't like the defaults
::                Godspeed
SETLOCAL


:::::::::::::::
:: VARIABLES :: --------------- Set these to your desired values --------------------------- ::
:::::::::::::::
:: Rules for variables:
::  * NO quotes!                       (bad:  "c:\directory\path"       )
::  * NO trailing slashes on the path! (bad:   c:\directory\            )
::  * Spaces are okay                  (okay:  c:\my folder\with spaces )
::  * Network paths are okay           (okay:  \\server\share name      )
::                                     (       \\172.16.1.5\share name  )

:: Log settings
set LOGPATH=%SystemDrive%\Logs
set LOGFILE=tron.log

:: Post-run delay (in seconds) before rebooting. Set to 0 to disable auto-reboot.
set AUTO_REBOOT_DELAY=0

:: Set to anything but "no" in order to skip defrag regardless whether the system drive is an SSD or not.
:: Leave as "no" to let the script auto-detect SSDs
set SKIP_DEFRAG=no


:: -------------------------- Don't edit anything below this line -------------------------- ::


:::::::::::::::::::::
:: Prep and Checks :: -- Don't change anything in this section
:::::::::::::::::::::
@echo off && cls && echo. && echo  Loading... && echo.
set VERSION=1.8.1
set UPDATED=2014-07-29
title TRON v%VERSION% (%UPDATED%)
:: Get the date into ISO 8601 standard date format (yyyy-mm-dd) so it's useful 
FOR /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%

:: Get in the correct drive (~d0). This is sometimes needed when running from a thumb drive
%~d0 2>NUL
:: Get in the correct path (~dp0). This is useful if we start from a network share; convert CWD to a drive letter
pushd %~dp0 2>NUL

:: Detect if we're on an XP/2k3-series kernel
:: This is used to determine which powercfg.exe commands to run in the Prep section
:detect_xp
set WIN_VER=undetected
ver | find /i "Version 5." 2>NUL
if %ERRORLEVEL%==0 set WIN_VER=xp2k3

:: Detect Solid State hard drives (determines if post-run defrag executes or not)
:: Basically we use a trick to set the global SSD_DETECTED variable outside of the setlocal block, by stacking it on the same line so it gets executed along with ENDLOCAL
:: Alternate method by /u/Suddenly_Engineer and /u/Aberu. Big time thanks for helping out with this.
:detect_ssd
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

:: Detect Safe Mode
:detect_safe_mode
popd
set SAFE_MODE=no
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" set SAFE_MODE=yes
if /i "%SAFEBOOT_OPTION%"=="NETWORK" set SAFE_MODE=yes

:: Check for autorun
if "%1"=="--auto" goto execute_jobs
if "%1"=="-a" goto execute_jobs

:::::::::::::::::::::::
:: LOG FILE HANDLING ::
:::::::::::::::::::::::
if not exist %LOGPATH% mkdir %LOGPATH%
if not exist %LOGPATH%\%LOGFILE% echo. > %LOGPATH%\%LOGFILE%

::::::::::::::::::::
:: WELCOME SCREEN ::
::::::::::::::::::::
:welcome_screen
cls
echo  *****************  TRON v%VERSION% (%UPDATED%)  ****************
echo  * Script to automate a series of cleanup/disinfect tools.   *
echo  * Author: vocatus on reddit.com/r/sysadmin                  *
echo  *                                                           *
echo  * Stage:         Tools:                                     *
echo  * --------------------------------------------------------- *
echo  *  0 Prep:       rkill, WMI repair                          *
echo  *  1 TempClean:  BleachBit, CCleaner                        *
echo  *  2 Disinfect:  Vipre, Sophos, MBAM                        *
echo  *  3 De-bloat:   Remove OEM bloatware apps                  *
echo  *  4 Patch:      Update 7-Zip/Java/Flash/Windows            *
echo  *  5 Optimize:   Defrag %SystemDrive% (non-SSD only)                   *
echo  *                                                           *
echo  * The \resources folder contains additional tools which may *
echo  * be run manually if necessary.                             *
echo  *************************************************************
echo.
:: This is so ugly it makes me cry
echo  Current settings (edit script to change):
echo     Log location:            %LOGPATH%\%LOGFILE%
if not "%AUTO_REBOOT_DELAY%"=="0" echo     Post-clean reboot delay: %AUTO_REBOOT_DELAY% seconds
if "%AUTO_REBOOT_DELAY%"=="0" echo     Post-clean reboot delay: disabled
if "%SSD_DETECTED%"=="yes" echo     SSD detected?            %SSD_DETECTED% (stage_5 skipped)
if "%SSD_DETECTED%"=="no" echo     SSD detected?            %SSD_DETECTED%
if "%SAFEBOOT_OPTION%"=="MINIMAL" echo     Safe mode?               %SAFE_MODE%, without Networking
if "%SAFEBOOT_OPTION%"=="NETWORK" echo     Safe mode?               %SAFE_MODE%, with Networking (ideal)
if not "%SAFE_MODE%"=="yes" echo     Safe mode?               %SAFE_MODE% (not ideal)
if not "%SKIP_DEFRAG%"=="no" (
	echo   ! SKIP_DEFRAG set; skipping stage_5_optimize ^(defrag^)
	echo     Runtime estimate:        3-5 hours
	goto welcome_screen_trailer
	)
if "%SSD_DETECTED%"=="yes" echo     Runtime estimate:        3-5 hours
if not "%SSD_DETECTED%"=="yes" echo     Runtime estimate:        5-7 hours
echo.
:welcome_screen_trailer
pause

::::::::::::::::::::::::
:: ADMIN RIGHTS CHECK ::
::::::::::::::::::::::::
:check_permissions
sfc 2>NUL | find /i "/SCANNOW" > NUL
if not "%ERRORLEVEL%"=="0" (
		color 0c
		cls
		echo.
		echo  ERROR
		echo.
		echo  Tron doesn't think it is running as an Administrator.
		echo  Tron MUST be run with full Administrator rights to 
		echo  function correctly.
        echo.
		echo  It's possible Tron is mistaken ^(this usually happens on
        echo  Windows 8^/8.1^), so if you're SURE you're running as an 
		echo  Administrator, go ahead.
		echo.
		pause
	)

:::::::::::::::::::::
:: SAFE MODE CHECK ::
:::::::::::::::::::::
:check_safe_mode
:: Test if we're in safe mode
if not "%SAFE_MODE%"=="yes" (
		color 0c
		cls
		echo.
		echo  WARNING
		echo.
		echo  The system is not in safe mode. Tron functions best
		echo  in "Safe Mode with Networking" in order to download
        echo  Windows and anti-virus updates.
		echo.
		echo  Tron will still function, but rebooting to "Safe Mode
		echo  with Networking" is STRONGLY recommended.
		echo.
		pause
		cls
		)

:: Test if we have network support
if /i  "%SAFEBOOT_OPTION%"=="MINIMAL" (
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
		
::::::::::::::::::
:: EXECUTE JOBS ::
::::::::::::::::::
:execute_jobs
color 0f
title TRON v%VERSION% [stage_0_prep]
:: Create the log header for this job
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------
echo  %CUR_DATE% %TIME%  TRON v%VERSION% (%UPDATED%), %PROCESSOR_ARCHITECTURE% architecture detected>> %LOGPATH%\%LOGFILE%
echo  %CUR_DATE% %TIME%  TRON v%VERSION% (%UPDATED%), %PROCESSOR_ARCHITECTURE% architecture detected
echo                          Executing as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%>> %LOGPATH%\%LOGFILE%
echo                          Executing as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------


:::::::::::::::::::
:: STAGE 0: PREP ::
:::::::::::::::::::
:stage_0_prep
pushd resources\stage_0_prep
echo %CUR_DATE% %TIME%   Launching stage_0_prep jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching stage_0_prep jobs...

:: JOB: rkill
echo %CUR_DATE% %TIME%   Launching job 'rkill'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'rkill'...
pushd rkill
if '%PROCESSOR_ARCHITECTURE%'=='AMD64' rkill64.exe -s -l "%LOGPATH%\tron_rkill.log"
if '%PROCESSOR_ARCHITECTURE%'=='x86' rkill.exe -s -l "%LOGPATH%\tron_rkill.log"
type "%LOGPATH%\tron_rkill.log" >> "%LOGPATH%\%LOGFILE%"
del "%LOGPATH%\tron_rkill.log"
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Disable sleep mode
echo %CUR_DATE% %TIME%   Disabling Sleep mode...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Disabling Sleep mode...
pushd disable_sleep
:: Check for Windows XP and run the appropriate powercfg command
if "%WIN_VER%"=="xp2k3" (powercfg /SETACTIVE "Always On") else (powercfg /SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c)
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Check and Repair WMI if it's broken
echo %CUR_DATE% %TIME%   Checking WMI...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Checking WMI...
pushd repair_wmi

:: Do a quick check to make sure WMI is working, and if not, repair it
wmic timezone >NUL
if not %ERRORLEVEL%==0 (
    echo %CUR_DATE% %TIME% ! WMI appears to be broken. Running WMI repair. This might take a minute, please be patient...>> "%LOGPATH%\%LOGFILE%"
    echo %CUR_DATE% %TIME% ! WMI appears to be broken. Running WMI repair. This might take a minute, please be patient...
    net stop winmgmt
    pushd %WINDIR%\system32\wbem
    for %%i in (*.dll) do RegSvr32 -s %%i
    :: Kill this random window that pops up
    tskill wbemtest /a 2>NUL
    scrcons.exe /RegServer
    unsecapp.exe /RegServer
    start "" wbemtest.exe /RegServer
    tskill wbemtest /a 2>NUL
    tskill wbemtest /a 2>NUL
    :: winmgmt.exe /resetrepository       -- optional; forces full rebuild instead of a repair like the line below this
	winmgmt.exe /salvagerepository /resyncperf
    wmiadap.exe /RegServer
    wmiapsrv.exe /RegServer
    wmiprvse.exe /RegServer
    net start winmgmt
	popd
	)

popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

popd
echo %CUR_DATE% %TIME%   Completed stage_0_prep jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_0_prep jobs.


::::::::::::::::::::::::
:: STAGE 1: TEMPCLEAN ::
::::::::::::::::::::::::
:stage_1_tempclean
title TRON v%VERSION% [stage_1_tempclean]
pushd resources\stage_1_tempclean
echo %CUR_DATE% %TIME%   Launching stage_1_tempclean jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching stage_1_tempclean jobs...

:: JOB: CCLeaner
echo %CUR_DATE% %TIME%   Launching job 'CCleaner'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'CCleaner'...
pushd ccleaner
ccleaner.exe /auto>> "%LOGPATH%\%LOGFILE%" 2>NUL
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: BleachBit
echo %CUR_DATE% %TIME%   Launching job 'BleachBit'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'BleachBit'...
pushd bleachbit
bleachbit_console.exe --preset -c>> "%LOGPATH%\%LOGFILE%" 2>NUL
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Clear Windows event logs
echo %CUR_DATE% %TIME%   Launching job 'Clear Windows event logs'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Clear Windows event logs'...
pushd clear_windows_event_logs
for /f %%x in ('wevtutil el') do wevtutil cl "%%x" 2>NUL
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

popd
echo %CUR_DATE% %TIME%   Completed stage_1_tempclean jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_1_tempclean jobs.


::::::::::::::::::::::::
:: STAGE 2: Disinfect ::
::::::::::::::::::::::::
:stage_2_disinfect
title TRON v%VERSION% [stage_2_disinfect]
pushd resources\stage_2_disinfect
echo %CUR_DATE% %TIME%   Launching stage_2_disinfect jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching stage_2_disinfect jobs...

:: JOB: Emsisoft Commandline Scanner (a2cmd)
echo %CUR_DATE% %TIME%   Launching job 'Emsisoft Commandline Scanner'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Emsisoft Commandline Scanner'...
echo %CUR_DATE% %TIME%   Logging to console instead of logfile for this job...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Logging to console instead of logfile for this job...
pushd a2cmd
a2cmd.exe /update
a2cmd.exe /smart /dda /ntfs /delete
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: VIPRE Rescue
echo %CUR_DATE% %TIME%   Launching job 'Vipre rescue scanner' (takes a LONG time)...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Vipre rescue scanner' (takes a LONG time)...
echo %CUR_DATE% %TIME%   Logging to console instead of logfile for this job...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Logging to console instead of logfile for this job...
pushd vipre_rescue
VipreRescueScanner.exe
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Sophos Virus Remover
echo %CUR_DATE% %TIME%   Launching job 'Sophos Virus Removal Tool' (takes a LONG time)...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Sophos Virus Removal Tool' (takes a LONG time)...
echo %CUR_DATE% %TIME%   Logging to console instead of logfile for this job...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Logging to console instead of logfile for this job...
pushd sophos_virus_remover
svrtcli.exe -yes
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: MBAM (MalwareBytes Anti-Malware)
echo %CUR_DATE% %TIME%   Launching job 'Malwarebytes Anti-Malware', continuing other jobs..."%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Malwarebytes Anti-Malware', continuing other jobs...
pushd mbam

:: Install & remove the desktop icon
"Malwarebytes Anti-Malware v2.0.2.1012.exe" /verysilent
if exist "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk" del "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk"
if exist "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk" del "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk"

:: Scan
pushd "%ProgramFiles(x86)%\Malwarebytes Anti-Malware"
start "" "mbam.exe"
popd


popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: System File Checker scan
echo %CUR_DATE% %TIME%   Launching job 'System File Checker'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'System File Checker'...
pushd sfc
:: Basically this says "If OS is NOT XP or 2003, then go ahead and run system file checker
if not "%WIN_VER%"=="xp2k3" sfc /scannow
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.



popd
echo %CUR_DATE% %TIME%   Completed stage_2_disinfect jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_2_disinfect jobs.


:::::::::::::::::::::::
:: STAGE 3: De-Bloat ::
:::::::::::::::::::::::
:stage_3_de-bloat
title TRON v%VERSION% [stage_3_de-bloat]
pushd resources\stage_3_de-bloat
echo %CUR_DATE% %TIME%   Launching stage_3_de-bloat jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching stage_3_de-bloat jobs...

:: JOB: Remove crapware programs
echo %CUR_DATE% %TIME%   Searching for and removing common crapware programs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Searching for and removing common crapware programs...
echo %CUR_DATE% %TIME%   Customize list here: \resources\stage_3_de-bloat\programs_to_target.txt>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Customize list here: \resources\stage_3_de-bloat\programs_to_target.txt
:: This searches through the list of programs in "programs_to_target.txt" file and uninstalls them one-by-one
FOR /F "tokens=*" %%i in (programs_to_target.txt) DO echo  %%i && echo  %%i...>> "%LOGPATH%\%LOGFILE%" && wmic product where "name like '%%i'" uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"

echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

popd
echo %CUR_DATE% %TIME%   Completed stage_3_de-bloat jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_3_de-bloat jobs.


::::::::::::::::::::::
:: STAGE 4: Patches ::
::::::::::::::::::::::
:stage_4_patch
title TRON v%VERSION% [stage_4_patch]
pushd resources\stage_4_patch
echo %CUR_DATE% %TIME%   Launching stage_4_patch jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching stage_4_patch jobs...

:: Prep task: enable MSI installer in Safe Mode
start "" "enable_msi_installer\SafeMSI.exe"
ping localhost -n 2 >NUL
taskkill /im SafeMSI.exe /f /t

:: JOB: 7-Zip
echo %CUR_DATE% %TIME%   Launching job '7-Zip'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job '7-Zip'...

:: Check if we're on 32-bit Windows and run the appropriate architecture installer
if '%PROCESSOR_ARCHITECTURE%'=='x86' (
	pushd 7-zip\v9.20\x86
	setlocal
	call "7-Zip v9.20 x86.bat"
	endlocal
	popd
) else (
	pushd 7-zip\v9.20\x64
	setlocal
	call "7-Zip v9.20 x64.bat"
	endlocal
	popd
	)

echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Adobe Flash Player
echo %CUR_DATE% %TIME%   Launching job 'Update Adobe Flash Player'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Update Adobe Flash Player'...
pushd "adobe\flash_player\v14.0.0.145\firefox"
setlocal
call "Adobe Flash Player (Firefox).bat"
endlocal
popd
pushd "adobe\flash_player\v14.0.0.145\internet explorer"
setlocal
call "Adobe Flash Player (IE).bat"
endlocal
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Adobe Reader
echo %CUR_DATE% %TIME%   Launching job 'Update Adobe Reader'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Update Adobe Reader'...
pushd adobe\reader\v11.0.07\x86
setlocal
call "Adobe Reader.bat"
endlocal
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Remove outdated JRE runtimes (security risk)
echo %CUR_DATE% %TIME%   Checking and removing outdated JRE installations...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Checking and removing outdated JRE installations...
:: Okay, so all JRE runtimes (series 4-8) use product GUIDs, with certain numbers that increment with each new update (e.g. Update 25)
:: This makes it easy to catch ALL of them through liberal use of WMI wildcards ("_" is single character, "%" is any number of characters)
:: Additionally, JRE 6 introduced 64-bit runtimes, so in addition to the two-digit Update XX revision number, we also check for the architecture 
:: type, which always equals '32' or '64'. The first wildcard is the architecture, the second is the revision/update number.

:: JRE 8
:: we can skip JRE 8 because the JRE 8 updater automatically removes older versions, no need to do it twice

:: JRE 7
echo %CUR_DATE% %TIME%   JRE 7...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   JRE 7...
%WMIC% product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F8__170__FF}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%"

:: JRE 6
echo %CUR_DATE% %TIME%   JRE 6...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   JRE 6...
:: 1st line is for updates 23-xx, after 64-bit runtimes were introduced.
:: 2nd line is for updates 1-22, before Oracle released 64-bit JRE 6 runtimes
%WMIC% product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F8__160__FF}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"
%WMIC% product where "IdentifyingNumber like '{3248F0A8-6813-11D6-A77B-00B0D0160__0}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"

:: JRE 5
echo %CUR_DATE% %TIME%   JRE 5...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   JRE 5...
%WMIC% product where "IdentifyingNumber like '{3248F0A8-6813-11D6-A77B-00B0D0150__0}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"

:: JRE 4
echo %CUR_DATE% %TIME%   JRE 4...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   JRE 4...
%WMIC% product where "IdentifyingNumber like '{7148F0A8-6813-11D6-A77B-00B0D0142__0}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"

echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Java Runtime 8
echo %CUR_DATE% %TIME%   Launching job 'Update Java Runtime Environment'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Update Java Runtime Environment'...

:: Check if we're on 32-bit Windows and run the appropriate architecture installer
if '%PROCESSOR_ARCHITECTURE%'=='x86' (
	echo %CUR_DATE% %TIME%   x86 architecture detected, installing x86 version...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%   x86 architecture detected, installing x86 version...
	pushd java\jre\8\u11\x86
	setlocal
	call "jre-8u11-windows-x86.bat"
	endlocal
	popd
) else (
	echo %CUR_DATE% %TIME%   x64 architecture detected, installing x64 version...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%   x64 architecture detected, installing x64 version...
	pushd java\jre\8\u11\x64
	setlocal
	call "jre-8u11-windows-x64.bat"
	endlocal
	popd
	)

echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Notepad++
echo %CUR_DATE% %TIME%   Launching job 'Update Notepad++'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Update Notepad++'...
pushd notepad++\v6.6.7
setlocal
call "npp.Installer.bat"
endlocal
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Windows updates
echo %CUR_DATE% %TIME%   Launching job 'Install Windows updates'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Install Windows updates'...
pushd windows_updates
wuauclt /detectnow /updatenow
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

popd
echo %CUR_DATE% %TIME%   Completed stage_4_patch jobs.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Completed stage_4_patch jobs.


:::::::::::::::::::::::
:: STAGE 5: Optimize ::
:::::::::::::::::::::::
:stage_5_optimize
title TRON v%VERSION% [stage_5_optimize]
pushd resources\stage_5_optimize
echo %CUR_DATE% %TIME%   Launching stage_5_optimize jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching stage_5_optimize jobs...

:: Check if we are supposed to run a defrag before doing this section
if "%SKIP_DEFRAG%"=="yes" (
	echo %CUR_DATE% %TIME%   SKIP_DEFRAG set to "yes". Skipping job.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%   SKIP_DEFRAG set to "yes". Skipping job.
	popd
	goto :wrap-up
	)

:: Check if we are supposed to run a defrag before doing this section
if "%SSD_DETECTED%"=="yes" (
	echo %CUR_DATE% %TIME%   Solid State hard drive detected. Skipping job 'Defrag %SystemDrive%'.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%   Solid State hard drive detected. Skipping job 'Defrag %SystemDrive%'.
	popd
	goto :wrap-up
	)

:: JOB: Defrag the system drive
if "%SSD_DETECTED%"=="no" (
	echo %CUR_DATE% %TIME%   Launching job 'Defrag %SystemDrive%'...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%   Launching job 'Defrag %SystemDrive%'...
	pushd defrag
	df.exe %SystemDrive%
	popd
	echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%   Done.
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

echo %CUR_DATE% %TIME%   Resetting power settings to their defaults...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Resetting power settings to their defaults...
:: Check for XP and run the appropriate version of the command
if "%WIN_VER%"=="xp2k3" (powercfg /RestoreDefaultPolicies) else (powercfg -restoredefaultschemes)
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

title TRON v%VERSION% [DONE]

echo %CUR_DATE% %TIME%   DONE. Use the tools in resources\stage_6_manual_tools if further cleaning is required.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   DONE. Use the tools in resources\stage_6_manual_tools if further cleaning is required.
echo %CUR_DATE% %TIME%   Logfile is located at %LOGPATH%\%LOGFILE%>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Logfile is located at %LOGPATH%\%LOGFILE%

if "%AUTO_REBOOT_DELAY%"=="0" (
	echo %CUR_DATE% %TIME% ! Auto-reboot disabled. Recommend rebooting as soon as possible.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME% ! Auto-reboot disabled. Recommend rebooting as soon as possible.
) else (
	echo %CUR_DATE% %TIME% ! Rebooting in %AUTO_REBOOT_DELAY% seconds.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME% ! Rebooting in %AUTO_REBOOT_DELAY% seconds.
	)

:: Create the log trailer for this job
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------
echo  %CUR_DATE% %TIME%  TRON v%VERSION% (%UPDATED%) complete>> %LOGPATH%\%LOGFILE%
echo  %CUR_DATE% %TIME%  TRON v%VERSION% (%UPDATED%) complete
echo                          Executed as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%>> %LOGPATH%\%LOGFILE%
echo                          Executed as %USERDOMAIN%\%USERNAME% on %COMPUTERNAME%
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------

if not "%AUTO_REBOOT_DELAY%"=="0" shutdown /r /f /t %AUTO_REBOOT_DELAY% /c "Rebooting in %AUTO_REBOOT_DELAY% seconds to finish cleanup."
pause

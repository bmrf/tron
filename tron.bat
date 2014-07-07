:: Purpose:       Runs a series of cleaners and anti-virus engines to clean up/optimize a PC
::                  Kevin Flynn:  "Who's that guy?"
::                  Program:      "That's Tron. He fights for the Users."
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended
:: Author:        vocatus on reddit.com/r/sysadmin ( vocatus.gate@gmail.com ) // PGP key ID: 0x82A211A2
:: Version:       1.2  + stage_5_optimize:  Added detection of SSD drives. If drive is detected, post-run defrag is skipped
::                                          Thanks to reddit.com/user/you_drown_now for help with this function.
::                     * stage_3_de-bloat:  Improved logic, logging, and robustness for WMIC removal section
::                     * tron.bat:          Improved overall logging, appearance and commenting. Added clarification screens for
::                                          various Safe Mode states
::                     / Intro screen:      Adjusted runtime estimates based on user feedback
::                     / tron.bat:          Disabled post-run auto-reboot by default. Change "REBOOT_DELAY" variable if you wish to auto-reboot
::                     - tron.bat:          Removed section asking user if we want to do a post-run defrag (replaced by auto-detect)
::                     - stage_1_tempclean: Removed TempFileCleanup job (ccleaner and bleachbit cover this requirement)
::                     - stage_4_patch:     Removed /r flag on wuauclt command
::                1.1  * tron.bat:          Various comment, log and syntax cleanup
::                     + tron.bat:          Added section to ask if we want to do a post-run defrag, and skip the defrag
::                                          if the user says no
::                     * tron.bat:          Removed hard requirement to run in safe mode and added code to detect various Safe Mode states
::                     * stage_3_de-bloat:  Converted section to read from a text list located in
::                                          resource\stage_3_de-bloat\programs_to_target.txt
::                     + stage_3_de-bloat:  Added additional programs to find and remove
::                     + stage_3_de-bloat:  Added line to remove Adobe Shockwave (not in wide use anymore)
::                     - stage_4_patch:     Removed installation of Adobe Shockwave
::                1.0    Initial write

:: Usage:         Run this script and let it reboot when finished.


:::::::::::::::::::::
:: Prep and Checks :: -- Don't change anything in this section
:::::::::::::::::::::
@echo off && cls
SETLOCAL
set VERSION=1.2
set UPDATED=2014-07-07
if "%DATE:~-5,1%"=="/" (set CUR_DATE=%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%) else (set CUR_DATE=%DATE%)

:: Get in the correct drive. This is sometimes needed when running from a thumb drive
%~d0 2>NUL
:: This is useful if we start from a network share; convert CWD to a drive letter
pushd %~dp0 2>NUL

:: Detect Solid State hard drives (determines if post-run defrag executes or not)
pushd resources\stage_5_optimize\defrag
set SSD_DETECTED=no
smartctl -a /dev/sda | find /i "Solid State" >NUL
if "%ERRORLEVEL%"=="0" set SSD_DETECTED=yes
popd

:: Detect Safe Mode
set SAFE_MODE=no
if /i "%SAFEBOOT_OPTION%"=="MINIMAL" set SAFE_MODE=yes
if /i "%SAFEBOOT_OPTION%"=="NETWORK" set SAFE_MODE=yes
title TRON v%VERSION% (%UPDATED%)

:::::::::::::::
:: VARIABLES :: -- Set these to your desired values
:::::::::::::::
:: Rules for variables:
::  * NO quotes!                       (bad:  "c:\directory\path"       )
::  * NO trailing slashes on the path! (bad:   c:\directory\            )
::  * Spaces are okay                  (okay:  c:\my folder\with spaces )
::  * Network paths are okay           (okay:  \\server\share name      )
::                                     (       \\172.16.1.5\share name  )

:: Log settings. Max size is how big (in bytes) the log can be before it is archived. 1048576 bytes is one megabyte
set LOGPATH=%SystemDrive%\Logs
set LOGFILE=tron.log

:: Post-run delay (in seconds) before rebooting. Set to 0 to disable auto-reboot.
set REBOOT_DELAY=0

:::::::::::::::::::::::
:: LOG FILE HANDLING :: -- Don't edit anything below this line
:::::::::::::::::::::::
if not exist %LOGPATH% mkdir %LOGPATH%
if not exist %LOGPATH%\%LOGFILE% echo. > %LOGPATH%\%LOGFILE%


::::::::::::::::::::
:: WELCOME SCREEN ::
::::::::::::::::::::
:welcome_screen
echo  *************************************************************
echo  * TRON v%VERSION% (%UPDATED%)                                    *
echo  * Author: vocatus on reddit.com/r/sysadmin                  *
echo  * --------------------------------------------------------- *
echo  * Script to automate a series of cleanup/disinfect tools.   *
echo  *                                                           *
echo  * Stage:         Tools:                                     *
echo  * --------------------------------------------------------- *
echo  *  0 Prep:       rkill                                      *
echo  *  1 TempClean:  BleachBit, CCleaner                        *
echo  *  2 Disinfect:  Vipre, Sophos, MBAM                        *
echo  *  3 De-bloat:   Remove OEM bloatware apps                  *
echo  *  4 Patch:      Update Java/Flash/7-Zip/Windows updates    *
echo  *  5 Optimize:   Defraggler run on %SystemDrive%                       *
echo  *                                                           *
echo  * The \resources folder contains additional tools which     *
echo  * may be run manually if necessary.                         *
echo  *************************************************************
echo.
echo  Current settings (edit script to change):
if not "%REBOOT_DELAY%"=="0" echo     Post-cleanup reboot delay: %REBOOT_DELAY% seconds
if "%REBOOT_DELAY%"=="0" echo     Post-cleanup reboot delay: disabled
echo     Log location:              %LOGPATH%\%LOGFILE%
if "%SAFEBOOT_OPTION%"=="MINIMAL" echo     Safe mode?                 %SAFE_MODE%, without Network support
if "%SAFEBOOT_OPTION%"=="NETWORK" echo     Safe mode?                 %SAFE_MODE%, with Network support (ideal)
if not "%SAFE_MODE%"=="yes" echo     Safe mode?                 %SAFE_MODE% (not ideal)
if "%SSD_DETECTED%"=="yes" echo     SSD detected?              %SSD_DETECTED% (stage_5 will be skipped)
if "%SSD_DETECTED%"=="no" echo     SSD detected?              %SSD_DETECTED%
if "%SSD_DETECTED%"=="yes" echo     Runtime estimate:          2-4 hours
if "%SSD_DETECTED%"=="no" echo     Runtime estimate:          4-6 hours
echo.
pause

:::::::::::::::::::::
:: SAFE MODE CHECK ::
:::::::::::::::::::::
:safe_mode_check
:: Test if we're in safe mode
if not "%SAFE_MODE%"=="yes" (
		color 0c
		cls
		echo.
		echo  WARNING
		echo.
		echo  The system is not in safe mode. Tron functions best
		echo  in safe mode, specifically "Safe Mode with Network"
        echo  in order to download Windows and anti-virus updates.
		echo.
		echo  Tron will still function, but rebooting to safe mode
		echo  is STRONGLY recommended.
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
		echo  The system is in safe mode without Network support.
		echo  Tron functions best in "Safe Mode with Network", in
        echo  in order to download Windows and anti-virus updates.
		echo.
		echo  Tron will still function, but rebooting to Safe Mode
		echo  with Network support enabled is recommended.
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
echo  %CUR_DATE% %TIME%  TRON v%VERSION% (%UPDATED%), %PROCESSOR_ARCHITECTURE% system detected>> %LOGPATH%\%LOGFILE%
echo  %CUR_DATE% %TIME%  TRON v%VERSION% (%UPDATED%), %PROCESSOR_ARCHITECTURE% system detected
echo                          Executing as %USERDOMAIN%\%USERNAME% against %COMPUTERNAME%>> %LOGPATH%\%LOGFILE%
echo                          Executing as %USERDOMAIN%\%USERNAME% against %COMPUTERNAME%
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------


:::::::::::::::::::
:: STAGE 0: PREP ::
:::::::::::::::::::
:stage_0_prep
pushd resources\stage_0_prep
echo %CUR_DATE% %TIME%   Launching stage_0_prep jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching stage_0_prep jobs...

:: JOB: rkill (kills running malware processes)
echo %CUR_DATE% %TIME%   Launching job 'rkill'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'rkill'...
echo %CUR_DATE% %TIME%   Pinging localhost while waiting for rkill to finish...
pushd rkill
if '%PROCESSOR_ARCHITECTURE%'=='AMD64' start /MIN "" "rkill64.exe"
if '%PROCESSOR_ARCHITECTURE%'=='x86' start /MIN "" "rkill.exe"
ping localhost -n 120 >NUL
TASKKILL /F /IM rkill64.exe /T 2>NUL
TASKKILL /F /IM rkill.exe /T 2>NUL
TASKKILL /F /IM notepad.exe /T 2>NUL
:: Dump the rkill log into the tron log
type %USERPROFILE%\Desktop\rkill.txt>> %LOGPATH%\tron.log
del %USERPROFILE%\Desktop\rkill.txt
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
ccleaner.exe /auto
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

:: JOB: VIPRE Rescue
echo %CUR_DATE% %TIME%   Launching job 'Vipre rescue scanner' (takes a while)...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Vipre rescue scanner' (takes a while)...
pushd vipre_rescue
VipreRescueScanner.exe>> "%LOGPATH%\%LOGFILE%"
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Sophos Virus Remover
echo %CUR_DATE% %TIME%   Launching job 'Sophos Virus Removal Tool' (takes a while)...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Sophos Virus Removal Tool' (takes a while)...
pushd sophos_virus_remover
svrtcli.exe -yes>> "%LOGPATH%\%LOGFILE%"
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: MBAM (MalwareBytes Anti-Malware)
echo %CUR_DATE% %TIME%   Launching job 'Malwarebytes Anti-Malware', continuing other jobs...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Malwarebytes Anti-Malware', continuing other jobs...
pushd mbam
"Malwarebytes Anti-Malware v2.0.2.1012.exe" /verysilent
pushd "%ProgramFiles(x86)%\Malwarebytes Anti-Malware"
start "" "mbam.exe"
:: Remove the desktop icon
if exist "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk" del "%PUBLIC%\Desktop\Malwarebytes Anti-Malware.lnk"
if exist "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk" del "%USERPROFILE%\Desktop\Malwarebytes Anti-Malware.lnk"
popd
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
	)

:: else install the 64-bit version
if '%PROCESSOR_ARCHITECTURE%'=='AMD64' (
	pushd 7-zip\v9.20\x64
	setlocal
	call "7-Zip v9.20 x64.bat"
	endlocal
	popd
	)

echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Adobe Flash Player
echo %CUR_DATE% %TIME%   Launching job 'Adobe Flash Player'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Adobe Flash Player'...
pushd "adobe\flash_player\v14.0.0.125\firefox"
setlocal
call "Adobe Flash Player (Firefox).bat"
endlocal
popd
pushd "adobe\flash_player\v14.0.0.125\internet explorer"
setlocal
call "Adobe Flash Player (IE).bat"
endlocal
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Adobe Reader
echo %CUR_DATE% %TIME%   Launching job 'Adobe Reader'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Adobe Reader'...
pushd adobe\reader\v11.0.07\x86
setlocal
call "Adobe Reader.bat"
endlocal
popd
echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Java Runtime 8
echo %CUR_DATE% %TIME%   Launching job 'Java Runtime 8'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Java Runtime 8'...

:: Check if we're on 32-bit Windows and run the appropriate architecture installer
if '%PROCESSOR_ARCHITECTURE%'=='x86' (
	echo %CUR_DATE% %TIME%   x86 architecture detected, installing x86 version...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%   x86 architecture detected, installing x86 version...
	pushd java\jre\8\u5\x86
	setlocal
	call "jre-8u5-windows-x86.bat"
	endlocal
	popd
	)

:: else install the 64-bit version
if '%PROCESSOR_ARCHITECTURE%'=='AMD64' (
	echo %CUR_DATE% %TIME%   x64 architecture detected, installing x64 version...>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME%   x64 architecture detected, installing x64 version...
	pushd java\jre\8\u5\x64
	setlocal
	call "jre-8u5-windows-x64.bat"
	endlocal
	popd
	)

echo %CUR_DATE% %TIME%   Done.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Done.

:: JOB: Notepad++
echo %CUR_DATE% %TIME%   Launching job 'Notepad++'...>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Launching job 'Notepad++'...
pushd notepad++\v6.6.4
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
title TRON v%VERSION% [DONE]
echo %CUR_DATE% %TIME%   DONE. Use the tools in resources\stage_6_manual_methods if further cleaning is required.>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   DONE. Use the tools in resources\stage_6_manual_methods if further cleaning is required.
echo %CUR_DATE% %TIME%   Logfile is located at %LOGPATH%\%LOGFILE%>> "%LOGPATH%\%LOGFILE%"
echo %CUR_DATE% %TIME%   Logfile is located at %LOGPATH%\%LOGFILE%

if "%REBOOT_DELAY%"=="0" (
	echo %CUR_DATE% %TIME% ! Auto-reboot disabled. Recommend rebooting as soon as possible.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME% ! Auto-reboot disabled. Recommend rebooting as soon as possible.
)

if not "%REBOOT_DELAY%"=="0" (
	echo %CUR_DATE% %TIME% ! Rebooting in %REBOOT_DELAY% seconds.>> "%LOGPATH%\%LOGFILE%"
	echo %CUR_DATE% %TIME% ! Rebooting in %REBOOT_DELAY% seconds.
)

:: Create the log trailer for this job
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------
echo  %CUR_DATE% %TIME%  TRON v%VERSION% (%UPDATED%) complete>> %LOGPATH%\%LOGFILE%
echo  %CUR_DATE% %TIME%  TRON v%VERSION% (%UPDATED%) complete
echo                          Executed as %USERDOMAIN%\%USERNAME% against %COMPUTERNAME%>> %LOGPATH%\%LOGFILE%
echo                          Executed as %USERDOMAIN%\%USERNAME% against %COMPUTERNAME%
echo ------------------------------------------------------------------------------->> %LOGPATH%\%LOGFILE%
echo -------------------------------------------------------------------------------

if not "%REBOOT_DELAY%"=="0" shutdown /r /f /t %REBOOT_DELAY% /c "Rebooting in %REBOOT_DELAY% seconds to finish cleanup."
pause

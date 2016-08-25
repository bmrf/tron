:: Purpose:       Checks for updated sub-stage script code on Github prior to executing Tron. If updates are found, they are spliced in prior to Stage 0 execution
:: Requirements:  Must be called from Tron
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.0 + Initial write
@echo off



:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set UPDATE_CHECK_SUBSTAGES_VERSION=1.0.0
set UPDATE_CHECK_SUBSTAGES_VERSION=2016-08-17

:: Base of the Github URL we pull the scripts from
set GITHUB_URL_BASE=https://github.com/bmrf/tron/raw/master/resources/stage

:: Preload repo version variables in case they don't get fetched for some reason
for %%i in (0,1,2,3,4,5,6) do set REPO_STAGE_%%i_SCRIPT_VERSION=0

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



:::::::::::::::::::::::
:: CHECK FOR UPDATES ::
:::::::::::::::::::::::

:: Clean up the download area
if exist "%TEMP%\stage_*.bat" del /f "%TEMP%\stage_*.bat" 2>NUL

:: Fetch the repo files
for %%i in (_0_prep,_1_tempclean,_2_de-bloat,_3_disinfect,_4_repair,_5_patch,_6_optimize) do (
	start /min stage_0_prep\check_update\wget --no-check-certificate %GITHUB_URL_BASE%%%i/stage%%i.bat -O %TEMP%\stage%%i.bat
)

:: Reset window title since wget clobbers it
title Tron v%SCRIPT_VERSION% (%SCRIPT_DATE%)

:: Wait for wget to finish
:wget_check_loop
tasklist | find /i "wget" >nul
if not errorlevel 1 (
    ping 127.0.0.1 -n 4 >nul
    goto :wget_check_loop
)

:: Parse local sub-stage scripts for their versions and stash in variables
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_0_prep\stage_0_prep.bat" ^| find "STAGE_0_SCRIPT_VERSION"`) DO ( set LOCAL_STAGE_0_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_1_tempclean\stage_1_tempclean.bat" ^| find "STAGE_1_SCRIPT_VERSION"`) DO ( set LOCAL_STAGE_1_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_2_de-bloat\stage_2_de-bloat.bat" ^| find "STAGE_2_SCRIPT_VERSION"`) DO ( set LOCAL_STAGE_2_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_3_disinfect\stage_3_disinfect.bat" ^| find "STAGE_3_SCRIPT_VERSION"`) DO ( set LOCAL_STAGE_3_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_4_repair\stage_4_repair.bat" ^| find "STAGE_4_SCRIPT_VERSION"`) DO ( set LOCAL_STAGE_4_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_5_patch\stage_5_patch.bat" ^| find "STAGE_5_SCRIPT_VERSION"`) DO ( set LOCAL_STAGE_5_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_6_optimize\stage_6_optimize.bat" ^| find "STAGE_6_SCRIPT_VERSION"`) DO ( set LOCAL_STAGE_6_SCRIPT_VERSION=%%i )

:: Parse repo sub-stage scripts for their versions and stash in variables
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\stage_0_prep.bat" ^| find "STAGE_0_SCRIPT_VERSION"`) DO ( set REPO_STAGE_0_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\stage_1_tempclean.bat" ^| find "STAGE_1_SCRIPT_VERSION"`) DO ( set REPO_STAGE_1_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\stage_2_de-bloat.bat" ^| find "STAGE_2_SCRIPT_VERSION"`) DO ( set REPO_STAGE_2_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\stage_3_disinfect.bat" ^| find "STAGE_3_SCRIPT_VERSION"`) DO ( set REPO_STAGE_3_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\stage_4_repair.bat" ^| find "STAGE_4_SCRIPT_VERSION"`) DO ( set REPO_STAGE_4_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\stage_5_patch.bat" ^| find "STAGE_5_SCRIPT_VERSION"`) DO ( set REPO_STAGE_5_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\stage_6_optimize.bat" ^| find "STAGE_6_SCRIPT_VERSION"`) DO ( set REPO_STAGE_6_SCRIPT_VERSION=%%i )


:: Check all versions and splice in new code if necessary
:: Check Stage 0
if /i %LOCAL_STAGE_0_SCRIPT_VERSION% LSS %REPO_STAGE_0_SCRIPT_VERSION% (
	call functions\log.bat " ! Github Stage 0 is v%REPO_STAGE_0_SCRIPT_VERSION%which is newer than local v%LOCAL_STAGE_0_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated Stage 0 v%REPO_STAGE_0_SCRIPT_VERSION%and renaming old code with .backup extension."
	move /y "stage_0_prep\stage_0_prep.bat" "stage_0_prep\stage_0_prep.bat.backup" >NUL
	move /y "%TEMP%\stage_0_prep.bat" "stage_0_prep\stage_0_prep.bat" >NUL
	ping 127.0.0.1 -n 4 >nul
	call functions\log.bat "   Done."
)


:: Check Stage 1
if /i %LOCAL_STAGE_1_SCRIPT_VERSION% LSS %REPO_STAGE_1_SCRIPT_VERSION% (
	call functions\log.bat " ! Github Stage 1 is v%REPO_STAGE_1_SCRIPT_VERSION%which is newer than local v%LOCAL_STAGE_1_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated Stage 1 v%REPO_STAGE_1_SCRIPT_VERSION%and renaming old code with .backup extension."
	move /y "stage_1_tempclean\stage_1_tempclean.bat" "stage_1_tempclean\stage_1_tempclean.bat.backup" >NUL
	move /y "%TEMP%\stage_1_tempclean.bat" "stage_1_tempclean\stage_1_tempclean.bat" >NUL
	ping 127.0.0.1 -n 4 >nul
	call functions\log.bat "   Done."
)


:: Check Stage 2
if /i %LOCAL_STAGE_2_SCRIPT_VERSION% LSS %REPO_STAGE_2_SCRIPT_VERSION% (
	call functions\log.bat " ! Github Stage 2 is v%REPO_STAGE_2_SCRIPT_VERSION%which is newer than local v%LOCAL_STAGE_2_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated Stage 2 v%REPO_STAGE_2_SCRIPT_VERSION%and renaming old code with .backup extension."
	move /y "stage_2_de-bloat\stage_2_de-bloat.bat" "stage_2_de-bloat\stage_2_de-bloat.bat.backup" >NUL
	move /y "%TEMP%\stage_2_de-bloat.bat" "stage_2_de-bloat\stage_2_de-bloat.bat" >NUL
	ping 127.0.0.1 -n 4 >nul
	call functions\log.bat "   Done."
)


:: Check Stage 3
if /i %LOCAL_STAGE_3_SCRIPT_VERSION% LSS %REPO_STAGE_3_SCRIPT_VERSION% (
	call functions\log.bat " ! Github Stage 3 is v%REPO_STAGE_3_SCRIPT_VERSION%which is newer than local v%LOCAL_STAGE_3_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated Stage 3 v%REPO_STAGE_3_SCRIPT_VERSION%and renaming old code with .backup extension."
	move /y "stage_3_disinfect\stage_3_disinfect.bat" "stage_3_disinfect\stage_3_disinfect.bat.backup" >NUL
	move /y "%TEMP%\stage_3_disinfect.bat" "stage_3_disinfect\stage_3_disinfect.bat" >NUL
	ping 127.0.0.1 -n 4 >nul
	call functions\log.bat "   Done."
)


:: Check Stage 4
if /i %LOCAL_STAGE_4_SCRIPT_VERSION% LSS %REPO_STAGE_4_SCRIPT_VERSION% (
	call functions\log.bat " ! Github Stage 4 is v%REPO_STAGE_4_SCRIPT_VERSION%which is newer than local v%LOCAL_STAGE_4_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated Stage 4 v%REPO_STAGE_4_SCRIPT_VERSION%and renaming old code with .backup extension."
	move /y "stage_4_repair\stage_4_repair.bat" "stage_4_repair\stage_4_repair.bat.backup" >NUL
	move /y "%TEMP%\stage_4_repair.bat" "stage_4_repair\stage_4_repair.bat" >NUL
	ping 127.0.0.1 -n 4 >nul
	call functions\log.bat "   Done."
)


:: Check Stage 5
if /i %LOCAL_STAGE_5_SCRIPT_VERSION% LSS %REPO_STAGE_5_SCRIPT_VERSION% (
	call functions\log.bat " ! Github Stage 5 is v%REPO_STAGE_5_SCRIPT_VERSION%which is newer than local v%LOCAL_STAGE_5_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated Stage 5 v%REPO_STAGE_5_SCRIPT_VERSION%and renaming old code with .backup extension."
	move /y "stage_5_patch\stage_5_patch.bat" "stage_5_patch\stage_5_patch.bat.backup" >NUL
	move /y "%TEMP%\stage_5_patch.bat" "stage_5_patch\stage_5_patch.bat" >NUL
	ping 127.0.0.1 -n 4 >nul
	call functions\log.bat "   Done."
)


:: Check Stage 6
if /i %LOCAL_STAGE_6_SCRIPT_VERSION% LSS %REPO_STAGE_6_SCRIPT_VERSION% (
	call functions\log.bat " ! Github Stage 6 is v%REPO_STAGE_6_SCRIPT_VERSION%which is newer than local v%LOCAL_STAGE_6_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated Stage 6 v%REPO_STAGE_6_SCRIPT_VERSION%and renaming old code with .backup extension."
	move /y "stage_6_optimize\stage_6_optimize.bat" "stage_6_optimize\stage_6_optimize.bat.backup" >NUL
	move /y "%TEMP%\stage_6_optimize.bat" "stage_6_optimize\stage_6_optimize.bat" >NUL
	ping 127.0.0.1 -n 4 >nul
	call functions\log.bat "   Done."
)

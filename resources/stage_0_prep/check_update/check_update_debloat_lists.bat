:: Purpose:       Checks for updated debloat lists on Github prior to executing Tron. If updates are found, they are spliced in prior to Stage 0 execution
:: Requirements:  Must be called from Tron
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.0 + Add new job to check for and download the programs_to_target_by_name list 
::                      * Update jobs to reflect new list names on Github
::                1.0.3 * Wrap all references to %TEMP% in quotes to account for possibility of a user account with special characters in it (e.g. "&")
::                1.0.2 ! Remove erroneous debugging statement that was mistakenly left in. It flagged the local 3rd party Metro list as being out of date regardless of version
::                      + Add preloading of variables so the script doesn't crash if it can't detect a version number correctly
::                1.0.1 - Remove '--no-check-certificate' statement from wget commands, due to upgrade of Tron's internal wget.exe to v1.18.
::                        Enables proper SSL encryption when checking Github's S2 debloat lists. Note that the wget commands will fail if not using at least v1.18 of wget
::                1.0.0 + Initial write
@echo off



:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set CHECK_UPDATE_DEBLOAT_LISTS_VERSION=1.1.0
set CHECK_UPDATE_DEBLOAT_LISTS_VERSION=2016-11-01

:: Base of the Github URL we pull the scripts from
:: Full URL is built like this: %GITHUB_URL_BASE%/oem/FILENAME  (for example)
set GITHUB_URL_BASE=https://github.com/bmrf/tron/raw/master/resources/stage_2_de-bloat

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

:: Preload variables
set LOCAL_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=0
set LOCAL_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=0
set LOCAL_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION=0
set LOCAL_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION=0
set LOCAL_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION=0


set REPO_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=0
set REPO_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=0
set REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION=0
set REPO_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION=0
set REPO_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION=0


:::::::::::::
:: EXECUTE ::
:::::::::::::
:: Clean up the download area
if exist "%TEMP%\*to_target_by_*" del /f "%TEMP%\*to_target_by_*" 2>NUL

:: Fetch the repo PowerShell scripts
for %%i in (metro_3rd_party_modern_apps_to_target_by_name,metro_Microsoft_modern_apps_to_target_by_name) do (
	start /min stage_0_prep\check_update\wget %GITHUB_URL_BASE%/metro/%%i.ps1 -O "%TEMP%\%%i.ps1"
)
:: Fetch the repo text scripts
for %%i in (programs_to_target_by_GUID,programs_to_target_by_name,toolbars_BHOs_to_target_by_GUID) do (
	start /min stage_0_prep\check_update\wget %GITHUB_URL_BASE%/oem/%%i.txt -O "%TEMP%\%%i.txt"
)

:: Wait for wget to finish
:wget_check_loop
tasklist | %FIND% /i "wget" >nul
if not errorlevel 1 (
    ping 127.0.0.1 -n 3 >nul
    goto :wget_check_loop
)

:: Reset window title since wget clobbers it
title Tron v%SCRIPT_VERSION% (%SCRIPT_DATE%)




:: Parse all scripts for their versions and stash in variables
:: WARNING: FOR /F black magic was used below
:: LOCAL: PowerShell scripts
for /F usebackqtokens^=2delims^=^" %%i IN (`type "stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1" ^| %FIND% "SCRIPT_VERSION"`) DO ( set LOCAL_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i )
for /F usebackqtokens^=2delims^=^" %%i IN (`type "stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1" ^| %FIND% "SCRIPT_VERSION"`) DO ( set LOCAL_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i )
:: LOCAL: Batch scripts
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt" ^| %FIND% "SCRIPT_VERSION"`) DO ( set LOCAL_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_2_de-bloat\oem\programs_to_target_by_name.txt" ^| %FIND% "SCRIPT_VERSION"`) DO ( set LOCAL_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt" ^| %FIND% "SCRIPT_VERSION"`) DO ( set LOCAL_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION=%%i )
:: REPO: PowerShell scripts
for /F usebackqtokens^=2delims^=^" %%i IN (`type "%TEMP%\metro_3rd_party_modern_apps_to_target_by_name.ps1" ^| %FIND% "SCRIPT_VERSION"`) DO ( set REPO_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i )
for /F usebackqtokens^=2delims^=^" %%i IN (`type "%TEMP%\metro_Microsoft_modern_apps_to_target_by_name.ps1" ^| %FIND% "SCRIPT_VERSION"`) DO ( set REPO_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i )
:: REPO: Batch scripts
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\programs_to_target_by_GUID.txt" ^| %FIND% "SCRIPT_VERSION"`) DO ( set REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\programs_to_target_by_name.txt" ^| %FIND% "SCRIPT_VERSION"`) DO ( set REPO_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i )
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\toolbars_BHOs_to_target_by_GUID.txt" ^| %FIND% "SCRIPT_VERSION"`) DO ( set REPO_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION=%%i )




:: Check all versions and splice in new code if necessary
:: metro_3rd_party_modern_apps_to_target_by_name.ps1
if /i %LOCAL_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% LSS %REPO_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% (
	call functions\log.bat " ! Github metro_3rd_party list is v%REPO_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%which is newer than local v%LOCAL_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1" "stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1.backup" >NUL
	move /y "%TEMP%\metro_3rd_party_modern_apps_to_target_by_name.ps1" "stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)

:: metro_Microsoft_modern_apps_to_target_by_name.ps1
if /i %LOCAL_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% LSS %REPO_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% (
	call functions\log.bat " ! Github metro_Microsoft list is v%REPO_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%which is newer than local v%LOCAL_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1" "stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1.backup" >NUL
	move /y "%TEMP%\metro_Microsoft_modern_apps_to_target_by_name.ps1" "stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)

:: programs_to_target_by_GUID.txt
if /i %LOCAL_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION% LSS %REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION% (
	call functions\log.bat " ! Github programs_to_target_by_GUID list is v%REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION%which is newer than local v%LOCAL_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION%list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt.backup" >NUL
	move /y "%TEMP%\programs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)

:: programs_to_target_by_name.txt
if /i %LOCAL_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION% LSS %REPO_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION% (
	call functions\log.bat " ! Github programs_to_target_by_name list is v%REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION%which is newer than local v%LOCAL_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION%list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt.backup" >NUL
	move /y "%TEMP%\programs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)

:: toolbars_BHOs_to_target_by_GUID.txt
if /i %LOCAL_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION% LSS %REPO_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION% (
	call functions\log.bat " ! Github toolbars_BHOs_to_target_by_GUID list is v%REPO_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION%which is newer than local v%LOCAL_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION%list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt.backup" >NUL
	move /y "%TEMP%\toolbars_BHOs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)




:: Clean up
if exist "%TEMP%\*to_target_by_*" del /f "%TEMP%\*to_target_by_*" 2>NUL

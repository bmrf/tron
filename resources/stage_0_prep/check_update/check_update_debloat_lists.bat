:: Purpose:       Checks for updated debloat lists on Github prior to executing Tron. If updates are found, they are spliced in prior to Stage 0 execution
:: Requirements:  Must be called from Tron
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.1 ! Fix edge case where a new programs_to_target_by_name.txt was released on Github, and would mistakenly delete the local by_GUID list
::                      ! Fix a hung or very slow download stalling Tron indefinitely. Downloads now run one at a time, each giving up after 2 tries with a
::                        10 second timeout, and remaining downloads are skipped if a network failure occurs
::                      ! Delete any download that wget reports as failed, so partial or error-page download never replaces current list
::                      ! Compare list versions numerically instead of as text
::                      ! Fix CHECK_UPDATE_DEBLOAT_LISTS_VERSION being overwritten with the script date
::                1.1.0 + Add new job to check for and download the programs_to_target_by_name list 
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
set CHECK_UPDATE_DEBLOAT_LISTS_VERSION=1.1.1
set CHECK_UPDATE_DEBLOAT_LISTS_DATE=2026-10-30

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

:: Download the repo lists one at a time. Each download gives up after 2 tries with a 10 second timeout, so a bad connection can't stall Tron
:: wget exits non-zero on any failure, including HTTP errors like 404. Delete whatever it left behind, so a partial or error-page download is never used
:: wget exit code 4 = network failure. If that happens, skip the remaining downloads since they'd most likely time out too
:: "if defined" is evaluated when the line runs (not when the block is parsed), so it sees the flag set by an earlier pass through the loop
set DEBLOAT_DOWNLOAD_NETWORK_FAILURE=
:: Fetch the repo PowerShell scripts
for %%i in (metro_3rd_party_modern_apps_to_target_by_name,metro_Microsoft_modern_apps_to_target_by_name) do (
	if not defined DEBLOAT_DOWNLOAD_NETWORK_FAILURE (
		stage_0_prep\check_update\wget -q --tries=2 --timeout=10 %GITHUB_URL_BASE%/metro/%%i.ps1 -O "%TEMP%\%%i.ps1"
		if errorlevel 4 if not errorlevel 5 set DEBLOAT_DOWNLOAD_NETWORK_FAILURE=yes
		if errorlevel 1 del /f /q "%TEMP%\%%i.ps1" >NUL 2>&1
	)
)
:: Fetch the repo text scripts
for %%i in (programs_to_target_by_GUID,programs_to_target_by_name,toolbars_BHOs_to_target_by_GUID) do (
	if not defined DEBLOAT_DOWNLOAD_NETWORK_FAILURE (
		stage_0_prep\check_update\wget -q --tries=2 --timeout=10 %GITHUB_URL_BASE%/oem/%%i.txt -O "%TEMP%\%%i.txt"
		if errorlevel 4 if not errorlevel 5 set DEBLOAT_DOWNLOAD_NETWORK_FAILURE=yes
		if errorlevel 1 del /f /q "%TEMP%\%%i.txt" >NUL 2>&1
	)
)
if defined DEBLOAT_DOWNLOAD_NETWORK_FAILURE call functions\log.bat " ! Network error while downloading debloat lists. Remaining downloads skipped, using local lists."

:: Reset window title since wget clobbers it
title Tron v%TRON_VERSION% (%TRON_DATE%)




:: Parse all scripts for their versions and stash in variables
:: WARNING: FOR /F black magic was used below
:: LOCAL: PowerShell scripts
for /F usebackqtokens^=2delims^=^" %%i IN (`type "stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set LOCAL_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i)
for /F usebackqtokens^=2delims^=^" %%i IN (`type "stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set LOCAL_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i)
:: LOCAL: Batch scripts
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set LOCAL_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION=%%i)
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_2_de-bloat\oem\programs_to_target_by_name.txt" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set LOCAL_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i)
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set LOCAL_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION=%%i)
:: REPO: PowerShell scripts
for /F usebackqtokens^=2delims^=^" %%i IN (`type "%TEMP%\metro_3rd_party_modern_apps_to_target_by_name.ps1" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set REPO_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i)
for /F usebackqtokens^=2delims^=^" %%i IN (`type "%TEMP%\metro_Microsoft_modern_apps_to_target_by_name.ps1" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set REPO_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i)
:: REPO: Batch scripts
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\programs_to_target_by_GUID.txt" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION=%%i)
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\programs_to_target_by_name.txt" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set REPO_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION=%%i)
for /F "tokens=2 delims='=' USEBACKQ" %%i IN (`type "%TEMP%\toolbars_BHOs_to_target_by_GUID.txt" ^| "%FIND%" "SCRIPT_VERSION"`) DO (set REPO_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION=%%i)




:: Check all versions and splice in new code if necessary
:: metro_3rd_party_modern_apps_to_target_by_name.ps1
call :compare_versions %LOCAL_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% %REPO_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%
if /i %VERSION_IS_NEWER%==yes (
	call functions\log.bat " ! Github metro_3rd_party list is v%REPO_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% which is newer than local v%LOCAL_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1" "stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1.backup" >NUL
	move /y "%TEMP%\metro_3rd_party_modern_apps_to_target_by_name.ps1" "stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)

:: metro_Microsoft_modern_apps_to_target_by_name.ps1
call :compare_versions %LOCAL_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% %REPO_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%
if /i %VERSION_IS_NEWER%==yes (
	call functions\log.bat " ! Github metro_Microsoft list is v%REPO_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% which is newer than local v%LOCAL_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION% list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1" "stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1.backup" >NUL
	move /y "%TEMP%\metro_Microsoft_modern_apps_to_target_by_name.ps1" "stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)

:: programs_to_target_by_GUID.txt
call :compare_versions %LOCAL_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION% %REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION%
if /i %VERSION_IS_NEWER%==yes (
	call functions\log.bat " ! Github programs_to_target_by_GUID list is v%REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION% which is newer than local v%LOCAL_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_PROGRAMS_TO_TARGET_BY_GUID_SCRIPT_VERSION% list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt.backup" >NUL
	move /y "%TEMP%\programs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\programs_to_target_by_GUID.txt" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)

:: programs_to_target_by_name.txt
call :compare_versions %LOCAL_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION% %REPO_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION%
if /i %VERSION_IS_NEWER%==yes (
	call functions\log.bat " ! Github programs_to_target_by_name list is v%REPO_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION% which is newer than local v%LOCAL_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_PROGRAMS_TO_TARGET_BY_NAME_SCRIPT_VERSION% list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\oem\programs_to_target_by_name.txt" "stage_2_de-bloat\oem\programs_to_target_by_name.txt.backup" >NUL
	move /y "%TEMP%\programs_to_target_by_name.txt" "stage_2_de-bloat\oem\programs_to_target_by_name.txt" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)

:: toolbars_BHOs_to_target_by_GUID.txt
call :compare_versions %LOCAL_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION% %REPO_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION%
if /i %VERSION_IS_NEWER%==yes (
	call functions\log.bat " ! Github toolbars_BHOs_to_target_by_GUID list is v%REPO_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION% which is newer than local v%LOCAL_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION%"
	call functions\log.bat " ! Splicing in updated v%REPO_TOOLBARS_BHOS_TO_TARGET_BY_GUID_SCRIPT_VERSION% list and renaming old list with .backup extension."
	move /y "stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt.backup" >NUL
	move /y "%TEMP%\toolbars_BHOs_to_target_by_GUID.txt" "stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt" >NUL
	ping 127.0.0.1 -n 5 >nul
	call functions\log.bat "   Done."
)




:: Clean up
if exist "%TEMP%\*to_target_by_*" del /f "%TEMP%\*to_target_by_*" 2>NUL
exit /b 0




:::::::::::::::
:: FUNCTIONS ::
:::::::::::::::
:: Compare two version strings (x.y.z) numerically. Usage: call :compare_versions LOCAL_VERSION REPO_VERSION
:: Sets VERSION_IS_NEWER=yes if the repo version is newer than the local version, otherwise no
:: A text comparison (LSS) gets this wrong once a field reaches two digits, e.g. "1.10.0" LSS "1.9.0" is true
:: Missing fields count as 0, so the preloaded version of 0 (version not found or download failed) compares correctly
:: Uses exit /b rather than goto :eof to return
:compare_versions
set VERSION_IS_NEWER=no
set CV_LOCAL_1=0
set CV_LOCAL_2=0
set CV_LOCAL_3=0
set CV_REPO_1=0
set CV_REPO_2=0
set CV_REPO_3=0
for /f "tokens=1-3 delims=." %%a in ("%~1") do (
	set /a CV_LOCAL_1=%%a+0
	set /a CV_LOCAL_2=%%b+0
	set /a CV_LOCAL_3=%%c+0
)
for /f "tokens=1-3 delims=." %%a in ("%~2") do (
	set /a CV_REPO_1=%%a+0
	set /a CV_REPO_2=%%b+0
	set /a CV_REPO_3=%%c+0
)
if %CV_REPO_1% GTR %CV_LOCAL_1% set VERSION_IS_NEWER=yes
if %CV_REPO_1% EQU %CV_LOCAL_1% if %CV_REPO_2% GTR %CV_LOCAL_2% set VERSION_IS_NEWER=yes
if %CV_REPO_1% EQU %CV_LOCAL_1% if %CV_REPO_2% EQU %CV_LOCAL_2% if %CV_REPO_3% GTR %CV_LOCAL_3% set VERSION_IS_NEWER=yes
exit /b 0

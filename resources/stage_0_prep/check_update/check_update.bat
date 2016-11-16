:: Purpose:       Tron's update checker, broken out from tron.bat as a function
:: Requirements:  Must be called from Tron
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.6 ! Fix bug with missing username in %USERPROFILES% statement. Thanks to /u/TyanColte
::                1.0.5 ! Fix edge case where self-destruct code would be incorrectly triggered by re-using Tron's global SELF_DESTRUCT variable
::                        check_update.bat now uses its own internal "NUKE_OLD_VERSION" variable to check if we need to cleanup after an update. Thanks /u/wogmail
::                1.0.4 + Add missing :self_destruct code and fix sha256sums.txt character encoding. Thanks to /u/botopz
::                1.0.3 - Remove '--ca-certificate=stage_0_prep\check_update\bmrf.org.pem' declarative from wget calls, due to upgrading Tron's internal wget version to v1.18
::                1.0.2 + Import REPO_URL, REPO_BTSYNC_KEY, REPO_SCRIPT_DATE and REPO_SCRIPT_VERSION variables from tron.bat since they're only relevant here
::                1.0.1 ! Fix SSL encryption on update check and new version download. Previously we were skipping certificate checking due to cert errors. With this fix we now properly use the bundled .pem certificate to establish an SSL connection to the repo
::                1.0.0 + Initial write
@echo off



:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set CHECK_UPDATE_VERSION=1.0.6
set CHECK_UPDATE_VERSION=2016-11-16

:: Variables used during the update check
set REPO_URL=https://bmrf.org/repos/tron
set REPO_BTSYNC_KEY=BYQYYECDOJPXYA2ZNUDWDN34O2GJHBM47
set REPO_SCRIPT_DATE=0
set REPO_SCRIPT_VERSION=0
set NUKE_OLD_VERSION=no

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

:: wget sha256sums.txt from the repo
stage_0_prep\check_update\wget.exe %REPO_URL%/sha256sums.txt -O "%TEMP%\sha256sums.txt" 2>NUL
:: Assuming there was no error, go ahead and extract version number into REPO_SCRIPT_VERSION, and release date into REPO_SCRIPT_DATE
if /i %ERRORLEVEL%==0 (
	for /f "tokens=1,2,3 delims= " %%a in (%TEMP%\sha256sums.txt) do set WORKING=%%b
	for /f "tokens=4 delims=,()" %%a in (%TEMP%\sha256sums.txt) do set WORKING2=%%a
)
if /i %ERRORLEVEL%==0 (
	set REPO_SCRIPT_VERSION=%WORKING:~1,6%
	set REPO_SCRIPT_DATE=%WORKING2%
)
:: Trigger warning if we couldn't check for an update
:: We don't log anything about it yet because the log is wiped at the start of each Tron run.
:: There is a check immediately after the log header for the update checker return code, and this is where we log it if it failed
if not %ERRORLEVEL%==0 set WARNINGS_DETECTED=yes_update_check_failed


:: Reset window title since wget clobbers it
title Tron v%SCRIPT_VERSION% (%SCRIPT_DATE%)


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
	if /i !CHOICE!==y (
		color 8B
		cls
		echo.
		echo %TIME%   Downloading new version to the desktop, please wait...
		echo.
		stage_0_prep\check_update\wget.exe "%REPO_URL%/Tron v%REPO_SCRIPT_VERSION% (%REPO_SCRIPT_DATE%).exe" -O "%USERPROFILES%\%USERNAME%\Desktop\Tron v%REPO_SCRIPT_VERSION% (%REPO_SCRIPT_DATE%).exe"
		echo.
		echo %TIME%   Download finished.
		echo.
		echo %TIME%   Verifying SHA256 pack integrity, please wait...
		echo.
		stage_0_prep\check_update\hashdeep.exe -s -e -b -v -a -k "%TEMP%\sha256sums.txt" "%USERPROFILES%\%USERNAME%\Desktop\Tron*.exe" | %FIND% /i "Files matched: 1"
		if !ERRORLEVEL!==0 (
			color 2f
			echo %TIME%   SHA256 pack integrity verified. The new version is on your desktop.
			echo.
			echo %TIME%   This copy of Tron will now self-destruct.
			echo.
			popd
			pause
			echo. && ENDLOCAL DISABLEDELAYEDEXPANSION && set NUKE_OLD_VERSION=yes
		) else (
			color 0c
			echo %TIME% ^^! ERROR: Download FAILED the integrity check. Recommend manually
			echo                      downloading latest version. Will delete failed file and
			echo                      exit.
			echo.
			pause
			REM Clean up after ourselves
			del /f /q "%USERPROFILES%\%USERNAME%\Desktop\Tron v%REPO_SCRIPT_VERSION% (%REPO_SCRIPT_DATE%).exe"
			del /f /q "%TEMP%\sha256sums.txt"
			exit /b 1
		)
	)
	color 0f
)
ENDLOCAL DISABLEDELAYEDEXPANSION
:: Clean up after ourselves
if exist "%TEMP%\*sums.txt" del "%TEMP%\*sums.txt"


:: Blow away the old version if we downloaded a new version
set CWD=%CD%
if /i %NUKE_OLD_VERSION%==yes (
	cd ..
	del /f /q tron.bat >NUL 2>&1
	%SystemDrive%
	cd \
	rmdir /s /q "%CWD%"
	exit
)

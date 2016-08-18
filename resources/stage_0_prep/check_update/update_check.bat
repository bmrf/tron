:: Purpose:       Tron's update checker, broken out from tron.bat as a function
:: Requirements:  Must be called from Tron
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.2 + Import REPO_URL, REPO_BTSYNC_KEY, REPO_SCRIPT_DATE and REPO_SCRIPT_VERSION variables from tron.bat since they're only relevant here
::                1.0.1 ! Fix SSL encryption on update check and new version download. Previously we were skipping certificate checking due to cert errors. With this fix we now properly use the bundled .pem certificate to establish an SSL connection to the repo
::                1.0.0 + Initial write
@echo off



:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set UPDATE_CHECK_VERSION=1.0.2
set UPDATE_CHECK_VERSION=2016-08-18

:: Variables used during the update check
set REPO_URL=https://bmrf.org/repos/tron
set REPO_BTSYNC_KEY=BYQYYECDOJPXYA2ZNUDWDN34O2GJHBM47
set REPO_SCRIPT_DATE=0
set REPO_SCRIPT_VERSION=0

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

:: wget sha256sums.txt from the repo and parse through it. Extract latest version number and release date from last line (which is always the latest release)
stage_0_prep\check_update\wget.exe --ca-certificate=stage_0_prep\check_update\bmrf.org.pem %REPO_URL%/sha256sums.txt -O %TEMP%\sha256sums.txt 2>NUL
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
		stage_0_prep\check_update\wget.exe --ca-certificate=stage_0_prep\check_update\bmrf.org.pem "%REPO_URL%/Tron v%REPO_SCRIPT_VERSION% (%REPO_SCRIPT_DATE%).exe" -O "%USERPROFILE%\Desktop\Tron v%REPO_SCRIPT_VERSION% (%REPO_SCRIPT_DATE%).exe"
		echo.
		echo %TIME%   Download finished.
		echo.
		echo %TIME%   Verifying SHA256 pack integrity, please wait...
		echo.
		stage_0_prep\check_update\hashdeep.exe -s -e -b -v -a -k "%TEMP%\sha256sums.txt" "%USERPROFILE%\Desktop\Tron*.exe" | %FIND% /i "Files matched: 1"
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
			del /f /q "%TEMP%\sha256sums.txt"
			exit /b 1
		)
	)
	color 0f
)
ENDLOCAL DISABLEDELAYEDEXPANSION
:: Clean up after ourselves
if exist "%TEMP%\*sums.txt" del "%TEMP%\*sums.txt"




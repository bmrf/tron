:: Purpose:       Installs a package
:: Requirements:  Run this script with a network admin account
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.3-TRON + Add installer for Chrome version of Flash (PPAPI)
::                1.0.2-TRON * Make version-agnostic. Now just drop the latest Flash installers, named appropriately, in the same directory as this script
::                1.0.1-TRON * Make architecture-agnostic, now will detect correct system architecture and install relevant package
::                           * Replace all hard-coded system file paths with relevant variable for better portability
::                1.0.0-TRON + Initial build for Tron, modified from PDQ Deploy pack installer version
::                             Remove many items not necessary for Tron
::                             Script inherits log parameters when called by Tron


:::::::::::::::
:: VARIABLES :: -- Set these to your desired values
:::::::::::::::
:: Package to install. Do not use trailing slashes (\)
set BINARY_VERSION=
set FLAGS=ALLUSERS=1 /q /norestart


::::::::::
:: Prep :: -- Don't change anything in this section
::::::::::
@echo off
set SCRIPT_VERSION=1.0.3-TRON
set SCRIPT_UPDATED=2016-06-27
pushd %~dp0


::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: Attempt to kill any running instances first
taskkill /f /im firefox.exe /t >> "%LOGPATH%\%LOGFILE%" 2>NUL
taskkill /f /im palemoon.exe /t >> "%LOGPATH%\%LOGFILE%" 2>NUL
taskkill /f /im iexplore.exe /t >> "%LOGPATH%\%LOGFILE%" 2>NUL
taskkill /f /im chrome.exe /t >> "%LOGPATH%\%LOGFILE%" 2>NUL
taskkill /f /im chrome64.exe /t >> "%LOGPATH%\%LOGFILE%" 2>NUL
wmic process where name="firefox.exe" call terminate >> "%LOGPATH%\%LOGFILE%" 2>NUL
wmic process where name="palemoon.exe" call terminate >> "%LOGPATH%\%LOGFILE%" 2>NUL
wmic process where name="iexplore.exe" call terminate >> "%LOGPATH%\%LOGFILE%" 2>NUL
wmic process where name="chrome.exe" call terminate >> "%LOGPATH%\%LOGFILE%" 2>NUL
wmic process where name="chrome64.exe" call terminate >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Remove prior versions of the Flash player
wmic product where "name like 'Adobe Flash Player%%Plugin'" uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL
wmic product where "name like 'Adobe Flash Player%%NPAPI'" uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL
wmic product where "name like 'Adobe Flash Player%%PPAPI'" uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Install Firefox and IE versions of Flash
msiexec /i "install_flash_player_22_plugin.msi" %FLAGS%
msiexec /i "install_flash_player_22_active_x.msi" %FLAGS%
msiexec /i "install_flash_player_22_ppapi.msi" %FLAGS%

:: Delete the Adobe Acrobat Update Service
net stop AdobeARMservice >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete AdobeARMservice >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the Adobe Acrobat Update Service (older version)
net stop armsvc >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete armsvc >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the Adobe Flash Player Update Service
net stop AdobeFlashPlayerUpdateSvc >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete AdobeFlashPlayerUpdateSvc >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the scheduled task Adobe installs (against our wishes)
del /F /Q "%SystemDrive%\Windows\tasks\Adobe Flash Player Updater.job" >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the annoying Acrobat tray icon
if exist "%ProgramFiles(x86)%\Adobe\Acrobat 7.0\Distillr\acrotray.exe" (
	taskkill /im "acrotray.exe" >> "%LOGPATH%\%LOGFILE%" 2>NUL
	del /f /q "%ProgramFiles(x86)%\Adobe\Acrobat 7.0\Distillr\acrotray.exe" >> "%LOGPATH%\%LOGFILE%" 2>NUL
	)

:: Return exit code to SCCM/PDQ Deploy/Tron/etc
exit /B %EXIT_CODE%

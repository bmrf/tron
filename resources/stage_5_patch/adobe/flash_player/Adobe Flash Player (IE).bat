:: Purpose:       Installs a package
:: Requirements:  Run this script with a network admin account
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.0-TRON + Initial build for Tron, modified from PDQ Deploy pack installer version
::                             Remove many items not necessary for Tron
::                             Script inherits log parameters when called by Tron


:::::::::::::::
:: VARIABLES :: -- Set these to your desired values
:::::::::::::::
:: Package to install. Do not use trailing slashes (\)
set BINARY=Adobe Flash Player v19.0.0.207 (IE).msi
set FLAGS=ALLUSERS=1 /q /norestart


::::::::::
:: Prep :: -- Don't change anything in this section
::::::::::
@echo off
set SCRIPT_VERSION=1.0.0-TRON
set SCRIPT_UPDATED=2015-03-25
pushd %~dp0


::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: Attempt to kill any running instances first
taskkill /f /im iexplore.exe /t >> "%LOGPATH%\%LOGFILE%" 2>NUL
taskkill /f /im iexplorer.exe /t >> "%LOGPATH%\%LOGFILE%" 2>NUL
wmic process where name="iexplore.exe" call terminate >> "%LOGPATH%\%LOGFILE%" 2>NUL
wmic process where name="iexplorer.exe" call terminate >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Remove prior versions of the Flash player
wmic product where "name like 'Adobe Flash Player%%ActiveX'" uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Install the package from the local folder (if all files are in the same directory)
msiexec /i "%BINARY%" %FLAGS% >> "%LOGPATH%\%LOGFILE%" 2>NUL

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

:: Return exit code to SCCM/PDQ Deploy/etc
exit /B %EXIT_CODE%

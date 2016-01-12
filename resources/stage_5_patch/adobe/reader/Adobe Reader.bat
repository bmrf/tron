:: Purpose:       Installs a package
:: Requirements:  Run this script with a network admin account
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.2-TRON ! Suppress output on desktop shortcut deletion
::                1.0.1-TRON + Create BINARY_VERSION and PATCH_VERSION variables to make updates easier
::                1.0.0-TRON + Initial build for Tron, modified from PDQ Deploy pack installer version
::                             Remove many items not necessary for Tron
::                             Script inherits log parameters when called by Tron
@echo off

:::::::::::::::
:: VARIABLES :: -- Set these to your desired values
:::::::::::::::
:: Package to install. Do not use trailing slashes (\)
set BINARY_VERSION=11.0.10
set PATCH_VERSION=11.0.14
set FLAGS=/sAll /rs /msi /qb- /norestart EULA_ACCEPT=YES REMOVE_PREVIOUS=YES


::::::::::
:: Prep :: -- Don't change anything in this section
::::::::::

set SCRIPT_VERSION=1.0.2-TRON
set SCRIPT_UPDATED=2015-11-24
pushd %~dp0


::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: This line installs the package from the local folder (if all files are in the same directory)
"Adobe Reader v%BINARY_VERSION%.exe" %FLAGS%

:: Install a patch from the local folder (if all files are in the same directory)
msiexec /p "Adobe Reader v%PATCH_VERSION% patch.msp" REINSTALL=ALL REINSTALLMODE=omus /qn

:: Disable Adobe Updater via registry
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown" /v bUpdater /t REG_DWORD /d 00000000 /f >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: DELETE the Adobe Acrobat Update Service
net stop AdobeARMservice >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete AdobeARMservice >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the scheduled task that Adobe installs against our wishes
del /F /Q C:\windows\tasks\Adobe*.job >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the desktop icons
if exist "%PUBLIC%\Desktop\Adobe Reader XI.lnk" del /s /q "%PUBLIC%\Desktop\Adobe Reader XI.lnk" >NUL
if exist "%ALLUSERSPROFILE%\Desktop\Adobe Reader XI.lnk" del /s /q "%ALLUSERSPROFILE%\Desktop\Adobe Reader XI.lnk" >NUL

:: Delete the Start Menu icon
if exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Adobe Reader XI.lnk" del /s /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Adobe Reader XI.lnk" >NUL

:: Delete the annoying Acrobat tray icon
if exist "%ProgramFiles(x86)%\Adobe\Acrobat 7.0\Distillr\acrotray.exe" (
	taskkill /im "acrotray.exe"
	del /f /q "%ProgramFiles(x86)%\Adobe\Acrobat 7.0\Distillr\acrotray.exe"
	)

:: Return exit code to SCCM/PDQ Deploy/etc
exit /B %EXIT_CODE%

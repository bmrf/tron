:: Purpose:       Installs a package
:: Requirements:  Run this script with a network admin account
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.5-TRON * Script now supports standalone execution (for example if you just want to update all versions of Flash on the machine)
::                           * Improve existing Flash installation detection; add granular tests per version. Thanks to /u/nubduck
::                           * Catch additional Flash Updater scheduled task that gets installed
::                1.0.4-TRON * Loopify browser process kill section
::                1.0.3-TRON + Add installer for Chrome version of Flash (PPAPI)
::                1.0.2-TRON * Make version-agnostic. Now just drop the latest Flash installers, named appropriately, in the same directory as this script
::                1.0.1-TRON * Make architecture-agnostic, now will detect correct system architecture and install relevant package
::                           * Replace all hard-coded system paths with relevant variables for better portability
::                1.0.0-TRON + Initial build for Tron, modified from PDQ Deploy pack installer version
::                             Remove many items not necessary for Tron
::                             Script inherits log parameters when called by Tron
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set SCRIPT_VERSION=1.0.5-TRON
set SCRIPT_UPDATED=2017-02-09

:: Get in the Flash directory
pushd %~dp0

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (

	:: Load the settings file
	call ..\..\..\functions\tron_settings.bat

	:: Initialize the runtime environment
	call ..\..\..\functions\initialize_environment.bat
)

:: Flash installation flags
set FLAGS=ALLUSERS=1 /q /norestart

:: Preload detection variables
set FLASH_ACTIVEX_DETECTED=no
set FLASH_CHROME_DETECTED=no
set FLASH_FIREFOX_DETECTED=no



::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: Attempt to kill any running instances first
for %%i in (firefox,palemoon,iexplore,chrome,chrome64,opera) do (
	taskkill /f /im %%i.exe /t >> "%LOGPATH%\%LOGFILE%" 2>NUL
	wmic process where name="%%i.exe" call terminate >> "%LOGPATH%\%LOGFILE%" 2>NUL
)


:: Detect each browser-specific installation
:: "Active_x"     = Internet Explorer version
if exist "%windir%\SysWOW64\macromed\flash\*ActiveX.exe" set FLASH_ACTIVEX_DETECTED=yes
if exist "%windir%\System32\macromed\flash\*ActiveX.exe" set FLASH_ACTIVEX_DETECTED=yes

:: "PPAPI/Pepper" = Chrome version
if exist "%windir%\SysWOW64\macromed\flash\*pepper.exe" set FLASH_CHROME_DETECTED=yes
if exist "%windir%\System32\macromed\flash\*pepper.exe" set FLASH_CHROME_DETECTED=yes

:: "NPAPI/Plugin" = Firefox/plugin version
if exist "%windir%\SysWOW64\macromed\flash\*plugin.exe" set FLASH_FIREFOX_DETECTED=yes
if exist "%windir%\System32\macromed\flash\*plugin.exe" set FLASH_FIREFOX_DETECTED=yes


:: Perform removal and fresh installation of those existing versions
if %FLASH_ACTIVEX_DETECTED%==yes (
	wmic product where "name like 'Adobe Flash Player%%ActiveX'" uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL
	msiexec /i "install_flash_player_24_active_x.msi" %FLAGS%
)
if %FLASH_CHROME_DETECTED%==yes (
	wmic product where "name like 'Adobe Flash Player%%PPAPI'" uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL
	msiexec /i "install_flash_player_24_ppapi.msi" %FLAGS%
)
if %FLASH_FIREFOX_DETECTED%==yes (
	wmic product where "name like 'Adobe Flash Player%%Plugin'" uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL
	wmic product where "name like 'Adobe Flash Player%%NPAPI'" uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%" 2>NUL
	msiexec /i "install_flash_player_24_plugin.msi" %FLAGS%
)


:: Delete the Adobe Acrobat Update Service
net stop AdobeARMservice >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete AdobeARMservice >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the Adobe Acrobat Update Service (older version)
net stop armsvc >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete armsvc >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the Adobe Flash Player Update Service
net stop AdobeFlashPlayerUpdateSvc >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete AdobeFlashPlayerUpdateSvc >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete scheduled tasks Adobe installs against our wishes
del /F /Q "%SystemDrive%\Windows\tasks\Adobe Acrobat Update Task*" >> "%LOGPATH%\%LOGFILE%" 2>NUL
del /F /Q "%SystemDrive%\Windows\tasks\Adobe Flash Player Update*" >> "%LOGPATH%\%LOGFILE%" 2>NUL
del /F /Q "%SystemDrive%\Windows\system32\tasks\Adobe Acrobat Update Task*" >> "%LOGPATH%\%LOGFILE%" 2>NUL
del /F /Q "%SystemDrive%\Windows\system32\tasks\Adobe Flash Player Update*" >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the annoying Acrobat tray icon
if exist "%ProgramFiles(x86)%\Adobe\Acrobat 7.0\Distillr\acrotray.exe" (
	taskkill /im "acrotray.exe" >> "%LOGPATH%\%LOGFILE%" 2>NUL
	del /f /q "%ProgramFiles(x86)%\Adobe\Acrobat 7.0\Distillr\acrotray.exe" >> "%LOGPATH%\%LOGFILE%" 2>NUL
)

popd

:: Return exit code to SCCM/PDQ Deploy/Tron/etc
exit /B %EXIT_CODE%

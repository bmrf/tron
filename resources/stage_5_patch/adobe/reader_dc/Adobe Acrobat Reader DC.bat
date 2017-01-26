:: Purpose:       Installs a package
:: Requirements:  Run this script with Administrator rights
:: Author:        vocatus on reddit.com/r/sysadmin ( vocatus.gate@gmail.com ) // PGP key ID: 0x07d1490f82a211a2
:: Version:       1.0.2 + Add killing of additional Updater registry keys
::                1.0.1 + Add killing of additional Task Scheduler job
::                      + Add killing of Adobe ARM directory
::                1.0.0 + Initial write
@echo off


:::::::::::::::
:: VARIABLES ::
:::::::::::::::
:: Package to install. Do not use trailing slashes (\)
set BINARY_VERSION=15.007.20033
set PATCH_VERSION=15.023.20053
set FLAGS=ALLUSERS=1 /qn /norestart TRANSFORMS="Adobe Acrobat Reader DC v%BINARY_VERSION%_customizations.mst"


::::::::::
:: Prep :: -- Don't change anything in this section
::::::::::
set SCRIPT_VERSION=1.0.2
set SCRIPT_UPDATED=2017-01-26
pushd "%~dp0"


::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: Install base package
msiexec /i "Adobe Acrobat Reader DC v%BINARY_VERSION%.msi" %FLAGS% >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Install patch
msiexec /p "Adobe Acrobat Reader DC v%PATCH_VERSION%_patch.msp" REINSTALL=ALL REINSTALLMODE=omus /qn >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Disable Adobe Updater via registry; both methods
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Acrobat Reader\11.0\FeatureLockDown" /v bUpdater /t REG_DWORD /d 00000000 /f >> "%LOGPATH%\%LOGFILE%" 2>NUL
%SystemRoot%\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run" /v "Adobe ARM" /f >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the Adobe Acrobat Update Service
net stop AdobeARMservice >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete AdobeARMservice >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the Adobe Acrobat Update Service (older version)
net stop armsvc >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete armsvc >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the Adobe Flash Player Update Service which the Acrobat installer inexplicably loads
net stop AdobeFlashPlayerUpdateSvc >> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete AdobeFlashPlayerUpdateSvc >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the annoying Scheduler update jobs Adobe installs against our wishes
if exist "%WINDIR%\tasks\Adobe Acrobat Update Task" del /f /q "%WINDIR%\tasks\Adobe Acrobat Update Task" >> "%LOGPATH%\%LOGFILE%" 2>NUL
if exist "%WINDIR%\system32\tasks\Adobe Acrobat Update Task" del /f /q "%WINDIR%\system32\tasks\Adobe Acrobat Update Task" >> "%LOGPATH%\%LOGFILE%" 2>NUL
schtasks /delete /tn "Adobe Acrobat Update Task" /f >> "%LOGPATH%\%LOGFILE%" 2>NUL

:: Delete the stupid ARM updater Adobe installs even when we say not to install it
if exist "%ProgramFiles(x86)%\common files\adobe\arm" rmdir /s /q "%ProgramFiles(x86)%\common files\adobe\arm"
if exist "%ProgramFiles%\common files\adobe\arm" rmdir /s /q "%ProgramFiles%\common files\adobe\arm"

:: Delete the annoying Acrobat tray icon
if exist "%ProgramFiles(x86)%\Adobe\Acrobat 7.0\Distillr\acrotray.exe" (
	taskkill /im "acrotray.exe"
	del /f /q "%ProgramFiles(x86)%\Adobe\Acrobat 7.0\Distillr\acrotray.exe" >> "%LOGPATH%\%LOGFILE%" 2>NUL
)

:: Pop back to original directory. This isn't necessary in stand-alone runs of the script, but is needed when being called from another script
popd

:: Return exit code to SCCM/PDQ Deploy/etc
exit /B %EXIT_CODE%

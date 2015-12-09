:: Purpose:       Sub-script containing all commands for Tron's Stage 2: De-bloat stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
::                3. Called from tron.bat. If you try to run this script directly it will error out
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.1 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_2_SCRIPT_VERSION=1.0.1
set STAGE_2_SCRIPT_DATE=2015-12-09

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
:: STAGE 2: De-Bloat :: // Begin jobs
:::::::::::::::::::::::
call functions\log.bat "%CUR_DATE% %TIME%   stage_2_de-bloat begin..."


:: JOB: Remove crapware programs, phase 1: by specific GUID
title TRON v%SCRIPT_VERSION% [stage_2_de-bloat] [Remove bloatware by GUID]
call functions\log.bat "%CUR_DATE% %TIME%    Attempt junkware removal: Phase 1 (by specific GUID)..."
call functions\log.bat "%CUR_DATE% %TIME%    Tweak here: \resources\stage_2_de-bloat\oem\programs_to_target_by_GUID.bat"
if /i %DRY_RUN%==no call stage_2_de-bloat\oem\programs_to_target_by_GUID.bat >> "%LOGPATH%\%LOGFILE%" 2>&1
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Remove crapware programs, phase 2: wildcard by name
title TRON v%SCRIPT_VERSION% [stage_2_de-bloat] [Remove bloatware by name]
call functions\log.bat "%CUR_DATE% %TIME%    Attempt junkware removal: Phase 2 (wildcard by name)..."
call functions\log.bat "%CUR_DATE% %TIME%    Tweak here: \resources\stage_2_de-bloat\oem\programs_to_target_by_name.txt"
:: Search through the list of programs in "programs_to_target.txt" file and uninstall them one-by-one
if /i %DRY_RUN%==no FOR /F "tokens=*" %%i in (stage_2_de-bloat\oem\programs_to_target_by_name.txt) DO echo   %%i && echo   %%i...>> "%LOGPATH%\%LOGFILE%" && %WMIC% product where "name like '%%i'" uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%"
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Remove crapware programs, phase 3: unwanted toolbars and BHOs by GUID
title TRON v%SCRIPT_VERSION% [stage_2_de-bloat] [Remove toolbars by GUID]
call functions\log.bat "%CUR_DATE% %TIME%    Attempt junkware removal: Phase 3 (toolbars by specific GUID)..."
call functions\log.bat "%CUR_DATE% %TIME%    Tweak here: \resources\stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.bat"
if /i %DRY_RUN%==no call stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.bat >> "%LOGPATH%\%LOGFILE%" 2>&1
call functions\log.bat "%CUR_DATE% %TIME%    Done."


:: JOB: Remove default Metro apps (Windows 8 and up)
title TRON v%SCRIPT_VERSION% [stage_2_de-bloat] [Remove default metro apps]
:: This command will re-install ALL default Windows 10 apps:
:: Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}

:: Version checks
if "%WIN_VER:~0,9%"=="Windows 8" set TARGET_METRO=yes
if "%WIN_VER:~0,9%"=="Windows 1" set TARGET_METRO=yes
if "%WIN_VER:~0,18%"=="Windows Server 201" set TARGET_METRO=yes
if /i %PRESERVE_METRO_APPS%==yes set TARGET_METRO=no
if /i %DRY_RUN%==no net start AppXSVC >nul 2>&1
if /i %TARGET_METRO%==yes (
	call functions\log.bat "%CUR_DATE% %TIME%    Windows 8 or higher detected, removing OEM Metro apps..."
	:: Force allowing us to start AppXSVC service in Safe Mode. AppXSVC is the MSI Installer equivalent for "apps" (vs. programs)
	if /i %DRY_RUN%==no (
		REM Enable starting AppXSVC in Safe Mode
		reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\AppXSVC" /ve /t reg_sz /d Service /f >nul 2>&1
		net start AppXSVC >nul 2>&1
		REM Enable scripts in PowerShell
		powershell "Set-ExecutionPolicy Unrestricted -force 2>&1 | Out-Null"

		REM Do the removal
		if /i not "%WIN_VER:~0,9%"=="Windows 1" (

			REM Windows 8/8.1 version
			powershell "Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

		) else (

			REM Windows 10 version
			:: Kill forced OneDrive integration
			taskkill /f /im OneDrive.exe >> "%LOGPATH%\%LOGFILE%" 2>&1
			%SystemRoot%\System32\OneDriveSetup.exe /uninstall >> "%LOGPATH%\%LOGFILE%" 2>&1 >nul 2>&1
			%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall >> "%LOGPATH%\%LOGFILE%" 2>&1
			:: These keys are orphaned after the OneDrive uninstallation and can be safely removed
			reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
			reg delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
			takeown /f "%LocalAppData%\Microsoft\OneDrive" /r /d y >> "%LOGPATH%\%LOGFILE%" 2>&1
			icacls "%LocalAppData%\Microsoft\OneDrive" /grant administrators:F /t >> "%LOGPATH%\%LOGFILE%" 2>&1
			rmdir /s /q "%LocalAppData%\Microsoft\OneDrive" >> "%LOGPATH%\%LOGFILE%" 2>&1
			rmdir /s /q "%ProgramData%\Microsoft OneDrive" >> "%LOGPATH%\%LOGFILE%" 2>&1
			rmdir /s /q "%SystemDrive%\OneDriveTemp" >> "%LOGPATH%\%LOGFILE%" 2>&1

			REM "Get Office"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*officehub*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *officehub* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM "Get Skype"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*getstarted*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *getstarted* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM "Groove Music"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*zunemusic*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *zunemusic* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM "Money / Bing Finance"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*bingfinance*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *bingfinance* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM "Movies & TV / Zune Video"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*zunevideo*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *zunevideo* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM "News / Bing News"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*bingnews*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *bingnews* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM "Phone Companion"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*windowsphone*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *windowsphone* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM "Sports / Bing Sports"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*bingsports*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *bingsports* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM "Windows Feedback"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*windowsfeedback*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *windowsfeedback* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM "Xbox"
			powershell "Get-AppXProvisionedPackage -online | where-object {$_.packagename -like "*xboxapp*"} | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage *xboxapp* -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"

			REM Call /u/danodemano's script to do removal of OEM Modern App's
			REM powershell -noprofile -noexit -executionpolicy bypass -file ".\stage_2_de-bloat\OEM_modern_apps_to_target_by_name.ps1"
			powershell -executionpolicy bypass -file ".\stage_2_de-bloat\metro\metro_OEM_modern_apps_to_target_by_name.ps1"
		)
	)
)



:: Stage complete
call functions\log.bat "%CUR_DATE% %TIME%   stage_2_de-bloat complete."

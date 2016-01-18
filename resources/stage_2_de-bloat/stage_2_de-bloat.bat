:: Purpose:       Sub-script containing all commands for Tron's Stage 2: De-bloat stage. Called by tron.bat and returns control when finished
:: Requirements:  1. Administrator access
::                2. Safe mode is strongly recommended (though not required)
::                3. Called from tron.bat. If you try to run this script directly it will error out
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.1 ! Only set registry flag to allow starting AppX service in Safe Mode if the system is already in Safe Mode
::                      / Move OneDrive removal from Metro debloat to its own job
::                      * Don't remove OneDrive if any files are present in the default OneDrive folder
::                      * Disable OneDrive links in Explorer side pane via registry keys, instead of deleting the keys entirely
::                      - Remove redundant "net start AppXSVC" line prior to Metro de-bloat code
::                1.1.0 * Move embedded Win10 metro de-bloat code to PowerShell sub-scripts
::                1.0.1 - Remove internal log function and switch to Tron's external logging function. Thanks to github:nemchik
::                1.0.0 + Initial write
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_2_SCRIPT_VERSION=1.1.1
set STAGE_2_SCRIPT_DATE=2016-01-18

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
if %WIN_VER_NUM% geq 6.2 set TARGET_METRO=yes
if /i %PRESERVE_METRO_APPS%==yes set TARGET_METRO=no
if /i %TARGET_METRO%==yes (
	call functions\log.bat "%CUR_DATE% %TIME%    Windows 8 or higher detected, removing OEM Metro apps..."
	:: Force allowing us to start AppXSVC service in Safe Mode. AppXSVC is the MSI Installer equivalent for "apps" (vs. programs)
	if /i %DRY_RUN%==no (
		REM Enable starting AppXSVC in Safe Mode
		if /i "%SAFE_MODE%"=="yes" reg add "HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\%SAFEBOOT_OPTION%\AppXSVC" /ve /t reg_sz /d Service /f >nul 2>&1
		net start AppXSVC >nul 2>&1
		REM Enable scripts in PowerShell
		powershell "Set-ExecutionPolicy Unrestricted -force 2>&1 | Out-Null"

		REM Windows 8/8.1 version
		if /i "%WIN_VER:~0,9%"=="Windows 8" (
			REM In Windows 8/8.1 we can blast ALL AppX/Metro/"Modern App" apps because unlike in Windows 10, the "core" apps (calculator, paint, etc) aren't in the "modern" format
			powershell "Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online 2>&1 | Out-Null"
			powershell "Get-AppxPackage -AllUsers | Remove-AppxPackage 2>&1 | Out-Null"
		)
		REM Windows 10 version
		if /i "%WIN_VER:~0,9%"=="Windows 1" (
			REM Call the external PowerShell scripts to do removal of Microsoft and 3rd party OEM Modern Apps
			powershell -executionpolicy bypass -file ".\stage_2_de-bloat\metro\metro_3rd_party_modern_apps_to_target_by_name.ps1"
			powershell -executionpolicy bypass -file ".\stage_2_de-bloat\metro\metro_Microsoft_modern_apps_to_target_by_name.ps1"
		)
	)
	call functions\log.bat "%CUR_DATE% %TIME%    Done."
)


:: JOB: Remove forced OneDrive integration
if /i "%WIN_VER:~0,9%"=="Windows 1" (
	call functions\log.bat "%CUR_DATE% %TIME%    Checking if OneDrive is in use, please wait..."
	for /F %%i in ('dir /b "%USERPROFILE%\OneDrive\*.*"') do (
		call functions\log.bat "%CUR_DATE% %TIME% !  OneDrive appears to be in use. Skipping removal."
		goto skip_onedrive_removal
	)
		call functions\log.bat "%CUR_DATE% %TIME%    OneDrive doesn't appear to be in use. Removing..."
			taskkill /f /im OneDrive.exe >> "%LOGPATH%\%LOGFILE%" 2>&1
			ping 127.0.0.1 -n 5 > NUL 2>&1
			%SystemRoot%\System32\OneDriveSetup.exe /uninstall >> "%LOGPATH%\%LOGFILE%" >nul 2>&1
			%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall >> "%LOGPATH%\%LOGFILE%" >nul 2>&1
			ping 127.0.0.1 -n 7 > NUL 2>&1
			takeown /f "%LocalAppData%\Microsoft\OneDrive" /r /d y >> "%LOGPATH%\%LOGFILE%" 2>&1
			icacls "%LocalAppData%\Microsoft\OneDrive" /grant administrators:F /t >> "%LOGPATH%\%LOGFILE%" 2>&1
			rmdir /s /q "%LocalAppData%\Microsoft\OneDrive" >> "%LOGPATH%\%LOGFILE%" 2>&1
			rmdir /s /q "%ProgramData%\Microsoft OneDrive" >> "%LOGPATH%\%LOGFILE%" 2>&1
			rmdir /s /q "%SystemDrive%\OneDriveTemp" >> "%LOGPATH%\%LOGFILE%" 2>&1
			REM These two registry entries disable OneDrive links in the Explorer side pane
			reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f >> "%LOGPATH%\%LOGFILE%" 2>&1
			reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t reg_dword /d 0 /f >> "%LOGPATH%\%LOGFILE%" 2>&1
		call functions\log.bat "%CUR_DATE% %TIME%   Done."
)
:skip_onedrive_removal


:: Stage complete
call functions\log.bat "%CUR_DATE% %TIME%   stage_2_de-bloat complete."

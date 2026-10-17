:: Purpose:       Purges Windows 10 telemetry
:: Requirements:  Called from Tron ( reddit.com/r/TronScript ) in Stage 4: Repair. Can also be run directly
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
::                code heavily borrowed from:
::                  - Aegis project: https://voat.co/v/technology/comments/459263
::                  - win10-unfu**k: https://github.com/dfkt/win10-unfuck
::                  - WindowsLies:   https://github.com/WindowsLies/BlockWindows
::                  - ... and many other places around the web
:: Version:       1.3.3-TRON - Remove null-route code sections that were more relevant circa 2016
::                1.3.2-TRON + Add additional Diagtrack-Listener registry location for disabling. Thanks to github:starmania
::                1.3.1-TRON - Windows Updates: remove outdated job that used to uninstall "bad" updates
::                           + bugfix: Add registry entry to re-enable the webcam in the rare case where O&OShutUp10 disables it
::                1.3.0-TRON ! bugfix: Switch "manual" to "demand" on service startup changes
::                1.2.9-TRON ! bugfix: Switch Xbox service startup status to "manual" vs. "disabled". Thanks to u/EnderProGaming
::                1.2.8-TRON ! bugfix: Move OneDrive and SkyDrive (old OneDrive name) disabling code via registry from this script into appropriate location in the Stage 2 debloat script. Thanks to u/Tenelia
::                1.2.7-TRON ! Fix standalone and Tron-called execution due to typo in STANDALONE variable comparison command. Thanks to u/bubonis
::                1.2.6-TRON ! Fix standalone execution not working in some sections due to relative paths being different. Thanks to u/AncientAv
::                1.2.5-TRON + Add disabling of "Occasionally show suggestions in Start"
::                1.2.4-TRON ! Fix standalone execution broken due to use of uninitialized %REG% variable
::                1.2.3-TRON * Use %REG% instead of relative calls
::                1.2.2-TRON + Add additional XBox Live services to disable list
::                1.2.1-TRON + Add disabling of "show fun tips, tricks and hints" on the lock screen. Thanks to u/mikargibbros
::                1.2.0-TRON + Add disabling of registry keys AllowCortanaAboveLock and AllowSearchToUseLocation. Thanks to u/tylerwatt12
::                           ! Fix syntax error in DiagTrack service disabling. Thanks to u/KiranOtter
::                             thread: https://www.reddit.com/r/sysadmin/comments/777vt2/the_windows_fall_creators_update_has_been/
::                1.1.9-TRON * Update Spybot Anti-Beacon to v1.6.0.42
::                1.1.8-TRON + Add registry keys to disable Cortana and Web Search from Start Menu globally. Thanks to u/TootZoot and u/Falkerz
::                1.1.7-TRON + Add job "OandOShutUp10." Tron now automatically applies all immunizations from OandOShutUp10
::                1.1.6-TRON ! Fix broken path on setacl.exe call. Thanks to u/Seascan
::                           ! Fix broken path on Spybot call. Thanks to u/Seascan
::                           * Embed contents of 'disable_telemetry_registry_entries.reg' directly into script. Removes dependence on an external .reg file
::                1.1.5-TRON ! Fix incorrect path in call to 'disable_telemetry_registry_entries.reg.' Thanks to u/T_Belfs
::                1.1.4-TRON + Add log messages explaining each step in the process. These will error out in stand-alone mode (since no log function) but can be safely ignored
::                1.1.3-TRON + Add job "Spybot Anti-Beacon." Tron now automatically applies all immunizations from Spybot Anti-Beacon
::                <-- obsolete changelog comments removed -->
::                1.0.0-TRON + Initial write
SETLOCAL


:::::::::::::::
:: VARIABLES :: -------------- These are the defaults. Change them if you so desire. --------- ::
:::::::::::::::
:: No user-set variables for this script


:: --------------------------- Don't edit anything below this line --------------------------- ::


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
@echo off
set SCRIPT_VERSION=1.3.3-TRON
set SCRIPT_UPDATED=2026-10-17

:: Populate dependent variables if we didn't inherit them from Tron (standalone execution)
set STANDALONE=no
if /i "%LOGPATH%"=="" (
	set FIND=%SystemRoot%\System32\find.exe
	set FINDSTR=%SystemRoot%\System32\findstr.exe
	set REG=%SystemRoot%\System32\reg.exe
)
if /i "%LOGPATH%"=="" (
	set LOGPATH=%SystemDrive%\logs
	set LOGFILE=windows_10_telemetry_removal.log
	set VERBOSE=no
	set STANDALONE=yes
	for /f "tokens=3*" %%i IN ('%REG% query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| %FIND% "ProductName"') DO set WIN_VER=%%i %%j
	for /f "tokens=3*" %%i IN ('%REG% query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion ^| %FIND% "CurrentVersion"') DO set WIN_VER_NUM=%%i
)

:: Make sure we're on Win10
:: Windows 10 stupidly reports its version number as 6.3 so we can't use WIN_VER_NUM. sigh
if /i not "%WIN_VER:~0,9%"=="Windows 1" (
	color 0c
	echo  ERROR! This script is only for Windows 10. Detected version is %WIN_VER% ^(%WIN_VER_NUM%^). Aborting. >> %LOGPATH%\%LOGFILE%
	echo.
	echo  ERROR
	echo.
	echo   This script is only for Windows 10.
	echo.
	echo   Detected version is %WIN_VER% ^(%WIN_VER_NUM%^).
	echo.
	echo   Quitting in 30 seconds...
	echo.
	ping 127.0.0.1 -n 30 >NUL
	color
	exit /b 1
)



:::::::::::::
:: EXECUTE ::
:::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::
:: SCHEDULED TASKS
if %STANDALONE%==no (
	call functions\log.bat "     Removing telemetry-related scheduled tasks..."
) else (
	echo "Removing telemetry-related scheduled tasks...."
)


if "%VERBOSE%"=="yes" (
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
	schtasks /delete /F /TN "\Microsoft\Windows\Autochk\Proxy"
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
	schtasks /delete /F /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
	schtasks /delete /F /TN "\Microsoft\Windows\PI\Sqm-Tasks"
	schtasks /delete /F /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
	schtasks /delete /F /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
	schtasks /delete /f /tn "\Microsoft\Windows\application experience\Microsoft compatibility appraiser"
	schtasks /delete /f /tn "\Microsoft\Windows\application experience\aitagent"
	schtasks /delete /f /tn "\Microsoft\Windows\application experience\programdataupdater"
	schtasks /delete /f /tn "\Microsoft\Windows\autochk\proxy"
	schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\consolidator"
	schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\kernelceiptask"
	schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\usbceip"
	schtasks /delete /f /tn "\Microsoft\Windows\diskdiagnostic\Microsoft-Windows-diskdiagnosticdatacollector"
	schtasks /delete /f /tn "\Microsoft\Windows\maintenance\winsat"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\activateWindowssearch"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\configureinternettimeservice"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\dispatchrecoverytasks"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\ehdrminit"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\installplayready"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\mcupdate"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\mediacenterrecoverytask"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\objectstorerecoverytask"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\ocuractivate"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\ocurdiscovery"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscovery">nul 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw1"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw2"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrrecoverytask"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrscheduletask"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\registersearch"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\reindexsearchroot"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\sqlliterecoverytask"
	schtasks /delete /f /tn "\Microsoft\Windows\media center\updaterecordpath"
) else (
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Autochk\Proxy" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\PI\Sqm-Tasks" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\application experience\Microsoft compatibility appraiser" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\application experience\aitagent" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\application experience\programdataupdater" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\autochk\proxy" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\consolidator" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\kernelceiptask" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\usbceip" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\diskdiagnostic\Microsoft-Windows-diskdiagnosticdatacollector" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\maintenance\winsat" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\activateWindowssearch" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\configureinternettimeservice" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\dispatchrecoverytasks" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\ehdrminit" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\installplayready" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\mcupdate" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\mediacenterrecoverytask" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\objectstorerecoverytask" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\ocuractivate" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\ocurdiscovery" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscovery">> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw1" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw2" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrrecoverytask" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrscheduletask" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\registersearch" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\reindexsearchroot" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\sqlliterecoverytask" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /f /tn "\Microsoft\Windows\media center\updaterecordpath" >> "%LOGPATH%\%LOGFILE%" 2>&1
)

if %STANDALONE%==no (call functions\log.bat "     Done.") else (echo "Done.")



::::::::::::::::::::::::::::::::::::::::::::::::::
:: SERVICES
if %STANDALONE%==no (
	call functions\log.bat "     Removing bad services, please wait..."
) else (
	echo "Removing bad services, please wait..."
)

if "%VERBOSE%"=="yes" (
	:: Diagnostic Tracking; changed delete to disable on 2017-08-28 per https://www.reddit.com/r/TronScript/comments/6vjeap/connected_user_experience_and_telemetry_service/dm2dv3d/?context=3
	sc stop Diagtrack
	sc config Diagtrack start= disabled

	:: Remote Registry (disable only)
	sc config remoteregistry start= disabled
	sc stop remoteregistry

	:: Retail Demo
	sc stop RetailDemo
	sc delete RetailDemo

	:: "WAP Push Message Routing Service"
	sc stop dmwappushservice
	sc config dmwappushservice start= disabled

	:: Windows Event Collector Service (disable only)
	sc stop Wecsvc
	sc config Wecsvc start= disabled

	:: Xbox Live services
	sc stop XblAuthManager
	sc stop XblGameSave
	sc stop XboxNetApiSvc
	sc stop XboxGipSvc
	sc stop xbgm
	sc config XblAuthManager start= demand
	sc config XblGameSave start= demand
	sc config XboxNetApiSvc start= demand
	sc config XboxGipSvc start= demand
	sc config xbgm start= demand
) else (
	:: Diagnostic Tracking
	sc stop Diagtrack >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config Diagtrack start= disabled >> "%LOGPATH%\%LOGFILE%" 2>&1

	:: Remote Registry (disable only)
	sc config remoteregistry start= disabled >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc stop remoteregistry >> "%LOGPATH%\%LOGFILE%" 2>&1

	:: Retail Demo
	sc stop RetailDemo >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc delete RetailDemo >> "%LOGPATH%\%LOGFILE%" 2>&1

	:: "WAP Push Message Routing Service"
	sc stop dmwappushservice >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config dmwappushservice start= disabled >> "%LOGPATH%\%LOGFILE%" 2>&1

	:: Windows Event Collector Service (disable only)
	sc stop Wecsvc >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config Wecsvc start= disabled>> "%LOGPATH%\%LOGFILE%" 2>&1

	:: Xbox Live services
	sc stop XblAuthManager>> "%LOGPATH%\%LOGFILE%" 2>&1
	sc stop XblGameSave>> "%LOGPATH%\%LOGFILE%" 2>&1
	sc stop XboxNetApiSvc>> "%LOGPATH%\%LOGFILE%" 2>&1
	sc stop XboxGipSvc>> "%LOGPATH%\%LOGFILE%" 2>&1
	sc stop xbgm>> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config XblAuthManager start= demand>> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config XblGameSave start= demand>> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config XboxNetApiSvc start= demand>> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config XboxGipSvc start= demand>> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config xbgm start= demand>> "%LOGPATH%\%LOGFILE%" 2>&1
)

if %STANDALONE%==no (call functions\log.bat "     Done.") else (echo "Done.")


::::::::::::::::::::::::::::::::::::::::::::::::::
:: REGISTRY ENTRIES
if %STANDALONE%==no (
	call functions\log.bat "     Toggling official MS telemetry registry entries..."
) else (
	echo "Toggling official MS telemetry registry entries..."
)

if "%VERBOSE%"=="yes" (
	REM Disable Microsoft 3rd-party app silent installation (sigh...)
title Tron v%TRON_VERSION% [stage_4_repair] [disable NVIDIA telemetry]
call functions\log_with_date.bat "   Launch job 'Disable silent 3rd-party app installation'..."
if /i %DRY_RUN%==no (
	%REG% ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /d 0 /f
)
call functions\log_with_date.bat "   Done."
	
	REM GPO options to disable telemetry
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f

	REM Keylogger
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f

	REM Wifi sense; this is a nasty one, privacy-wise
	%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisensecredshared" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisenseopen" /t REG_DWORD /d "0" /f

	REM Windows Defender sample reporting
	%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "spynetreporting" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "submitsamplesconsent" /t REG_DWORD /d "0" /f

	REM DiagTrack service
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f

	REM "WAP Push Message Routing Service"
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f

	REM Disable Cortana globally
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f

	REM Disable "Search online and include web results"
	%REG% add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
) else (
	REM GPO options to disable telemetry
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1

	REM Keylogger
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f /v "Start" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1

	REM Wifi sense; this is a nasty one, privacy-wise
	%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisensecredshared" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisenseopen" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1

	REM Windows Defender sample reporting
	%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "spynetreporting" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "submitsamplesconsent" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1

	REM DiagTrack service
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f >> "%LOGPATH%\%LOGFILE%" 2>&1

	REM "WAP Push Message Routing Service"
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f >> "%LOGPATH%\%LOGFILE%" 2>&1

	REM Disable Cortana globally
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1

	REM Disable "Search online and include web results"
	%REG% add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1

)

if %STANDALONE%==no (call functions\log.bat "     Done.") else (echo "Done.")



::::::::::::::::::::::::::::::::::::::::::::::::::
:: SPYBOT ANTI-BEACON IMMUNIZATIONS
if %STANDALONE%==no (
	call functions\log.bat "     Applying Spybot Anti-Beacon protections, please wait..."
	"stage_4_repair\disable_windows_telemetry\Spybot Anti-Beacon v1.7.0.47.exe" /apply /silent >> "%LOGPATH%\%LOGFILE%" 2>&1
) else (
	echo "Applying Spybot Anti-Beacon protections, please wait..."
	"Spybot Anti-Beacon v1.7.0.47.exe" /apply /silent >> "%LOGPATH%\%LOGFILE%" 2>&1
)
if %STANDALONE%==no (call functions\log.bat "     Done.") else (echo "Done.")



::::::::::::::::::::::::::::::::::::::::::::::::::
:: OandOShutUp10 IMMUNIZATIONS
if %STANDALONE%==no (
	call functions\log.bat "     Applying OandOShutUp10 protections, please wait..."
	stage_4_repair\disable_windows_telemetry\OOShutUp10.exe stage_4_repair\disable_windows_telemetry\ooshutup10_tron_settings.cfg /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
) else (
	echo "Applying OandOShutUp10 protections, please wait..."
	OOShutUp10.exe .\ooshutup10_tron_settings.cfg /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
)

:: Reg fix for the rare case where O&OShutUp10 disables the webcam. 64-bit version is first, 32-bit version is second
if %PROCESSOR_ARCHITECTURE%==AMD64 reg add "HKEY_LOCAL_Machine\SOFTWARE\WOW6432Node\Microsoft\Windows Media Foundation\Platform" /f /v EnableFrameServerMode /t REG_SZ /d 0 >> "%LOGPATH%\%LOGFILE%" 2>&1
reg add "HKEY_LOCAL_Machine\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /f /v EnableFrameServerMode /t REG_SZ /d 0 >> "%LOGPATH%\%LOGFILE%" 2>&1

if %STANDALONE%==no (call functions\log.bat "     Done.") else (echo "Done.")



::::::::::::::::::::::::::::::::::::::::::::::::::
:: MISCELLANEOUS
if %STANDALONE%==no (
	call functions\log.bat "     Miscellaneous cleanup, please wait..."
) else (
	echo "Miscellaneous cleanup, please wait..."
)

:: Kill GWX/Skydrive/Spynet/Telemetry/wifisense/etc
if "%VERBOSE%"=="yes" (
	taskkill /f /im gwx.exe /t
	if %STANDALONE%==no (
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn setowner -ownr n:administrators
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn ace -ace "n:administrators;p:full"
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn setowner -ownr n:administrators
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn ace -ace "n:administrators;p:full"
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn setowner -ownr n:administrators
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn ace -ace "n:administrators;p:full"
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn setowner -ownr n:administrators
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn ace -ace "n:administrators;p:full"
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn setowner -ownr n:administrators
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn ace -ace "n:administrators;p:full"
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn setowner -ownr n:administrators
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn ace -ace "n:administrators;p:full"
	) else (
		setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn setowner -ownr n:administrators
		setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn ace -ace "n:administrators;p:full"
		setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn setowner -ownr n:administrators
		setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn ace -ace "n:administrators;p:full"
		setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn setowner -ownr n:administrators
		setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn ace -ace "n:administrators;p:full"
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn setowner -ownr n:administrators
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn ace -ace "n:administrators;p:full"
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn setowner -ownr n:administrators
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn ace -ace "n:administrators;p:full"
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn setowner -ownr n:administrators
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn ace -ace "n:administrators;p:full"
	)
) else (
	taskkill /f /im gwx.exe /t >> "%LOGPATH%\%LOGFILE%" 2>&1
	if %STANDALONE%==no (
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		stage_4_repair\disable_windows_telemetry\setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
	) else (
		setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn setowner -ownr n:administrators >> "%LOGPATH%\%LOGFILE%" 2>&1
		setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn ace -ace "n:administrators;p:full" >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
)

:: Kill pending tracking reports
if not exist %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\ mkdir %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\ >NUL 2>&1
echo. > %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl 2>NUL
echo y|cacls.exe "%programdata%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /d SYSTEM >NUL 2>&1


:: Kill "show fun tips, hints and tricks" on the lock screen
%REG% load HKEY_LOCAL_MACHINE\defuser %USERPROFILES%\default\ntuser.dat >NUL 2>&1
%REG% add "HKEY_LOCAL_MACHINE\defuser\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V RotatingLockScreenOverlayEnabled /T REG_DWORD /D 00000000 /F >NUL 2>&1
%REG% unload HKEY_LOCAL_MACHINE\defuser >NUL 2>&1

:: Disable "Occasionally show suggestions in Start"...sigh
%REG% ADD HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f


if %STANDALONE%==no (call functions\log.bat "     Done.") else (echo "Done.")

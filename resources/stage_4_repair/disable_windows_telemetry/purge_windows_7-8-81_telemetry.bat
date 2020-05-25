:: Purpose:       Purges Windows 7/8/8.1 telemetry
:: Requirements:  Called from Tron script ( reddit.com/r/TronScript ) in Stage 4: Repair. Can also be run directly
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.7-TRON - Windows Updates: remove outdated job that used to uninstall "bad" updates
::                1.1.6-TRON ! Fix standalone and Tron-called execution due to typo in STANDALONE variable comparison command. Thanks to u/bubonis
::                1.1.5-TRON ! Fix standalone execution not working in some sections due to relative paths being different. Thanks to u/AncientAv
::                1.1.4-TRON ! Fix standalone execution broken due to use of uninitialized %REG% variable
::                1.1.3-TRON * Use %REG% instead of relative calls
::                1.1.2-TRON + Add additional scheduled tasks to remove. Thanks to /u/MirageESO
::                1.1.1-TRON * Embed contents of 'disable_telemetry_registry_entries.reg' directly into script. Removes dependence on an external .reg file
::                1.1.0-TRON + Add updates 2882822 3050265 3065987 3075851 3102810 3118401 3135445 3138612 3173040 from http://www.overclock.net/t/1587577/windows-7-updates-list-descriptions-windows-10-preparation-telemetry
::                             Thanks to /u/HeyYou13
::                1.0.9-TRON ! Fix incorrect path in call to 'disable_telemetry_registry_entries.reg.' Thanks to /u/T_Belfs
::                1.0.8-TRON + Add log messages explaining each step in the process
::                1.0.7-TRON ! Fix incorrectly named directory in pushd statement. Resolves error where Tron couldn't find the Windows Update blocker script. Thanks to /u/DrQuack32
::                           * Simplify and clean up OS version detection
::                           ! Fix bug where script could mistakenly run on a Windows 10 system if manually executed
::                1.0.6-TRON + Add KB's 3112343, 3083324, 3083325, and 3065988. Thanks to /u/toomasmolder
::                1.0.5-TRON + Add KB 3139929. Thanks to /u/MirageESO
::                1.0.4-TRON + Add additional KB entries. Thanks to /u/kronflux
::                           ! OS version check: Replace "pause" command with "ping 127.0.0.1 -n 60 >NUL". This should protect against invalid results permanently stalling the script, and instead abort after 60 seconds
::                           * OS version check: Log a short message to the log file if version check fails. This way we know why the script aborted. Thanks to everyone who helped troubleshoot this
::                1.0.3-TRON + Add KB 3123862 to list of updates to remove and block. Thanks to /u/MirageESO
::                1.0.2-TRON + Add WIN_VER to list of variables to populate if running in standalone mode
::                1.0.1-TRON ! Fix crash error due to log file name containing "::" characters from a sloppy find/replace
::                1.0.0-TRON + Initial write
@echo off
SETLOCAL


:::::::::::::::
:: VARIABLES :: -------------- These are the defaults. Change them if you so desire. --------- ::
:::::::::::::::
:: No user-set variables for this script


:: --------------------------- Don't edit anything below this line --------------------------- ::


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set SCRIPT_VERSION=1.1.7-TRON
set SCRIPT_UPDATED=2020-05-25

:: Populate dependent variables if we didn't inherit them from Tron (standalone execution)
set STANDALONE=no
if /i "%LOGPATH%"=="" (
	set WMIC=%SystemRoot%\System32\wbem\wmic.exe
	set FIND=%SystemRoot%\System32\find.exe
	set FINDSTR=%SystemRoot%\System32\findstr.exe
	set REG=%SystemRoot%\System32\reg.exe
)
if /i "%LOGPATH%"=="" (
	set LOGPATH=%SystemDrive%\logs
	set LOGFILE=windows_7-8-81_telemetry_removal.log
	set VERBOSE=yes
	set STANDALONE=yes
	for /f "tokens=3*" %%i IN ('%REG% query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| %FIND% "ProductName"') DO set WIN_VER=%%i %%j
	for /f "tokens=3*" %%i IN ('%REG% query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion ^| %FIND% "CurrentVersion"') DO set WIN_VER_NUM=%%i
)

:: Make sure we're on Win7, 8 or 8.1 series
:: On Windows 10 the console stupidly reports that the internal version number is 6.3, same
:: as Win7-8.1, so we have to add an additional literal string check to catch it. Sigh.
set ABORT=no
if %WIN_VER_NUM% gtr 6.3 set ABORT=yes
if %WIN_VER_NUM% leq 6.0 set ABORT=yes
if "%WIN_VER:~0,10%"=="Windows 10" set ABORT=yes
if %ABORT%==yes (
	color 0c
	echo  ERROR! This script is only for Windows 7/8/8.1. Detected version is %WIN_VER% ^(%WIN_VER_NUM%^). Aborting.>> %LOGPATH%\%LOGFILE%
	echo.
	echo  ERROR
	echo.
	echo   This script is only for Windows 7, 8 and 8.1
	echo   ^(including server variants^).
	echo.
	echo   Detected version is %WIN_VER% ^(%WIN_VER_NUM%^).
	echo.
	echo   Quitting in 60 seconds...
	echo.
	ping 127.0.0.1 -n 60 >NUL
	color
	exit /b 1
)



:::::::::::::
:: EXECUTE ::
:::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::
:: SCHEDULED TASKS
if %STANDALONE%==no (
	call functions\log.bat "     Removing telemetry-related scheduled tasks..."
) else (
	echo "Removing telemetry-related scheduled tasks...."
)

if "%VERBOSE%"=="yes" (
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\AitAgent"
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
	schtasks /delete /F /TN "\Microsoft\Windows\Autochk\Proxy"
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM"
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
	schtasks /delete /F /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
	schtasks /delete /F /TN "\Microsoft\Windows\PI\Sqm-Tasks"
	schtasks /delete /F /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
	schtasks /delete /F /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
) else (
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\AitAgent" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Autochk\Proxy" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\PI\Sqm-Tasks" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >> "%LOGPATH%\%LOGFILE%" 2>&1
	schtasks /delete /F /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" >> "%LOGPATH%\%LOGFILE%" 2>&1
)

if %STANDALONE%==no (call functions\log.bat "     Done.") else (echo "Done.")



::::::::::::::::::::::::::::::::::::::::::::::::
:: SERVICES
if %STANDALONE%==no (
	call functions\log.bat "     Removing bad services, please wait..."
) else (
	echo "Removing bad services, please wait..."
)

if "%VERBOSE%"=="yes" (
	:: Diagnostic Tracking
	sc stop Diagtrack
	sc delete Diagtrack

	:: Remote Registry (disable only)
	sc config RemoteRegistry start= disabled
	sc stop RemoteRegistry
) else (
	:: Diagnostic Tracking
	sc stop Diagtrack >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc delete Diagtrack >> "%LOGPATH%\%LOGFILE%" 2>&1

	:: Remote Registry (disable only)
	sc config RemoteRegistry start= disabled >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc stop RemoteRegistry >> "%LOGPATH%\%LOGFILE%" 2>&1
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
	REM GPO options to disable telemetry
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
	
	REM Keylogger
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f
	
	REM Wifi sense; this is a nasty one, privacy-wise
	%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisensecredshared" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisenseopen" /t REG_DWORD /d "0" /f
	
	REM Windows Defender sample reporting
	%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "spynetreporting" /t REG_DWORD /d "0" /f
	%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "submitsamplesconsent" /t REG_DWORD /d "0" /f
	
	REM SkyDrive
	%REG% add "HKLM\software\policies\microsoft\windows\skydrive" /v "disablefilesync" /t REG_DWORD /d "1" /f
	
	REM Kill OneDrive from hooking into Explorer even when disabled
	%REG% add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
	%REG% add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
	
	REM DiagTrack service
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f
	
	REM "WAP Push Message Routing Service"
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f
) else (
	REM GPO options to disable telemetry
	%REG% add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	
	REM Keylogger
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	
	REM Wifi sense; this is a nasty one, privacy-wise
	%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisensecredshared" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\software\microsoft\wcmsvc\wifinetworkmanager" /v "wifisenseopen" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	
	REM Windows Defender sample reporting
	%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "spynetreporting" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKLM\software\microsoft\windows defender\spynet" /v "submitsamplesconsent" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	
	REM SkyDrive
	%REG% add "HKLM\software\policies\microsoft\windows\skydrive" /v "disablefilesync" /t REG_DWORD /d "1" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	
	REM Kill OneDrive from hooking into Explorer even when disabled
	%REG% add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	%REG% add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	
	REM DiagTrack service
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
	
	REM "WAP Push Message Routing Service"
	%REG% add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f >> "%LOGPATH%\%LOGFILE%" 2>&1
)

if %STANDALONE%==no (call functions\log.bat "     Done.") else (echo "Done.")



::::::::::::::::::::::::::::::::::::::::::::::::
:: MISC
if %STANDALONE%==no (
	call functions\log.bat "     Miscellaneous cleanup, please wait..."
) else (
	echo "Miscellaneous cleanup, please wait..."
)

:: Kill pending tracking reports
if not exist %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\ mkdir %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\ >NUL 2>&1
echo. > %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl 2>NUL
echo y|cacls.exe "%programdata%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /d SYSTEM >NUL 2>&1

if %STANDALONE%==no (call functions\log.bat "     Done.") else (echo "Done.")

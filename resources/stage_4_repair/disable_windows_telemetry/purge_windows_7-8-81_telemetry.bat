:: Purpose:       Purges Windows 7/8/8.1 telemetry
:: Requirements:  Called from Tron script ( reddit.com/r/TronScript ) in Stage 4: Repair. Can also be run directly
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.8-TRON + Add log messages explaining each step in the process
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
@SETLOCAL


:::::::::::::::
:: VARIABLES :: -------------- These are the defaults. Change them if you so desire. --------- ::
:::::::::::::::
:: No user-set variables for this script


:: --------------------------- Don't edit anything below this line --------------------------- ::


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
@echo off
set SCRIPT_VERSION=1.0.8-TRON
set SCRIPT_UPDATED=2016-09-10

:: Populate dependent variables if we didn't inherit them from Tron (standalone execution)
if /i "%LOGPATH%"=="" (
	set LOGPATH=%SystemDrive%\Logs
	set LOGFILE=windows_7-8-81_telemetry_removal.log
	set VERBOSE=yes
	for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| Find "ProductName"') DO set WIN_VER=%%i %%j
	for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion ^| Find "CurrentVersion"') DO set WIN_VER_NUM=%%i
)

:: Make sure we're on Win7, 8 or 8.1 series
:: On Windows 10 the console stupidly reports that the internal version number is 6.3, same
:: as Win7-81, so we have to add an additional literal string check to catch it. Sigh.
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


:::::::::::::::::::::::::::::::::::::::::::::::
:: REMOVE BAD UPDATES
call functions\log.bat "%CUR_DATE% %TIME%    Uninstalling bad updates, please wait..."

if "%VERBOSE%"=="yes" (
	:: Updated capabilities to upgrade Windows 8.1 and Windows 7
	start /wait "" wusa /uninstall /kb:3123862 /quiet /norestart
	:: Compatibility update for Windows 8.1 and Windows 8
	start /wait "" wusa /uninstall /kb:2976978 /quiet /norestart
	:: New update client for Windows 8/8.1
	start /wait "" wusa /uninstall /kb:3083711 /quiet /norestart
	:: Windows 8/8.1/2012/2012R2: Update: activate Windows 10 from Windows 8 or Windows 8.1, and Windows Server 2012 or Windows Server 2012 R2 KMS hosts
	start /wait "" wusa /uninstall /kb:3058168 /quiet /norestart
	:: Windows 8.1: Windows 8.1 OOBE modifications to reserve Windows 10
	start /wait "" wusa /uninstall /kb:3064683 /quiet /norestart
	:: Windows 8.1: Update for Windows 8.1 OOBE to upgrade to Windows 10
	start /wait "" wusa /uninstall /kb:3072318 /quiet /norestart
	:: Windows 8.1: Windows Update for reserved devices in Windows 8.1 or Windows 7 SP1
	start /wait "" wusa /uninstall /kb:3090045 /quiet /norestart
	:: Update that enables you to upgrade from Windows 7 to a later version of Windows
	start /wait "" wusa /uninstall /kb:2990214 /quiet /norestart
	:: Updated Internet Explorer 11 capabilities to upgrade Windows 8.1 and Windows 7
	start /wait "" wusa /uninstall /kb:3139929 /quiet /norestart
	:: Customer Experience and Diagnostic Telemetry-related updates
	start /wait "" wusa /uninstall /kb:3022345 /quiet /norestart
	start /wait "" wusa /uninstall /kb:3068708 /quiet /norestart
	start /wait "" wusa /uninstall /kb:3080149 /quiet /norestart
	start /wait "" wusa /uninstall /kb:3021917 /quiet /norestart
	:: Adds telemetry points to consent.exe in Windows 8.1 and Windows 7
	start /wait "" wusa /uninstall /kb:3075249 /quiet /norestart
	start /wait "" wusa /uninstall /kb:3015249 /quiet /norestart
	:: Windows 7: Update for Work Folders improvements in Windows 7 SP1 (adds Windows 10 telemetry points)
	start /wait "" wusa /uninstall /kb:3081954 /quiet /norestart
	:: "Get Windows 10" nagger in Windows 8.1 and Windows 7 SP1
	start /wait "" wusa /uninstall /kb:3035583 /quiet /norestart
	:: Enable upgrade from Windows 8.1 to Windows 10
	start /wait "" wusa /uninstall /kb:3044374 /quiet /norestart
	:: Windows 7/8.1: Update helps to determine whether to migrate the .NET Framework 1.1 when you upgrade Windows 8.1 or Windows 7
	start /wait "" wusa /uninstall /kb:3046480 /quiet /norestart
	:: Windows 7/8.1: How to manage Windows 10 notification and upgrade options
	start /wait "" wusa /uninstall /kb:3080351 /quiet /norestart
	:: Windows 7/8/8.1: Compatibility update for upgrading to Windows 10
	start /wait "" wusa /uninstall /kb:3081437 /quiet /norestart
	start /wait "" wusa /uninstall /kb:3081454 /quiet /norestart
	start /wait "" wusa /uninstall /kb:3074677 /quiet /norestart
	:: Compatibility update for Windows 7 (is a scanner)
	start /wait "" wusa /uninstall /kb:2977759 /quiet /norestart
	:: Compatibility update for Windows 7
	start /wait "" wusa /uninstall /kb:2952664 /quiet /norestart
	:: New update client for Windows 7
	start /wait "" wusa /uninstall /kb:3083710 /quiet /norestart
	:: Description of the update for Windows Activation Technologies
	start /wait "" wusa /uninstall /kb:971033 /quiet /norestart
	:: KB entries removed by Microsoft; previously associated with Win10 upgrade/telemetry
	start /wait "" wusa /uninstall /kb:2902907 /quiet /norestart
	start /wait "" wusa /uninstall /kb:2922324 /quiet /norestart
	start /wait "" wusa /uninstall /kb:3012973 /quiet /norestart
	start /wait "" wusa /uninstall /kb:3014460 /quiet /norestart
	start /wait "" wusa /uninstall /kb:3068707 /quiet /norestart
	:: Windows Update Client for Windows 8.1 and Windows Server 2012 R2: July 2015
	:: Reference: http://www.addictivetips.com/windows-tips/a-complete-list-of-all-updates-you-should-uninstall-to-block-windows-10/
	start /wait "" wusa /uninstall /kb:3065988 /quiet /norestart
	:: Windows Update Client for Windows 7 and Windows Server 2008 R2: September 2015
	:: Reference: http://www.addictivetips.com/windows-tips/a-complete-list-of-all-updates-you-should-uninstall-to-block-windows-10/
	start /wait "" wusa /uninstall /kb:3083324 /quiet /norestart
	:: Windows Update Client for Windows 8.1 and Windows Server 2012 R2: September 2015
	:: Reference: http://www.addictivetips.com/windows-tips/a-complete-list-of-all-updates-you-should-uninstall-to-block-windows-10/
	start /wait "" wusa /uninstall /kb:3083325 /quiet /norestart
	:: Windows Update Client for Windows 8.1 and Windows Server 2012 R2: December 2015
	:: Reported here: https://www.reddit.com/r/TronScript/comments/3v592f/tron_v800_20151202_modularize_entire_project_see/cxl6rko
	start /wait "" wusa /uninstall /kb:3112336 /quiet /norestart
	:: Windows Update Client for Windows 7 and Windows Server 2008 R2: December 2015
	:: This update enables support for additional upgrade scenarios from Windows 7 to Windows 10, and provides a smoother experience
	:: when you have to retry an operating system upgrade because of certain failure conditions.
	:: This update also improves the ability of Microsoft to monitor the quality of the upgrade experience.
	start /wait "" wusa /uninstall /kb:3112343 /quiet /norestart
) else (
	:: Updated capabilities to upgrade Windows 8.1 and Windows 7
	start /wait "" wusa /uninstall /kb:3123862 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Compatibility update for Windows 8.1 and Windows 8
	start /wait "" wusa /uninstall /kb:2976978 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: New update client for Windows 8/8.1
	start /wait "" wusa /uninstall /kb:3083711 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows 8/8.1/2012/2012R2: Update: activate Windows 10 from Windows 8 or Windows 8.1, and Windows Server 2012 or Windows Server 2012 R2 KMS hosts
	start /wait "" wusa /uninstall /kb:3058168 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows 8.1: Windows 8.1 OOBE modifications to reserve Windows 10
	start /wait "" wusa /uninstall /kb:3064683 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows 8.1: Update for Windows 8.1 OOBE to upgrade to Windows 10
	start /wait "" wusa /uninstall /kb:3072318 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows 8.1: Windows Update for reserved devices in Windows 8.1 or Windows 7 SP1
	start /wait "" wusa /uninstall /kb:3090045 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Update that enables you to upgrade from Windows 7 to a later version of Windows
	start /wait "" wusa /uninstall /kb:2990214 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Customer Experience and Diagnostic Telemetry-related updates
	start /wait "" wusa /uninstall /kb:3022345 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3068708 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3080149 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3021917 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Adds telemetry points to consent.exe in Windows 8.1 and Windows 7
	start /wait "" wusa /uninstall /kb:3075249 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3015249 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows 7: Update for Work Folders improvements in Windows 7 SP1 (adds Windows 10 telemetry points)
	start /wait "" wusa /uninstall /kb:3081954 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: "Get Windows 10" nagger in Windows 8.1 and Windows 7 SP1
	start /wait "" wusa /uninstall /kb:3035583 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Enable upgrade from Windows 8.1 to Windows 10
	start /wait "" wusa /uninstall /kb:3044374 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows 7/8.1: Update helps to determine whether to migrate the .NET Framework 1.1 when you upgrade Windows 8.1 or Windows 7
	start /wait "" wusa /uninstall /kb:3046480 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows 7/8.1: How to manage Windows 10 notification and upgrade options
	start /wait "" wusa /uninstall /kb:3080351 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows 7/8/8.1: Compatibility update for upgrading to Windows 10
	start /wait "" wusa /uninstall /kb:3081437 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3081454 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3074677 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Compatibility update for Windows 7 (is a scanner)
	start /wait "" wusa /uninstall /kb:2977759 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Compatibility update for Windows 7
	start /wait "" wusa /uninstall /kb:2952664 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: New update client for Windows 7
	start /wait "" wusa /uninstall /kb:3083710 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Description of the update for Windows Activation Technologies
	start /wait "" wusa /uninstall /kb:971033 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB entries removed by Microsoft; previously associated with Win10 upgrade/telemetry
	start /wait "" wusa /uninstall /kb:2902907 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:2922324 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3012973 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3014460 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3068707 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows Update Client for Windows 8.1 and Windows Server 2012 R2: July 2015
	:: Reference: http://www.addictivetips.com/windows-tips/a-complete-list-of-all-updates-you-should-uninstall-to-block-windows-10/
	start /wait "" wusa /uninstall /kb:3065988 /quiet /norestart
	:: Windows Update Client for Windows 7 and Windows Server 2008 R2: September 2015
	:: Reference: http://www.addictivetips.com/windows-tips/a-complete-list-of-all-updates-you-should-uninstall-to-block-windows-10/
	start /wait "" wusa /uninstall /kb:3083324 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows Update Client for Windows 8.1 and Windows Server 2012 R2: September 2015
	:: Reference: http://www.addictivetips.com/windows-tips/a-complete-list-of-all-updates-you-should-uninstall-to-block-windows-10/
	start /wait "" wusa /uninstall /kb:3083325 /quiet /norestart
	:: Windows Update Client for Windows 8.1 and Windows Server 2012 R2: December 2015
	:: Reported here: https://www.reddit.com/r/TronScript/comments/3v592f/tron_v800_20151202_modularize_entire_project_see/cxl6rko
	start /wait "" wusa /uninstall /kb:3112336 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Windows Update Client for Windows 7 and Windows Server 2008 R2: December 2015
	:: This update enables support for additional upgrade scenarios from Windows 7 to Windows 10, and provides a smoother experience
	:: when you have to retry an operating system upgrade because of certain failure conditions.
	:: This update also improves the ability of Microsoft to monitor the quality of the upgrade experience.
	start /wait "" wusa /uninstall /kb:3112343 /quiet /norestart >> "%LOGPATH%\%LOGFILE%" 2>&1
)

call functions\log.bat "%CUR_DATE% %TIME%    Done."



::::::::::::::::::::::::::::::::::::::::::::::::
:: BLOCK BAD UPDATES
call functions\log.bat "%CUR_DATE% %TIME%    Blocking bad updates, please wait..."

:: This line needed if we're being called from Tron. In standalone mode we'll already be in the appropriate directory
pushd stage_4_repair\disable_windows_telemetry 2>NUL
start "" /b /wait cscript.exe "block_windows_updates.vbs" 971033 3123862 3112336 3090045 3083711 3083710 3081954 3081454 3081437 3080351 3080149 3075249 3074677 3072318 3068708 3068707 3064683
:: Next batch
start "" /b /wait cscript.exe "block_windows_updates.vbs" 3058168 3046480 3044374 3035583 3022345 3021917 3015249 3014460 3012973 2990214 3139929 2977759 2976987 2976978 2952664 2922324 2902907 3112343 3083324 3083325
popd

call functions\log.bat "%CUR_DATE% %TIME%    Done."



::::::::::::::::::::::::::::::::::::::::::::::::
:: SCHEDULED TASKS
call functions\log.bat "%CUR_DATE% %TIME%    Removing telemetry-related scheduled tasks..."

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
)

call functions\log.bat "%CUR_DATE% %TIME%    Done."



::::::::::::::::::::::::::::::::::::::::::::::::
:: SERVICES
call functions\log.bat "%CUR_DATE% %TIME%    Removing bad services, please wait..."

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

call functions\log.bat "%CUR_DATE% %TIME%    Done."



::::::::::::::::::::::::::::::::::::::::::::::::::
:: REGISTRY ENTRIES
call functions\log.bat "%CUR_DATE% %TIME%    Adding official disable telemtry registry entries..."

:: Disable telemetry via master registry key
reg import disable_telemetry_registry_entries.reg >nul 2>&1
regedit /S disable_telemetry_registry_entries.reg >nul 2>&1

call functions\log.bat "%CUR_DATE% %TIME%    Done."



::::::::::::::::::::::::::::::::::::::::::::::::
:: MISC
call functions\log.bat "%CUR_DATE% %TIME%    Miscellaneous cleanup, please wait..."

:: Kill pending tracking reports
if not exist %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\ mkdir %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\
echo. > %ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl 2>NUL
echo y|cacls.exe "%programdata%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /d SYSTEM 2>NUL

call functions\log.bat "%CUR_DATE% %TIME%    Done."

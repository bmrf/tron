:: Purpose:       Purges Windows 10 telemetry
:: Requirements:  Called from Tron script ( reddit.com/r/TronScript ) in Stage 4: Repair. Can also be run directly
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
::                code heavily borrowed from:
::                  - Aegis project: https://voat.co/v/technology/comments/459263
::                  - win10-unfu**k: https://github.com/dfkt/win10-unfuck
::                  - WindowsLies:   https://github.com/WindowsLies/BlockWindows
::                  - ... and many other places around the web
:: Version:       1.1.1-TRON + Add additional KB entries. Thanks to /u/kronflux
::                           ! OS version check: Replace "pause" command with "ping 127.0.0.1 -n 60 >NUL". This should protect against invalid results permanently stalling the script, and instead abort after 60 seconds
::                           * OS version check: Log a short message to the log file if version check fails. This way we know why the script aborted. Thanks to everyone who helped troubleshoot this
::                1.1.0-TRON - Disable null-routing of storeedgefd.dsx.mp.microsoft.com, which is required for the App Store to connect. Thanks to /u/derphurr for Wireshark analysis
::                1.0.9-TRON + Add WIN_VER to list of variables to populate if running in standalone mode
::                1.0.8-TRON ! Fix critical bug where the check to prevent running the script on any Windows version besides 10 would check WIN_VER_NUM and find the version # to be 6.3 instead of 10
::                           / Change "sc delete" commands to "sc config <servicename> start= disabled" for Xbox related services
::                1.0.7-TRON * Populate dependent variables (LOGPATH, LOGFILE, VERBOSE, WIN_VER_NUM) if we didn't inherit them from Tron (allows standalone execution)
::                1.0.6-TRON * Wrap all references to VERBOSE in quotes. Doesn't fix an active bug but better protects us against bad input
::                1.0.5-TRON ! Revert all /disable flags to /delete, since /disable isn't (apparently) supported on Win10. Thanks to /u/PhantomGamers
::                1.0.4-TRON + Add blocking ("hiding") of bad updates to prevent re-installation
::                           + Add logging and -v flag (VERBOSE) support
::                           / Change Scheduled Tasks cleanup to use "/disable" flag instead of "/delete" in case those jobs are needed later on
::                1.0.3-TRON - Remove "Kill forced OneDrive integration" and move it to Windows 10 Metro de-bloat section of main Tron.bat
::                           / Change Wecsvc deletion to disabling only. Thanks to /u/hoodrichson
::                1.0.2-TRON + Add removing of RetailDemo service
::                1.0.1-TRON - Remove five host null-route entries that incorrectly blocked Windows Update cache servers. Thanks to /u/SirHaxalot and /u/DewArmy
::                           - Remove incorrect pushd %SystemDrive at head of script
::                           - Remove KB971033 from KB purge list; not applicable to Win10. Thanks to /u/spexdi
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
set SCRIPT_VERSION=1.1.1-TRON
set SCRIPT_UPDATED=2016-02-24

:: Populate dependent variables if we didn't inherit them from Tron (standalone execution)
if /i "%LOGPATH%"=="" (
	set LOGPATH=%SystemDrive%\Logs
	set LOGFILE=windows_10_telemetry_removal.log
	set VERBOSE=yes
	for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| Find "ProductName"') DO set WIN_VER=%%i %%j
	for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentVersion ^| Find "CurrentVersion"') DO set WIN_VER_NUM=%%i
)

:: Make sure we're on Win10
:: Windows 10 stupidly reports its version number as 6.3 so we can't use WIN_VER_NUM. sigh
if /i not "%WIN_VER:~0,9%"=="Windows 1" (
	color 0c
	echo  ERROR! This script is only for Windows 10. Detected version is %WIN_VER% %WIN_VER_NUM%. Aborting. >> %LOGPATH%\%LOGFILE%
	echo.
	echo  ERROR
	echo.
	echo   This script is only for Windows 10.
	echo   Detected version is %WIN_VER% %WIN_VER_NUM%
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

::::::::::::::::::::::::::::::::::::::::::::::::::
:: MISCELLANEOUS
:: Kill GWX/Skydrive/Spynet/Telemetry/waitifisense/etc
if "%VERBOSE%"=="yes" (
	taskkill /f /im gwx.exe /t
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
) else (
	taskkill /f /im gwx.exe /t >> "%LOGPATH%\%LOGFILE%" 2>&1
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



::::::::::::::::::::::::::::::::::::::::::::::::::
:: REMOVE BAD UPDATES
if "%VERBOSE%"=="yes" (
	:: KB 2902907 (https://support.microsoft.com/en-us/kb/2902907)
	start /wait "" wusa /uninstall /kb:2902907 /norestart /quiet
	:: KB 2922324 (https://support.microsoft.com/en-us/kb/2922324)
	start /wait "" wusa /uninstall /kb:2922324 /norestart /quiet
	:: KB 2952664 (https://support.microsoft.com/en-us/kb/2952664)
	start /wait "" wusa /uninstall /kb:2952664 /norestart /quiet
	:: KB 2976978 (https://support.microsoft.com/en-us/kb/2976978)
	start /wait "" wusa /uninstall /kb:2976978 /norestart /quiet
	:: KB 2977759 (https://support.microsoft.com/en-us/kb/2977759)
	start /wait "" wusa /uninstall /kb:2977759 /norestart /quiet
	:: KB 2990214 (https://support.microsoft.com/en-us/kb/2990214)
	start /wait "" wusa /uninstall /kb:2990214 /norestart /quiet
	:: KB 3012973 (https://support.microsoft.com/en-us/kb/3012973)
	start /wait "" wusa /uninstall /kb:3012973 /norestart /quiet
	:: KB 3014460 (https://support.microsoft.com/en-us/kb/3014460)
	start /wait "" wusa /uninstall /kb:3014460 /norestart /quiet
	:: KB 3015249 (https://support.microsoft.com/en-us/kb/3015249)
	start /wait "" wusa /uninstall /kb:3015249 /norestart /quiet
	:: KB 3021917 (https://support.microsoft.com/en-us/kb/3021917)
	start /wait "" wusa /uninstall /kb:3021917 /norestart /quiet
	:: KB 3022345 (https://support.microsoft.com/en-us/kb/3022345)
	start /wait "" wusa /uninstall /kb:3022345 /norestart /quiet
	:: KB 3035583 (https://support.microsoft.com/en-us/kb/3035583)
	start /wait "" wusa /uninstall /kb:3035583 /norestart /quiet
	:: KB 3044374 (https://support.microsoft.com/en-us/kb/3044374)
	start /wait "" wusa /uninstall /kb:3044374 /norestart /quiet
	:: KB 3050265 (https://support.microsoft.com/en-us/kb/3050265)
	start /wait "" wusa /uninstall /kb:3050265 /norestart /quiet
	:: KB 3050267 (https://support.microsoft.com/en-us/kb/3050267)
	start /wait "" wusa /uninstall /kb:3050267 /norestart /quiet
	:: KB 3065987 (https://support.microsoft.com/en-us/kb/3065987)
	start /wait "" wusa /uninstall /kb:3065987 /norestart /quiet
	:: KB 3068708 (https://support.microsoft.com/en-us/kb/3068708)
	start /wait "" wusa /uninstall /kb:3068708 /norestart /quiet
	:: KB 3075249 (https://support.microsoft.com/en-us/kb/3075249)
	start /wait "" wusa /uninstall /kb:3075249 /norestart /quiet
	:: KB 3075851 (https://support.microsoft.com/en-us/kb/3075851)
	start /wait "" wusa /uninstall /kb:3075851 /norestart /quiet
	:: KB 3075853 (https://support.microsoft.com/en-us/kb/3075853)
	start /wait "" wusa /uninstall /kb:3075853 /norestart /quiet
	:: KB 3080149 (https://support.microsoft.com/en-us/kb/3080149)
	start /wait "" wusa /uninstall /kb:3080149 /norestart /quiet
	:: Additional KB entries removed by Microsoft; originally associated with telemetry
	start /wait "" wusa /uninstall /kb:2976987 /norestart /quiet
	start /wait "" wusa /uninstall /kb:3068707 /norestart /quiet
) else (
	:: KB 2902907 (https://support.microsoft.com/en-us/kb/2902907)
	start /wait "" wusa /uninstall /kb:2902907 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 2922324 (https://support.microsoft.com/en-us/kb/2922324)
	start /wait "" wusa /uninstall /kb:2922324 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 2952664 (https://support.microsoft.com/en-us/kb/2952664)
	start /wait "" wusa /uninstall /kb:2952664 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 2976978 (https://support.microsoft.com/en-us/kb/2976978)
	start /wait "" wusa /uninstall /kb:2976978 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 2977759 (https://support.microsoft.com/en-us/kb/2977759)
	start /wait "" wusa /uninstall /kb:2977759 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 2990214 (https://support.microsoft.com/en-us/kb/2990214)
	start /wait "" wusa /uninstall /kb:2990214 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3012973 (https://support.microsoft.com/en-us/kb/3012973)
	start /wait "" wusa /uninstall /kb:3012973 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3014460 (https://support.microsoft.com/en-us/kb/3014460)
	start /wait "" wusa /uninstall /kb:3014460 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3015249 (https://support.microsoft.com/en-us/kb/3015249)
	start /wait "" wusa /uninstall /kb:3015249 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3021917 (https://support.microsoft.com/en-us/kb/3021917)
	start /wait "" wusa /uninstall /kb:3021917 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3022345 (https://support.microsoft.com/en-us/kb/3022345)
	start /wait "" wusa /uninstall /kb:3022345 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3035583 (https://support.microsoft.com/en-us/kb/3035583)
	start /wait "" wusa /uninstall /kb:3035583 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3044374 (https://support.microsoft.com/en-us/kb/3044374)
	start /wait "" wusa /uninstall /kb:3044374 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3050265 (https://support.microsoft.com/en-us/kb/3050265)
	start /wait "" wusa /uninstall /kb:3050265 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3050267 (https://support.microsoft.com/en-us/kb/3050267)
	start /wait "" wusa /uninstall /kb:3050267 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3065987 (https://support.microsoft.com/en-us/kb/3065987)
	start /wait "" wusa /uninstall /kb:3065987 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3068708 (https://support.microsoft.com/en-us/kb/3068708)
	start /wait "" wusa /uninstall /kb:3068708 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3075249 (https://support.microsoft.com/en-us/kb/3075249)
	start /wait "" wusa /uninstall /kb:3075249 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3075851 (https://support.microsoft.com/en-us/kb/3075851)
	start /wait "" wusa /uninstall /kb:3075851 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3075853 (https://support.microsoft.com/en-us/kb/3075853)
	start /wait "" wusa /uninstall /kb:3075853 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: KB 3080149 (https://support.microsoft.com/en-us/kb/3080149)
	start /wait "" wusa /uninstall /kb:3080149 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: Additional KB entries removed by Microsoft; originally associated with telemetry
	start /wait "" wusa /uninstall /kb:2976987 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
	start /wait "" wusa /uninstall /kb:3068707 /norestart /quiet >> "%LOGPATH%\%LOGFILE%" 2>&1
)



::::::::::::::::::::::::::::::::::::::::::::::::::
:: BLOCK BAD UPDATES FROM RE-INSTALLING

:: This line needed if we're being called from Tron. In standalone mode we'll already be in the appropriate directory
pushd stage_4_repair\purge_windows_telemetry 2>NUL

::start "" /b /wait cscript.exe "%~dp0block_windows_updates.vbs" 3080149 3075853 3075851 3075249 3068708 3068707 3065987 3050267 3050265 3044374 3035583 3022345 3021917 3015249 3014460 3012973 2990214 2977759 2976987 2976978 2952664 2922324 2902907
start "" /b /wait cscript.exe "block_windows_updates.vbs" 3080149 3075853 3075851 3075249 3068708 3068707 3065987 3050267 3050265 3044374 3035583 3022345 3021917 3015249 3014460 3012973 2990214 2977759 2976987 2976978 2952664 2922324 2902907

popd


::::::::::::::::::::::::::::::::::::::::::::::::::
:: SCHEDULED TASKS
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


::::::::::::::::::::::::::::::::::::::::::::::::::
:: SERVICES
if "%VERBOSE%"=="yes" (
	:: Diagnostic Tracking
	sc stop Diagtrack
	sc delete Diagtrack

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
	sc config XblAuthManager start= disabled
	sc config XblGameSave start= disabled
	sc config XboxNetApiSvc start= disabled
) else (
	:: Diagnostic Tracking
	sc stop Diagtrack >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc delete Diagtrack >> "%LOGPATH%\%LOGFILE%" 2>&1

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
	sc stop XblAuthManager >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc stop XblGameSave >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc stop XboxNetApiSvc >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config XblAuthManager start= disabled >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config XblGameSave start= disabled >> "%LOGPATH%\%LOGFILE%" 2>&1
	sc config XboxNetApiSvc start= disabled >> "%LOGPATH%\%LOGFILE%" 2>&1
)



::::::::::::::::::::::::::::::::::::::::::::::::::
:: REGISTRY ENTRIES
if "%VERBOSE%"=="yes" (
	reg import %~dp0disable_telemetry_registry_entries.reg
	reg import disable_telemetry_registry_entries.reg
	regedit /S %~dp0disable_telemetry_registry_entries.reg
	regedit /S disable_telemetry_registry_entries.reg
) else (
	reg import %~dp0disable_telemetry_registry_entries.reg >> "%LOGPATH%\%LOGFILE%" 2>&1
	reg import disable_telemetry_registry_entries.reg >> "%LOGPATH%\%LOGFILE%" 2>&1
	regedit /S %~dp0disable_telemetry_registry_entries.reg >> "%LOGPATH%\%LOGFILE%" 2>&1
	regedit /S disable_telemetry_registry_entries.reg >> "%LOGPATH%\%LOGFILE%" 2>&1
)



::::::::::::::::::::::::::::::::::::::::::::::::::
:: NULL ROUTE BAD HOSTS

:: Run this command to flush ALL routes IMMEDIATELY. It will delete your default route so you'll need to reboot or do an ipconfig /release & ipconfig /renew to get back online
::route -f

:: Run this command to clear persistent routes only, takes effect at reboot. This will undo all the below changes
::reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\PersistentRoutes /va /f
if "%VERBOSE%"=="yes" (
	:: a-0001.a-msedge.net
	route -p add 204.79.197.200/32 0.0.0.0
	:: a23-218-212-69.deploy.static.akamaitechnologies.com
	route -p add 23.218.212.69/32 0.0.0.0
	:: a.ads1.msn.com
	route -p add 204.160.124.125/32 0.0.0.0
	route -p add 8.253.14.126/32 0.0.0.0
	route -p add 8.254.25.126/32 0.0.0.0
	:: a.ads2.msads.net
	route -p add 93.184.215.200/32 0.0.0.0
	:: a.ads2.msn.com
	route -p add 198.78.194.252/32 0.0.0.0
	route -p add 198.78.209.253/32 0.0.0.0
	route -p add 8.254.23.254/32 0.0.0.0
	:: ac3.msn.com
	route -p add 131.253.14.76/32 0.0.0.0
	:: ads1.msads.net
	route -p add 23.201.58.73/32 0.0.0.0
	:: ads1.msn.com
	route -p add 204.160.124.125/32 0.0.0.0
	route -p add 8.253.14.126/32 0.0.0.0
	route -p add 8.254.25.126/32 0.0.0.0
	:: adsmockarc.azurewebsites.net
	route -p add 191.236.16.12/32 0.0.0.0
	:: ads.msn.com
	route -p add 157.56.91.82/32 0.0.0.0
	:: auth.gfx.ms
	route -p add 23.61.72.70/32 0.0.0.0
	:: b.ads1.msn.com
	route -p add 204.160.124.125/32 0.0.0.0
	route -p add 8.253.14.126/32 0.0.0.0
	route -p add 8.254.25.126/32 0.0.0.0
	:: b.ads2.msads.net
	route -p add 93.184.215.200/32 0.0.0.0
	:: df.telemetry.microsoft.com
	route -p add 65.52.100.7/32 0.0.0.0
	:: help.bingads.microsoft.com
	route -p add 207.46.202.114/32 0.0.0.0
	:: oca.telemetry.microsoft.com
	route -p add 65.55.252.63/32 0.0.0.0
	:: oca.telemetry.microsoft.com.nsatc.net
	route -p add 65.55.252.63/32 0.0.0.0
	:: pre.footprintpredict.com
	route -p add 204.79.197.200/32 0.0.0.0
	:: reports.wes.df.telemetry.microsoft.com
	route -p add 65.52.100.91/32 0.0.0.0
	:: sb.scorecardresearch.com
	route -p add 104.79.156.195/32 0.0.0.0
	:: services.wes.df.telemetry.microsoft.com
	route -p add 65.52.100.92/32 0.0.0.0
	:: settings-win.data.microsoft.com
	route -p add 65.55.44.108/32 0.0.0.0
	:: s.gateway.messenger.live.com
	route -p add 157.56.106.210/32 0.0.0.0
	:: sgmetrics.cloudapp.net
	route -p add 168.62.11.145/32 0.0.0.0
	:: spynet2.microsoft.com
	route -p add 23.96.212.225/32 0.0.0.0
	:: spynetalt.microsoft.com
	route -p add 23.96.212.225/32 0.0.0.0
	:: sqm.df.telemetry.microsoft.com
	route -p add 65.52.100.94/32 0.0.0.0
	:: sqm.telemetry.microsoft.com
	route -p add 65.55.252.93/32 0.0.0.0
	:: sqm.telemetry.microsoft.com.nsatc.net
	route -p add 65.55.252.93/32 0.0.0.0
	:: statsfe1.ws.microsoft.com
	route -p add 134.170.115.60/32 0.0.0.0
	route -p add 207.46.114.61/32 0.0.0.0
	:: statsfe2.update.microsoft.com.akadns.net
	route -p add 65.52.108.153/32 0.0.0.0
	:: statsfe2.ws.microsoft.com
	route -p add 64.4.54.22/32 0.0.0.0
	:: storeedgefd.dsx.mp.microsoft.com // Disabled for Tron, required for the Microsoft App Store to connect
	:: route -p add 104.79.153.53/32 0.0.0.0
	:: telecommand.telemetry.microsoft.com
	route -p add 65.55.252.92/32 0.0.0.0
	:: telecommand.telemetry.microsoft.com.nsatc.net
	route -p add 65.55.252.92/32 0.0.0.0
	:: telemetry.appex.bing.net
	route -p add 168.62.187.13/32 0.0.0.0
	:: telemetry.microsoft.com
	route -p add 65.52.100.9/32 0.0.0.0
	:: telemetry.urs.microsoft.com
	route -p add 131.253.40.37/32 0.0.0.0
	:: vortex.data.microsoft.com
	route -p add 64.4.54.254/32 0.0.0.0
	:: vortex-sandbox.data.microsoft.com
	route -p add 64.4.54.32/32 0.0.0.0
	:: vortex-win.data.microsoft.com
	route -p add 64.4.54.254/32 0.0.0.0
	:: watson.live.com
	route -p add 207.46.223.94/32 0.0.0.0
	:: watson.microsoft.com
	route -p add 65.55.252.71/32 0.0.0.0
	:: watson.ppe.telemetry.microsoft.com
	route -p add 65.52.100.11/32 0.0.0.0
	:: watson.telemetry.microsoft.com
	route -p add 65.52.108.29/32 0.0.0.0
	:: watson.telemetry.microsoft.com.nsatc.net
	route -p add 65.52.108.29/32 0.0.0.0
	:: wes.df.telemetry.microsoft.com
	route -p add 65.52.100.93/32 0.0.0.0
) else (
	:: a-0001.a-msedge.net
	route -p add 204.79.197.200/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: a23-218-212-69.deploy.static.akamaitechnologies.com
	route -p add 23.218.212.69/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: a.ads1.msn.com
	route -p add 204.160.124.125/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	route -p add 8.253.14.126/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	route -p add 8.254.25.126/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: a.ads2.msads.net
	route -p add 93.184.215.200/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: a.ads2.msn.com
	route -p add 198.78.194.252/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	route -p add 198.78.209.253/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	route -p add 8.254.23.254/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: ac3.msn.com
	route -p add 131.253.14.76/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: ads1.msads.net
	route -p add 23.201.58.73/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: ads1.msn.com
	route -p add 204.160.124.125/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	route -p add 8.253.14.126/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	route -p add 8.254.25.126/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: adsmockarc.azurewebsites.net
	route -p add 191.236.16.12/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: ads.msn.com
	route -p add 157.56.91.82/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: auth.gfx.ms
	route -p add 23.61.72.70/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: b.ads1.msn.com
	route -p add 204.160.124.125/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	route -p add 8.253.14.126/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	route -p add 8.254.25.126/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: b.ads2.msads.net
	route -p add 93.184.215.200/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: df.telemetry.microsoft.com
	route -p add 65.52.100.7/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: help.bingads.microsoft.com
	route -p add 207.46.202.114/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: oca.telemetry.microsoft.com
	route -p add 65.55.252.63/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: oca.telemetry.microsoft.com.nsatc.net
	route -p add 65.55.252.63/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: pre.footprintpredict.com
	route -p add 204.79.197.200/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: reports.wes.df.telemetry.microsoft.com
	route -p add 65.52.100.91/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: sb.scorecardresearch.com
	route -p add 104.79.156.195/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: services.wes.df.telemetry.microsoft.com
	route -p add 65.52.100.92/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: settings-win.data.microsoft.com
	route -p add 65.55.44.108/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: s.gateway.messenger.live.com
	route -p add 157.56.106.210/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: sgmetrics.cloudapp.net
	route -p add 168.62.11.145/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: spynet2.microsoft.com
	route -p add 23.96.212.225/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: spynetalt.microsoft.com
	route -p add 23.96.212.225/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: sqm.df.telemetry.microsoft.com
	route -p add 65.52.100.94/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: sqm.telemetry.microsoft.com
	route -p add 65.55.252.93/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: sqm.telemetry.microsoft.com.nsatc.net
	route -p add 65.55.252.93/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: statsfe1.ws.microsoft.com
	route -p add 134.170.115.60/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	route -p add 207.46.114.61/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: statsfe2.update.microsoft.com.akadns.net
	route -p add 65.52.108.153/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: statsfe2.ws.microsoft.com
	route -p add 64.4.54.22/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: storeedgefd.dsx.mp.microsoft.com // Disabled for Tron. Required for the Microsoft App Store to connect
	:: route -p add 104.79.153.53/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: telecommand.telemetry.microsoft.com
	route -p add 65.55.252.92/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: telecommand.telemetry.microsoft.com.nsatc.net
	route -p add 65.55.252.92/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: telemetry.appex.bing.net
	route -p add 168.62.187.13/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: telemetry.microsoft.com
	route -p add 65.52.100.9/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: telemetry.urs.microsoft.com
	route -p add 131.253.40.37/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: vortex.data.microsoft.com
	route -p add 64.4.54.254/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: vortex-sandbox.data.microsoft.com
	route -p add 64.4.54.32/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: vortex-win.data.microsoft.com
	route -p add 64.4.54.254/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: watson.live.com
	route -p add 207.46.223.94/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: watson.microsoft.com
	route -p add 65.55.252.71/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: watson.ppe.telemetry.microsoft.com
	route -p add 65.52.100.11/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: watson.telemetry.microsoft.com
	route -p add 65.52.108.29/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: watson.telemetry.microsoft.com.nsatc.net
	route -p add 65.52.108.29/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
	:: wes.df.telemetry.microsoft.com
	route -p add 65.52.100.93/32 0.0.0.0 >> "%LOGPATH%\%LOGFILE%" 2>&1
)

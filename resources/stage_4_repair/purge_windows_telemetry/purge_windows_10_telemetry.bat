:: Purpose:       Purges Windows 10 telemetry
:: Requirements:  Called from Tron script ( reddit.com/r/TronScript ) in Stage 4: Repair. Can also be run directly
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
::                code heavily borrowed from:
::                  - Aegis project: https://voat.co/v/technology/comments/459263
::                  - win10-unfu**k: https://github.com/dfkt/waitin10-unfuck
::                  - ... and many other places around the web
:: Version:       1.0.1-TRON - Remove five host null-route entries that incorrectly blocked Windows Update cache servers. Thanks to /u/SirHaxalot and /u/DewArmy
::                           - Remove incorrect pushd %SystemDrive at head of script
::                           - Remove KB971033 from KB purge list; not applicable to Win10. Thanks to /u/spexdi
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
set SCRIPT_VERSION=1.0.1-TRON
set SCRIPT_UPDATED=2015-09-25


:::::::::::::
:: EXECUTE ::
:::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::
:: MISCELLANEOUS

:: Kill GWX/Skydrive/Spynet/Telemetry/waitifisense ...
taskkill /f /im gwx.exe /t >nul 2>&1
setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn setowner -ownr n:administrators >nul 2>&1
setacl.exe -on "hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager" -ot reg -actn ace -ace "n:administrators;p:full" >nul 2>&1
setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn setowner -ownr n:administrators >nul 2>&1
setacl.exe -on "hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update" -ot reg -actn ace -ace "n:administrators;p:full" >nul 2>&1
setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn setowner -ownr n:administrators >nul 2>&1
setacl.exe -on "hkey_local_machine\software\microsoft\windows defender\spynet" -ot reg -actn ace -ace "n:administrators;p:full" >nul 2>&1
setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn setowner -ownr n:administrators >nul 2>&1
setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\datacollection" -ot reg -actn ace -ace "n:administrators;p:full" >nul 2>&1
setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn setowner -ownr n:administrators >nul 2>&1
setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\gwx" -ot reg -actn ace -ace "n:administrators;p:full" >nul 2>&1
setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn setowner -ownr n:administrators >nul 2>&1
setacl.exe -on "hkey_local_machine\software\policies\microsoft\windows\skydrive" -ot reg -actn ace -ace "n:administrators;p:full" >nul 2>&1

:: Kill Adobe Flash that ships baked-in to Windows 10
:: Disabled for Tron; it seems regular Flash also stores files here
REM takeown /f "%windir%\System32\Macromed" /r /d y >nul 2>&1
REM icacls "%windir%\System32\Macromed" /grant administrators:F /t >nul 2>&1
REM rd /s /q "%windir%\System32\Macromed" >nul 2>&1
REM takeown /f "%windir%\SysWOW64\Macromed" /r /d y >nul 2>&1
REM icacls "%windir%\SysWOW64\Macromed" /grant administrators:F /t >nul 2>&1
REM rd /s /q "%windir%\SysWOW64\Macromed" >nul 2>&1
REM rd /s /q "%appdata%\Adobe" >nul 2>&1
REM rd /s /q "%appdata%\Macromedia" >nul 2>&1

:: Kill forced OneDrive integration
taskkill /f /im OneDrive.exe >nul 2>&1
%SystemRoot%\System32\OneDriveSetup.exe /uninstall >nul 2>&1
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall >nul 2>&1
:: These keys are orphaned after the OneDrive uninstallation and can be safely removed
reg Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
takeown /f "%LocalAppData%\Microsoft\OneDrive" /r /d y >nul 2>&1
icacls "%LocalAppData%\Microsoft\OneDrive" /grant administrators:F /t >nul 2>&1
rd /s /q "%LocalAppData%\Microsoft\OneDrive" >nul 2>&1
rd /s /q "%UserProfile%\OneDrive" /Q /S >nul 2>&1
rd /s /q "%ProgramData%\Microsoft OneDrive" >nul 2>&1
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>&1


::::::::::::::::::::::::::::::::::::::::::::::::::
:: UPDATES

:: Second, purge bad updates
:: 02/22 - kb 2902907 (https://support.microsoft.com/en-us/kb/2902907)
start /wait "" wusa /uninstall /kb:2902907 /norestart /quiet >nul 2>&1
:: 03/22 - kb 2922324 (https://support.microsoft.com/en-us/kb/2922324)
start /wait "" wusa /uninstall /kb:2922324 /norestart /quiet >nul 2>&1
:: 04/22 - kb 2952664 (https://support.microsoft.com/en-us/kb/2952664)
start /wait "" wusa /uninstall /kb:2952664 /norestart /quiet >nul 2>&1
:: 05/22 - kb 2976978 (https://support.microsoft.com/en-us/kb/2976978)
start /wait "" wusa /uninstall /kb:2976978 /norestart /quiet >nul 2>&1
:: 06/22 - kb 2977759 (https://support.microsoft.com/en-us/kb/2977759)
start /wait "" wusa /uninstall /kb:2977759 /norestart /quiet >nul 2>&1
:: 07/22 - kb 2990214 (https://support.microsoft.com/en-us/kb/2990214)
start /wait "" wusa /uninstall /kb:2990214 /norestart /quiet >nul 2>&1
:: 08/22 - kb 3012973 (https://support.microsoft.com/en-us/kb/3012973)
start /wait "" wusa /uninstall /kb:3012973 /norestart /quiet >nul 2>&1
:: 09/22 - kb 3014460 (https://support.microsoft.com/en-us/kb/3014460)
start /wait "" wusa /uninstall /kb:3014460 /norestart /quiet >nul 2>&1
:: 10/22 - kb 3015249 (https://support.microsoft.com/en-us/kb/3015249)
start /wait "" wusa /uninstall /kb:3015249 /norestart /quiet >nul 2>&1
:: 11/22 - kb 3021917 (https://support.microsoft.com/en-us/kb/3021917)
start /wait "" wusa /uninstall /kb:3021917 /norestart /quiet >nul 2>&1
:: 12/22 - kb 3022345 (https://support.microsoft.com/en-us/kb/3022345)
start /wait "" wusa /uninstall /kb:3022345 /norestart /quiet >nul 2>&1
:: 13/22 - kb 3035583 (https://support.microsoft.com/en-us/kb/3035583)
start /wait "" wusa /uninstall /kb:3035583 /norestart /quiet >nul 2>&1
:: 14/22 - kb 3044374 (https://support.microsoft.com/en-us/kb/3044374)
start /wait "" wusa /uninstall /kb:3044374 /norestart /quiet >nul 2>&1
:: 15/22 - kb 3050265 (https://support.microsoft.com/en-us/kb/3050265)
start /wait "" wusa /uninstall /kb:3050265 /norestart /quiet >nul 2>&1
:: 16/22 - kb 3050267 (https://support.microsoft.com/en-us/kb/3050267)
start /wait "" wusa /uninstall /kb:3050267 /norestart /quiet >nul 2>&1
:: 17/22 - kb 3065987 (https://support.microsoft.com/en-us/kb/3065987)
start /wait "" wusa /uninstall /kb:3065987 /norestart /quiet >nul 2>&1
:: 18/22 - kb 3068708 (https://support.microsoft.com/en-us/kb/3068708)
start /wait "" wusa /uninstall /kb:3068708 /norestart /quiet >nul 2>&1
:: 19/22 - kb 3075249 (https://support.microsoft.com/en-us/kb/3075249)
start /wait "" wusa /uninstall /kb:3075249 /norestart /quiet >nul 2>&1
:: 20/22 - kb 3075851 (https://support.microsoft.com/en-us/kb/3075851)
start /wait "" wusa /uninstall /kb:3075851 /norestart /quiet >nul 2>&1
:: 21/22 - kb 3075853 (https://support.microsoft.com/en-us/kb/3075853)
start /wait "" wusa /uninstall /kb:3075853 /norestart /quiet >nul 2>&1
:: 22/22 - kb 3080149 (https://support.microsoft.com/en-us/kb/3080149)
start /wait "" wusa /uninstall /kb:3080149 /norestart /quiet >nul 2>&1
echo.


::::::::::::::::::::::::::::::::::::::::::::::::::
:: SCHEDULED TASKS
schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >nul 2>&1
schtasks /delete /F /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" >nul 2>&1
schtasks /delete /F /TN "\Microsoft\Windows\Autochk\Proxy" >nul 2>&1
schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >nul 2>&1
schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >nul 2>&1
schtasks /delete /F /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >nul 2>&1
schtasks /delete /F /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >nul 2>&1
schtasks /delete /F /TN "\Microsoft\Windows\PI\Sqm-Tasks" >nul 2>&1
schtasks /delete /F /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >nul 2>&1
schtasks /delete /F /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\application experience\Microsoft compatibility appraiser" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\application experience\aitagent" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\application experience\programdataupdater" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\autochk\proxy" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\consolidator" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\kernelceiptask" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\customer experience improvement program\usbceip" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\diskdiagnostic\Microsoft-Windows-diskdiagnosticdatacollector" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\maintenance\winsat" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\activateWindowssearch" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\configureinternettimeservice" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\dispatchrecoverytasks" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\ehdrminit" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\installplayready" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\mcupdate" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\mediacenterrecoverytask" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\objectstorerecoverytask" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\ocuractivate" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\ocurdiscovery" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscovery">nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw1" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\pbdadiscoveryw2" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrrecoverytask" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\pvrscheduletask" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\registersearch" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\reindexsearchroot" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\sqlliterecoverytask" >nul 2>&1
schtasks /delete /f /tn "\Microsoft\Windows\media center\updaterecordpath" >nul 2>&1
echo.


::::::::::::::::::::::::::::::::::::::::::::::::::
:: SERVICES

:: Diagnostic Tracking
sc stop Diagtrack >nul 2>&1
sc delete Diagtrack >nul 2>&1

:: Remote Registry (disable only)
sc config remoteregistry start= disabled >nul 2>&1
sc stop remoteregistry >nul 2>&1

:: "WAP Push Message Routing Service"
sc stop dmwappushservice >nul 2>&1
sc delete dmwappushservice >nul 2>&1

:: Windows Event Collector Service (disable only)
sc stop Wecsvc >nul 2>&1
sc delete Wecsvc >nul 2>&1

:: Xbox Live services
sc stop XblAuthManager >nul 2>&1
sc stop XblGameSave >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1
sc delete XblAuthManager >nul 2>&1
sc delete XblGameSave >nul 2>&1
sc delete XboxNetApiSvc >nul 2>&1


::::::::::::::::::::::::::::::::::::::::::::::::::
:: REGISTRY ENTRIES
reg import %~dp0disable_telemetry_registry_entries.reg >nul 2>&1
reg import disable_telemetry_registry_entries.reg >nul 2>&1
regedit /S %~dp0disable_telemetry_registry_entries.reg >nul 2>&1
regedit /S disable_telemetry_registry_entries.reg >nul 2>&1


::::::::::::::::::::::::::::::::::::::::::::::::::
:: NULL ROUTE BAD HOSTS ...

:: Run this command to flush ALL routes IMMEDIATELY (you'll need to reboot or do an ipconfig /release & ipconfig /renew to get a new default route)
::route -f

:: Run this commend to clear persistent routes only, takes effect at reboot. This will undo all the below changes
::reg delete HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\PersistentRoutes /va /f

:: a-0001.a-msedge.net
route -p add 204.79.197.200/32 0.0.0.0 >nul 2>&1
:: a23-218-212-69.deploy.static.akamaitechnologies.com
route -p add 23.218.212.69/32 0.0.0.0 >nul 2>&1
:: a.ads1.msn.com
route -p add 204.160.124.125/32 0.0.0.0 >nul 2>&1
route -p add 8.253.14.126/32 0.0.0.0 >nul 2>&1
route -p add 8.254.25.126/32 0.0.0.0 >nul 2>&1
:: a.ads2.msads.net
route -p add 93.184.215.200/32 0.0.0.0 >nul 2>&1
:: a.ads2.msn.com
route -p add 198.78.194.252/32 0.0.0.0 >nul 2>&1
route -p add 198.78.209.253/32 0.0.0.0 >nul 2>&1
route -p add 8.254.23.254/32 0.0.0.0 >nul 2>&1
:: ac3.msn.com
route -p add 131.253.14.76/32 0.0.0.0 >nul 2>&1
:: ads1.msads.net
route -p add 23.201.58.73/32 0.0.0.0 >nul 2>&1
:: ads1.msn.com
route -p add 204.160.124.125/32 0.0.0.0 >nul 2>&1
route -p add 8.253.14.126/32 0.0.0.0 >nul 2>&1
route -p add 8.254.25.126/32 0.0.0.0 >nul 2>&1
:: adsmockarc.azurewebsites.net
route -p add 191.236.16.12/32 0.0.0.0 >nul 2>&1
:: ads.msn.com
route -p add 157.56.91.82/32 0.0.0.0 >nul 2>&1
:: auth.gfx.ms
route -p add 23.61.72.70/32 0.0.0.0 >nul 2>&1
:: b.ads1.msn.com
route -p add 204.160.124.125/32 0.0.0.0 >nul 2>&1
route -p add 8.253.14.126/32 0.0.0.0 >nul 2>&1
route -p add 8.254.25.126/32 0.0.0.0 >nul 2>&1
:: b.ads2.msads.net
route -p add 93.184.215.200/32 0.0.0.0 >nul 2>&1
:: df.telemetry.microsoft.com
route -p add 65.52.100.7/32 0.0.0.0 >nul 2>&1
:: help.bingads.microsoft.com
route -p add 207.46.202.114/32 0.0.0.0 >nul 2>&1
:: oca.telemetry.microsoft.com
route -p add 65.55.252.63/32 0.0.0.0 >nul 2>&1
:: oca.telemetry.microsoft.com.nsatc.net
route -p add 65.55.252.63/32 0.0.0.0 >nul 2>&1
:: pre.footprintpredict.com
route -p add 204.79.197.200/32 0.0.0.0 >nul 2>&1
:: reports.wes.df.telemetry.microsoft.com
route -p add 65.52.100.91/32 0.0.0.0 >nul 2>&1
:: sb.scorecardresearch.com
route -p add 104.79.156.195/32 0.0.0.0 >nul 2>&1
:: services.wes.df.telemetry.microsoft.com
route -p add 65.52.100.92/32 0.0.0.0 >nul 2>&1
:: settings-win.data.microsoft.com
route -p add 65.55.44.108/32 0.0.0.0 >nul 2>&1
:: s.gateway.messenger.live.com
route -p add 157.56.106.210/32 0.0.0.0 >nul 2>&1
:: sgmetrics.cloudapp.net
route -p add 168.62.11.145/32 0.0.0.0 >nul 2>&1
:: spynet2.microsoft.com
route -p add 23.96.212.225/32 0.0.0.0 >nul 2>&1
:: spynetalt.microsoft.com
route -p add 23.96.212.225/32 0.0.0.0 >nul 2>&1
:: sqm.df.telemetry.microsoft.com
route -p add 65.52.100.94/32 0.0.0.0 >nul 2>&1
:: sqm.telemetry.microsoft.com
route -p add 65.55.252.93/32 0.0.0.0 >nul 2>&1
:: sqm.telemetry.microsoft.com.nsatc.net
route -p add 65.55.252.93/32 0.0.0.0 >nul 2>&1
:: statsfe1.ws.microsoft.com
route -p add 134.170.115.60/32 0.0.0.0 >nul 2>&1
route -p add 207.46.114.61/32 0.0.0.0 >nul 2>&1
:: statsfe2.update.microsoft.com.akadns.net
route -p add 65.52.108.153/32 0.0.0.0 >nul 2>&1
:: statsfe2.ws.microsoft.com
route -p add 64.4.54.22/32 0.0.0.0 >nul 2>&1
:: storeedgefd.dsx.mp.microsoft.com
route -p add 104.79.153.53/32 0.0.0.0 >nul 2>&1
:: telecommand.telemetry.microsoft.com
route -p add 65.55.252.92/32 0.0.0.0 >nul 2>&1
:: telecommand.telemetry.microsoft.com.nsatc.net
route -p add 65.55.252.92/32 0.0.0.0 >nul 2>&1
:: telemetry.appex.bing.net
route -p add 168.62.187.13/32 0.0.0.0 >nul 2>&1
:: telemetry.microsoft.com
route -p add 65.52.100.9/32 0.0.0.0 >nul 2>&1
:: telemetry.urs.microsoft.com
route -p add 131.253.40.37/32 0.0.0.0 >nul 2>&1
:: vortex.data.microsoft.com
route -p add 64.4.54.254/32 0.0.0.0 >nul 2>&1
:: vortex-sandbox.data.microsoft.com
route -p add 64.4.54.32/32 0.0.0.0 >nul 2>&1
:: vortex-win.data.microsoft.com
route -p add 64.4.54.254/32 0.0.0.0 >nul 2>&1
:: watson.live.com
route -p add 207.46.223.94/32 0.0.0.0 >nul 2>&1
:: watson.microsoft.com
route -p add 65.55.252.71/32 0.0.0.0 >nul 2>&1
:: watson.ppe.telemetry.microsoft.com
route -p add 65.52.100.11/32 0.0.0.0 >nul 2>&1
:: watson.telemetry.microsoft.com
route -p add 65.52.108.29/32 0.0.0.0 >nul 2>&1
:: watson.telemetry.microsoft.com.nsatc.net
route -p add 65.52.108.29/32 0.0.0.0 >nul 2>&1
:: wes.df.telemetry.microsoft.com
route -p add 65.52.100.93/32 0.0.0.0 >nul 2>&1

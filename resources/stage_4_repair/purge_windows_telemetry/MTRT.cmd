@ECHO OFF
:::::::::::::::
:: VARIABLES :: -------------- These are the defaults. Change them if you so desire. --------- ::
:::::::::::::::

:: Log File Name
SET "MTRT_LOGFILE=MTRT_Log.log"

:: Setting to either 'Disable' or 'Delete' the questionable Scheduled Tasks
:: You can review and change what gets affected by editing the SchedTasks.ini file
SET "TASKMODE=Disable"

:: Windows upgrade temp folders, will be cleaned and locked down
:: DEFAULT: "WINTEMP=$Windows.~BT,$Windows.~WS,Windows.old"
SET "WINTEMP=$Windows.~BT,$Windows.~WS,Windows.old"

:: MTRT scripts folder. Leave entry blank if you put everything in the same folder.
:: DEFAULT: "SCRIPTS=data"
SET "SCRIPTS=data"

:: Pull log path from command switch if invoked from TRON (Ex: MTRT.cmd "C:\Logs\tron\RAW_LOGS")
:: You can edit this manually, but it will will no longer save in the RAW_LOGS folder that Tron defines
:: DEFAULT: "MTRT_LOGPATH=%~1"
set "MTRT_LOGPATH=%~1"

:: Dry Run (Run through script, but don't execute any jobs)
:: Can be paired with Command Logging to generate a log of what commands will run on your system.
SET "DRY_RUN=NO"

:: Command Logging: Logs command and it's output to log file *WARNING* May generate large log file!
:: Can be paired with Dry Run to skip command execution
:: SETTINGS: YES or NO
SET "COMMAND_LOGGING=NO"



:: --------------------------- Don't edit anything below this line --------------------------- ::

:: GET ADMIN RIGHTS
(NET FILE||(powershell -NoProfile -ExecutionPolicy Bypass -command Start-Process '%0' -Verb runAs -ArgumentList '%* '&EXIT /B))>NUL 2>&1

SETLOCAL ENABLEDELAYEDEXPANSION

:: MTRT Version number
SET "SCRIPT_VERSION=2.2"

:: If no switch passed, set MTRT help dir as log destination
IF "%MTRT_LOGPATH%"=="" (
	set "MTRT_LOGPATH=%~dp0help"
)

:: Set scripts path
IF NOT DEFINED SCRIPTS (
		SET "DATA=%~dp0"
	) ELSE (
		SET "DATA=%~Dp0%SCRIPTS%"
)

:: Configure Command Logging
IF /I "%COMMAND_LOGGING%"=="NO" (
		SET "VERBOSE=>NUL 2>&1"
	) ELSE (
		SET "VERBOSE=>>"%MTRT_LOGPATH%\%MTRT_LOGFILE%" 2>&1"
)

:: Set date and time for logging
FOR /F %%a IN ('WMIC OS GET LocalDateTime ^| find "."') DO SET DTS=%%a
SET CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%

:: Determine OS
FOR /F "tokens=3*" %%I IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ProductName ^| Find "ProductName"') DO (SET WIN_VER=%%I %%J)

:: Settings for Reg.ini and KB.ini file
IF /I "%WIN_VER:~0,9%"=="Windows 7" (set "TOKENS=1,4,5,6,7" & GOTO END_VER_CHECK)
IF /I "%WIN_VER:~0,9%"=="Windows 8" (set "TOKENS=2,4,5,6,7" & GOTO END_VER_CHECK)
IF /I "%WIN_VER:~0,9%"=="Windows 1" (set "TOKENS=3,4,5,6,7" & GOTO END_VER_CHECK)
GOTO FAIL
:END_VER_CHECK
:: Get User SID
FOR /F "delims= " %%A IN ('"wmic path win32_useraccount where name='%UserName%' get sid"') DO (
   IF /I NOT "%%A"=="SID" (          
      SET SID=%%A
      GOTO :END_SID_LOOP
   )
)
:END_SID_LOOP




:START
CD /D "%DATA%"
ECHO: >> "%MTRT_LOGPATH%\%MTRT_LOGFILE%"
ECHO: >> "%MTRT_LOGPATH%\%MTRT_LOGFILE%"
ECHO: >> "%MTRT_LOGPATH%\%MTRT_LOGFILE%"
CALL :LOGTXT "  Start MTRT - MS Telemetry Removal %SCRIPT_VERSION%"
CALL :LOGTXT "   Logging to: %MTRT_LOGPATH%\%MTRT_LOGFILE%"

CALL :LOGTXT "   TaskKilling Gwx / OneDrive"
CALL :LOGCMD TASKKILL /F /IM Gwx.exe /T
CALL :LOGCMD TASKKILL /F /IM OneDrive.exe /T

CALL :LOGTXT "   Disable Remote Registry"
CALL :LOGCMD SC STOP RemoteRegistry
CALL :LOGCMD SC CONFIG RemoteRegistry START= disabled

CALL :LOGTXT "   Setting registry permissions"
REM Take ownership of registry folders as defined in reg.ini file
REM There will be a ton of errors here, as it will try to set permissions to many folders that don't exist
FOR /F "eol=# tokens=%TOKENS% delims=	|" %%A IN (Reg.ini) DO (
	IF /I "%%A"=="Y" (
		CALL :LOGCMD setacl.exe -ON "%%B" -OT REG -ACTN SETOWNER -OWNR "N:ADMINISTRATORS"
		CALL :LOGCMD setacl.exe -ON "%%B" -OT REG -ACTN ACE -ACE "N:ADMINISTRATORS;P:FULL"
	)
)

CALL :LOGTXT "   Disable scheduled telemtry tasks"
FOR /F "eol=# tokens=1* delims=$" %%D IN (SchedTasks.ini) DO (CALL :LOGCMD schtasks /Change /%TASKMODE% /TN "%%D")

CALL :LOGTXT "   Disable Windows Event Collector Service"
CALL :LOGCMD SC STOP Wecsvc
CALL :LOGCMD SC CONFIG Wecsvc START= disabled

CALL :LOGTXT "   Disable Windows Error Reporting Service"
CALL :LOGCMD SC STOP WerSvc
CALL :LOGCMD SC CONFIG WerSvc START= disabled

CALL :LOGTXT "   Delete Diagnostic Tracking Service"
CALL :LOGCMD SC STOP DiagTrack
CALL :LOGCMD SC DELETE DiagTrack
:: Clear or create log file, then lock it down
IF EXIST "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" (
		CD /D "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger"
		CALL :LOGCMD TAKEOWN /F AutoLogger-Diagtrack-Listener.etl
		CALL :LOGCMD ICACLS AutoLogger-Diagtrack-Listener.etl /GRANT ADMINISTRATORS:F /Q
		CALL :LOGCMD BREAK>AutoLogger-Diagtrack-Listener.etl
		CALL :LOGCMD ICACLS AutoLogger-Diagtrack-Listener.etl /DENY SYSTEM:F /Q
	) ELSE (
		CALL :LOGCMD MKDIR "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger"
		CALL :LOGCMD CD /D "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger"
		CALL :LOGCMD COPY /Y NUL AutoLogger-Diagtrack-Listener.etl
		CALL :LOGCMD ICACLS AutoLogger-Diagtrack-Listener.etl /DENY SYSTEM:F /Q
)
CALL :LOGCMD REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "{60E6D465-398E-4850-BE86-7EF7620A2377}" /t REG_SZ /d "v2.24|Action=Block|Active=TRUE|Dir=Out|App=C:\windows\system32\svchost.exe|Svc=DiagTrack|Name=Windows Telemetry|" /f
CD /D "%DATA%"

:: Start Window 10 Only
IF /I NOT "%WIN_VER:~0,9%"=="Windows 1" (GOTO :SKIP_10_TWEAKS)

CALL :LOGTXT "   Kill OneDrive integration"
CALL :LOGCMD TASKKILL /F /IM  Explorer.exe
CALL :LOGCMD TIMEOUT 5
CALL :LOGCMD %SystemRoot%\System32\OneDriveSetup.exe /Uninstall
CALL :LOGCMD %SystemRoot%\SysWOW64\OneDriveSetup.exe /Uninstall
:: These keys are orphaned after the OneDrive uninstallation and can be safely removed
CALL :LOGCMD REG DELETE "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F
CALL :LOGCMD REG DELETE "HKCR%Wow6432Node%\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F
CD /D "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
CALL :LOGCMD DEL "OneDrive.lnk" /F /S /Q
FOR %%D IN ("%LOCALAPPDATA%\Microsoft\OneDrive","%USERPROFILE%\OneDrive","%PROGRAMDATA%\Microsoft OneDrive","%SYSTEMDRIVE%\OneDriveTemp") DO (
	CALL :LOGCMD TAKEOWN /F %%D /A /R /D Y
	CALL :LOGCMD ICACLS %%D /GRANT ADMINISTRATORS:F /T /Q
	CALL :LOGCMD DEL %%D /F /S /Q
	CALL :LOGCMD RMDIR %%D /S /Q
)
CD /D "%WINDIR%\WinSxS"
FOR /D %%O IN (*onedrive*) DO (
	CALL :LOGCMD TAKEOWN /F %%O /A /R /D Y
	CALL :LOGCMD ICACLS %%O /GRANT ADMINISTRATORS:F /T /Q
	CALL :LOGCMD DEL %%O /F /S /Q
	CALL :LOGCMD RMDIR %%O /S /Q
)
CALL :LOGCMD TIMEOUT 5
CALL :LOGCMD START Explorer.exe
CD /D "%DATA%"

CALL :LOGTXT "   Delete WAP Push Message Routing Service"
CALL :LOGCMD SC STOP dmwappushservice
CALL :LOGCMD SC DELETE dmwappushservice


CALL :LOGTXT "   Delete RetailDemo Service"
CALL :LOGCMD SC STOP RetailDemo
CALL :LOGCMD SC DELETE RetailDemo

CALL :LOGTXT "   Delete Xbox Live Services"
CALL :LOGCMD SC STOP XblAuthManager
CALL :LOGCMD SC STOP XblGameSave
CALL :LOGCMD SC STOP XboxNetApiSvc
CALL :LOGCMD SC DELETE XblAuthManager
CALL :LOGCMD SC DELETE XblGameSave
CALL :LOGCMD SC DELETE XboxNetApiSvc

:: Overly redundant keys, as we disable Wifi Sense is the main tweaks, this is just another layer
:: 893- All enabled		828- All disabled
CALL :LOGCMD REG ADD "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%SID%" /T REG_DWORD /V FeatureStates /D 828 /F
CALL :LOGCMD REG ADD "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%SID%\SocialNetworks\ABCH" /T REG_DWORD /V OptInStatus /D 0 /F
CALL :LOGCMD REG ADD "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%SID%\SocialNetworks\ABCH-SKYPE" /T REG_DWORD /V OptInStatus /D 0 /F
CALL :LOGCMD REG ADD "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%SID%\SocialNetworks\FACEBOOK" /T REG_DWORD /V OptInStatus /D 0 /F

:SKIP_10_TWEAKS



CALL :LOGTXT "   Adding registry tweaks"
CD /D "%DATA%"
FOR /F "eol=# tokens=%TOKENS% delims=	:" %%A IN (Reg.ini) DO (
	IF /I %%A==Y (
		CALL :LOGCMD REG ADD "%%B" /T %%E /V %%C /D %%D /F
	)
)


IF /I "%WIN_VER:~0,9%"=="Windows 1" (GOTO :SKIPHOSTS)
CALL :LOGTXT "   Blocking PersistentRoutes"
:: Parse PersistentRoutes.ini, skip any line starting with ; and route to 0.0.0.0
FOR /F "eol=# tokens=1*" %%E in (PersistentRoutes.ini) DO (CALL :LOGCMD route -p add %%E 0.0.0.0)


CALL :LOGTXT "   Backing up HOSTS file and applying tweaks"
:: Configure HOSTS permissions and make backup
CD /D "%WINDIR%\System32\drivers\etc"
CALL :LOGCMD TAKEOWN /F hosts
CALL :LOGCMD ICACLS hosts /GRANT ADMINISTRATORS:F /Q
IF EXIST %WINDIR%\System32\drivers\etc\hosts*.* (CALL :LOGCMD ATTRIB +A -H -R -S %WINDIR%\System32\drivers\etc\hosts*.*)
IF EXIST %WINDIR%\System32\drivers\etc\hosts (CALL :LOGCMD COPY %WINDIR%\System32\drivers\etc\hosts "HOSTS_%CUR_DATE%.BAK" /Y)
CALL :LOGTXT "    - File HOSTS_%CUR_DATE%.BAK created."
CALL :LOGCMD ECHO. >>%WINDIR%\System32\Drivers\etc\hosts
CD /D "%DATA%"
:: Finding and adding missing HOSTS entries as defined by hosts.ini
FOR /F "eol=# tokens=1 delims=	 " %%F IN (hosts.ini) DO (CALL :SCANHOSTS "%%F")
GOTO :SKIPHOSTS
:SCANHOSTS
	FIND "0.0.0.0 %~1 #" %WINDIR%\System32\Drivers\etc\hosts >NUL 2>&1
	IF !ERRORLEVEL!==1 (
		CALL :LOGTXT "    - Add Host: %~1"
		ECHO 0.0.0.0 %~1 # >> %WINDIR%\System32\Drivers\etc\hosts
	)
	EXIT /B	
:SKIPHOSTS

IF NOT DEFINED TOKENS (CALL :LOGTXT "     - ERROR! Skipping.") && (GOTO :SKIPKBREMOVAL)
IF /I "%WIN_VER:~0,9%"=="Windows 1" (GOTO :SKIPKBREMOVAL)
CALL :LOGTXT "   Searching and Uninstalling KB updates:"
FOR /F "skip=5 eol=# tokens=%TOKENS% delims=	|" %%A IN (KB.ini) DO (
	IF /I %%A==Y (
		TITLE Searching for KB%%B
		CALL :LOGCMD WUSA /UNINSTALL /KB:%%B /NORESTART /QUIET
		IF !ERRORLEVEL!==3010 (CALL :LOGTXT "     - KB%%B uninstalled")
		IF !ERRORLEVEL!==2359303 (CALL :LOGTXT "     - KB%%B not found")
	)
)
:SKIPKBREMOVAL


REM Clean up the temp folders
CALL :LOGCMD NET STOP wuauserv
FOR %%G IN (%WINTEMP:,= %) DO (
	CALL :LOGTXT "   Cleaning and locking %%G folder"
	IF EXIST "%SYSTEMDRIVE%\%%G" (
		CALL :LOGCMD TAKEOWN /F "%SYSTEMDRIVE%\%%G" /A /R /D Y
		CALL :LOGCMD ICACLS "%SYSTEMDRIVE%\%%G" /GRANT ADMINISTRATORS:F /T /Q
		CALL :LOGCMD DEL "%SYSTEMDRIVE%\%%G" /F /S /Q
		CALL :LOGCMD RMDIR "%SYSTEMDRIVE%\%%G" /S /Q
		)
	CALL :LOGCMD MKDIR "%SYSTEMDRIVE%\%%G"
	CALL :LOGCMD ATTRIB +R +S +H +I "%SYSTEMDRIVE%\%%G"
	CALL :LOGCMD ICACLS "%SYSTEMDRIVE%\%%G" /INHERITANCE:R /DENY SYSTEM:F /DENY ADMINISTRATORS:F
)
CALL :LOGCMD NET START wuauserv


IF /I "%WIN_VER:~0,9%"=="Windows 1" (GOTO :SKIPHIDEUPDATES)
CALL :LOGTXT "   Hiding Updates (VERY SLOW, last step though)"
CD /D "%DATA%"
FOR /F "skip=5 eol=# tokens=%TOKENS% delims=	|" %%A IN (KB.ini) DO (
	IF /I %%A==Y (	
		SET KB=!KB! %%B
	)
)

CALL :LOGTXT "     - Press CTRL_C to skip if pressed for time"
CALL :LOGCMD CSCRIPT //NOLOGO HideWindowsUpdates.vbs%KB% "%MTRT_LOGPATH%\%MTRT_LOGFILE%"
:SKIPHIDEUPDATES


:COMPLETE
CALL :LOGTXT "   All done! You should restart your PC now."
ECHO   
TIMEOUT 6
GOTO :EOF
:FAIL
TITLE MTRT - ERROR
ECHO.
ECHO   
ECHO   Error, OS not recognized or not Admin!
ECHO    - This tool is to be run on Windows 7, 8, or 10
ECHO    - Please Right-Click on this file and choose "Run as Administrator" 
TIMEOUT 6
GOTO :EOF
:LOGCMD
IF /I "%COMMAND_LOGGING%"=="YES" (
		ECHO:%CUR_DATE% %TIME%      ^> %* >>"%MTRT_LOGPATH%\%MTRT_LOGFILE%"
		IF /I "%DRY_RUN%"=="YES" EXIT /B
		%* >>"%MTRT_LOGPATH%\%MTRT_LOGFILE%" 2>&1
	) ELSE (
		IF /I "%DRY_RUN%"=="YES" EXIT /B
		%* >NUL 2>&1
)
EXIT /B
:LOGTXT
ECHO:%CUR_DATE% %TIME%  %~1 >>"%MTRT_LOGPATH%\%MTRT_LOGFILE%"
ECHO:%CUR_DATE% %TIME%  %~1
EXIT /B
:EOF
ENDLOCAL
EXIT /B
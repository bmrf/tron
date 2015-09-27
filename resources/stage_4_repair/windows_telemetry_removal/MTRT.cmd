:: Title:         Microsoft Telemetry Removal Tool - MTRT
:: Purpose:       Purges Windows 7/8/8/1/10 telemetry
:: Requirements:  Called from Tron script ( reddit.com/r/TronScript ) in Stage 4: Repair. Can also be run directly
:: Author:        reddit.com/user/spexdi
::                code heavily borrowed from:
::                  - Aegis project: https://Voat.co/V/Technology/comments/459263
::                  - win10-unfu**k: https://github.com/Dfkt/waitin10-unfuck
::                  - Spybot Anti-Beacon: http://forums.spybot.info/showthread.php?72686
::                  - Current list of bad KB updates: http://techne.alaya.net/?p=12499
::                  - blockwindows: https://blockwindows.wordpress.com
::                  - Debloat-Windows-10: https://github.com/W4RH4WK/Debloat-Windows-10
::                  - ... and many other places around the web
:: Version:       1.0.2-TRON - 1.0.1-TRON merged with Spexdi's MTRT (reddit.com/r/computertechs/comments/3kn4cf)
:: Version:       1.0.1-TRON - Remove five host null-route entries that incorrectly blocked Windows Update cache servers. Thanks to /u/SirHaxalot and /u/DewArmy
::                           - Remove incorrect pushd %SystemDrive at head of script
::                1.0.0-TRON + Initial write
@ECHO OFF
CD /D "%~DP0"
SETLOCAL ENABLEDELAYEDEXPANSION


:::::::::::::::
:: VARIABLES :: -------------- These are the defaults. Change them if you so desire. --------- ::
:::::::::::::::

:: Log File Name
SET "MTRT_LOGFILE=MTRT_Log.log"

REM Pull log path from command switch if invoked from TRON (Ex: MTRT.cmd "C:\Temp Files")
REM  Do not Edit!
set "MTRT_LOGPATH=%~1"

REM Setting to either 'Disable' or 'Delete' the questionable Scheduled Tasks
REM You can review and change what gets affected by editing the SchedTasks.ini file
SET TASKMODE=Disable

:: If no switch, set root MTRT dir as log destination
IF "%MTRT_LOGPATH%"=="" (
	set "MTRT_LOGPATH=%~dp0"
)
:: --------------------------- Don't edit anything below this line --------------------------- ::
REM Check Admin
BCDEDIT >NUL 2>&1
IF ERRORLEVEL 1 GOTO FAIL

FOR /F %%a IN ('WMIC OS GET LocalDateTime ^| find "."') DO SET DTS=%%a
SET CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%

SET SCRIPT_VERSION=1.0.2-TRON
SET SCRIPT_UPDATED=2015-09-26

REM Determine OS
FOR /F "tokens=3*" %%I IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ProductName ^| Find "ProductName"') DO (SET WIN_VER=%%I %%J)

REM Settings for KB.ini file
IF /I "%WIN_VER:~0,9%"=="Windows 7" (set "kb_tokens=1,4")
IF /I "%WIN_VER:~0,9%"=="Windows 8" (set "kb_tokens=2,4")
IF /I "%WIN_VER:~0,9%"=="Windows 1" (set "kb_tokens=3,4")
REM Settings for Reg.ini file
IF /I "%WIN_VER:~0,9%"=="Windows 7" (set "REG_TOKENS=1,4,5,6,7")
IF /I "%WIN_VER:~0,9%"=="Windows 8" (set "REG_TOKENS=2,4,5,6,7")
IF /I "%WIN_VER:~0,9%"=="Windows 1" (set "REG_TOKENS=3,4,5,6,7")

REM Get User SID
FOR /F "delims= " %%A IN ('"wmic path win32_useraccount where name='%UserName%' get sid"') DO (
   IF /I NOT "%%A"=="SID" (          
      SET SID=%%A
      goto :END_SID_LOOP
   )
)
:END_SID_LOOP



:START
ECHO: >> "%MTRT_LOGPATH%\%MTRT_LOGFILE%"
ECHO: >> "%MTRT_LOGPATH%\%MTRT_LOGFILE%"
ECHO: >> "%MTRT_LOGPATH%\%MTRT_LOGFILE%"
CALL :LOG "   Killing Gwx / OneDrive"
TASKKILL /F /IM Gwx.exe /T >NUL 2>&1
TASKKILL /F /IM OneDrive.exe /T >NUL 2>&1

CALL :LOG "   Setting registry permissions"
REM Take ownership of registry folders as defined in reg.ini file
FOR /F "eol=# tokens=%REG_TOKENS% delims=	|" %%A IN (Reg.ini) DO (
	IF /I %%A==Y (
		setacl.exe -ON "%%B" -OT REG -ACTN SETOWNER -OWNR N:ADMINISTRATORS >NUL 2>&1
		setacl.exe -ON "%%B" -OT REG -ACTN ACE -ACE "N:ADMINISTRATORS;P:FULL" >NUL 2>&1
	)
)

CALL :LOG "   Disable scheduled telemtry tasks"
FOR /F "eol=# tokens=1* delims=$" %%D IN (SchedTasks.ini) DO schtasks /Change /Disable /TN "%%D" >NUL 2>&1

CALL :LOG "   Disable Remote Registry"
SC STOP RemoteRegistry >NUL 2>&1
SC CONFIG RemoteRegistry START= disabled >NUL 2>&1

CALL :LOG "   Disable Windows Event Collector Service"
SC STOP Wecsvc >NUL 2>&1
SC CONFIG Wecsvc START= disabled >NUL 2>&1

CALL :LOG "   Delete Diagnostic Tracking Service"
SC STOP DiagTrack >NUL 2>&1
SC DELETE DiagTrack >NUL 2>&1
REM Clear or create log file, then lock it down
IF EXIST "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" (
		CD /D "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger"
		TAKEOWN /F AutoLogger-Diagtrack-Listener.etl >NUL 2>&1
		ICACLS AutoLogger-Diagtrack-Listener.etl /GRANT ADMINISTRATORS:F /Q >NUL 2>&1
		BREAK>AutoLogger-Diagtrack-Listener.etl
		ICACLS AutoLogger-Diagtrack-Listener.etl /DENY SYSTEM:F /Q >NUL 2>&1
	) ELSE (
		MKDIR "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger" >NUL 2>&1
		CD /D "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger"
		COPY /Y NUL AutoLogger-Diagtrack-Listener.etl >NUL 2>&1
		ICACLS AutoLogger-Diagtrack-Listener.etl /DENY SYSTEM:F /Q >NUL 2>&1
)
CD /D "%~DP0"

:: Start Window 10 Only
IF /I NOT "%WIN_VER:~0,9%"=="Windows 1" (GOTO SKIP_10_TWEAKS)
:: Disabled for Tron; it seems regular Flash also stores files here
REM CALL :LOG "   Kill Adobe Flash that ships with Windows 10"
REM RD /S /Q "%APPDATA%\Adobe" >NUL 2>&1
REM RD /S /Q "%APPDATA%\Macromedia" >NUL 2>&1
REM TAKEOWN /F "%WINDIR%\System32\Macromed" /A /R /D Y >NUL 2>&1
REM ICACLS "%WINDIR%\System32\Macromed" /GRANT ADMINISTRATORS:F /T /Q >NUL 2>&1
REM RD /S /Q "%WINDIR%\System32\Macromed" >NUL 2>&1
REM TAKEOWN /F "%WINDIR%\SysWOW64\Macromed" /A /R /D Y >NUL 2>&1
REM ICACLS "%WINDIR%\SysWOW64\Macromed" /GRANT ADMINISTRATORS:F /T /Q >NUL 2>&1
REM RD /S /Q "%WINDIR%\SysWOW64\Macromed" >NUL 2>&1

CALL :LOG "   Kill OneDrive integration"
REM TASKKILL /F /IM  Explorer.exe /T >NUL 2>&1
%SystemRoot%\System32\OneDriveSetup.exe /Uninstall >NUL 2>&1
%SystemRoot%\SysWOW64\OneDriveSetup.exe /Uninstall >NUL 2>&1
:: These keys are orphaned after the OneDrive uninstallation and can be safely removed
REG DELETE "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG DELETE "HKCR%Wow6432Node%\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
CD /D "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
DEL "OneDrive.lnk" /F /S /Q >NUL 2>&1
FOR %%D IN ("%LOCALAPPDATA%\Microsoft\OneDrive","%USERPROFILE%\OneDrive","%PROGRAMDATA%\Microsoft OneDrive","%SYSTEMDRIVE%\OneDriveTemp") DO (
	TAKEOWN /F %%D /A /R /D Y >NUL 2>&1
	ICACLS %%D /GRANT ADMINISTRATORS:F /T /Q >NUL 2>&1
	DEL %%D /F /S /Q >NUL 2>&1
	RMDIR %%D /S /Q >NUL 2>&1
)
CD /D "%WINDIR%\WinSxS"
FOR /D %%O IN (*onedrive*) DO (
	TAKEOWN /F %%O /A /R /D Y >NUL 2>&1
	ICACLS %%O /GRANT ADMINISTRATORS:F /T /Q >NUL 2>&1
	DEL %%O /F /S /Q >NUL 2>&1
	RMDIR %%O /S /Q >NUL 2>&1
)
CD /D "%~DP0"

CALL :LOG "   Disable geolocation "
SC STOP lfsvc  >NUL 2>&1
SC CONFIG lfsvc START= disabled >NUL 2>&1

CALL :LOG "   Delete WAP Push Message Routing Service"
SC STOP dmwappushservice >NUL 2>&1
SC DELETE dmwappushservice >NUL 2>&1

CALL :LOG "   Delete Xbox Live services"
SC STOP XblAuthManager >NUL 2>&1
SC STOP XblGameSave >NUL 2>&1
SC STOP XboxNetApiSvc >NUL 2>&1
SC DELETE XblAuthManager >NUL 2>&1
SC DELETE XblGameSave >NUL 2>&1
SC DELETE XboxNetApiSvc >NUL 2>&1

REG ADD "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\features\%SID%" /T REG_DWORD /V FeatureStates /D 0x33c /F >NUL 2>&1

:SKIP_10_TWEAKS


IF /I NOT "%WIN_VER:~0,9%"=="Windows 7" (
Set-WindowsSearchSetting -EnableWebResultsSetting $False -SafeSearchSetting "Off" -SearchExperienceSetting "NotPersonalized" >NUL 2>&1
)


CALL :LOG "   Adding registry tweaks"
FOR /F "eol=# tokens=%REG_TOKENS% delims=	|" %%A IN (Reg.ini) DO (
	IF /I %%A==Y (
		REG ADD "%%B" /T %%E /V %%C /D %%D /F >NUL 2>&1
	)
)


CALL :LOG "   Blocking PersistentRoutes"
REM Parse PersistentRoutes.ini, skip any line starting with ; and route to 0.0.0.0
 FOR /F "eol=# tokens=1*" %%E in (PersistentRoutes.ini) do route -p add %%E 0.0.0.0 >NUL 2>&1


CALL :LOG "   Backing up HOSTS file and applying tweaks"
REM Configure HOSTS permissions and make backup
CD /D "%WINDIR%\System32\drivers\etc"
TAKEOWN /F hosts >NUL 2>&1
ICACLS hosts /GRANT ADMINISTRATORS:F /Q >NUL 2>&1
IF EXIST %WINDIR%\System32\drivers\etc\hosts*.* ATTRIB +A -H -R -S %WINDIR%\System32\drivers\etc\hosts*.* >NUL 2>&1
IF EXIST %WINDIR%\System32\drivers\etc\hosts (COPY %WINDIR%\System32\drivers\etc\hosts "HOSTS_%CUR_DATE%_%TIME%.BAK" /Y) >NUL 2>&1
CALL :LOG "     - File HOSTS_%CUR_DATE%_%TIME%.BAK created."
ECHO. >>%WINDIR%\System32\Drivers\etc\hosts
CD /D "%~DP0"
REM Finding and adding missing HOSTS entries as defined by hosts.ini
FOR /F "eol=# tokens=1* delims=" %%F IN (hosts.ini) DO CALL :SCANHOSTS "%%F"
GOTO SKIPHOSTS
:SCANHOSTS
	FIND "0.0.0.0 %~1 #" %WINDIR%\System32\Drivers\etc\hosts >NUL 2>&1
	IF %ERRORLEVEL%==1 (ECHO 0.0.0.0 %~1 #>> %WINDIR%\System32\Drivers\etc\hosts)	
	EXIT /B	
:SKIPHOSTS


IF NOT DEFINED KB_TOKENS (CALL :LOG "     - ERROR! Skipping.") && (GOTO SKIPKBREMOVAL)
CALL :LOG "   Searching and Uninstalling KB updates:"
FOR /F "skip=5 eol=# tokens=%kb_tokens% delims=	|" %%A IN (KB.ini) DO (
	IF /I %%A==Y (
		SET KBNUM=%%B
		TITLE Searching for "KB%%B"
		WUSA /UNINSTALL /KB:%%B /NORESTART /QUIET >NUL 2>&1
		IF !ERRORLEVEL!==3010 (CALL :LOG "     - KB!KBNUM!Uninstalled")
		IF !ERRORLEVEL!==2359303 (ECHO:%CUR_DATE% %TIME%      - KB!KBNUM!not found. >> "%MTRT_LOGPATH%\%MTRT_LOGFILE%")
	)
)
:SKIPKBREMOVAL


REM Clean up the following folders
SET WINTEMP=$Windows.~BT,$Windows.~WS,Windows.old
NET STOP wuauserv >NUL 2>&1
FOR %%G IN (%WINTEMP:,= %) DO (
	CALL :LOG "   Cleaning and locking %%G folder"
	IF EXIST "%SYSTEMDRIVE%\%%G" (
		TAKEOWN /F "%SYSTEMDRIVE%\%%G" /A /R /D Y >NUL 2>&1
		ICACLS "%SYSTEMDRIVE%\%%G" /GRANT ADMINISTRATORS:F /T /Q >NUL 2>&1
		DEL "%SYSTEMDRIVE%\%%G" /F /S /Q >NUL 2>&1
		RMDIR "%SYSTEMDRIVE%\%%G" /S /Q >NUL 2>&1
		)
	MKDIR "%SYSTEMDRIVE%\%%G"
	ATTRIB +R +S +H +I "%SYSTEMDRIVE%\%%G"
	ICACLS "%SYSTEMDRIVE%\%%G" /INHERITANCE:R /DENY SYSTEM:F /DENY ADMINISTRATORS:F >NUL 2>&1
)
NET START wuauserv >NUL 2>&1


CALL :LOG "   Hiding Updates (VERY SLOW, last step though)"
IF NOT DEFINED KB_TOKENS (CALL :LOG "     - ERROR! Skipping.") && (GOTO SKIP_KB_HIDE)
FOR /F "skip=5 eol=# tokens=%kb_tokens% delims=	|" %%A IN (KB.ini) DO (
	IF /I %%A==Y (	
		SET KB=!KB! %%B
		echo !KB!
	)
)
CALL :LOG "     - Press CTRL_C to skip if pressed for time"
CSCRIPT //NOLOGO HideWindowsUpdates.vbs%KB% "%MTRT_LOGPATH%%MTRT_LOGFILE%"




:COMPLETE
CALL :LOG "   All done! Suggest to restart your PC now."
ECHO   
timeout 6 >NUL
GOTO EOF
:FAIL
TITLE MTRT - ERROR
ECHO.
ECHO   
ECHO   Error, OS not recognized or not Admin!
ECHO   This tool is to be run on Windows 7, 8, or 10
ECHO   Please Right-Click on this file and choose "Run as Administrator" 
PAUSE >NUL 
GOTO EOF
:LOG
ECHO:%CUR_DATE% %TIME% %~1 >> "%MTRT_LOGPATH%\%MTRT_LOGFILE%"
ECHO:%CUR_DATE% %TIME% %~1
EXIT /B
:EOF
ENDLOCAL
EXIT /B
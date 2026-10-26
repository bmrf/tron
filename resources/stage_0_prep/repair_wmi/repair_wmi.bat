:: Purpose:       Test and attempt repair of WMI
:: Requirements:  Broken WMI configuration
:: Author:        Originally taken from http://craighassan.com/fix-wmi-batch-file/
::                Modified by reddit.com/user/vocatus ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.2 ! Remove errant pause command on line 95 that could stall script
::                      + Skip WMI check and repair entirely if the WMI service (winmgmt) isn't present on the system
::                1.0.1 ! Fix "smart quotes" incorrectly being used on some commands
::                1.0.0 + Initial write
SETLOCAL


:::::::::::::::
:: VARIABLES :: -------------- These are the defaults. Change them if you so desire. --------- ::
:::::::::::::::
:: No user-set variables for this script


:: --------------------------- Don't edit anything below this line --------------------------- ::


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set SCRIPT_VERSION=1.0.2
set SCRIPT_UPDATED=2026-10-26

@echo OFF
REM Test and attempt repair of WMI
REM
REM 1. Restart WinMgmts and all dependendency services
REM 2. Verify / Salvage / Reset Repository and restart services
REM 3. Rebuild WMI Repository and restart services


set LERR=0
set ATTEMPT=0

:: Skip the check and repair entirely if WMI isn't present on the system
:: sc returns 1060 (ERROR_SERVICE_DOES_NOT_EXIST) if the winmgmt service isn't registered. Language-independent and doesn't rely on WMI or PowerShell
:: goto :eof is used instead of goto END so we don't hit the popd under :END and pop the caller's directory stack
sc query winmgmt >nul 2>&1
if %ERRORLEVEL%==1060 (
	echo WMI SERVICE ^(winmgmt^) NOT PRESENT ON THIS SYSTEM. SKIPPING WMI CHECK AND REPAIR.
	goto :eof
)

:: PowerShell engine variables are normally inherited from Tron's initialize_environment.bat. If run standalone, default to Windows PowerShell
if not defined PS_WMI_MODE (
	set PS_CMD="%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command
	set PS_GET=Get-WmiObject
	set PS_WMI_MODE=wmi
)

:BEGINCHK
echo CHECKING WMI... ATTEMPT:%ATTEMPT%...
:: Equivalent of: wmic computersystem get name. Exit code 0 = query succeeded, 1 = failed
<NUL %PS_CMD% "try { 'Name'; (%PS_GET% Win32_ComputerSystem -ErrorAction Stop).Name; exit 0 } catch { [Console]::Error.WriteLine($_.Exception.Message); exit 1 }"
IF %ERRORLEVEL%==0 goto SUCCESS
IF %ATTEMPT%==0 GOTO REPAIR1
IF %ATTEMPT%==1 GOTO REPAIR2
IF %ATTEMPT%==2 GOTO REPAIR3
GOTO ERR

:REPAIR1
set ATTEMPT=1
set LERR=1001
echo 1. RESTARTING WMI... ATTEMPT:%ATTEMPT%...&
for /f "tokens=2 delims= " %%a in ('sc enumdepend winmgmt^| findstr -i "SERVICE_NAME"') do echo 1. RESTARTING WMI... Stopping "%%a"...& net stop "%%a" /y> nul
echo 1. RESTARTING WMI... Stopping WinMgmt& net stop winmgmt /y> nul& sc stop winmgmt> nul
ping 127.0.0.1 -n 5
echo 1. RESTARTING WMI... Starting WinMgmt& sc start winmgmt> nul
for /f "tokens=2 delims= " %%a in ('sc enumdepend winmgmt^| findstr -i "SERVICE_NAME"') do echo 1. RESTARTING WMI... Starting "%%a"...& sc start "%%a"> nul
GOTO BEGINCHK


:REPAIR2
set ATTEMPT=2
set LERR=2001
echo 2. REPAIRING WMI REPOSITORY... ATTEMPT:%ATTEMPT%...
echo 2. REPAIRING WMI REPOSITORY... 1. Resetting permissions...
sc sdset winmgmt D:(A;;CCDCLCSWRPWPDTLOCRRC;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;DA)(A;;CCDCLCSWRPWPDTLOCRRC;;;PU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)
echo 2. REPAIRING WMI REPOSITORY... 1. Verifying...& %windir%\system32\wbem\winmgmt /verifyrepository
IF %ERRORLEVEL%==0 GOTO SKIPRESET
set LERR=2002
echo 2. REPAIRING WMI REPOSITORY... 2. Salvaging...& %windir%\system32\wbem\winmgmt /salvagerepository
IF %ERRORLEVEL%==0 GOTO SKIPRESET
set LERR=2003
echo 2. REPAIRING WMI REPOSITORY... 3. Resetting...& %windir%\system32\wbem\winmgmt /resetrepository
IF %ERRORLEVEL%==0 GOTO SKIPRESET
set LERR=2004

:SKIPRESET
for /f "tokens=2 delims= " %%a in ('sc enumdepend winmgmt^| findstr -i "SERVICE_NAME"') do echo 2. REPAIRING WMI REPOSITORY... Stopping "%%a"...& net stop "%%a" /y> nul
echo 2. REPAIRING WMI REPOSITORY... Stopping WinMgmt& net stop winmgmt /y> nul& sc stop winmgmt> nul
ping 127.0.0.1 -n 5
echo 2. REPAIRING WMI REPOSITORY.. Starting WinMgmt& sc start winmgmt> nul
for /f "tokens=2 delims= " %%a in ('sc enumdepend winmgmt^| findstr -i "SERVICE_NAME"') do echo 2. REPAIRING WMI REPOSITORY... Starting "%%a"...& sc start "%%a"> nul
GOTO BEGINCHK


:REPAIR3
set ATTEMPT=3
set LERR=3001
echo 3. REBUILDING WMI REPOSITORY... ATTEMPT:%ATTEMPT%...
for /f "tokens=2 delims= " %%a in ('sc enumdepend winmgmt^| findstr -i "SERVICE_NAME"') do echo 3. REBUILDING WMI REPOSITORY... Stopping "%%a"...& net stop "%%a" /y> nul
echo 3. REBUILDING WMI REPOSITORY... Stopping BITS& net stop BITS /y> nul& sc stop BITS> nul
ping 127.0.0.1 -n 5
echo 3. REBUILDING WMI REPOSITORY... Stopping WinMgmt& net stop winmgmt /y> nul& sc stop winmgmt> nul
ping 127.0.0.1 -n 5
%SystemDrive%
pushd %systemroot%\system32\wbem
echo 3. REBUILDING WMI REPOSITORY... Deleting WMI Repository& rd /S /Q repository
if exist %systemroot%\system32\wbem\repository echo 3. REBUILDING WMI REPOSITORY... ERROR! Unable to delete WMI repository. Reboot Required.
echo 3. REBUILDING WMI REPOSITORY... Registering DLLs (scecli.dll)& regsvr32 /s %systemroot%\system32\scecli.dll
echo 3. REBUILDING WMI REPOSITORY... Registering DLLs (userenv.dll)& regsvr32 /s %systemroot%\system32\userenv.dll
echo 3. REBUILDING WMI REPOSITORY... Compiling MOFs (cimwin32.mof)& mofcomp cimwin32.mof
echo 3. REBUILDING WMI REPOSITORY... Compiling MOFs (cimwin32.mfl)& mofcomp cimwin32.mfl
echo 3. REBUILDING WMI REPOSITORY... Compiling MOFs (rsop.mof)& mofcomp rsop.mof
echo 3. REBUILDING WMI REPOSITORY... Compiling MOFs (rsop.mfl)& mofcomp rsop.mfl
echo 3. REBUILDING WMI REPOSITORY... Registering DLLs
for /f %%s in ('dir /b /s *.dll') do echo 3. REBUILDING WMI REPOSITORY... Registering DLLs (%%s)& regsvr32 /s %%s> nul
echo 3. REBUILDING WMI REPOSITORY... Compiling MOFs
for /f %%s in ('dir /b *.mof') do echo 3. REBUILDING WMI REPOSITORY... Compiling MOFs (%%s)& mofcomp %%s> nul
for /f %%s in ('dir /b *.mfl') do echo 3. REBUILDING WMI REPOSITORY... Compiling MFLs (%%s)& mofcomp %%s> nul

echo 3. REBUILDING WMI REPOSITORY... Registering .exe's
for %%i in (*.exe) do call :FixSrv %%i
:FixSrv
	if /I (%1) == (wbemcntl.exe) goto SkipSrv
	if /I (%1) == (wbemtest.exe) goto SkipSrv
	if /I (%1) == (mofcomp.exe) goto SkipSrv
	%1 /RegServer
:SkipSrv

echo 3. REBUILDING WMI REPOSITORY... Starting WinMgmt& sc start winmgmt> nul
ping 127.0.0.1 -n 5
echo 3. REBUILDING WMI REPOSITORY... Starting BITS& sc start BITS> nul
for /f "tokens=2 delims= " %%a in ('sc enumdepend winmgmt^| findstr -i "SERVICE_NAME"') do echo 3. REBUILDING WMI REPOSITORY... Starting "%%a"...& sc start "%%a"> nul
timeout /t 10
echo 3. REBUILDING WMI REPOSITORY... 1. Verifying...& %windir%\system32\wbem\winmgmt /verifyrepository
IF %ERRORLEVEL%==0 GOTO SKIPRESET
set LERR=3002
echo 3. REBUILDING WMI REPOSITORY... 2. Salvaging...& %windir%\system32\wbem\winmgmt /salvagerepository
IF %ERRORLEVEL%==0 GOTO SKIPRESET
set LERR=3003
echo 3. REBUILDING WMI REPOSITORY... 3. Resetting...& %windir%\system32\wbem\winmgmt /resetrepository
set LERR=3004
:SKIPRESET
for /f "tokens=2 delims= " %%a in ('sc enumdepend winmgmt^| findstr -i "SERVICE_NAME"') do echo 3. REBUILDING WMI REPOSITORY... Stopping "%%a"...& net stop "%%a" /y> nul
echo 3. REBUILDING WMI REPOSITORY... Stopping WinMgmt& net stop winmgmt /y> nul& sc stop winmgmt> nul
ping 127.0.0.1 -n 5
echo 3. REBUILDING WMI REPOSITORY... Starting WinMgmt& sc start winmgmt> nul
for /f "tokens=2 delims= " %%a in ('sc enumdepend winmgmt^| findstr -i "SERVICE_NAME"') do echo 3. REBUILDING WMI REPOSITORY... Starting "%%a"...& sc start "%%a"> nul
GOTO BEGINCHK

:ERR
set LERR=4001
echo ERROR:%LERR% UNABLE TO REPAIR WMI, ATTEMPTS:%ATTEMPT% (%ATTEMPT%:%LERR%).
GOTO END

:SUCCESS
IF %LERR%==0 echo WMI FUNCTIONING CORRECTLY. REPAIR SKIPPED.
IF %LERR% NEQ 0 echo WMI REPAIR SUCCESS! WMI REPAIRED (%ATTEMPT%:%LERR%).
GOTO END

:END
popd
REM EXIT %LERR%

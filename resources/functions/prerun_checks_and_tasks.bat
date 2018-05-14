:: Purpose:       Tron's pre-run checks. Various things to check before continuing on.
:: Requirements:  Called by tron.bat during script initialization
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.6 / Import SMART problem code checks from tron.bat
::                1.0.5 * Don't check for drivedb.h updates if NETWORK_AVAILABLE is set to no
::                1.0.4 ! Fix syntax error in IF statement: Wrap paths in quotes to handle special characters and spaces
::                1.0.3 * Don't download drivedb.h definitions file if in either autorun mode
::                1.0.2 * Don't download drivedb.h definitions file if doing a dry run
::                1.0.1 + Add automatic update of drivedb.h prior to scanning hard drives. This ensures we're always on the latest definitions file
::                        Silently fails if no network connection
::                1.0.0 . Initial write, forked out of v9.9.0 of tron.bat


:: Script version
set PRERUN_CHECKS_SCRIPT_VERSION=1.0.6
set PRERUN_CHECKS_SCRIPT_DATE=2018-03-15



::::::::::::
:: CHECKS ::
::::::::::::

:: CHECK: Admin rights
:: Skip this check if we're in Safe Mode because Safe Mode command prompts always start with Admin rights
SETLOCAL ENABLEDELAYEDEXPANSION
if /i not "%SAFE_MODE%"=="yes" (
	fsutil dirty query %systemdrive% >NUL 2>&1
	if /i not !ERRORLEVEL!==0 (
		color cf
		cls
		echo.
		echo  ERROR
		echo.
		echo  Tron doesn't appear to be running as an Administrator.
		echo  Tron MUST be run with FULL Administrator rights to
		echo  function. Tron will now attempt to auto-elevate itself. 
		echo  Press any key now to skip the 10 second countdown and
		echo  request a UAC prompt immediately. Press Ctrl+C to
		echo  stop this process and terminate tron.
		echo.
		echo.
		timeout /t 10
	)
)
:: If tron isn't running as administrator, request a UAC prompt.
ENDLOCAL DISABLEDELAYEDEXPANSION
:: SC by Cyberponk, adapted and imported for tron by Steets.
setlocal ENABLEDELAYEDEXPANSION & set "_FilePath=%~1"
  if NOT EXIST "!_FilePath!" (echo/tron is running elevated.)
  :: UAC.ShellExecute only works with 8.3 filename, so use %~s1
  set "_FN=_%~ns1" & echo/%TEMP%| findstr /C:"(" >nul && (echo/ERROR: %%TEMP%% path can not contain parenthesis &pause &endlocal &fc;: 2>nul & goto:eof)
  :: Remove parenthesis from the temp filename
  set _FN=%_FN:(=%
  set _vbspath="%temp:~%\%_FN:)=%.vbs" & set "_batpath=%temp:~%\%_FN:)=%.bat"

  :: Check to see if the window was successfully elevated.
  fltmc >nul 2>&1 || goto :_getElevation

  :: The elelation has succeeded.
  (if exist %_vbspath% ( del %_vbspath% )) & (if exist %_batpath% ( del %_batpath% )) 
  :: Set ERRORLEVEL 0, set original folder and exit
  endlocal & CD /D "%~dp1" & ver >nul & exit

  :_getElevation
  echo Requesting Elevation...
  :: Try to create %_vbspath% file. If failed, exit with ERRORLEVEL 1
  echo/Set UAC = CreateObject^("Shell.Application"^) > %_vbspath% || (echo/&echo/Unable to create %_vbspath% & endlocal &md; 2>nul &goto:eof) 
  echo/UAC.ShellExecute "%_batpath%", "", "", "runas", 1 >> %_vbspath% & echo/wscript.Quit(1)>> %_vbspath%
  :: Try to create %_batpath% file. If failed, exit with ERRORLEVEL 1
  echo/@%* > "%_batpath%" || (echo/&echo/Unable to create %_batpath% & endlocal &md; 2>nul &goto:eof)
  echo/@if %%errorlevel%%==9009 (echo/^&echo/Admin user could not read the batch file. If running from a mapped drive or UNC path, check if Admin user can read it.)^&echo/^& @if %%errorlevel%% NEQ 0 pause >> "%_batpath%"

  :: Run %_vbspath%, that calls %_batpath%, calling the original file
  %_vbspath% && (echo/&echo/Failed to run VBscript %_vbspath% &endlocal &md; 2>nul & goto:eof)

  :: VBS script ran, exit with ERRORLEVEL -1
  echo/&echo/Elevation was requested on a new CMD window &endlocal &fc;: 2>nul & goto:eof

  :eof
  fltmc >nul 2>&1 || goto :_getElevation
  exit

:: CHECK: Detect unsupported OS. If we are, complain to the user and bail out
if "%WIN_VER:~0,19%"=="Windows Server 2016" (
	if /i %DEV_MODE%==no (
		color 0c
		echo.
		echo  ^! ERROR
		echo.
		echo    Tron does not support "%WIN_VER%" ^(yet^).
		echo.
		echo    If you want to override and run anyway, re-run
		echo    Tron from the command-line with the -dev flag.
		echo.
		echo    Keep in mind that by doing this you're waiving
		echo    your already non-existent warranty!
		echo.
		pause
		exit 3
	)
)



:: CHECK: Prohibited directory execution
:: Why? because people have some bizarre obsession with running from the System temp folder
:: or some other random location instead of from the desktop as instructed
set RUNDIR=%~dp0
if "%RUNDIR:~0,7%"=="%SystemDrive%\tron" set BAD_RUNPATH=yes
if "%RUNDIR:~0,7%"=="%SystemDrive%\temp" set BAD_RUNPATH=yes
if "%RUNDIR%"=="%TEMP%\tron\tron\resources\functions\" set BAD_RUNPATH=yes
if "%RUNDIR%"=="%TEMP%\tron\resources\functions\" set BAD_RUNPATH=yes
if "%RUNDIR%"=="%TEMP%\resources\functions\" set BAD_RUNPATH=yes
if %BAD_RUNPATH%==yes (
	color 0c
	cls
	echo.
	echo  ERROR
	echo.
	echo  Tron is running from a temp location or the root of %SystemDrive%.
	echo  Tron cannot run from these locations as they're some of the
	echo  first places to get cleaned when the script starts. Run Tron
	echo  directly from the Desktop. Example of a correct path:
	echo.
	echo   "%USERPROFILE%\Desktop\tron\tron.bat"
	echo.
	echo  Go avail yourself of Step 1 of the instructions, which are named,
	echo  appropriately enough...
	echo.
	echo  "INSTRUCTIONS -- YES ACTUALLY READ THEM.txt"
	echo.
	echo  Goodbye.
	echo.
	pause
	exit 5
)




:::::::::::
:: TASKS ::
:::::::::::

:: TASK: Detect Solid State hard drives or Virtual Machine installation (determines if post-run defrag executes or not)
pushd stage_6_optimize\defrag\

	:: Check for an updated drivedb.h, but ONLY if:
	:: a. not in a dry run
	:: b. not in autorun
	:: c. not in autorun (safe mode)
	:: d. network IS available
	if /i %DRY_RUN%==no ( if /i %AUTORUN%==no ( if /i %AUTORUN_IN_SAFE_MODE%==no ( if /i %NETWORK_AVAILABLE%==yes ( update-smart-drivedb.exe /S ) ) ) )

	:: Do the scan
	for /f %%i in ('smartctl.exe --scan') do smartctl.exe %%i -a | %FINDSTR% /i "Solid SSD RAID SandForce" >NUL && set SKIP_DEFRAG=yes_ssd
	for /f %%i in ('smartctl.exe --scan') do smartctl.exe %%i -a | %FINDSTR% /i "VMware VBOX XENSRC PVDISK" >NUL && set SKIP_DEFRAG=yes_vm
	for /f %%i in ('smartctl.exe --scan') do smartctl.exe %%i -a | %FIND% /i "Read Device Identity Failed" >NUL && set SKIP_DEFRAG=yes_disk_smart_read_error&&set WARNINGS_DETECTED=yes_disk_smart_read_error

	:: Look for known problem codes and set skip_defrag if so
	set WARNING_LIST=(Error Degraded Unknown PredFail Service Stressed NonRecover)
	for /f %%i in ('^<NUL %WMIC% diskdrive get status') do echo %%i|%FINDSTR% /i "%WARNING_LIST:~1,-1%" && (
		set SMART_PROBLEM_CODE=%%i
		set SKIP_DEFRAG=yes_disk_smart_problem_code
		set WARNINGS_DETECTED=yes_disk_smart_problem_code
	)

popd


:: TASK: Get free space on the system drive and stash it for comparison later
for /F "tokens=2 delims=:" %%a in ('fsutil volume diskfree %SystemDrive% ^| %FIND% /i "avail free"') do set bytes=%%a
:: GB version
::set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024/1024
:: MB version
set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024


:: TASK: Re-enable the standard "F8" key functionality for choosing bootup options (Microsoft started disabling it by default in Windows 8 and up)
if %WIN_VER_NUM% geq 6.3 bcdedit /set {default} bootmenupolicy legacy

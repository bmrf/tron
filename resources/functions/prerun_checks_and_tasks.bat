:: Purpose:       Tron's pre-run checks. Various things to check before continuing on.
:: Requirements:  Called by tron.bat during script initialization
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.1 + Add automatic update of drivedb.h prior to scanning hard drives. This ensures we're always on the latest definitions file
::                        Silently fails if no network connection
::                1.0.0 . Initial write, forked out of v9.9.0 of tron.bat


:: Script version
set PRERUN_CHECKS_SCRIPT_VERSION=1.0.1
set PRERUN_CHECKS_SCRIPT_DATE=2017-11-06



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
		echo  Tron doesn't think it is running as an Administrator.
		echo  Tron MUST be run with full Administrator rights to
		echo  function correctly.
		echo.
		echo  Close this window and re-run Tron as an Administrator.
		echo  ^(right-click tron.bat and click "Run as Administrator"^)
		echo.
		pause
		exit 1
	)
)
ENDLOCAL DISABLEDELAYEDEXPANSION


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
		exit 1
	)
)


:: CHECK: Make sure we're not running from the %TEMP% directory
if "%~dp0"=="%TEMP%\tron\" (
	color 0c
	cls
	echo.
	echo  ERROR
	echo.
	echo  Tron is running from the Windows TEMP directory. Tron
	echo  cannot run from the TEMP directory as it's one of the
	echo  first places to get wiped when Tron starts. Run Tron
	echo  directly from your Desktop. Example of correct path:
	echo.
	echo   "%USERPROFILE%\Desktop\tron\tron.bat"
	echo.
	echo  Tron will now quit.
	echo.
	pause
	exit 1
)


:: CHECK: Make sure we're not running from %SystemDrive%\TEMP
if "%~dp0"=="%SystemDrive%\temp\tron\" (
	color 0c
	cls
	echo.
	echo  ERROR
	echo.
	echo  Tron is running from %SystemDrive%\TEMP. Tron cannot
	echo  run from this location as it's one of the first
	echo  places to get wiped when Tron starts. Run Tron
	echo  directly from your Desktop. Example of correct path:
	echo.
	echo   "%USERPROFILE%\Desktop\tron\tron.bat"
	echo.
	echo  Tron will now quit.
	echo.
	pause
	exit 1
)



:::::::::::
:: TASKS ::
:::::::::::

:: TASK: Detect Solid State hard drives or Virtual Machine installation (determines if post-run defrag executes or not)
pushd stage_6_optimize\defrag\

	:: Check for an updated drivedb.h
	update-smart-drivedb.exe /S

	:: Do the scan
	for /f %%i in ('smartctl.exe --scan') do smartctl.exe %%i -a | %FINDSTR% /i "Solid SSD RAID SandForce" >NUL && set SKIP_DEFRAG=yes_ssd
	for /f %%i in ('smartctl.exe --scan') do smartctl.exe %%i -a | %FINDSTR% /i "VMware VBOX XENSRC PVDISK" >NUL && set SKIP_DEFRAG=yes_vm
	for /f %%i in ('smartctl.exe --scan') do smartctl.exe %%i -a | %FIND% /i "Read Device Identity Failed" >NUL && set SKIP_DEFRAG=yes_error
popd


:: TASK: Get free space on the system drive and stash it for comparison later
for /F "tokens=2 delims=:" %%a in ('fsutil volume diskfree %SystemDrive% ^| %FIND% /i "avail free"') do set bytes=%%a
:: GB version
::set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024/1024
:: MB version
set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024


:: TASK: Re-enable the standard "F8" key functionality for choosing bootup options (Microsoft started disabling it by default in Windows 8 and up)
if %WIN_VER_NUM% geq 6.3 bcdedit /set {default} bootmenupolicy legacy

:: Purpose:       Tron's pre-run checks. Various things to check before continuing on.
:: Requirements:  Called by tron.bat during script initialization
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.1.4 ! Fix SMART problem code check missing statuses that contain a space ("Pred Fail", "No Contact", "Lost Comm").
::                        for /f only kept the first word ("Pred"), so a drive predicting failure wasn't flagged and defrag still ran. Thanks to u/jchristyr
::                      ! Pass each device's type (-d) from 'smartctl --scan' through to smartctl. It was being dropped, so NVMe, USB and RAID
::                        devices could be queried with the wrong protocol and return incomplete data or a false 'Read Device Identity Failed'
::                      * Query each disk once and check the saved output, instead of querying every disk three times
::                      ! Detect NVMe drives as solid state from their smartctl device type, instead of relying on "SSD" appearing in the
::                        model name (many NVMe models don't include it, so they were treated as spinning disks and defragmented)
::                      ! Base the SSD and VM defrag decisions on the system drive only, since that's the only drive Stage 6 defragments.
::                        Previously the last disk smartctl listed decided it, so an SSD data drive could skip defrag of an HDD system drive
::                        and vice versa. Falls back to checking all disks if the system disk can't be matched to a smartctl device.
::                        On Windows 8 and up, Windows' own media type for the system disk (MSFT_PhysicalDisk) is also used to detect an SSD.
::                        Read error and SMART problem code warnings still cover every disk
::                      + Detect Hyper-V (and Azure) virtual machines from the machine model and skip defrag, since smartctl doesn't
::                        reliably identify Hyper-V's virtual disks
::                1.1.3 ! Fix free disk space calculation
::                1.1.2 * Update unsupported OS check to trigger on Windows XP, since we're deprecating support for it soon
::                1.1.1 * Switch to alternate Administrator rights check
::                1.1.0 ! Fix regression re: disk space calculation fix
::                1.0.9 ! Fix disk space calculation on Win10 build 17763 (1809) and up due to fsutil output changing. Thanks to u/Paul_NZ
::                1.0.8 + Add some display messages explaining what we're doing (detecting disks, updating drivedb, etc)
::                      - Suppress "The operation completed successfully" output from bcdedit command
::                1.0.7 * Improve disk free space detection to work on non-English installations. Thanks to r/TchangLaTempete
::                1.0.6 / Import SMART problem code checks from tron.bat
::                1.0.5 * Don't check for drivedb.h updates if NETWORK_AVAILABLE is set to no
::                1.0.4 ! Fix syntax error in IF statement: Wrap paths in quotes to handle special characters and spaces
::                1.0.3 * Don't download drivedb.h definitions file if in either autorun mode
::                1.0.2 * Don't download drivedb.h definitions file if doing a dry run
::                1.0.1 + Add automatic update of drivedb.h prior to scanning hard drives. This ensures we're always on the latest definitions file
::                        Silently fails if no network connection
::                1.0.0 . Initial write, forked out of v9.9.0 of tron.bat
@echo off


:: Script version
set PRERUN_CHECKS_SCRIPT_VERSION=1.1.4
set PRERUN_CHECKS_SCRIPT_DATE=2026-10-27



::::::::::::
:: CHECKS ::
::::::::::::

:: CHECK: Admin rights
:: Skip this check if we're in Safe Mode because Safe Mode command prompts always start with Admin rights
SETLOCAL ENABLEDELAYEDEXPANSION
if /i not "%SAFE_MODE%"=="yes" (
	
	
	%REG% query "HKU\S-1-5-19\Environment" > NUL
	
	REM Alternate method
	REM fsutil dirty query %systemdrive% >NUL 2>&1
	
	
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
if "%WIN_VER:~0,10%"=="Windows XP" (
  	if /i %DEV_MODE%==no (
  		color 0c
  		echo.
  		echo  ^! ERROR
  		echo.
REM  	echo    Tron does not support "%WIN_VER%" ^(yet^).
		echo    Tron does not support "%WIN_VER%".
  		echo.
  		echo    If you want to override and run anyway, re-run
  		echo    Tron from the command-line with the -dev switch.
  		echo.
  		echo    Keep in mind that by doing this some things might
  		echo    not function as intended.
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
	if /i %DRY_RUN%==no ( if /i %AUTORUN%==no ( if /i %AUTORUN_IN_SAFE_MODE%==no ( if /i %NETWORK_AVAILABLE%==yes ( 
		echo.
		echo    Updating SMART drive database, please wait...
		echo.
		update-smart-drivedb.exe /S >nul
		echo    Done.
	) ) ) )

	:: Find the system drive's disk number, the matching smartctl device name, and on Windows 8 and up the media type Windows reports for it
	:: Output is "index|/dev/sdX|mediatype". smartctl on Windows names \\.\PhysicalDriveN as /dev/sdX, where a = 0, b = 1, etc.
	:: MediaType values: 3 = HDD, 4 = SSD, 5 = SCM, 0 or empty = unknown. Empty on Windows 7, which doesn't have MSFT_PhysicalDisk
	:: If anything fails, nothing is set and the checks below fall back to looking at all disks
	set SYSTEM_DISK_INDEX=
	set SYSTEM_SMART_DEVICE=
	set SYSTEM_DISK_MEDIATYPE=
	if /i "%PS_WMI_MODE%"=="wmi" (
		for /f "tokens=1-3 delims=|" %%a in ('^<NUL %PS_CMD% "$ld = Get-WmiObject Win32_LogicalDisk -Filter ('DeviceID=''' + $env:SystemDrive + ''''); $dd = @($ld.GetRelated('Win32_DiskPartition') | ForEach-Object { $_.GetRelated('Win32_DiskDrive') }) | Select-Object -First 1; if ($dd) { $n = [int]$dd.Index; $m = ''; try { $m = [string](Get-WmiObject -Namespace 'root\Microsoft\Windows\Storage' -Class MSFT_PhysicalDisk -Filter ('DeviceId=''' + $n + '''') -ErrorAction Stop).MediaType } catch { }; if ($n -le 25) { [string]$n + '|/dev/sd' + [char](97 + $n) + '|' + $m } }" 2^>NUL') do (
			set SYSTEM_DISK_INDEX=%%a
			set SYSTEM_SMART_DEVICE=%%b
			set SYSTEM_DISK_MEDIATYPE=%%c
		)
	)
	if /i "%PS_WMI_MODE%"=="cim" (
		for /f "tokens=1-3 delims=|" %%a in ('^<NUL %PS_CMD% "$ld = Get-CimInstance Win32_LogicalDisk -Filter ('DeviceID=''' + $env:SystemDrive + ''''); $dd = @($ld | Get-CimAssociatedInstance -ResultClassName Win32_DiskPartition | Get-CimAssociatedInstance -ResultClassName Win32_DiskDrive) | Select-Object -First 1; if ($dd) { $n = [int]$dd.Index; $m = ''; try { $m = [string](Get-CimInstance -Namespace 'root/Microsoft/Windows/Storage' -ClassName MSFT_PhysicalDisk -Filter ('DeviceId=''' + $n + '''') -ErrorAction Stop).MediaType } catch { }; if ($n -le 25) { [string]$n + '|/dev/sd' + [char](97 + $n) + '|' + $m } }" 2^>NUL') do (
			set SYSTEM_DISK_INDEX=%%a
			set SYSTEM_SMART_DEVICE=%%b
			set SYSTEM_DISK_MEDIATYPE=%%c
		)
	)
	if not defined SYSTEM_SMART_DEVICE set SYSTEM_SMART_DEVICE=undetected

	:: Hyper-V guests: smartctl doesn't reliably identify Hyper-V's virtual disks, so check the machine model instead
	:: Hyper-V and Azure VMs report Manufacturer "Microsoft Corporation" and Model "Virtual Machine". Surface devices share the manufacturer but not the model
	set SYSTEM_IS_HYPERV=no
	if /i not "%PS_WMI_MODE%"=="none" for /f %%a in ('^<NUL %PS_CMD% "$cs = %PS_GET% Win32_ComputerSystem; if (($cs.Manufacturer -eq 'Microsoft Corporation') -and ($cs.Model -eq 'Virtual Machine')) { 'yes' }" 2^>NUL') do set SYSTEM_IS_HYPERV=%%a

	:: Do the scan
	:: Each line of "smartctl --scan" looks like "/dev/sda -d ata # /dev/sda, ATA device". Pass the device AND its -d type to smartctl,
	:: otherwise NVMe, USB and RAID devices can be queried with the wrong protocol and return incomplete data or a false read error
	:: Each disk is queried once and its output checked from a temp file. Results are collected per check and applied after the loop
	:: so the precedence stays the same as before (read error beats VM, VM beats SSD), regardless of the order disks are listed in
	echo.
	echo    Detecting disks...
	echo.
	:: SMART_FOUND_* = any disk, SYSTEM_DISK_* = the system disk only
	set SMART_FOUND_SSD=no
	set SMART_FOUND_VM=no
	set SMART_FOUND_READ_ERROR=no
	set SYSTEM_DISK_FOUND=no
	set SYSTEM_DISK_SSD=no
	set SYSTEM_DISK_VM=no
	for /f "eol=# tokens=1-3" %%i in ('smartctl.exe --scan') do (
		if "%%j"=="-d" (
			smartctl.exe %%i -d %%k -a > "%TEMP%\tron_smart_results.txt" 2>&1
		) else (
			smartctl.exe %%i -a > "%TEMP%\tron_smart_results.txt" 2>&1
		)
		REM NVMe drives are always solid state, whether or not "SSD" is in the model name. Covers native NVMe, type nvme, and
		REM NVMe in USB enclosures, which smartctl reports with an "snt" bridge type: sntjmicron, sntasmedia, sntrealtek
		REM No parentheses in these comments, since they sit inside a parenthesized block
		echo %%j %%k| %FINDSTR% /i /b /c:"-d nvme" /c:"-d snt" >NUL && set SMART_FOUND_SSD=yes
		%FINDSTR% /i "Solid SSD RAID SandForce" "%TEMP%\tron_smart_results.txt" >NUL && set SMART_FOUND_SSD=yes
		%FINDSTR% /i "VMware VBOX XENSRC PVDISK" "%TEMP%\tron_smart_results.txt" >NUL && set SMART_FOUND_VM=yes
		%FIND% /i "Read Device Identity Failed" "%TEMP%\tron_smart_results.txt" >NUL && set SMART_FOUND_READ_ERROR=yes
		REM Same SSD and VM checks, recorded separately for the system disk
		if /i "%%i"=="%SYSTEM_SMART_DEVICE%" (
			set SYSTEM_DISK_FOUND=yes
			echo %%j %%k| %FINDSTR% /i /b /c:"-d nvme" /c:"-d snt" >NUL && set SYSTEM_DISK_SSD=yes
			%FINDSTR% /i "Solid SSD RAID SandForce" "%TEMP%\tron_smart_results.txt" >NUL && set SYSTEM_DISK_SSD=yes
			%FINDSTR% /i "VMware VBOX XENSRC PVDISK" "%TEMP%\tron_smart_results.txt" >NUL && set SYSTEM_DISK_VM=yes
		)
	)
	del /f /q "%TEMP%\tron_smart_results.txt" >NUL 2>&1

	:: Windows itself reports the system disk as SSD or SCM (Windows 8 and up only)
	if "%SYSTEM_DISK_MEDIATYPE%"=="4" set SYSTEM_DISK_SSD=yes
	if "%SYSTEM_DISK_MEDIATYPE%"=="5" set SYSTEM_DISK_SSD=yes

	:: Decide. Use the system disk's results if smartctl listed it. Otherwise fall back to any disk (the previous behavior), which can
	:: only cause an unneeded defrag skip, never a defrag of an SSD. Precedence is unchanged: read error beats VM, VM beats SSD
	if /i "%SYSTEM_DISK_FOUND%"=="yes" (
		if %SYSTEM_DISK_SSD%==yes set SKIP_DEFRAG=yes_ssd
		if %SYSTEM_DISK_VM%==yes set SKIP_DEFRAG=yes_vm
	) else (
		if %SMART_FOUND_SSD%==yes set SKIP_DEFRAG=yes_ssd
		if %SYSTEM_DISK_SSD%==yes set SKIP_DEFRAG=yes_ssd
		if %SMART_FOUND_VM%==yes set SKIP_DEFRAG=yes_vm
	)
	if %SYSTEM_IS_HYPERV%==yes set SKIP_DEFRAG=yes_vm
	if %SMART_FOUND_READ_ERROR%==yes (
		set SKIP_DEFRAG=yes_disk_smart_read_error
		set WARNINGS_DETECTED=yes_disk_smart_read_error
	)

	:: Look for known problem codes and set skip_defrag if so
	:: Some Win32_DiskDrive Status values contain a space ("Pred Fail", "No Contact", "Lost Comm"). for /f only keeps the first word, so
	:: PowerShell strips the spaces first ("Pred Fail" becomes "PredFail") and WARNING_LIST uses the space-free forms
	set WARNING_LIST=(Error Degraded Unknown PredFail Service Stressed NonRecover NoContact LostComm)
	if /i not "%PS_WMI_MODE%"=="none" for /f %%i in ('^<NUL %PS_CMD% "%PS_GET% Win32_DiskDrive | ForEach-Object { $_.Status -replace ' ','' }"') do echo %%i|%FINDSTR% /i "%WARNING_LIST:~1,-1%" && (
		set SMART_PROBLEM_CODE=%%i
		set SKIP_DEFRAG=yes_disk_smart_problem_code
		set WARNINGS_DETECTED=yes_disk_smart_problem_code
	)

	echo    Done.
	
popd


:: TASK: Get free space on the system drive (in MB) and stash it for comparison later
:: Uses .NET's DriveInfo via PowerShell instead of parsing fsutil output, which has changed between Windows builds and differs by language.
:: PowerShell does the math in 64-bit, so drives over 2 TB don't overflow cmd's 32-bit set /A. MB values fit in set /A up to ~2 PB
set FREE_SPACE_BEFORE=0
if /i not "%PS_WMI_MODE%"=="none" (
	for /f %%a in ('^<NUL %PS_CMD% "[int64][math]::Floor((New-Object System.IO.DriveInfo($env:SystemDrive)).AvailableFreeSpace / 1MB)" 2^>NUL') do set FREE_SPACE_BEFORE=%%a
)



:: TASK: Re-enable the standard "F8" key functionality for choosing bootup options (Microsoft started disabling it by default in Windows 8 and up)
if %WIN_VER_NUM% geq 6.3 bcdedit /set {default} bootmenupolicy legacy >NUL

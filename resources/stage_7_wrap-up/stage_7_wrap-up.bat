:: Purpose:       Sub-script containing all commands for Tron's Stage 7: Wrap-up stage. Called by tron.bat and returns control when finished
:: Requirements:  Administrator access
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.0 + Initial break-out of code from tron.bat into discrete subscript
@echo off


:::::::::::::::::::::
:: PREP AND CHECKS ::
:::::::::::::::::::::
set STAGE_7_SCRIPT_VERSION=1.0.0
set STAGE_7_SCRIPT_DATE=2018-02-16

:: Check for standalone vs. Tron execution and build the environment if running in standalone mode
if /i "%LOGFILE%"=="" (
	pushd "%~dp0"
	pushd ..

	:: Load the settings file
	call functions\tron_settings.bat

	:: Initialize the runtime environment
	call functions\initialize_environment.bat
)



:::::::::::::::::::::::
:: STAGE 7: Wrap-up  :: // Begin jobs
:::::::::::::::::::::::
call functions\log_with_date.bat "  stage_7_wrap-up begin..."


:: JOB: Reset power settings to Windows defaults
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Reset power settings]
if %PRESERVE_POWER_SCHEME%==yes (
	call functions\log_with_date.bat "!  PRESERVE_POWER_SCHEME (-p) set to "%PRESERVE_POWER_SCHEME%", skipping power settings reset."
) else (
	call functions\log_with_date.bat "   Resetting Windows power settings to defaults and re-enabling screensaver..."
	if %DRY_RUN%==no (
		REM Check for Windows XP/2k3
		if %WIN_VER_NUM% lss 6.0 %WINDIR%\system32\powercfg.exe /RestoreDefaultPolicies >NUL 2>&1
		REM Run commands for all other versions of Windows
		%WINDIR%\system32\powercfg.exe -restoredefaultschemes >NUL 2>&1
)
call functions\log_with_date.bat "   Done."
)


:: JOB: Get post-Tron system state (installed programs, complete file list) and generate the summary logs
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Generate Summary Logs]
call functions\log_with_date.bat "   Calculating post-run results for summary logs..."
if /i %DRY_RUN%==no (
	:: Get list of installed programs
	stage_0_prep\log_tools\siv\siv32x.exe -save=[software]="%RAW_LOGS%\installed-programs-after.txt"
	:: Get list of all files
	stage_0_prep\log_tools\everything\everything.exe -create-filelist %RAW_LOGS%\filelist-after.txt %SystemDrive%
	:: Parse everything
		REM Step 1: Find FILES that were deleted (second line is to strip everything trailing the first comma from the output)
		stage_0_prep\log_tools\comm\comm.exe -23 %RAW_LOGS%\filelist-before.txt %RAW_LOGS%\filelist-after.txt | %FIND% /i /v "$RECYCLE" | %FIND% /i /v "AppData\" | %FIND% /i /v "ntuser.dat" > "%TEMP%\temp.txt"
		for /f "tokens=1 delims=," %%a in ("%TEMP%\temp.txt") do echo %%a >> %SUMMARY_LOGS%\tron_removed_files.txt

		REM Step 2: Find PROGRAMS that were removed. This is super ugly and complicated, but lets us avoid bundling another external utility
		REM Compact the files by removing blank lines, stripping top 4 lines off file, then last two lines, then output to the final text file for comparison
		copy /y %RAW_LOGS%\installed-programs-before.txt %RAW_LOGS%\before.txt >NUL
		for /f "delims=" %%a in (%RAW_LOGS%\before.txt) do echo %%a>> %RAW_LOGS%\before1.txt
		more +3 %RAW_LOGS%\before1.txt >> %RAW_LOGS%\before2.txt
		%FINDSTR% /v /i "[==" %RAW_LOGS%\before2.txt > %RAW_LOGS%\installed-programs-before.txt

		REM AFTER: Compact the files by removing blank lines, stripping top 4 lines off file, then last two lines, then output to the final text file for comparison
		copy /y %RAW_LOGS%\installed-programs-after.txt %RAW_LOGS%\after.txt >NUL
		for /f "delims=" %%a in (%RAW_LOGS%\after.txt) do echo %%a>> %RAW_LOGS%\after1.txt
		more +3 %RAW_LOGS%\after1.txt >> %RAW_LOGS%\after2.txt
		%FINDSTR% /v /i "[==" %RAW_LOGS%\after2.txt > %RAW_LOGS%\installed-programs-after.txt

		REM Calculate differences, using GnuWin32 coreutil's comm.exe
		stage_0_prep\log_tools\comm\comm.exe -23 %RAW_LOGS%\installed-programs-before.txt %RAW_LOGS%\installed-programs-after.txt > %SUMMARY_LOGS%\tron_removed_programs.txt

		REM If the parsed file is the same as the original, we can assume nothing was removed, so just echo that into the file
		fc /b %RAW_LOGS%\installed-programs-before.txt %RAW_LOGS%\installed-programs-after.txt >NUL
		if %ERRORLEVEL%==0 echo No programs were removed.> %SUMMARY_LOGS%\tron_removed_programs.txt

		REM Cleanup
		del /f /q "%TEMP%\temp.txt" 2>NUL
		del /f /q %RAW_LOGS%\before*txt 2>NUL
		del /f /q %RAW_LOGS%\after*txt 2>NUL
	)
call functions\log_with_date.bat "   Done. Summary logs are at "%SUMMARY_LOGS%\""


:: JOB: Collect misc logs and deposit them in the log folder
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Collect logs]
call functions\log_with_date.bat "   Saving misc logs to "%RAW_LOGS%\"..."
if /i %DRY_RUN%==no (
	if exist "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs" copy /Y "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\*.l*" "%RAW_LOGS%" >NUL
	if exist "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Logs" copy /Y "%ProgramData%\Malwarebytes\Malwarebytes Anti-Malware\Logs\*.xml" "%RAW_LOGS%" >NUL
	if exist "%LOGPATH%\mbam-log*" move /y "%LOGPATH%\mbam-log*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\Sophos*" move /y "%LOGPATH%\Sophos*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\protection-log*" move /y "%LOGPATH%\protection-log*" "%RAW_LOGS%\"
	if exist "%LOGPATH%\jre*" move /y "%LOGPATH%\jre*" "%RAW_LOGS%\"
)
call functions\log_with_date.bat "   Done."


:: JOB: Create post-run Restore Point
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Create Restore Point]
if %WIN_VER_NUM% geq 6.0 (
	REM Remove the stupid restore point creation 24 hour cooldown timer Microsoft brilliantly introduced in Windows 8 and up
	if %WIN_VER_NUM% geq 6.2 reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /t reg_dword /v SystemRestorePointCreationFrequency /d 0 /f >nul 2>&1
	REM Create the restore point
	echo "%WIN_VER%" | %FINDSTR% /i /c:"server" >NUL || (
		call functions\log_with_date.bat "   Creating post-run Restore Point..."
		if /i %DRY_RUN%==no	powershell "Checkpoint-Computer -Description 'TRON v%TRON_VERSION%: Post-run checkpoint' | Out-Null" >> "%LOGPATH%\%LOGFILE%" 2>&1
	)
)
call functions\log_with_date.bat "   OK."


:: JOB: Calculate saved disk space
title Tron v%TRON_VERSION% [stage_7_wrap-up] [Calculate saved disk space]
for /F "tokens=2 delims=:" %%a in ('fsutil volume diskfree %SystemDrive% ^| %FIND% /i "avail free"') do set bytes=%%a
:: GB version
::set /A FREE_SPACE_BEFORE=%bytes:~0,-3%/1024*1000/1024/1024
:: MB version
set /A FREE_SPACE_AFTER=%bytes:~0,-3%/1024*1000/1024
set /a FREE_SPACE_SAVED=%FREE_SPACE_AFTER% - %FREE_SPACE_BEFORE%

call functions\log_with_date.bat "  stage_7_wrap-up complete."





:: Stage complete
call functions\log_with_date.bat "  stage_7_wrap-up complete."

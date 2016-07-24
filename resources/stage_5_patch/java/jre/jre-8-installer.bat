:: Purpose:       Installs a package
:: Requirements:  Run this script with a network admin account
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: History:       1.6.3-TRON ! Fix missing percentage sign around SystemDrive variable
::                1.6.2-TRON * Replace LOGPATH variable with inherited RAW_LOGS variable from Tron
::                1.6.1-TRON / Branch into Tron-specific version
::                           * Switch to version-agnostic installation, will now detect system architecture and run appropriate installer
::                1.0.0      + Initial write


:::::::::::::::
:: Variables :: -- Set these to your desired values. No trailing slashes (\)
:::::::::::::::
:: If RAW_LOGS isn't populated then we're running in standalone mode and likely weren't called from Tron, so populate RAW_LOGS with the standard log location
if /i "%RAW_LOGS%"=="" set RAW_LOGS=%SystemDrive%\logs
:: This overrides Tron's LOGFILE, but only for the duration of the script
set LOGFILE=tron_jre8_update.log

:: Package to install
set BINARY_VERSION=8u102
set FLAGS=ALLUSERS=1 /qn /norestart /l %RAW_LOGS%\%LOGFILE% JU=0 JAVAUPDATE=0 AUTOUPDATECHECK=0 RebootYesNo=No WEB_JAVA_SECURITY_LEVEL=M


::::::::::
:: Prep :: -- Don't change anything in this section
::::::::::
@echo off
set SCRIPT_VERSION=1.6.3-TRON
set SCRIPT_UPDATED=2016-17-24
:: Get the date into ISO 8601 standard format (yyyy-mm-dd) so we can use it
FOR /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%

:: This is useful if we start from a network share; converts CWD to a drive letter
pushd "%~dp0" 2>NUL

:: Create the log directory if it doesn't exist
if not exist %RAW_LOGS% mkdir %RAW_LOGS%


::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: First remove previous versions of the JRE
echo %CUR_DATE% %TIME%   Uninstalling all versions of JRE 8 x64 prior to installation of current version...>> "%RAW_LOGS%\%LOGFILE%"
wmic product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F864180__FF}'" call uninstall /nointeractive>> "%RAW_LOGS%\%LOGFILE%" 2>NUL
:: Sometimes the previous line doesn't work for whatever reason, so we run this line as well
wmic product where "name like 'Java 8 Update __ (64-bit)'" uninstall /nointeractive 2>NUL

:: This line installs the package from a local directory (if all files are in the same directory)
:: Nothing below this line will log correctly, because MSI logs in a different format than the standard "echo >> %logfile%" commands. Haven't had time to find a workaround.

:: Detect system architecture and install appropriate version
if /i '%PROCESSOR_ARCHITECTURE%'=='x86' (
	msiexec /i "jre-%BINARY_VERSION%-windows-i586.msi" %FLAGS%
) else (
	msiexec /i "jre-%BINARY_VERSION%-windows-x64.msi" %FLAGS%
)

:: Kill the Java Update scheduler if it's running
%SystemRoot%\System32\taskkill.exe /f /im jusched.exe>>%RAW_LOGS%\%LOGFILE% 2>NUL

:: Uninstall the Java Auto Updater from Add/Remove Programs because it sometimes sneaks through
wmic product where "name like 'Java Auto Updater'" call uninstall /nointeractive 2>NUL

:: Disable the Java Auto-Updater keys in the registry
%SystemRoot%\System32\reg.exe DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v SunJavaUpdateSched /f>> "%RAW_LOGS%\%LOGFILE%" 2>NUL
%SystemRoot%\System32\reg.exe DELETE "HKLM\SOFTWARE\JavaSoft\Java Update" /f>> "%RAW_LOGS%\%LOGFILE%" 2>NUL

:: Stop the Java Quickstarter service
net stop JavaQuickStarterService>> "%RAW_LOGS%\%LOGFILE%" 2>NUL
sc delete JavaQuickStarterService>> "%RAW_LOGS%\%LOGFILE%" 2>NUL

:: Stop the Java update service
net stop SunJavaUpdateSched>> "%RAW_LOGS%\%LOGFILE%" 2>NUL
sc delete SunJavaUpdateSched>> "%RAW_LOGS%\%LOGFILE%" 2>NUL

:: Delete the Java Update directory (normally contains jaureg.exe, jucheck.exe, and jusched.exe)
rmdir /S /Q "%CommonProgramFiles%\Java\Java Update\">> "%RAW_LOGS%\%LOGFILE%" 2>NUL
rmdir /S /Q "%CommonProgramFiles(x86)%\Java\Java Update\">> "%RAW_LOGS%\%LOGFILE%" 2>NUL

:: Delete a bunch of pointless shortcuts Java installs in the All Users Start Menu (sigh...)
rmdir /S /Q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Java">> "%RAW_LOGS%\%LOGFILE%" 2>NUL

:: Install the customization files to set the Java Web Security level to MEDIUM (default in all versions prior to JRE8)
xcopy deployment.* %WINDIR%\Sun\Java\Deployment /I /Y >NUL
xcopy *.sites %WINDIR%\Sun\Java\Deployment /I /Y >NUL

:: Pop back to original directory. This isn't necessary in stand-alone runs of the script, but is needed when being called from another script
popd

:: Return exit code to SCCM/PDQ Deploy/etc
exit /B %EXIT_CODE%

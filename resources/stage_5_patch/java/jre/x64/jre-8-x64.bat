:: Purpose:       Installs a package
:: Requirements:  Run this script with a network admin account
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: History:       1.6.0 * Reworked CUR_DATE variable to handle all Windows date formats regardless of locale
::                1.0.0   Initial write

::::::::::
:: Prep :: -- Don't change anything in this section
::::::::::
@echo off
set SCRIPT_VERSION=1.6.0
set SCRIPT_UPDATED=2015-08-13
:: Get the date into ISO 8601 standard date format (yyyy-mm-dd) so we can use it
FOR /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%

:: This is useful if we start from a network share; converts CWD to a drive letter
pushd "%~dp0" 2>NUL


:::::::::::::::
:: Variables :: -- Set these to your desired values
:::::::::::::::
:: Log location and name. Do not use trailing slashes (\)
set LOGPATH=%SystemDrive%\Logs
set LOGFILE=jre8_x64_update.log

:: Package to install. Do not use trailing slashes (\)
set LOCATION=
set BINARY=jre-8u40-windows-x64.msi
set FLAGS=ALLUSERS=1 /qn /norestart /l %LOGPATH%\%LOGFILE% JU=0 JAVAUPDATE=0 AUTOUPDATECHECK=0 RebootYesNo=No WEB_JAVA_SECURITY_LEVEL=M

:: Create the log directory if it doesn't exist
if not exist %LOGPATH% mkdir %LOGPATH%


::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: This first removes previous versions of the JRE
echo %CUR_DATE% %TIME%   Uninstalling all versions of JRE 8 x64 prior to installation of current version...>> "%LOGPATH%\%LOGFILE%"
wmic product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F864180__FF}'" call uninstall /nointeractive>> "%LOGPATH%\%LOGFILE%" 2>NUL
:: Sometimes the previous line doesn't work for whatever reason, so we run this line as well
wmic product where "name like 'Java 8 Update __ (64-bit)'" uninstall /nointeractive 2>NUL

:: This line installs the package from a local directory (if all files are in the same directory)
:: Nothing below this line will log correctly, because MSI logs in a different format than the standard "echo >> %logfile%" commands. Haven't had time to find a workaround.
msiexec /i "%BINARY%" %FLAGS%

:: This line kills the Java Update scheduler if it's running
%SystemRoot%\System32\taskkill.exe /f /im jusched.exe>>%LOGPATH%\%LOGFILE% 2>NUL

:: Uninstall the Java Auto Updater from Add/Remove Programs because it sometimes sneaks through
wmic product where "name like 'Java Auto Updater'" call uninstall /nointeractive 2>NUL

:: These lines disable the Java Auto-Updater keys in the registry
%SystemRoot%\System32\reg.exe DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v SunJavaUpdateSched /f>> "%LOGPATH%\%LOGFILE%" 2>NUL
%SystemRoot%\System32\reg.exe DELETE "HKLM\SOFTWARE\JavaSoft\Java Update" /f>> "%LOGPATH%\%LOGFILE%" 2>NUL

:: This stops the Java Quickstarter service
net stop JavaQuickStarterService>> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete JavaQuickStarterService>> "%LOGPATH%\%LOGFILE%" 2>NUL

:: This stops the Java update service
net stop SunJavaUpdateSched>> "%LOGPATH%\%LOGFILE%" 2>NUL
sc delete SunJavaUpdateSched>> "%LOGPATH%\%LOGFILE%" 2>NUL

:: This deletes the Java Update directory (normally contains jaureg.exe, jucheck.exe, and jusched.exe)
rmdir /S /Q "%CommonProgramFiles%\Java\Java Update\">> "%LOGPATH%\%LOGFILE%" 2>NUL
rmdir /S /Q "%CommonProgramFiles(x86)%\Java\Java Update\">> "%LOGPATH%\%LOGFILE%" 2>NUL

:: This deletes a bunch of pointless shortcuts Java installs in the All Users Start Menu (sigh...)
rmdir /S /Q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Java">> "%LOGPATH%\%LOGFILE%" 2>NUL

:: This installs the customization files to set the Java Web Security level to MEDIUM (default in all versions prior to JRE8)
XCOPY deployment.* %WINDIR%\Sun\Java\Deployment /I /Y >NUL
XCOPY *.sites %WINDIR%\Sun\Java\Deployment /I /Y >NUL

:: Pop back to original directory. This isn't necessary in stand-alone runs of the script, but is needed when being called from another script
popd

:: Return exit code to SCCM/PDQ Deploy/etc
exit /B %EXIT_CODE%

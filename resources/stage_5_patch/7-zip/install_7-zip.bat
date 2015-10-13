:: Purpose:       Installs a package
:: Requirements:  Run this script with a network admin account
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: History:       1.3.0-TRON - Merge x86 and x64 scripts into one master script
:: History:       1.2.1-TRON - Remove logging of ftype and assoc output since it's not of any consequence
::                1.2.0-TRON - Remove logging functions since Tron handles logging
::                1.0.0      + Initial write

:: Usage:         Run the script as an admin. By default, will associate 7-Zip with the common file compression formats 
::                                     (7z,bz2,bzip2,gz,gzip,lzh,lzma,rar,tar,tgz,zip)
::
::
::                Pass the argument "-Associate_All" to Associate 7-zip with ALL the file compression formats it supports
::                                       (001,7z,arj,bz2,bzip2,cab,cpio,deb,dmg,fat,gz,gzip,hfs,iso,lha,lzh,lzma,ntfs,
::                                               rar,rpm,squashfs,swm,tar,taz,tbz,tbz2,tgz,tpz,txz,vhd,wim,xar,xz,z,zip)
::
::                e.g. install_7-Zip.bat -Associate_All  


::::::::::
:: Prep :: -- Don't change anything in this section
::::::::::
@echo off
set VERSION=1.3.0-TRON
set UPDATED=2015-10-13
:: Get the date into ISO 8601 standard date format (yyyy-mm-dd) so we can use it
FOR /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%


:::::::::::::::
:: VARIABLES :: -- Set these to your desired values
:::::::::::::::
:: Location of installation files relative to install script. Do not use trailing slashes (\)
set "LOCATION=%~Dp0"

:: 64/32 bit dependant settings. Determine what package to install
IF EXIST "%ProgramFiles(x86)%" (
	set "BINARY=7-Zip_x64.msi"
		) else (
	set "BINARY=7-Zip_x32.msi"
)

:: Command-Line arguments to pass to installer
set "FLAGS=ALLUSERS=1 /q /norestart INSTALLDIR="C:\Program Files\7-Zip""

:: File associations
:: Set full list of file associations "-Associate_All" flag was passed, else set common list of associations
IF /I "%1"=="-Associate_All" (
		SET "FILE_ASSOC=001,7z,arj,bz2,bzip2,cab,cpio,deb,dmg,fat,gz,gzip,hfs,iso,lha,lzh,lzma,ntfs,rar,rpm,squashfs,swm,tar,taz,tbz,tbz2,tgz,tpz,txz,vhd,wim,xar,xz,z,zip"
	) ELSE (
		SET "FILE_ASSOC=7z,bz2,bzip2,gz,gzip,lzh,lzma,rar,tar,tgz,zip"
)

::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: Get into the correct directory
pushd "%LOCATION%"

:: This line installs the package from the local folder (if all files are in the same directory)
START "" /I /High /Wait MSIEXEC /I "%BINARY%" %FLAGS%

:: Create file associations
:: Basically we just use a couple FOR loops to iterate through the list since it's prettier than using individual 'assoc' and 'ftype' commands
for %%i in (%FILE_ASSOC%) do (
		:: Associations...
		assoc .%%i=7-Zip.%%i >nul 2>&1
		:: ...and Open With...
		ftype 7-Zip.%%i="C:\Program Files\7-Zip\7zFM.exe" "%%1" >nul 2>&1
	)


:finished
:: Pop back to original directory. This isn't necessary in stand-alone runs of the script, but is needed when being called from another script
popd

:: Return exit code to SCCM/PDQ Deploy/etc
exit /B %EXIT_CODE%

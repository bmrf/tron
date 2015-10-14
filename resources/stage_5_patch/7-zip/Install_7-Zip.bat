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
@ECHO OFF
:::::::::::::::
:: VARIABLES :: -- Set these to your desired values
:::::::::::::::
:: Location of installation files relative to install script. Do not use trailing slashes (\)
set "LOCATION=%~Dp0"
:: 64/32 bit dependant settings. Determine what package to install
IF EXIST "%ProgramFiles(x86)%" (
	set "BINARY=7-Zip_x64.msi"
		) else (
	set "BINARY=7-Zip_x86.msi"
)

:: Command-Line arguments to pass to installer
set "FLAGS=/Qn /NoRestart INSTALLDIR="C:\Program Files\7-Zip" ALLUSERS=1"

:: File associations
:: Set full list of file associations "-Associate_All" flag was passed, or else set common list of associations
IF /I "%1"=="-Associate_All" (
		SET "FILE_ASSOC=001,7z,arj,bz2,bzip2,cab,cpio,deb,dmg,fat,gz,gzip,hfs,iso,lha,lzh,lzma,ntfs,rar,rpm,squashfs,swm,tar,taz,tbz,tbz2,tgz,tpz,txz,vhd,wim,xar,xz,z,zip"
	) ELSE (
		SET "FILE_ASSOC=7z,bz2,bzip2,gz,gzip,lzh,lzma,rar,tar,tgz,zip"
)

:: =============== Don not change anything below this line =============== ::
::::::::::
:: Prep ::
::::::::::
set VERSION=1.3.0-TRON
set UPDATED=2015-10-13
:: Get into the correct directory
pushd "%LOCATION%"
:: Just in case file does not exist, will make sure script doesn't pause at a msiexec error message
IF NOT EXIST "%BINARY%" EXIT /B


::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: This line installs the package from the local folder (if all files are in the same directory)
START "" /Wait /I MSIEXEC /I "%BINARY%" %FLAGS%

:: Create file associations
:: Basically we just use a couple FOR loops to iterate through the list since it's prettier than using individual 'assoc' and 'ftype' commands
FOR %%I IN (%FILE_ASSOC%) DO (
		:: Associations...
		assoc .%%I=7-Zip.%%I >nul 2>&1
		:: ...and Open With...
		ftype 7-Zip.%%I="C:\Program Files\7-Zip\7zFM.exe" "%%1" >nul 2>&1
	)


:EOF
:: Pop back to original directory. This isn't necessary in stand-alone runs of the script, but is needed when being called from another script
popd
:: Return exit code
EXIT /B %EXIT_CODE%
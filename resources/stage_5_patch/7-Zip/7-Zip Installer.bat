:: Purpose:       Installs a package
:: Requirements:  Run this script with a network admin account
:: Author:        reddit.com/user/vocatus ( vocatus.gate@gmail.com ) // PGP key: 0x07d1490f82a211a2
:: History:       1.2.2-TRON * Make architecture-agnostic, now will detect correct system architecture and install relevant package
::                           * Replace all hard-coded system file paths with relevant variable for better portability
::                1.2.1-TRON - Remove logging of ftype and assoc output since it's not of any consequence
::                1.2.0-TRON - Remove logging functions since Tron handles logging
::                1.0.0      + Initial write

:: Usage:         Run the script and pass one of the following arguments to it:
::                  associate_common  Associate 7-Zip with the common file compression formats 
::                                     (7z,bz2,bzip2,gz,gzip,lzh,lzma,rar,tar,tgz,zip)
::                  associate_all     Associate 7-zip with ALL the file compression formats it supports
::
::                e.g. 7-Zip v9.20.bat associate_all  
::
::                Default is "associate_common" unless told otherwise


:::::::::::::::
:: VARIABLES :: -- Set these to your desired values
:::::::::::::::
:: Package to install. Do not use trailing slashes (\)
set BINARY_VERSION=9.38
set FLAGS=ALLUSERS=1 /q /norestart INSTALLDIR="%SystemDrive%\Program Files\7-Zip"


::::::::::
:: Prep :: -- Don't change anything in this section
::::::::::
@echo off
set VERSION=1.2.2-TRON
set UPDATED=2015-10-14
:: Get the date into ISO 8601 standard format (yyyy-mm-dd) so we can use it
FOR /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set DTS=%%a
set CUR_DATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%

:: Get into the correct directory
pushd "%~dp0"


::::::::::::::::::
:: INSTALLATION ::
::::::::::::::::::
:: Detect system architecture and install appropriate version
if /i '%PROCESSOR_ARCHITECTURE%'=='x86' (
	"7-Zip v%BINARY_VERSION% x86.msi" %FLAGS%
) else (
	"7-Zip v%BINARY_VERSION% x64.msi" %FLAGS%
)

:: Create file associations
:: Basically we just use a couple FOR loops to iterate through the list since it's prettier than using individual 'assoc' and 'ftype' commands
if '%1'=='associate_all' goto associate_all

:: This section will run no matter what's passed to the installer, UNLESS it's "associate_all" 
:associate_common
for %%i in (7z,bz2,bzip2,gz,gzip,lzh,lzma,rar,tar,tgz,zip) do (
		:: Associations...
		assoc .%%i=7-Zip.%%i >nul 2>&1
		:: ...and Open With...
		ftype 7-Zip.%%i="%ProgramFiles%\7-Zip\7zFM.exe" "%%1" >nul 2>&1
	)
goto finished

:: We do this section if "associate_all" was passed to the installer
:associate_all
for %%i in (001,7z,arj,bz2,bzip2,cab,cpio,deb,dmg,fat,gz,gzip,hfs,iso,lha,lzh,lzma,ntfs,rar,rpm,squashfs,swm,tar,taz,tbz,tbz2,tgz,tpz,txz,vhd,wim,xar,xz,z,zip) do (
		:: Associations...
		assoc .%%i=7-Zip.%%i >nul 2>&1
		:: ...and Open With...
		ftype 7-Zip.%%i="%ProgramFiles%\7-Zip\7zFM.exe" "%%1" >nul 2>&1
	)
goto finished

:finished
:: Pop back to original directory. This isn't necessary in stand-alone runs of the script, but is needed when being called from another script
popd

:: Return exit code to SCCM/PDQ Deploy/etc
exit /B %EXIT_CODE%

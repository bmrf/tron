:: Only needed once, not in each batch file
@echo off

set TRON_VERSION=10.0.0
set TRON_DATE=2017-02-09

:: This is an easy way to make all "function" batch files
:: in a directory available for the system to use. You can
:: also call them cleanly (with out the .bat extension)
:: which makes the rest of the code SO much easier to read
set PATH=%PATH%;%~dp0

:: The logfiles and backups and things go with the System
:: TRON is working on, not with TRON, so we will hardcode
:: them in an easy to understand and change way that will
:: leave them for the user to access if the thumb drive
:: or network drive is disconnected
REM set TRON_LOG_FILE=%SystemDrive%\tron_log.txt
set TRON_LOG_FILE=nul

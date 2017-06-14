:: Repair Default File Extensions for Windows 7
:: by: /u/cuddlychops06
:: modified for use in Tron project by /u/vocatus

@echo off
for %%i in (*.reg) do (
	echo Importing: %%i >> %LOGPATH%\%LOGFILE%
	reg import %%i >> %LOGPATH%\%LOGFILE%
)

:: Return exit code to SCCM/PDQ Deploy/Tron/etc
exit /B %EXIT_CODE%
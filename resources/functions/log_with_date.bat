:: Tron's log function with embedded date and time group (DTG)

:: When the whole argument (%1) string is wrapped in double quotes, it is sent as an argument.
:: The tilde syntax (%~1) removes the double quotes around the argument.
@echo off
echo:%CUR_DATE% %TIME% %~1>> "%LOGPATH%\%LOGFILE%"
echo:%CUR_DATE% %TIME% %~1
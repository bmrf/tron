:: Tron's log function

:: %1 reference contains the first argument passed to the function. When the
:: whole argument string is wrapped in double quotes, it is sent as an argument.
:: The tilde syntax (%~1) removes the double quotes around the argument.
@echo off
echo:%~1 >> "%LOGPATH%\%LOGFILE%"
echo:%~1

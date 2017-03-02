:: Logging should show twice... once from file and once from screen

:: USAGE :: call log_with_time "Proving the logging with time function works"

:: ECHO to the SCREEN
echo %date% %time% -- %~1

:: ECHO to the LOGFILE
echo %date% %time% -- %~1 >> %TRON_LOG_FILE%

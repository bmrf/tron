:: Logging should show twice... once from file and once from screen

:: USAGE :: call log_section_header "Testing logging header section"

:: ECHO to the SCREEN
echo ==============================================================================
echo == %~1
echo ==============================================================================

:: ECHO to the LOGFILE
echo ============================================================================== >> %TRON_LOG_FILE%
echo == %~1 >> %TRON_LOG_FILE%
echo ============================================================================== >> %TRON_LOG_FILE%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SETUP AREA COMMON TO TESTS AND MAIN TRON BATCH FILE
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: This is the easy way to add the master directory for TRON
:: You can have a 'setup.bat' in each subdirectory that is
:: called that will setup that directory in the path if needed
:: and or add it to the path
set TRON_DIR=%~dp0

:: The main entry point for non-user configurable setup, and
:: adding it at the top of the script and moving configurable
:: items into these types of scripts could allow the main file
:: to be directly edited by users ending the need for all of
:: the commandline parsing and configuration gyrations
call "%~dp0lib\tron_setup.bat"

:: Other files could also be called in this way and can be the
:: gateway into the subdirectories which could make then entire
:: system much more modularized. Parts could also be standalone.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: TESTS AND EXAMPLES START HERE
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

call log_section_header "Testing logging header section"
call log_with_time "Proving the logging with time function works"

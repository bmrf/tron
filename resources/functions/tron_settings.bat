:: Purpose:       Tron's settings script, called when it launches. Customize this file to change how Tron behaves. 
::                Sub-stage scripts also call this file if they're launched directly.
:: Requirements:  n/a
:: Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
:: Version:       1.0.5 - Remove references to Adobe Flash
::                1.0.4 + Add PRESERVE_MALWAREBYTES (-rmb) switch to have Tron automatically remove Malwarebytes at the end of the run
::                      + Add SKIP_COOKIE_CLEANUP (-scc) switch to have Tron preserve ALL cookies. Thanks to tbr:sebastian
::                1.0.3 + Add SKIP_ONEDRIVE_REMOVAL (-sor) switch. Thanks to github:ptrkhh
::                1.0.2 - Remove references to Java
::                1.0.1 + Add AUTORUN_IN_SAFE_MODE (-asm) switch and associated variable. Combine this with -a to automatically reboot to Safe Mode prior to running (legacy behavior)
::                1.0.0 . Initial write; forked out of v9.9.0 of tron.bat

:: Script version
set TRON_SETTINGS_SCRIPT_VERSION=1.0.5
set TRON_SETTINGS_SCRIPT_DATE=2021-01-15


:::::::::::::::
:: VARIABLES ::
:::::::::::::::
:: Rules for variables:
::  * NO quotes!                    (bad:  "c:\directory\path"       )
::  * NO trailing slashes on paths! (bad:   c:\directory\            )
::  * Spaces are okay               (okay:  c:\my folder\with spaces )
::  * Network paths are okay        (okay:  \\server\share name      )

:: LOGPATH is the parent directory for all of Tron's output (logs, backups, etc). Tweak the paths below to your liking if you want to change it
:: If you want a separate directory generated per Tron run (for example if doing multiple runs for testing), use something like this:
::   set LOGPATH=%SystemDrive%\logs\tron\%COMPUTERNAME%_%DTS%
set LOGPATH=%SystemDrive%\logs\tron

:: Master log file. To differentiate logfiles if you're doing multiple runs, you can do something like:
::  set LOGFILE=tron_%COMPUTERNAME%_%DTS%.log
set LOGFILE=tron.log

:: Where Tron should save files that the various virus scanners put in quarantine. Currently unused (created, but nothing is stored here)
set QUARANTINE_PATH=%LOGPATH%\quarantine

:: Registry, Event Logs, and power scheme backups are all saved here
set BACKUPS=%LOGPATH%\backups

:: Where to save raw unprocessed logs from the various sub-tools
set RAW_LOGS=%LOGPATH%\raw_logs

:: Where to save the summary logs (created from the raw logs)
set SUMMARY_LOGS=%LOGPATH%\summary_logs


:::::::::::::::::::::
:: SCRIPT DEFAULTS ::
:::::::::::::::::::::
:: ! These are Tron's defaults. All settings here are overridden if their respective command-line switch is used
::   If you use a CLI switch and Tron encounters a reboot, the CLI switch will be honored when the script resumes
:: AUTORUN                (-a)   = Automatic execution (no welcome screen or prompts), implies -e
:: AUTORUN_IN_SAFE_MODE   (-asm) = Automatic execution (no welcome screen or prompts), implies -e, autoboots to Safe Mode
:: DRY_RUN                (-d)   = Run through script but skip all actual actions (test mode)
:: DEV_MODE               (-dev) = Override OS detection and allow running Tron on unsupported OS's
:: EULA_ACCEPTED          (-e)   = Accept EULA (suppress disclaimer warning screen)
:: EMAIL_REPORT           (-er)  = Email post-run report with log file. Requires you to configure SwithMailSettings.xml prior to running
:: PRESERVE_METRO_APPS    (-m)   = Don't remove OEM Metro apps
:: NO_PAUSE               (-np)  = Set to yes to skip pause at the end of the script
:: AUTO_SHUTDOWN          (-o)   = Shutdown after the finishing. Overrides auto-reboot
:: PRESERVE_POWER_SCHEME  (-p)   = Preserve active power scheme. Default is to reset power scheme to Windows defaults at the end of Tron
:: PRESERVE_MALWAREBYTES  (-pmb) = Preserve Malwarebytes (don't uninstall it) after Tron is complete
:: AUTO_REBOOT_DELAY      (-r)   = Post-run delay (in seconds) before rebooting. Set to 0 to disable auto-reboot
:: SKIP_ANTIVIRUS_SCANS   (-sa)  = Skip ALL antivirus scans (KVRT, MBAM, SAV). Use per-scanner switches to individually toggle usage
:: SKIP_APP_PATCHES       (-sap) = Set to yes to skip application patches (don't patch 7-Zip)
:: SKIP_COOKIE_CLEANUP    (-scc) = Set to yes to preserve ALL cookies (not recommended, Tron auto-preserves most common login cookies)
:: SKIP_CUSTOM_SCRIPTS    (-scs) = Set to yes to forcibly skip Stage 8: Custom Scripts regardless whether or not .bat files exist in the directory
:: SKIP_DEFRAG            (-sd)  = Set to yes to override the SSD detection check and force Tron to always skip defrag regardless of the drive type
:: SKIP_DEBLOAT           (-sdb) = Set to yes to skip de-bloat section (OEM bloat removal). Implies -m
:: SKIP_DISM_CLEANUP      (-sdc) = Skip DISM Cleanup (SxS component store deflation)
:: SKIP_DEBLOAT_UPDATE    (-sdu) = Set to yes to prevent Tron from auto-updating the stage 2 debloat lists prior to Stage 0 execution
:: SKIP_EVENT_LOG_CLEAR   (-se)  = Set to yes to skip Event Log clear (don't backup and clear Windows Event Logs)
:: SKIP_KASKPERSKY_SCAN   (-sk)  = Set to yes to skip Kaspersky Virus Rescue Tool scan
:: SKIP_MBAM_INSTALL      (-sm)  = Set to yes to skip Malwarebytes Anti-Malware installation
:: SKIP_ONEDRIVE_REMOVAL  (-sor) = Set to yes to skip OneDrive removal regardless whether it's in use or not
:: SKIP_PAGEFILE_RESET    (-spr) = Skip page file settings reset (don't set to "Let Windows manage the page file")
:: SKIP_SOPHOS_SCAN       (-ss)  = Set to yes to skip Sophos Anti-Virus scan
:: SKIP_TELEMETRY_REMOVAL (-str) = Set to yes to skip Telemetry Removal (just turn telemetry off instead of removing it)
:: SKIP_WINDOWS_UPDATES   (-swu) = Set to yes to skip Windows Updates entirely (ignore both WSUS Offline and online methods)
:: SKIP_WSUS_OFFLINE      (-swo) = Set to yes to skip user-supplied WSUS Offline updates (if they exist; online updates still attempted)
:: UPLOAD_DEBUG_LOGS      (-udl) = Upload debug logs. Send tron.log and the system GUID dump to the Tron developer. Please use this if possible, logs are extremely helpful in Tron development
:: VERBOSE                (-v)   = When possible, show as much output as possible from each program Tron calls (e.g. Sophos, KVRT, etc). NOTE: This is often much slower
:: SELF_DESTRUCT          (-x)   = Set to yes to have Tron automatically delete itself after running. Leaves logs intact
set AUTORUN=no
set AUTORUN_IN_SAFE_MODE=no
set DRY_RUN=no
set DEV_MODE=no
set EULA_ACCEPTED=no
set EMAIL_REPORT=no
set PRESERVE_METRO_APPS=no
set NO_PAUSE=no
set AUTO_SHUTDOWN=no
set PRESERVE_POWER_SCHEME=no
set PRESERVE_MALWAREBYTES=no
set AUTO_REBOOT_DELAY=0
set SKIP_ANTIVIRUS_SCANS=no
set SKIP_APP_PATCHES=no
set SKIP_COOKIE_CLEANUP=no
set SKIP_CUSTOM_SCRIPTS=no
set SKIP_DEFRAG=no
set SKIP_DEBLOAT=no
set SKIP_DISM_CLEANUP=no
set SKIP_DEBLOAT_UPDATE=no
set SKIP_EVENT_LOG_CLEAR=no
set SKIP_KASPERSKY_SCAN=no
set SKIP_MBAM_INSTALL=no
set SKIP_ONEDRIVE_REMOVAL=no
set SKIP_PAGEFILE_RESET=no
set SKIP_SOPHOS_SCAN=no
set SKIP_TELEMETRY_REMOVAL=no
set SKIP_WINDOWS_UPDATES=no
set SKIP_WSUS_OFFLINE=no
set UPLOAD_DEBUG_LOGS=no
set UNICORN_POWER_MODE=off
set VERBOSE=no
set SELF_DESTRUCT=no

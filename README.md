##tron
====

#Background

Tron is a script that "fights for the User"; basically automates a bunch of scanning/disinfection/cleanup tools on a Windows system. I got tired of running these utilities manually when doing cleanup jobs on individual client machines, and decided to just script the whole thing. I hope this helps other techs and admins.

#Stages of Tron:

Prep: rkill, WMI repair
Tempclean: CCLeaner, BleachBit
Disinfect: Emsisoft Commandline Scanner, Vipre Rescue Scanner, Sophos Virus Removal Tool, Malwarebytes Anti-Malware, sfc /scannow
De-bloat: removes a variety of OEM bloatware; customizable list is in \resources\stage_3_de-bloat\programs_to_target.txt
Patch: Updates 7-Zip, Java, and Adobe Flash/Reader and disables nag/update screens (uses some of our PDQ packs); then installs all available Windows updates
Optimize: Defrag %SystemDrive% (usually C:); skipped if the drive is an SSD
Manual stuff: Contains some extra tools you can run manually if necessary (ComboFix, AdwCleaner, aswMBR, autoruns, etc.)

Saves a log to C:\Logs\tron.log.

#Screenshots
Welcome Screen: https://i.imgur.com/Z2WAp6e.png
Safe Mode warning: https://i.imgur.com/DOJnjow.png
Dry run (example): http://i.imgur.com/0avEW7D.png

#Changelog

v1.7.4 (2014-07-23)

    Fixed incorrectly-placed popd statement at beginning of :detect_safe_mode block. (Thanks to reddit.com/user/Eschmacher)

v1.7.3 (2014-07-22)

    prep and checks: Think we finally fixed SSD detection. Please test and report if it fails on your drive.

    prep and checks: Renamed all instances of REBOOT_DELAY to AUTO_REBOOT_DELAY

v1.7.2 (2014-07-22)

    tron.bat: Script now accepts "--auto" and "-a" as flags for automatic unattended execution

    tron.bat: Re-added check for Administrator rights using a 100% reliable method for Windows 2000 through Windows 8. Thanks to stackoverflow.com/users/3198799/and31415 for fix

    tron.bat: Reverted SSD check to something more reliable

    tron.bat: Moved all but most recent changelog entries to the changelog file, to avoid cluttering up script header

v1.7 (2014-07-21)

    tron.bat: Moved user-configurable variables to the top of the script, above Check and Prep section

    tron.bat: Added check for Administrator rights. (thanks to /u/apcomputerworks)

    stage_2_disinfect: Added Emsisoft Commandline Scanner, set to 'smart' scan + NTFS ADS scan, using Direct Disk Access mode and auto-deletion flag

    stage_6_manual_tools: Added TDSSKiller v3.0.0.40

    stage_6_manual_tools: Updated ComboFix to v14.7.21.1

    stage_6_manual_tools: Updated AdwCleaner to v3.2.1.6

#Download

    Primary: BT Sync read-only key: BYQYYECDOJPXYA2ZNUDWDN34O2GJHBM47 (use this to sync to the repo and you'll get updates/fixes as soon as they're pushed). Make sure the settings for your Sync folder look like this 
    
    http://i.imgur.com/fyOdU7H.png
    
#Integrity

checksums.txt contains MD5 checksums for every file and is signed with my PGP key (0x82A211A2; included). You can use this to verify package integrity if necessary.

Please suggest modifications and fixes; community input is helpful and appreciated.

café/cerveza: 1JZmSPe1MCr8XwQ2b8pgjyp2KxmLEAfUi7

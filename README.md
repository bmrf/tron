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

#Download

    Primary: BT Sync read-only key: BYQYYECDOJPXYA2ZNUDWDN34O2GJHBM47 (use this to sync to the repo and you'll get updates/fixes as soon as they're pushed). Make sure the settings for your Sync folder look like this 
    
    http://i.imgur.com/fyOdU7H.png
    
#Integrity

checksums.txt contains MD5 checksums for every file and is signed with my PGP key (0x82A211A2; included). You can use this to verify package integrity if necessary.

Please suggest modifications and fixes; community input is helpful and appreciated.

café/cerveza: 1JZmSPe1MCr8XwQ2b8pgjyp2KxmLEAfUi7

NAME:        Tron, an automatic cleaner/scanner/disinfector

AUTHOR:      vocatus on reddit.com/r/sysadmin ( vocatus d0t gate@gmail.com ) // PGP key ID: 0x82A211A2

BACKGROUND:  Why the name Tron? Tron "Fights for the User"

I got tired of running these utilities manually and decided to just automate everything, so Tron basically automates a variety of tasks to clean up/disinfect a Windows machine.


USE:

1. Boot into safe mode (with Network support is preferable).

2. Copy tron.bat and the \resources folder to the target machine and run tron.bat as an ADMINISTRATOR.
   Tron will refuse to run if you don't run as an Administrator.

3. Wait anywhere from 3-10 hours (yes, it really does take that long).

4. By default the log file is at C:\Logs\tron.log

Tron will briefly check for a newer version when it starts up and notify you if one is found. Depending on how badly the system is infected, it could take anywhere from 3 to 10 hours to run. I've personally observed times between 4-8 hours. Basically set it and forget it.


SAFE MODE:

Microsoft, in their long-standing tradition of breaking useful, heavily-used functionality for no reason, changed how you get into Safe Mode for Windows 8, disabling the traditional F8 method. Tron re-enables the F8 method as part of it's prep tasks (before actually running), but here's how to manually re-enable the old-style boot menu that supports the F8 key. From an admin command prompt, run this command:

    bcdedit /set {default} bootmenupolicy legacy
	
That's it. Reboot and you should now be able to use F8 to select Safe Mode. Note that this command is the same one Tron runs, so if you launch Tron to the menu and then exit, you'll accomplish the same thing.


COMMAND-LINE USE:

Command-line use is optional. All flags are optional and can be combined

 tron.bat [-a -c -d -p -r -s] | [-h]

  -a  Automatic/silent mode (no welcome screen)
  
  -c  Config dump (display current config. Can be used with other
      flags to see what WOULD happen, but script will never execute
      if this flag is used)
      
  -d  Dry run (run through script without executing any jobs)
  
  -h  Display help text
  
  -p  Preserve power settings (don't reset power settings to default)
  
  -r  Reboot automatically (auto-reboot 30 seconds after Tron completes)
  
  -s  Skip defrag (force Tron to ALWAYS skip Stage 5 defrag)


CHANGE DEFAULTS (advanced):

Defaults are always overridden by command-line flags, but if you don't want to use the command-line and don't like Tron's defaults, you can edit the script and change the following default variables:

  - To ALWAYS skip defrag, regardless whether C:\ is an SSD or not, change this line to read yes:
  - 
       set SKIP_DEFRAG=no
 
  - To change log location, edit these lines:
  - 
       set LOGPATH=%SystemDrive%\Logs

       set LOGFILE=tron.log
	   
  - To configure post-run reboot, change this value (in seconds). 0 disables auto-reboot:
  - 
       set AUTO_REBOOT_DELAY=0

  - To always run automatically (no welcome screen), change this to yes:
  - 
       set AUTORUN=no
  
  - To always do a dry run (don't actually execute jobs), change this to yes:
  - 
       set DRY_RUN=no


INTEGRITY:

In every release 'checksums.txt' is signed with my PGP key (0x82A211A2, included). You can use it to verify package integrity.
	   
LICENSE:

Tron and any associated bootstrapper scripts and .reg files that I've written are free to use/redistribute/whatever under the MIT license. It'd be nice if you sent an email and let me know if you do something cool with it, but it's not required.
	   
OTHER:

I try to keep everything updated. If you notice some of the packages are out of date (e.g. Java, which updates at the frequency of every 3 minutes), PM me on reddit or send me an email (listed above). I respond pretty quickly most days (<=6 hours).

Hope this is helpful to other PC techs,

 - Vocatus

If you feel overly charitable:
1JZmSPe1MCr8XwQ2b8pgjyp2KxmLEAfUi7

#########################
# FULL TRON DESCRIPTION #
#########################
tron.bat                         Master script that launches all the other tools. It performs a lot of actions on its own, but for any task we can't perform directly, it calls an external utility or script.

Tron prep jobs:

 . Detect SSD                    Detect solid state hard drives. If found, tron skips the Stage 5 defrag

 . Detect Safe Mode              Detect whether or not we're in Safe Mode and notifies the user if we're not
 
  . Enable F8 Safe Mode selection Re-enable the ability to use the F8 key on bootup (Windows 8/8.1 only; enabled by default on Server 2012/2012 R2)

 . Make log and quarantine dirs  Create the LOGPATH and QUARANTINE_PATH directories if they don't already exist

 . Check for update              Use wget to pull down md5sums.txt from the Tron mirror and see if we're on the current version.

 . Disk health check             Use smartctl.exe to run a quick SMART health check on the system drive. If it fails, notify the 
user.

STAGE 0: Prep

 . Rkill                         rkill is an anti-malware prep tool; it looks for and kills a number of known malware that 
interfere with removal tools
 
 . TDSS Killer                   anti-rootkit utility from Kaspersky Labs. Tron calls TDSSKiller with the following flags: -l %TEMP%\tdsskiller.log -silent -tdlfs -dcexact -accepteula -accepteulaksn

 . erunt                         used to backup the registry before beginning a Tron run

 . VSS purge                     purges oldest set of Volume Shadow Service files (basically snapshot-in-time copies of files). Malware can often hide out here.

 . Disable sleep mode            Tron disables sleep mode when the script starts to prevent going to sleep. At the end of the script it resets power settings to Windows defaults, unless you run with the -p flag

 . check and repair WMI          Tron checks WMI interface and attempts to repair it if it's broken. Tron uses WMI for a lot of stuff including getting the date into ISO format, wildcard OEM bloatware removal, and other stuff
 
STAGE 1: Tempclean

 . Internet Explorer cleanup     Runs built-in Windows tool to clean and reset Internet Explorer ( rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351 )

 . CCLeaner                      CCLeaner utility by Piriform. Used to clean temp files before running AV scanners

 . BleachBit                     BleachBit utility. Used to clean temp files before running AV scanners

 . TempFileClean                 Script I wrote to clean some areas that other tools seem to miss

 . Clear Windows event logs      Backs up Windows event logs by default to the LOGPATH directory, then clears all log files

 . Clear Windows Update cache    Purges uninstaller files for already-installed Windows Updates. Typically frees up quite a bit of space

STAGE 2: Disinfect

 . Sophos Virus Removal Tool     Command-line anti-virus scanner. Runs in debug mode for more verbose output

 . Vipre Rescue Scanner          Command-line anti-virus scanner.

 . Malwarebytes Anti-Malware     Anti-malware scanner. Because there is no command-line support for MBAM, we simply install it and continue with the rest of the script. This way a tech can click "scan" whenever they're around, but the script doesn't stall while waiting for user input.

 . DISM image check & repair     Microsoft utility for checking the Windows Image Store (basically like System File Checker on crack). Windows 8 and up only

 . System File Checker           Microsoft utility for checking the filesystem for errors and attempting to repair if found. Tron runs this on Windows Vista and up only (XP and below require a reboot)
 
STAGE 3: De-bloat, programs specified in: \resources\stage_3_de-bloat\programs_to_target.txt

 . OEM de-bloat                  Use WMI to attempt to uninstall any program listed in this file: \resources\stage_3_de-bloat\oem\programs_to_target.txt

 . Metro de-bloat                Remove the built-in Metro apps that no one uses (stuff like Calculator, Paint etc is not removed). Purges them from the cache (can always fetch from Windows Update later).

STAGE 4: Patch                   Tron installs or updates these programs:

 . 7-zip                         Open-source compression and extraction tool. Far superior to just about everything (including the venerable WinRAR)

 . Adobe Flash Player            Used by YouTube and various other sites

 . Adobe Reader                  Standard PDF reader

 . Java Runtime Environment      I hate Java, but it is still widely used so we at least get the system on the latest version

 . Notepad++                     Open-source text editor with syntax highlighting

 . Windows updates               Self-explanatory

 . DISM base reset               Recompiles the "Windows Image Store" after we finished purging old files from it earlier. Windows 8 and up only
 
STAGE 5: Optimize

 . chkdsk                        Checks disk for errors and schedules a chkdsk with repair at next reboot

 . Defraggler                    command-line defrag tool from Piriform

STAGE 6: Manual tools            Tron does not run these automatically because most of them don't support command-line use.

 . ADSSpy                        Scans for hidden ADS streams

 . AdwCleaner                    Popular user-suggested adware removal tool

 . aswMBR                        Rootkit scanner

 . autoruns                      Examine and remove programs that run at startup

 . ComboFix                      The "scorched-earth policy" of malware removal

 . gmer                          Rootkit/ADS scanner

 . Junkware Removal Tool         Temp files and random junkware remover

 . TempFileCleaner               OldTimer utility for cleaning temp files

 . VirusTotal uploader tool      Uploads a file directly to VirusTotal for scanning

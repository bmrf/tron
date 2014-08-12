NAME:    Tron, an automatic cleaner/scanner/disinfector.

AUTHOR:  vocatus on reddit.com/r/sysadmin ( vocatus.gate@gmail.com ) // PGP key ID: 0x82A211A2

BACKGROUND:
Why the name Tron? Tron "Fights for the Users."

I got tired of running these utilities manually and decided to just automate everything, so Tron basically automates a variety of tasks to clean up/disinfect a Windows machine.


USE: 
1. Boot into safe mode (with Network support is preferable).
2. Copy tron.bat and the \resources folder to the target machine and run tron.bat as an ADMINISTRATOR. Tron will refuse to run if you don't do this.
3. Wait anywhere from 3-10 hours (yes, it really does take that long).

By default the log file is at C:\Logs\tron.log

Depending on how badly the computer is messed up, the script could take anywhere from 3 hour to 10 hours to run. I've personally observed times of about 3-7 hours. Basically set it and forget it.


COMMAND-LINE USE:
(all flags are optional and can be combined)

 tron.bat [-a -c -d -p -r -s] | [-h]

  -a  Automatic/silent mode (no welcome screen)
  
  -c  Config dump (display current config. Can be used with other
      flags to see what WOULD happen, but script will never execute
      if this flag is used)
      
  -d  Dry run (run through script without executing any jobs)
  
  -h  Display help text
  
  -p  Preserve power settings (don't reset power settings to default)
  
  -r  Reboot (auto-reboot 30 seconds after Tron completes)
  
  -s  Skip defrag (force Tron to ALWAYS skip Stage 5 defrag)


CHANGE DEFAULTS (advanced):
Defaults are always overridden by the command-line flags, but if you don't want to use the command-line and don't like Tron's defaults, you can edit the script and change the following default variables:

  - To ALWAYS skip defrag, regardless whether C:\ is an SSD or not, change this line to read yes:
       set SKIP_DEFRAG=no
 
  - To change log location, edit these lines:
       set LOGPATH=%SystemDrive%\Logs
       set LOGFILE=tron.log
	   
  - To configure post-run reboot, change this value (in seconds). 0 disables auto-reboot:
       set AUTO_REBOOT_DELAY=0

  - To always run automatically (no welcome screen), change this to yes:
       set AUTORUN=no
  
  - To always do a dry run (don't actually execute jobs), change this to yes:
       set DRY_RUN=no

OTHER:
I try to keep everything updated. If you notice some of the packages are out of date (e.g. Java, which seems to update at the frequency of every 3 seconds), shoot me a message on reddit - I respond pretty quickly most days (<=6 hours), and can also be reached by email (listed above).

Finally, in every release I sign 'checksums.txt' with my PGP key (0x82A211A2, included). You can use it to verify package integrity.

Hope this is helpful to other PC techs,

 - Vocatus

If you get to feeling overly charitable:
1JZmSPe1MCr8XwQ2b8pgjyp2KxmLEAfUi7

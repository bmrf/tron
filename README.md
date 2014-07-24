NAME:    Tron, an automatic cleaner/scanner/disinfector.

AUTHOR:  vocatus on reddit.com/r/sysadmin ( vocatus.gate@gmail.com ) // PGP key ID: 0x82A211A2

BACKGROUND:
Why the name Tron? Tron "Fights for the Users."

I got tired of running all these cleaners/scanners manually and decided to just automate everything, so this script automates a variety of tasks to clean up/disinfect Windows machines.


USAGE:
1. Boot into safe mode (with Network support is preferable).
2. Keep everything together the way it was when you got it (should be Tron.bat and a '\resources' folder). Tron.bat is just a batch file that calls other commands/programs/scripts, and is pretty well commented so you can crack it open with a text editor and see what it's doing if you'd like.
3. Copy the whole tron folder (Tron.bat and the \resources folder) to the target machine, and run Tron.bat as an ADMINISTRATOR.
4. Wait anywhere from 3-10 hours (yes, it really does take that long).
5. Default log file is at C:\Logs\tron.log

Depending on how badly the computer is messed up, the script could take anywhere from 3 hour to 10 hours to run. I've personally observed times of about 3-7 hours. Basically set it and forget it.


ADVANCED USAGE:
 - If you want to run Tron automatically (e.g. with zero prompts), run it from a command-prompt like this:
       tron.bat --auto
       tron.bat -a

 - If you want to force Tron to ALWAYS skip defrag, regardless whether C:\ is an SSD or not, edit this line in the script to say "yes" instead of "no":
       set SKIP_DEFRAG=no
 
  - To change log location, edit the script and edit these lines:
       set LOGPATH=%SystemDrive%\Logs
       set LOGFILE=tron.log


OTHER:
I try to keep everything updated. If you notice some of the packages are out of date (e.g. Java, which seems to update at the frequency of every 3 seconds), shoot me a message on reddit - I respond pretty quickly most days (<=6 hours), and can also be reached by email (listed above).

Finally, in every release I sign 'checksums.txt' with my PGP key (0x82A211A2, included). You can use it to verify package integrity.

Hope this is helpful to other PC techs,

 - Vocatus

If you get to feeling overly charitable:
1JZmSPe1MCr8XwQ2b8pgjyp2KxmLEAfUi7

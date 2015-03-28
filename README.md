| NAME       | Tron, an automated PC cleanup script                                                        |
| :--------- | :------------------------------------------------------------------------------------------ |
| AUTHOR     | vocatus on reddit.com/r/TronScript (`vocatus d0t gate@gmail.com`) // PGP key: `0x07d1490f82a211a2` |
| BACKGROUND | Why the name? Because Tron "Fights for the User"                                               |

I got tired of running these utilities manually and decided to just automate everything, so Tron basically automates a variety of tasks to clean up/disinfect a Windows machine.

# CONTENTS

1. Usage Summary

2. Command-Line Use

3. Script Interruption

4. Notes on Safe Mode

5. Sending a Post-Run Email Report

6. Changing Defaults

7. Pack Integrity

8. License

9. Contact Info

10. Full details of ALL steps

# USE

1. Boot into Safe Mode with Network Support (Safe Mode is not required but is strongly recommended)

2. Copy `tron.bat` and the `\resources` folder to the target machine and run `tron.bat` as an **ADMINISTRATOR** (Tron does not work if you don't it run as an Administrator)

3. Wait anywhere from **3-10 hours** (yes, it takes that long)

4. Reboot

By default the master log file is at `C:\Logs\tron\tron.log`. If you want to change this, read the section on changing defaults below.

Tron will briefly check for a newer version when it starts up and notify you if one is found. Depending how badly the system is infected, it could take anywhere from 3 to 10 hours to run. I've personally observed times between 4-8 hours, and one user reported a run time of 30 hours. Basically set it and forget it.

# COMMAND-LINE USE

Command-line use is fully supported. All flags are optional and can be combined. *

    tron.bat [-a -c -d -e -er -gsl -m -o -p -r -sa -sb -sd -se -sp -sw -v -x] | [-h]

    -a   Automatic mode (no welcome screen or prompts; implies -e)

    -c   Config dump (display current config. Can be used with other
         flags to see what WOULD happen, but script will never execute
         if this flag is used)

    -d   Dry run (run through script without executing any jobs)
    
    -e   Accept EULA (suppress disclaimer warning screen)
    
    -er  Email a report when finished. Requires you to configure SwithMailSettings.xml
    
    -gsl Generate summary logs. These list exactly what files and programs were removed

    -h   Display help text
    
    -m   Preserve default Metro apps (don't remove them)

    -o   Power off after running (overrides -r)

    -p   Preserve power settings (don't reset to Windows default)
    
    -r   Reboot automatically (auto-reboot 15 seconds after completion)

    -sa  Skip anti-virus scans (Sophos, Vipre, MBAM)
    
    -sb  Skip de-bloat (OEM bloatware removal; implies -m)

    -sd  Skip defrag (force Tron to ALWAYS skip Stage 5 defrag)
    
    -se  Skip Event Log clear (don't clear Windows Event Logs)

    -sp  Skip patches (do not patch 7-Zip, Java Runtime, Adobe Flash or Reader)

    -sw  Skip Windows Updates (do not attempt to run Windows Update)

    -v   Verbose. Show as much output as possible. NOTE: Significantly slower!
    
    -x   Self-destruct. Tron deletes itself after running and leaves logs intact
   
\* There is no -UPM flag


# SCRIPT INTERRUPTION

If the script is interrupted e.g. from a crash or a forced reboot (often encountered during stage_3_de-bloat), it will attempt to resume from the last stage successfully started. Tron accomplishes this by creating a `RunOnce` registry key for the current user at the beginning of Stage 0 (e.g. when jobs start executing), and deleting it at the end of the script if everything finished without interruption.

There are two limitations on the resume feature:

1. You must log back in as the original user that ran the script in the first place

2. ONLY command-line flags are preserved across a restart! Changes to the script defaults (accomplished by manually changing the variables in the script) are NOT preserved. 
 
More details about this function are in the list of all Tron steps at the bottom of this document.

# SAFE MODE

Microsoft, in their long-standing tradition of breaking useful, heavily-used functionality for no reason, changed how you get into Safe Mode for Windows 8, disabling the traditional F8 method. Tron re-enables the F8 method as part of it's prep tasks (before actually running), but here's how to manually re-enable the old-style boot menu that supports the F8 key. From an admin command prompt, run this command:

    bcdedit /set {default} bootmenupolicy legacy

Reboot and you should now be able to use F8 to select Safe Mode. Note that this command is the same one Tron runs, so if you launch Tron to the menu and then exit, you'll accomplish the same thing.


# EMAIL REPORT
To have Tron send an email report at completion, edit this file:

    \resources\stage_6_wrap-up\email_report\SwithMailSettings.xml
    
Specify your SMTP server, username, and password. After specifying your settings you can use the -er flag to have Tron send the email report. If you used the -gsl flag (generate summary logs) then `tron_removed_files.txt` and `tron_removed_programs.txt` will be attached as well.

Keep in mind the username and password for the email account will be stored in PLAIN TEXT so don't leave it lying around on a system you don't trust.


# CHANGE DEFAULTS (advanced)

If you don't want to use the command-line and don't like Tron's defaults, you can change the following default variables. Keep in mind command-line flags will always override their respective default option when used.

- To change the master directory where all of Tron's output goes, edit this line:
  ```
  set LOGPATH=%SystemDrive%\Logs\tron
  ```

- To change the name of Tron's master log file, edit this line:
  ```
  set LOGFILE=tron.log
  ```
  
- To change where Tron stores quarantined files, change this path (note: this is currently unused by Tron, setting it has no effect):
  ```
  set QUARANTINE=%LOGPATH%\quarantine
  ```

- To change the location of the backups Tron makes (Registry, Event Logs, power scheme, etc), edit this line:
  ```
  set BACKUPS=%LOGPATH%\backups
  ```
  
- To change where Tron saves raw unprocessed logs from the various sub-tools, edit this line:
  ```
  set RAW_LOGS=%LOGPATH%\raw_logs
  ```
  
- To change where Tron saves summary logs (generated if the -gsl flag is used), edit this line:
  ```
  set SUMMARY_LOGS=%LOGPATH%\summary_logs
  ```
  
- To always run automatically (no welcome screen, implies acceptance of EULA), change this to `yes`:
  ```
  set AUTORUN=no
  ```

- To always do a dry run (don't actually execute jobs), change this to `yes`:
  ```
  set DRY_RUN=no
  ```
  
- To permanently accept the End User License Agreement (suppress display of disclaimer warning screen), change this to `yes`:
  ```
  set EULA_ACCEPTED=no
  ```

- To have Tron send an email report when finished, change this to `yes`:
  ```
  set EMAIL_REPORT=no
  ```

- To have Tron generate summary logs (listing deleted files and removed programs), change this to `yes`:
  ```
  set GENERATE_SUMMARY_LOGS=no
  ```
  
- To preserve default Metro apps (don't remove them), change this to `yes`:
  ```
  set PRESERVE_METRO_APPS=no
  ```

- To shut down the computer when Tron is finished, change this to `yes`:
  ```
  set AUTO_SHUTDOWN=no
  ```

- To preserve the power scheme (instead of resetting to Windows defaults), change this to `yes`:
  ```
  set PRESERVE_POWER_SCHEME=no
  ```

- To configure post-run reboot, change this value (in seconds). `0` disables auto-reboot:
  ```
  set AUTO_REBOOT_DELAY=0
  ```
  
- To skip anti-virus scan engines (Sophos, Vipre, MBAM), change this to `yes`:
  ```
  set SKIP_ANTIVIRUS_SCANS=no
  ```

- To skip OEM debloat, change this to `yes`:
  ```     
  set SKIP_DEBLOAT=no
  ```
  
- To always skip defrag, regardless whether `C:\` is an SSD or not, change this to `yes`:
  ```
  set SKIP_DEFRAG=no
  ```
  
- To skip Windows Event Log clearing, change this to `yes`:
  ```
  set SKIP_EVENT_LOG_CLEAR=no
  ```

- To skip patches (don't patch 7-Zip, Java, Adobe Flash and Reader) change this to `yes`:
  ```
  set SKIP_PATCHES=no
  ```

- To skip Windows Updates (don't attempt to run Windows Update) change this to `yes`:
  ```
  set SKIP_WINDOWS_UPDATES=no
  ```
  
- To display as much output as possible (verbose), change this to `yes`:
  ```
  set VERBOSE=no
  ```

- To have Tron delete itself after running (self-destruct), change this to `yes`:
  ```
  set SELF_DESTRUCT=no
  ```

* There is no -UPM flag


# INTEGRITY

In every release `checksums.txt` is signed with my PGP key (`0x82A211A2`, included). You can use it to verify package integrity.


# LICENSE

Tron and any associated bootstrapper scripts and `.reg` files that I've written are free to use/redistribute/whatever under the **MIT license**. It'd be nice if you sent an email and let me know if you do something cool with it, but it's not required. All 3rd-party tools Tron calls (MBAM, TDSSK, etc) are bound by their respective licenses. It's YOUR responsibility to determine if you can use them in your specific situation.


# OTHER

I try to keep everything updated. If you notice some of the packages are out of date, PM me on reddit or send me an email (listed above), I respond pretty quickly most days.

Hope this is helpful to other PC techs,

– Vocatus

If you feel overly charitable:
```
1JWMVs5hQ5SnHxMu5QbRffQWkMy8k4SmLV
```


# FULL TRON DESCRIPTION
The best way to see what Tron does is simply to crack `Tron.bat` open with a text editor (preferably one with syntax highlighting) or here on Github and just read the code. Every section has comments explaining exactly what it does, and you don't need to be able to read code to understand it. However, barring that, here's a general description of every action Tron performs.

## tron.bat
Master script that launches all the other tools. It performs a lot of actions on its own, but for any task we can't perform directly, we call an external utility or script


## Tron-internal prep jobs

1. **Detect SSD**: Detect solid state hard drives. If found, tron skips the **Stage 5 defrag**

2. **Detect Safe Mode**: Detect whether or not we're in Safe Mode and notify the user if we're not

3. **Detect Administrator rights**: Detect whether or not we're running as Administrator and alert the user if we're not

4. **Create RunOnce entry**: Create the following registry key to support resuming if there is an interruption: `HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /v "tron_resume" /t REG_SZ /d "%~dp0tron.bat %-resume"`

5. **Create System Restore point**: Windows Vista and up only; client OS's only (not supported on Server OS's). Tron creates a system restore snapshot before beginning operations

6. **Enable F8 Safe Mode selection**: Re-enable the ability to use the `F8` key on bootup (Windows 8/8.1 only; enabled by default on Server 2012/2012 R2)

7. **Make log directories**: Create the master log directory and sub-directories if they don't exist

8. **Check for update**: Use `wget` to pull down `sha256sums.txt` from the Tron mirror and see if we're on the current version. Tron will ask to automatically download the newest version. If you answer yes, it will download a copy to the desktop, verify the SHA256 hash, and then self-destruct the current copy


## STAGE 0: Prep

1. **Rkill**: Rkill is an anti-malware prep tool; it looks for and kills a number of known malware that interfere with removal tools

2. **ProcessKiller**: Utility provided by /u/cuddlychops06 which kills various userland processes. We use this to further kill anything that might interfere with Tron. Specifically, it kills everything in userland with the exception of the following processes: `ClassicShellService.exe`, `explorer.exe`, `dwm.exe`, `cmd.exe`, `mbam.exe`, `teamviewer.exe`, `TeamViewer_Service.exe`, `Taskmgr.exe`, `Teamviewer_Desktop.exe`, `MsMpEng.exe`, `tv_w32.exe`, `VTTimer.exe`, `Tron.bat`, `rkill.exe`, `rkill64.exe`, `rkill.com`, `rkill64.com`, `conhost.exe`, `dashost.exe`, `wget.exe`

3. **McAfee Stinger**: Anti-malware/rootkit/virus standalone scanner from McAfee. Does not support plain-text logs so we save its HTML log to Tron's %LOGPATH%. Tron executes Stinger as follows: 

  ```
  stinger32.exe --GO --SILENT --PROGRAM --REPORTPATH="%LOGPATH%" --RPTALL --DELETE`
  ```

4. **KVRT**: Kaspersky Virus Removal Tool, replaces TDSSKiller

  ```
  -l %TEMP%\tdsskiller.log -silent -tdlfs -dcexact -accepteula -accepteulaksn
  ```

5. **erunt**: Used to backup the registry before beginning a Tron run

6. **VSS purge**: Purges oldest set of Volume Shadow Service files (basically snapshot-in-time copies of files). Malware can often hide out here

7. **Disable sleep mode**: Tron disables sleep mode when the script starts to prevent going to sleep. At the end of the script it resets power settings to Windows defaults, unless you run with the -p flag

8. **Check and repair WMI**: Check the WMI interface and attempt repair if broken. Tron uses WMI for a lot of stuff including ISO date format conversion, OEM bloatware removal, and various other things, so having it functioning is critical


## STAGE 1: Tempclean

1. **Internet Explorer cleanup**: Runs built-in Windows tool to clean and reset Internet Explorer:

  ```
  rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351
  ```

2. **CCLeaner**: CCLeaner utility by Piriform. Used to clean temp files before running AV scanners

3. **BleachBit**: BleachBit utility. Used to clean temp files before running AV scanners

4. **TempFileClean**: Script I wrote to clean some areas that other tools seem to miss

5. **DriveCleanup.exe**: Cleans unused/not present USB device drivers. Utility from Uwe Sieber ( www.uwe-sieber.de )

6. **Clear Windows event logs**: Backs up Windows event logs by default to the LOGPATH directory, then clears all log files

7. **Clear Windows Update cache**: Purges uninstaller files for already-installed Windows Updates. Typically frees up quite a bit of space


## STAGE 2: De-bloat

1. **OEM de-bloat** (by name): Use WMI to attempt to uninstall any program listed in this file:

  ```
  \resources\stage_2_de-bloat\oem\programs_to_target.txt
  ```

2. **OEM de-bloat** (by GUID): Use WMI to attempt to remove specific list of GUIDs in this file:

  ```
  \resources\stage_2_de-bloat\oem\programs_to_target_by_GUID.bat
  ```

3. **Metro de-bloat**: Remove built-in Metro apps that no one uses (programs like Calculator, Paint etc are NOT removed). Purges them from the cache (can always fetch from Windows Update later)


## STAGE 3: Disinfect

1. **RogueKiller**: anti-rootkit utility and anti-malware prep tool. Similar to rkill

2. **Sophos Virus Removal Tool**: Command-line anti-virus scanner. Using Tron's `-v` flag gives more verbose output. Using Tron's `-sa` flag skips this component

3. **Vipre Rescue Scanner**: Command-line anti-virus scanner. Using Tron's `-v` flag gives more verbose output. Using Tron's `-sa` flag skips this component

4. **Malwarebytes Anti-Malware**: Anti-malware scanner. Because there is no command-line support for MBAM, we simply install it and continue with the rest of the script. This way a tech can click **Scan** whenever they're around, but the script doesn't stall while waiting for user input. Using Tron's `-sa` flag skips this component

5. **DISM image check & repair**: Microsoft utility for checking the Windows Image Store (sort of a more powerful System File Checker). Windows 8 and up only

6. **System File Checker**: Microsoft utility for checking the filesystem for errors and attempting to repair if found. Only run on Windows Vista and up (XP and below require a reboot)


## STAGE 4: Patch
Tron installs or updates these programs:

1. **7-zip**: Open-source compression and extraction tool. Far superior to just about everything (including the venerable WinRAR). Using Tron's `-sp` flag skips this component

2. **Adobe Flash Player**: Used by YouTube and various other sites. Using Tron's `-sp` flag skips this component

3. **Adobe Reader**: Standard PDF reader. Using Tron's `-sp` flag skips this component

4. **Java Runtime Environment**: I hate Java, but it is still widely used so we at least get the system on the latest version. Using Tron's `-sp` flag skips this component

5. **Windows updates**: Self-explanatory

6. **DISM base reset**: Recompiles the "Windows Image Store" after we finished purging old files from it earlier. Windows 8 and up only


## STAGE 5: Optimize

1. **chkdsk**: Checks disk for errors and schedules a chkdsk with repair at next reboot

2. **Defraggler**: Command-line defrag tool from Piriform that's a little faster than the built-in Windows defragmenter


## STAGE 6: Wrap-up

1. **email_report**: Sends an email report with log file when Tron finishes. Requires you to specify your SMTP settings in `\resources\stage_6_wrap-up\email_report\SwithMailSettings.xml`

2. **generate summary logs**: If selected with -gsr flag or GENERATE_SUMMARY_LOGS variable, Tron will generate before and after logs detailing which files were deleted and which programs were removed. These are placed in `LOGPATH\tron_summary_logs`. Additionally, if -er flag was used or EMAIL_REPORT variable was set, these logs will be attached to the email that is sent out

## STAGE 7: Manual tools
Tron does not run these automatically because most of them don't support command-line use.

1. **ADSSpy**: Scans for hidden NTFS Alternate Data Streams

2. **AdwCleaner**: Popular user-suggested adware removal tool

3. **aswMBR**: Rootkit scanner

4. **autoruns**: Examine and remove programs that run at startup

5. **ComboFix**: The "scorched-earth policy" of malware removal

6. **PCHunter**: Tool to scan for rootkits and other malicious items. Replaces gmer

7. **Junkware Removal Tool**: Temp files and random junkware remover

8. **Net Adapter Repair**: Utility to repair most aspects of Windows network connections

9. **ServicesRepair.exe**: ESET utility for fixing broken Windows services

10. **TempFileCleaner**: OldTimer utility for cleaning temp files

11. **VirusTotal uploader tool**: Uploads a file directly to VirusTotal for scanning

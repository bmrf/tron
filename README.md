| NAME       | Tron, an automated PC cleanup script                                                        |
| :--------- | :------------------------------------------------------------------------------------------ |
| AUTHOR     | vocatus on [reddit.com/r/TronScript](https://reddit.com/r/tronscript) (`vocatus d0t gate@gmail`) // PGP key: `0x07d1490f82a211a2` |
| BACKGROUND | Why the name? Tron "Fights for the User"                                               |

# DO NOT DOWNLOAD TRON FROM GITHUB, IT WILL NOT WORK!! YOU NEED THE ENTIRE PACKAGE FROM [/r/TronScript](https://www.reddit.com/r/TronScript) !!

I got tired of running these utilities manually and decided to just script everything, so Tron is essentially a glorified batch file that automates a variety of tasks to clean up/disinfect a Windows machine.

# CONTENTS

1. [Usage Summary](#use)

2. [Command-Line Use](#command-line-use)

3. [Script Interruption](#script-interruption)

4. [Notes on Safe Mode](#safe-mode)

5. [Sending a Post-Run Email Report](#email-report)

6. [Changing Defaults](#change-defaults-advanced)

7. [Pack Integrity](#integrity)

8. [License](#license)

9. [Contact Info](#other)

10. [Full description of ALL actions](#full-tron-description)

# USE

1. First, [boot into Safe Mode with Network Support](#safe-mode). If you skip this step Tron will prompt you to automatically reboot into Safe Mode. You don't have to run Tron in Safe Mode, **but** it is strongly recommended.

2. Copy `tron.bat` and the `\resources` folder to the Desktop of target machine and run `tron.bat` as an **ADMINISTRATOR** (Tron does not work if you don't it run as an Administrator)

3. Wait anywhere from **3-10 hours** (yes, it takes that long)

4. Reboot

By default the master log file is at `C:\Logs\tron\tron.log`. If you want to change this, read the section on changing defaults below.

Tron will briefly check for a newer version when it starts up and notify you if one is available.

Depending how badly the system is infected, it could take anywhere from 3 to 10 hours to run. I've personally observed times between 4-8 hours, and one user reported a run time of 30 hours. Basically set it and forget it.


# COMMAND-LINE USE

Command-line use is fully supported. All flags are optional and can be combined. *

    tron.bat [-a -c -d -dev -e -er -m -o -p -r -sa -sb -sd -se -sfr -sk -sm 
              -sp -spr -srr -ss -str -sw -v -x] | [-h]

    Optional flags (can be combined):

     -a   Automatic mode (no welcome screen or prompts; implies -e)

     -c   Config dump (display current config. Can be used with other
          flags to see what WOULD happen, but script will never execute
          if this flag is used)

     -d   Dry run (run through script without executing any jobs)
    
     -dev Override OS detection (allow running on unsupported Windows versions)

     -e   Accept EULA (suppress disclaimer warning screen)

     -er  Email a report when finished. Requires you to configure SwithMailSettings.xml

     -m   Preserve default Metro apps (don't remove them)

     -o   Power off after running (overrides -r)

     -p   Preserve power settings (don't reset to Windows default)

     -r   Reboot automatically (auto-reboot 15 seconds after completion)

     -sa  Skip ALL anti-virus scans (KVRT, MBAM, SAV)

     -sb  Skip de-bloat (OEM bloatware removal; implies -m)

     -sd  Skip defrag (force Tron to ALWAYS skip Stage 5 defrag)

     -se  Skip Event Log clear (don't clear Windows Event Logs)

     -sfr Skip filesystem permissions reset (saves time if you're in a hurry)

     -sk  Skip Kaspersky Virus Rescue Tool (KVRT) scan

     -sm  Skip Malwarebytes Anti-Malware (MBAM) installation

     -sp  Skip patches (do not patch 7-Zip, Java Runtime, Adobe Flash or Reader)

     -spr Skip page file reset (don't set to "Let Windows manage the page file")

     -srr Skip registry permissions reset (saves time if you're in a hurry)

     -ss  Skip Sophos Anti-Virus (SAV) scan

     -str Skip Telemetry Removal (don't remove Windows user tracking, Win7 and up only)

     -sw  Skip Windows Updates (do not attempt to run Windows Update)

     -v   Verbose. Show as much output as possible. NOTE: Significantly slower!

     -x   Self-destruct. Tron deletes itself after running and leaves logs intact

    Misc flags (must be used alone):

     -h   Display help text


\* There is no -UPM flag


# SCRIPT INTERRUPTION

If the script is interrupted e.g. from a crash or a forced reboot (often encountered during stage_2_de-bloat), it will attempt to resume from the last stage successfully started. Tron accomplishes this by creating a `RunOnce` registry key for the current user at the beginning of Stage 0 (e.g. when jobs start executing), and deleting it at the end of the script if everything finished without interruption.

More details about this function can be found in the list of all actions Tron performs at the bottom of this document.


# SAFE MODE

Tron doesn't *need* to be run in Safe Mode, but it is **strongly recommended**. 

When Tron launches it will briefly check if the computer is in Safe Mode with Networking, and if not it will prompt you to automatically reboot into it.


# EMAIL REPORT
To have Tron send an email report at completion, edit this file:

    \tron\resources\stage_7_wrap-up\email_report\SwithMailSettings.xml

Specify your SMTP server, username, and password. After specifying your settings you can use the `-er` flag to have Tron send the email report. The summary logs (`tron_removed_files.txt` and `tron_removed_programs.txt`) will be attached as well.

Keep in mind the username and password for the email account will be stored in PLAIN TEXT so don't leave it lying around on a system you don't trust.


# CHANGE DEFAULTS (advanced)

If you don't want to use the command-line and don't like Tron's defaults, you can change the following default variables. Keep in mind command-line flags will always override their respective default option when used.

- To change the master directory where all of Tron's output goes, edit this line:
  ```
  set LOGPATH=%SystemDrive%\Logs\tron
  ```

- To change the name of the master log file, edit this line:
  ```
  set LOGFILE=tron.log
  ```

- To change where Tron stores quarantined files, change this path (note: this is currently unused by Tron, setting it has no effect):
  ```
  set QUARANTINE_PATH=%LOGPATH%\quarantine
  ```

- To change the location of the backups Tron makes (Registry, Event Logs, power scheme, etc), edit this line:
  ```
  set BACKUPS=%LOGPATH%\backups
  ```

- To change where Tron saves raw unprocessed logs from the various sub-tools, edit this line:
  ```
  set RAW_LOGS=%LOGPATH%\raw_logs
  ```

- To change where Tron saves summary logs, edit this line:
  ```
  set SUMMARY_LOGS=%LOGPATH%\summary_logs
  ```

- To always run automatically (no welcome screen, implies acceptance of EULA), change this to `yes`:
  ```
  set AUTORUN=no
  ```

- To do a dry run (don't actually execute jobs), change this to `yes`:
  ```
  set DRY_RUN=no
  ```

- To override OS detection (allow Tron to run on unsupported Windows versions), change this to `yes`:
  ```
  set DEV_MODE=no
  ```

- To permanently accept the End User License Agreement (suppress display of disclaimer warning screen), change this to `yes`:
  ```
  set EULA_ACCEPTED=no
  ```

- To have Tron send an email report when finished, change this to `yes`:
  ```
  set EMAIL_REPORT=no
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

- To skip anti-virus scan engines (MBAM, KVRT, Sophos), change this to `yes`:
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

- To prevent Tron from granting the SYSTEM and Administrator accounts full permissions to everything under the `%WinDir%` directory structure, change this to `yes`:
  ```
  set SKIP_FILEPERMS_RESET=no
  ```

- To skip scanning with Kaspersky Virus Rescue Tool (KVRT), change this to `yes`:
  ```
  set SKIP_KASPERSKY_SCAN=no
  ```

- To skip installation of Malwarebytes Anti-Malware (MBAM), change this to `yes`:
  ```
  set SKIP_MBAM_INSTALL=no
  ```

- To skip patches (don't patch 7-Zip, Java, Adobe Flash and Reader) change this to `yes`:
  ```
  set SKIP_PATCHES=no
  ```

- To prevent Tron from resetting the page file to Windows defaults, change this to `yes`:
  ```
  set SKIP_PAGEFILE_RESET=no
  ```

- To prevent Tron from granting the SYSTEM and Administrator accounts full permissions to the HKLM, HKCU, and HKCR hives, change this to `yes`:
  ```
  set SKIP_REGPERMS_RESET=no
  ```

- To skip scanning with Sophos Anti-Virus (SAV), change this to `yes`:
  ```
  set SKIP_SOPHOS_SCAN=no
  ```
  
- To skip removal of the Windows "telemetry" (user tracking) updates, change this to `yes`:
  ```
  set SKIP_TELEMETRY_REMOVAL=no
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

* There is no `-UPM` flag


# INTEGRITY

In each release, the file `\tron\integrity_verification\checksums.txt` contains SHA-256 hashes of *every* file included in Tron, and is signed with [my PGP key](http://pool.sks-keyservers.net:11371/pks/lookup?op=get&search=0x07D1490F82A211A2) (`0x07d1490f82a211a2`, included). You can use it to verify package integrity.


# LICENSE

Tron and any included subscripts and `.reg` files I've written are free to use/redistribute/whatever under the **MIT license**. It'd be nice if you sent an email and let me know if you do something cool with it, but it's not required. All 3rd-party tools Tron calls (MBAM, TDSSK, etc) are bound by their respective licenses. It is YOUR responsibility to determine if you can use them in your specific situation.


# OTHER

I try to keep everything updated. If you notice some of the packages are out of date, PM me on reddit or send me an email (listed above), I respond pretty quickly most days.

Hope this is helpful to other PC techs,

– Vocatus

If you feel overly charitable, bitcoin donations are accepted at this address:

```
1LSJ9qDzuHyRx6FfbUmHVSii4sLU3sx2TF
```


# FULL TRON DESCRIPTION
The best way to see what Tron does is simply crack open `Tron.bat` with a text editor (preferably one with syntax highlighting) or [on GitHub](https://github.com/bmrf/tron/blob/master/tron.bat) and just read the code. Every section has comments explaining exactly what it does, and you don't need to be able to read code to understand it. Barring that however, here's a general description of every action Tron performs.

## tron.bat
Master script that launches all the other tools. It performs a lot of actions on its own, but for any task we can't perform directly, we call an external utility or script. Each stage Tron runs (e.g. Stage 1: Tempclean) has its own master script that Tron calls sequentially. The sub-stage scripts can be found in each stages subdirectory under `\tron\resources`.


## Tron-internal prep jobs
(These are executed even if Tron is canceled before running)

0. **Detect TEMP execution**: Detect if we're running from the TEMP directory and prevent Tron from running if so. TEMP is one of the first places to get wiped when Tron starts so we cannot run from there

1. **Detect Windows & IE versions**: Determines quite a few things in the script, such as which versions of various commands get executed

2. **Unsupported OS blocker**: Throw an alert message if running on an unsupported OS, then exit. Use the `-dev` flag to override this behavior and allow running on unsupported Windows versions.

3. **Detect SSD**: Detect solid state hard drives. If found, tron sets the `SSD_DETECTED` variable and skips **Stage 5 defrag**

4. **Detect free space**: Detect and save available hard drive space to compare against later. Simply used to show how much space was reclaimed; does not affect any script functions

5. **Detect resume**: Detect whether or not we're resuming after an interrupted run (e.g. from a reboot)

6. **Enable F8 Safe Mode selection**: Re-enable the ability to use the `F8` key on bootup (Windows 8 and up only; enabled by default on Server 2012/2012 R2)

7. **Check for update**: Use `wget` to pull down `sha256sums.txt` from the Tron mirror and see if we're on the current version. Tron will ask to automatically download the newest version. If you answer yes, it will download a copy to the desktop, verify the SHA256 hash, and then self-destruct the current copy

8. **Detect Administrator rights**: Detect whether or not we're running as Administrator and alert the user if we're not

9. **Detect Safe Mode**: Detect whether or not we're in Safe Mode and notify the user if we're not. If not, Tron will prompt to automatically reboot into Safe Mode with Networking.

10. **Make log directories**: Create the master log directory and sub-directories if they don't exist


## STAGE 0: Prep

1. **Create RunOnce entry**: Create the following registry key to support resuming if there is an interruption: `HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /v "tron_resume" /t REG_SZ /d "%~dp0tron.bat %-resume"`

Note: `-resume` is an internal flag and not meant to be used by a human at the command-line. If you use it, things will break and I will laugh at you.

2. **SMART check**: Dump the SMART status of all hard disks in the system, then display an alert if any drive reports one of the following status codes: `Error`,`Degraded`,`Unknown`,`PredFail`,`Service`,`Stressed`,`NonRecover`

3. **Create System Restore point**: Tron creates a system restore snapshot before beginning operations. Windows Vista and up only, and client OS's only (not supported on Server OS's)

4. **[Rkill](http://www.bleepingcomputer.com/download/rkill/)**: Rkill is an anti-malware prep tool; it looks for and kills a number of known malware that interfere with removal tools. Rkill will NOT kill any process listed in `\resources\stage_0_prep\rkill\rkill_process_whitelist.txt` from being closed

5. **ProcessKiller**: Utility provided by /u/cuddlychops06 which kills various userland processes. We use this to further kill anything that might interfere with Tron. ProcessKiller will kill everything in userland EXCEPT: `ClassicShellService.exe`, `explorer.exe`, `dwm.exe`, `cmd.exe`, `mbam.exe`, `teamviewer.exe`, `TeamViewer_Service.exe`, `Taskmgr.exe`, `Teamviewer_Desktop.exe`, `MsMpEng.exe`, `tv_w32.exe`, `VTTimer.exe`, `Tron.bat`, `rkill.exe`, `rkill64.exe`, `rkill.com`, `rkill64.com`, `conhost.exe`, `dashost.exe`, `wget.exe`

6. **Safe mode**: Set system to reboot into Safe Mode with Networking if a reboot occurs. Removes this and resets to normal bootup at the end of the script. Accomplished via this command:
   ```
   bcdedit /set {default} safeboot network
   ```

7. **Set system time via NTP**: Set the system clock to sync against the following NTP servers, in this order: `2.pool.ntp.org`, `time.windows.com`, `time.nist.gov`

8. **Check and repair WMI**: Check the WMI interface and attempt repair if broken. Tron uses WMI for a lot of stuff including ISO date format conversion, OEM bloatware removal, and various other things, so having it functioning is critical

9. **[McAfee Stinger](http://www.mcafee.com/us/downloads/free-tools/stinger.aspx)**: Anti-malware/rootkit/virus standalone scanner from McAfee. Does not support plain-text logs so we save its HTML log to Tron's %LOGPATH%. Tron executes Stinger as follows:

  ```
  stinger32.exe --GO --SILENT --PROGRAM --REPORTPATH="%LOGPATH%" --RPTALL --DELETE
  ```

10. **[TDSS Killer](http://usa.kaspersky.com/downloads/TDSSKiller)**: Anti-rootkit utility from Kaspersky Labs. Tron executes TDSSKiller as follows:

  ```
  tdsskiller.exe -l %TEMP%\tdsskiller.log -silent -tdlfs -dcexact -accepteula -accepteulaksn
  ```

11. **[erunt](http://www.larshederer.homepage.t-online.de/erunt/)**: Used to backup the registry before beginning a Tron run

12. **VSS purge**: Purges oldest set of Volume Shadow Service files (basically snapshot-in-time copies of files). Malware can often hide out here

13. **Reduce system restore space**: Restrict System Restore to only use 7% of available hard drive space

13. **Disable sleep mode**: Tron uses `caffeine.exe` to disable sleep mode when the script starts. At the end of the script it resets power settings to Windows defaults. Using the `-p` flag prevents resetting power settings to Windows default.


## STAGE 1: Tempclean

1. **Internet Explorer cleanup**: Runs built-in Windows tool to clean and reset Internet Explorer:

  ```
  rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351
  ```
  
  Runs on IE versions 7 and up

2. **[CCLeaner](https://www.piriform.com/ccleaner)**: CCLeaner utility by Piriform. Used to clean temp files before running AV scanners

3. **[BleachBit](http://bleachbit.sourceforge.net/)**: BleachBit utility. Used to clean temp files before running AV scanners

4. **TempFileCleanup.bat**: Script I wrote to clean some areas that other tools seem to miss

5. **[DriveCleanup.exe](http://www.uwe-sieber.de/drivetools_e.html#drivecleanup)**: Cleans unused/not present USB device drivers. Utility from Uwe Sieber

6. **Clear Windows event logs**: Backs up Windows event logs by default to the LOGPATH directory, then clears all log files

7. **Clear Windows Update cache**: Purges uninstaller files for already-installed Windows Updates. Typically frees up quite a bit of space


## STAGE 2: De-bloat

1. **OEM de-bloat** (by name): Use WMI to attempt to uninstall any program listed in this file:

  ```
  \tron\resources\stage_2_de-bloat\oem\programs_to_target_by_name.txt
  ```

2. **OEM de-bloat** (by GUID): Use WMI to attempt to remove specific list of GUIDs in this file:

  ```
  \tron\resources\stage_2_de-bloat\oem\programs_to_target_by_GUID.bat
  ```
  
3. **Toolbar & BHOs** (by GUID): Use WMI to attempt to remove specific list of GUIDs in this file: 
  
  ```
  \resources\stage_3_de-bloat\toolbars_BHOs_to_target_by_GUID.bat
  ```

4. **Metro de-bloat**: Remove built-in Metro apps that no one uses (does NOT remove things like Calculator, Paint) then purges them from the cache (can always fetch later from Windows Update). On Windows 8/8.1, remove all stock "Modern" apps. On Windows 10 and up, only removes a few specific Modern apps.


## STAGE 3: Disinfect

1. **[Malwarebytes Anti-Malware](https://www.malwarebytes.org/)**: Anti-malware scanner. Because there is no command-line support for MBAM, we simply install it and continue with the rest of the script. This way a tech can click **Scan** whenever they're around, but the script doesn't stall waiting for user input. Using the `-sa` or `-sm` flags skip this component

2. **[KVRT](http://www.kaspersky.com/antivirus-removal-tool)**: Kaspersky Virus Removal Tool. Using the `-sa` or `-sk` flags skip this component

  ```
  -l %TEMP%\tdsskiller.log -silent -tdlfs -dcexact -accepteula -accepteulaksn
  ```

3. **[Sophos Virus Removal Tool](https://www.sophos.com/en-us/products/free-tools/virus-removal-tool.aspx)**: Command-line anti-virus scanner. Using the `-v` flag gives more verbose output. Using the `-sa` or `-ss` flags skip this component


## STAGE 4: Repair

1. **DISM image check & repair**: Microsoft utility for checking the Windows Image Store (sort of a more powerful System File Checker). Windows 8 and up only

2. **Registry permissions reset**: Grant `SYSTEM` and `Administrator` users full permissions on HKLM, HKCU, and HKCR hives. This is an add-only permissions operation (does not remove any permissions). Using the `-srr` flag skips this operation

3. **Filesystem permissions reset**: Grant `SYSTEM` and `Administrator` users full permissions on everything in the `%WinDir%` directory tree. Using the `-sfr` flag skips this operation

4. **[System File Checker](https://support.microsoft.com/en-us/kb/929833)**: Microsoft utility for checking the filesystem for errors and attempting to repair if found. Tron runs this on Windows Vista and up only (XP and below require a reboot)

5. **chkdsk**: Checks disk for errors and schedules a chkdsk with repair at next reboot (marks volume dirty) if errors are found

6. **Windows "telemetry" purge**: Disable Windows "telemetry" (user tracking), Windows 7 and up only. If the system is running Windows 7/8/8.1, Tron removes the "bad" updates Microsoft rolled out to Windows 7/8/8.1 systems after the Windows 10 release which backport the surveillance/spyware functions that are by default present in Windows 10 back to the older Windows versions. Tron removes these specific KB updates from Win 7/8/8.1: 2952664, 2976978, 2990214, 3021917, 3022345, 3068708, 3080149, 3075249, 3035583, 3044374, 971033. Tron also stops and deletes the `DiagTrack` ("Diagnostics Tracking Service") service. If the system is running Windows 10, Tron does a more in-depth disabling of the Windows telemetry features. Go over the code in `\tron\resources\stage_4_repair\purge_windows_telemetry\` to see exactly what is removed and disabled. Using the `-str` flag skips this component

7. **Network repair**: Tron performs minor network repair. Specifically it runs these commands: `ipconfig /flushdns`, `netsh interface ip delete arpcache`, `netsh winsock reset catalog`

8. **File extension repair**: Tron repairs most default file extensions with a batch file that loops through a series of registry files stored in `\tron\resources\stage_4_repair\repair_file_extensions\`


## STAGE 5: Patch
Tron updates these programs if they exist on the system. If a program does not exist, it is skipped:

1. **[7-Zip](http://7-zip.org/faq.html)**: Open-source compression and extraction tool. Far superior to just about everything (including the venerable WinRAR). Using the `-sp` flag skips this component

2. **Adobe Flash Player**: Used by YouTube and various other sites. Using the `-sp` flag skips this component

3. **Adobe Reader**: Standard PDF reader. Using the `-sp` flag skips this component

4. **Java Runtime Environment**: I personally hate Java, but it is still widely used, so we at least get the system on the latest version. Using the `-sp` flag skips this component

5. **Windows updates**: Runs Windows update via this command:  `wuauclt /detectnow /updatenow`. Using the `-sw` flag skips this component

6. **DISM base reset**: Recompile the "Windows Image Store" (SxS store) after we finished purging old files from it earlier. Windows 8 and up only. Note that any Windows Updates installed *prior* to this point will become "baked in" (uninstallable)


## STAGE 6: Optimize

1. **Page file reset**: Reset the system page file settings to "let Windows manage the page file." Accomplished via this command:

    `%WMIC% computersystem where name="%computername%" set AutomaticManagedPagefile=True`

    Using the `-spr` flag skips this action

2. **[Defraggler](https://www.piriform.com/defraggler)**: Command-line defrag tool from Piriform that's a little faster than the built-in Windows defragmenter. Defrag is automatically skipped if the system drive is an SSD. Using the `-sd` flag forces Tron to ALWAYS skip defrag


## STAGE 7: Wrap-up

1. **email_report**: Send an email report with the log file attached when Tron is finished. Requires you to specify your SMTP settings in `\resources\stage_7_wrap-up\email_report\SwithMailSettings.xml`

2. **generate summary logs**: Generate before and after logs detailing which files were deleted and which programs were removed. These are placed in `LOGPATH\tron_summary_logs`. Additionally, if `-er` flag was used or `EMAIL_REPORT` variable was set, these logs will be attached to the email that is sent out

## STAGE 8: Manual tools
Tron does not run these automatically because most of them don't support command-line use, or are only useful in special cases.

1. **[ADSSpy](http://www.bleepingcomputer.com/download/ads-spy/)**: Scans for hidden NTFS Alternate Data Streams

2. **[AdwCleaner](https://toolslib.net/downloads/viewdownload/1-adwcleaner/)**: Popular user-suggested adware removal tool

3. **[aswMBR](http://public.avast.com/~gmerek/aswMBR.htm)**: Rootkit scanner

4. **[autoruns](https://technet.microsoft.com/en-us/sysinternals/bb963902.aspx)**: Examine and remove programs that run at startup

5. **[ComboFix](http://www.combofix.org/)**: The "scorched-earth policy" of malware removal. Only works on Windows XP through Windows 7 (no Win8 or above)

6. **[PCHunter](http://www.majorgeeks.com/files/details/pc_hunter.html)**: Tool to scan for rootkits and other malicious items. Replaces gmer

7. **[Junkware Removal Tool](http://thisisudax.org/)**: Temp file and random junkware remover

8. **[Net Adapter Repair](http://www.bleepingcomputer.com/download/netadapter-repair-all-in-one/)**: Utility to repair most aspects of Windows network connections

9. **Remote Support Reboot Config**: Tool to quickly configure auto-login and other parameters for running Tron via a remote connection. Thanks to reddit.com/user/cuddlychops06

10. **Safe Mode Boot Selector.bat**: Batch file to quickly select bootup method to use (Safe Mode, Network, etc). Thanks to reddit.com/user/cuddlychops06

11. **ServicesRepair.exe**: ESET utility for fixing broken Windows services

12. **[TempFileCleaner](http://addpcs.com/software/tfc/)**: OldTimer utility for cleaning temp files

13. **Tron Reset Tool**: Tool to quickly reset Tron if it gets interrupted or breaks while running

14. **VirusTotal uploader tool**: Uploads a file directly to VirusTotal for scanning

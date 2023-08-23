| NAME       | Tron, an automated PC cleanup script                                                        |
| :--------- | :------------------------------------------------------------------------------------------ |
| AUTHOR     | vocatus on [old.reddit.com/r/TronScript](https://old.reddit.com/r/tronscript) (`vocatus.gate@gmail`) // PGP: [0x07d1490f82a211a2](http://pool.sks-keyservers.net:11371/pks/lookup?op=get&search=0x07D1490F82A211A2) |
| BACKGROUND | Why the name? Tron "Fights for the User"                                               |

# DO NOT DOWNLOAD TRON FROM GITHUB, IT WILL NOT WORK!! YOU NEED THE ENTIRE PACKAGE FROM [r/TronScript](https://old.reddit.com/r/TronScript)

I got tired of running these utilities manually and decided to just script everything. Tron is a glorified collection of batch files that automate the process of cleaning up and disinfecting Windows machines ([Common Questions](https://www.reddit.com/r/TronScript/wiki/index#wiki_cq_.28common_questions.29)). It is built with heavy reliance on community input, and updated regularly.

# CONTENTS
1. [Usage Summary](#use)

2. [Command-Line Use](#command-line-use)

3. [Script Interruption](#script-interruption)

4. [Notes on Safe Mode](#safe-mode)

5. [Sending a Post-Run Email Report](#email-report)

6. [Changing Defaults](#change-defaults-advanced)

7. [Executing Custom/3rd-party Scripts](#executing-3rd-party-custom-scripts)

8. [Executing bundled WSUS Offline updates](#executing-bundled-wsus-offline-updates)

9. [Pack Integrity](#integrity)

10. [License](#license)

11. [Problems and Support](#problems-and-support)

12. [Script exit codes](#script-exit-codes)

13. [Full description of ALL actions](#full-tron-description)


# USE

0. FIRST THINGS FIRST: **REBOOT THE COMPUTER BEFORE RUNNING TRON.** This is to allow any pending updates to finish. If you don't do this and the computer reboots during Tron with pending updates, it can brick the system. To re-iterate: it is very important to reboot the computer before running Tron.

1. [Download Tron](https://old.reddit.com/r/TronScript/). The download links are in the top post in [/r/TronScript](https://old.reddit.com/r/TronScript). If you download the self-extracting `.exe` file, run it and it will extract `tron.bat` and the `\resources` folder to the current directory. Copy both of them to the **Desktop** of the target machine.

2. Tron can be run with Windows in either Safe Mode or Regular mode. Regular mode is generally recommended unless the system is severely infected.

3. Right-click `tron.bat` and select "**Run as Administrator**"

4. Wait anywhere from **3-10 hours** (it really takes that long; do **not** cancel it in the middle of running)

      *Note: You'll need to manually click "scan" in the MBAM window that appears part of the way through Stage 3: Disinfect. Tron will continue in the background with its other tasks while waiting for you though, so the script won't stall if you're not around to hit "scan" immediately.*

5. **Reboot!** Reboot the system before doing *anything else*.

By default the master log is at `C:\logs\tron\tron.log`. If you want to change this, read the section on changing defaults below.

Depending how badly the system is infected, it could take anywhere from 3 to 10 hours to run. I've personally observed times between 4-8 hours, and one user reported a run time of 30 hours. Basically set it and forget it.

If you run with the `-udl` switch, it will automatically email me the run logs at the end of the script. Not required but greatly appreciated if you can.

NOTE: Each sub-stage script (e.g. `stage_2_de-bloat.bat`) can be run individually apart from Tron. Just remember to run them as Administrator if you go this route.

# COMMAND-LINE USE

Command-line use is fully supported. All switches are optional and can be used simultaneously. *

    tron.bat [ [-a | -asm] -c -d -dev -e -er -m -o -p -pmb -r -sa -sac -sap -scc -scs -sd -sdb
          -sdc -sdu -se -sk -sl -sm -sor -spr -ss -str -swu -swo -udl -v -x] | [-h]

    Optional switches (can be combined):

     -a   Automatic mode (no welcome screen or prompts; implies -e)
     
     -asm Automatic mode (no prompts; implies -e; reboots to Safe Mode first)
     
     -c   Config dump (display current config. Can be used with other
          switches to see what WOULD happen, but script will never execute
          if this switch is used)

     -d   Dry run (run through script without executing any jobs)
    
     -dev Override OS detection (allow running on unsupported Windows versions)

     -e   Accept EULA (suppress disclaimer warning screen)

     -er  Email a report when finished. Requires you to configure SwithMailSettings.xml

     -m   Preserve default Metro apps (don't remove them)

     -o   Power off after running (overrides -r)

     -p   Preserve power settings (don't reset to Windows default)

     -pmb Preserve Malwarebytes (don't uninstall it) after Tron is complete
     
     -r   Reboot automatically (auto-reboot 15 seconds after completion)
     
     -sa  Skip ALL anti-virus scans (AdwCleaner, KVRT, MBAM, SAV)

     -sac Skip AdwCleaner scan

     -sap Skip application patches (don't patch 7-Zip)

     -scs Skip custom scripts (has no effect if you haven't supplied custom scripts)

     -scc Skip cookie cleanup (not recommended, Tron auto-preserves most common login cookies)

     -sd  Skip defrag (force Tron to ALWAYS skip Stage 6 defrag)

     -sdb Skip de-bloat (entire OEM bloatware removal process; implies -m)
     
     -sdc Skip DISM component (SxS store) cleanup
     
     -sdu Skip debloat update. Prevent Tron from auto-updating the S2 debloat lists

     -se  Skip Event Log backup and clear (don't clear Windows Event Logs)

     -sk  Skip Kaspersky Virus Rescue Tool (KVRT) scan

     -sm  Skip Malwarebytes Anti-Malware (MBAM) installation

     -sor Skip OneDrive removal regardless whether it's in use or not

     -spr Skip page file reset (don't set to "Let Windows manage the page file")

     -ss  Skip Sophos Anti-Virus (SAV) scan

     -str Skip Telemetry Removal (just turn telemetry off instead of removing it)

     -swu Skip Windows Updates entirely (ignore both WSUS Offline and online methods)

     -swo Skip user-supplied WSUS Offline updates (if they exist; online updates still attempted)
     
     -udl Upload debug logs. Send tron.log and the system GUID dump to the Tron developer

     -v   Verbose. Show as much output as possible. NOTE: Significantly slower!

     -x   Self-destruct. Tron deletes itself after running and leaves logs intact

    Misc switches (must be used alone):

     -h   Display help text


\* There is probably no `-upm` switch


# SCRIPT INTERRUPTION

If the script is interrupted e.g. from a crash or a forced reboot (often encountered during stage_2_de-bloat), simply re-run `tron.bat` and Tron will resume from the last stage successfully started.

It will also re-use any previously-used command-line switches when it starts back up.

More details about this function can be found in the [list of all actions Tron performs](#full-tron-description) at the bottom of this document.


# SAFE MODE

In older versions of Tron (v10.3.1 and back), Safe Mode was recommended vs. Normal/Regular mode (Windows boot mode). The current recommendation has changed starting in v10.4.0, and I recommend first running in Normal/Regular mode, and only attempting a run in Safe Mode if that fails.


# EMAIL REPORT
To have Tron send an email report at completion, edit this file:

    \tron\resources\stage_7_wrap-up\email_report\SwithMailSettings.xml

Specify your SMTP server, username, and password. After specifying your settings you can use the `-er` switch to have Tron send the email report. The summary logs (`tron_removed_files.txt` and `tron_removed_programs.txt`) will be attached as well.

Keep in mind the username and password for the email account will be stored in PLAIN TEXT so don't leave it lying around on a system you don't trust.


# CHANGE DEFAULTS (advanced)

If you don't want to use the command-line and don't like Tron's defaults, you can change the following default settings. Keep in mind command-line switches will always override their respective default option when used.

**Edit this file**: `\tron\resources\functions\tron_settings.bat`

- To change the master directory where all of Tron's output goes, edit this line:
  ```
  set LOGPATH=%SystemDrive%\logs\tron
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
  
- To always reboot to Safe Mode for autorun (requires that AUTORUN also be set to yes), change this to `yes`:
  ```
  set AUTORUN_IN_SAFE_MODE=no
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

- To have Tron send an email report when finished, change this to `yes` (requires you to configure `SwithMailSettings.xml` with your SMTP info):
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

- To preserve Malwarebytes installation (skip removal) at the end of Tron, change this to `yes`:
  ```
  set PRESERVE_MALWAREBYTES=no
  ```

- To configure post-run reboot, change this value (in seconds). `0` disables auto-reboot:
  ```
  set AUTO_REBOOT_DELAY=0
  ```

- To skip ALL anti-virus scan engines (AdwCleaner, MBAM, KVRT, Sophos), change this to `yes`:
  ```
  set SKIP_ANTIVIRUS_SCANS=no
  ```

- To skip AdwCleaner scan, change this to `yes`:
  ```
  set SKIP_ADWCLEANER_SCAN=no
  ```

- To skip application patches (don't patch 7-Zip or Adobe Flash) change this to `yes`:
  ```
  set SKIP_APP_PATCHES=no
  ```

  - To leave ALL cookies intact (not recommended, Tron auto-preserves most common login cookies such as Spotify, Gmail, etc), change this to `yes`:
  ```
  set SKIP_COOKIE_CLEANUP=no
  ```

- To skip custom scripts (stage 8) regardless whether or not `.bat` files are present in the `stage_8_custom_scripts` folder, change this to yes:
  ```
  set SKIP_CUSTOM_SCRIPTS=no
  ```

- To skip OEM debloat, change this to `yes`:
  ```
  set SKIP_DEBLOAT=no
  ```

- To always skip defrag (even on mechanical drives; Tron automatically skips SSD defragmentation), change this to yes:
  ```
  set SKIP_DEFRAG=no
  ```
  
- To skip DISM component (SxS store) cleanup, change this to `yes`:
  ```
  set SKIP_DISM_CLEANUP=no
  ```
  
- To prevent Tron from connecting to Github and automatically updating the Stage 2 debloat lists, set this to `yes`:
  ```
  set SKIP_DEBLOAT_UPDATE=no
  ```

- To skip Windows Event Log clearing, change this to `yes`:
  ```
  set SKIP_EVENT_LOG_CLEAR=no
  ```

- To skip scanning with Kaspersky Virus Rescue Tool (KVRT), change this to `yes`:
  ```
  set SKIP_KASPERSKY_SCAN=no
  ```

- To skip installation of Malwarebytes Anti-Malware (MBAM), change this to `yes`:
  ```
  set SKIP_MBAM_INSTALL=no
  ```

- To skip removal of OneDrive regardless whether it's in use or not, change this to `yes`:
  ```
  set SKIP_ONEDRIVE_REMOVAL=no
  ```

- To prevent Tron from resetting the page file to Windows defaults, change this to `yes`:
  ```
  set SKIP_PAGEFILE_RESET=no
  ```

- To skip scanning with Sophos Anti-Virus (SAV), change this to `yes`:
  ```
  set SKIP_SOPHOS_SCAN=no
  ```
  
- To skip removal of the Windows "telemetry" (user tracking) updates, change this to `yes`:
  ```
  set SKIP_TELEMETRY_REMOVAL=no
  ```

- To skip only bundled WSUS Offline updates (online updates still attempted) change this to `yes`:
  ```
  set SKIP_WSUS_OFFLINE=no
  ```

- To skip Windows Updates entirely (ignore both WSUS Offline and online methods), change this to `yes`:
  ```
  set SKIP_WINDOWS_UPDATES=no
  ```
  
 - To automatically upload debug logs to the Tron developer (vocatus), change this to `yes`:
  ```
  set UPLOAD_DEBUG_LOGS=no
  ```

- To display as much output as possible (verbose), change this to `yes`:
  ```
  set VERBOSE=no
  ```

- To have Tron delete itself after running (self-destruct), change this to `yes`:
  ```
  set SELF_DESTRUCT=no
  ```

* There is probably no `-UPM` switch


# EXECUTING 3RD-PARTY CUSTOM SCRIPTS:

Tron supports executing custom scripts just prior to the end-screen.

Place any batch files you want to execute just prior to Tron completion in this folder: `\tron\resources\stage_8_custom_scripts`

Custom scripts work like so:

 - If any `.bat` files exist in `\stage_8_custom_scripts`, Tron will execute each one sequentially by name. When they're finished, Tron will clean up and end the script as normal

 - If no `.bat` files exist in `\stage_8_custom_scripts` folder, Stage 8 is silently skipped
 
 - Supporting files may be placed in the folder but Tron itself will ignore anything that isn't a `.bat` file 
 
 - If you want to use supporting batch files but don't want Tron executing them, use the `.cmd` file extension instead of `.bat` and Tron will ignore them
 
 - It is your responsibility what your scripts do. I provide no support for custom scripts other than having Tron attempt to run them
 
 - Use the `-scs` switch or edit the file `\tron\resources\functions\tron_settings.bat` and set `SKIP_CUSTOM_SCRIPTS` to `yes` to direct Tron to ignore custom scripts even if they are present. Can be useful if you have a set of scripts you only want to execute on certain systems and don't want to carry two copies of Tron around

# EXECUTING BUNDLED WSUS OFFLINE UPDATES

Tron supports using bundled WSUS Offline update packages over the traditional online update method.

To add offline update packages to Tron:

1. Download [WSUS Offline](http://download.wsusoffline.net/)

2. Run it and have it download the updates you want

3. Copy the `client` folder (usually at `\wsusoffline\client`) to `\tron\resources\stage_5_patch\wsus_offline\client\`

4. Make sure that `Update.cmd` is present in this path: `\tron\resources\stage_5_patch\wsus_offline\client\Update.cmd`

5. Run Tron, it should automatically detect and use the offline updates

If for some reason you want to skip the bundled update package on a certain system, use the `-swo` switch or edit [tron_settings.bat](https://github.com/bmrf/tron/blob/master/resources/functions/tron_settings.bat), set `SKIP_WSUS_OFFLINE` to yes and Tron will ignore any WSUS Offline files for that run.

# INTEGRITY

In each release, the file `\tron\integrity_verification\checksums.txt` contains SHA-256 hashes of *every* file included in Tron, and is signed with [my PGP key](http://pool.sks-keyservers.net:11371/pks/lookup?op=get&search=0x07D1490F82A211A2) (`0x07d1490f82a211a2`, included). You can use it to verify package integrity.


# LICENSE

Tron and any included subscripts and `.reg` files I've written are free to use/redistribute/whatever under the **MIT license**. It'd be nice if you sent an email and let me know if you do something cool with it, but it's not required. All 3rd-party tools Tron calls (MBAM, TDSSK, etc) are bound by their respective licenses. It is YOUR responsibility to determine if you can use them in your specific situation.


# PROBLEMS AND SUPPORT

Please look [here](https://old.reddit.com/r/TronScript/wiki/index#wiki_cq_.28common_questions.29) first for a list of common issues (Tron appearing to be stalled, etc). If it doesn't answer your issue, make a top-level post to [r/TronScript](https://old.reddit.com/r/TronScript) and myself or one of the community members will look at the issue. Additionally, you can reach me 24/7 [on Keybase](https://keybase.io/vocatus). 

Hope this is helpful to other PC techs,

– Vocatus

If you feel overly charitable, donations are accepted at these addresses:

Bitcoin: `1Biw8gx2kD7mZf66ZdNgB9tG1pE9YA3kEd`

Bitcoin Cash: `18sXTTrAViPZVQtm63zBK6aCK3XfJpEThk`


# SCRIPT EXIT CODES
When Tron exits, it will pass an exit code indicating the final status (success/warning/error/failure/etc).

| CODE       | MEANING |
| :--------- | :------ |
| 0 | Success
| 1 | Error (usually fatal)
| 2 | Warning (non-fatal)
| 3 | Unsupported OS (run with `-dev` to override)
| 4 | Exit pending reboot
| 5 | User is an idiot (aka you tried running from the temp directory in spite of the instructions clearly saying not to)


# FULL TRON DESCRIPTION
The best way to see what Tron does is simply crack open [tron.bat](https://github.com/bmrf/tron/blob/master/tron.bat) or one of the stage-specific subscripts with a text editor (preferably one with syntax highlighting) or [on GitHub](https://github.com/bmrf/tron/blob/master/tron.bat) and just read the code. Every section has comments explaining exactly what it does, and you don't need to be able to read code to understand it. Barring that, here's a general description of every action Tron performs.

## tron.bat

*[link to code](https://github.com/bmrf/tron/blob/master/tron.bat)*

Master script that launches everything else. It performs many actions on its own, but for any task not performed directly, we call an external utility or script. Each stage (e.g. Stage 1: Tempclean) has its own master script that Tron calls in sequence. Sub-stage scripts can be found in each stages subdirectory under the `\resources` folder. e.g. `\tron\resources\stage_1_tempclean\stage_1_tempclean.bat`


## Tron-internal prep jobs
(These are executed even if Tron is canceled before running)

0. **Detect TEMP execution**: Detect if we're running from the TEMP directory and prevent Tron from executing if so. TEMP is one of the first places to get wiped when Tron starts so we cannot run from there

1. **Make log directories**: Create the master log directory and sub-directories if they don't exist. By default this is `%SystemDrive%\Logs\tron.log`

2. **Detect Windows & IE versions**: Determines quite a few things in the script, such as which versions of various commands get executed

3. **Unsupported OS blocker**: Throw an alert message if running on an unsupported OS, then exit. Use the `-dev` switch to override this behavior and allow running on unsupported Windows versions. Currently only triggers on Windows Server 2016.

4. **Disk configuration check**: Check if the system drive is an SSD, Virtual Disk, or throws an unspecified error (couldn't be read by `smartctl.exe`) and set the `SKIP_DEFRAG` variable to `yes_ssd`, `yes_vm`, or `yes_error` respectively. If any of these conditions are triggered, Tron skips **Stage 5 defrag** automatically

5. **Detect free space**: Detect and save available hard drive space to compare against later. Simply used to show how much space was reclaimed; does not affect any script functions

6. **Detect resume**: Detect whether or not we're resuming after an interrupted run (e.g. from a reboot)

7. **Enable F8 Safe Mode selection**: Re-enable the ability to use the `F8` key on bootup (Windows 8 and up only; enabled by default on Server 2012/2012 R2)

8. **Check for network connection**: Check for an active network connection, and skip the update checks if one isn't found

9. **Check for update**: Compare the local copy of Tron to the version on the official repo (does this by reading latest version number from `sha256sums.txt`). If the local copy is out of date, Tron will ask to automatically download the latest copy (**always** recommended). If permitted, it will download a copy to the desktop, verify the SHA256 hash, then self-destruct (delete) the old version

10. **Update debloat lists**: Connect to Github and download the latest version of the Stage 2 debloat lists at initial launch. Use the `-sdu` (`SKIP_DEBLOAT_UPDATE`) switch to prevent this behavior. I recommend letting Tron update the lists unless you have a good, specific reason not to

11. **Detect Administrator rights**: Detect whether or not we're running as Administrator and alert the user if we're not

12. **Create RunOnce entry**: Create the following registry key to support resuming if there is an interruption: `HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce /v "*tron_resume" /t REG_SZ /d "%~dp0tron.bat %-resume"`. The `*` prefix on the key name forces Windows to execute it in Safe Mode.

   Note: `-resume` is an internal switch not meant for human use at the command-line. If you use it, things will break and I will laugh at you.

13. **SMART check**: Dump the SMART status of all hard disks in the system, then display an alert if any drive reports one of the following status codes: `Error`,`Degraded`,`Unknown`,`PredFail`,`Service`,`Stressed`,`NonRecover`


## STAGE 0: Prep

*[link to Stage 0 code](https://github.com/bmrf/tron/blob/master/resources/stage_0_prep/stage_0_prep.bat)*

1. **Create System Restore point**: Create a pre-run system restore point. Vista and up only, client OS's only. Not supported on Server OS's, and on Windows 10 does not work if the system is in any form of Safe Mode. This is a known bug, and I spent hours trying to find a workaround but was not able to find a solution, so if you absolutely require a system restore point, recommend running in normal mode

2. **[Rkill](http://www.bleepingcomputer.com/download/rkill/)**: Rkill is an anti-malware prep tool; it looks for and kills a number of known malware that interfere with removal tools. Rkill will NOT kill any process listed in `\resources\stage_0_prep\rkill\rkill_process_whitelist.txt` ([link](https://github.com/bmrf/tron/blob/master/resources/stage_0_prep/rkill/rkill_process_whitelist.txt))

3. **Create pre-run profile**: Dump list of installed programs and list of all files on the system so we can compare later and see exactly what was removed

4. **GUID dump**: Dump list of all installed program GUIDs. These dumps are useful in helping the project bolster the blacklist of known-bad GUIDs

5. **Metro app list dump**: Dump list of all Metro apps on the system. This is useful for helping the project bolster the blacklist of Metro apps to remove

6. **ProcessKiller**: Utility provided by [/u/cuddlychops06](https://www.reddit.com/user/cuddlychops06) which kills various userland processes. We use this to further kill anything that might interfere with Tron. ProcessKiller will kill everything in userland EXCEPT: `ClassicShellService.exe`, `explorer.exe`, `dwm.exe`, `cmd.exe`, `mbam.exe`, `teamviewer.exe`, `TeamViewer_Service.exe`, `Taskmgr.exe`, `Teamviewer_Desktop.exe`, `MsMpEng.exe`, `tv_w32.exe`, `VTTimer.exe`, `Tron.bat`, `rkill.exe`, `rkill64.exe`, `rkill.com`, `rkill64.com`, `conhost.exe`, `dashost.exe`, `wget.exe` . ([link](https://github.com/bmrf/tron/blob/master/resources/stage_0_prep/processkiller/whitelist.txt))

7. **Safe mode**: Set system to reboot into Safe Mode with Networking if a reboot occurs. Removes this and resets to normal bootup at the end of the script. Accomplished via this command:
   ```
   bcdedit /set {default} safeboot network
   ```

8. **Set system time via NTP**: Set the system clock to sync against the following NTP servers, in this order: `2.pool.ntp.org`, `time.windows.com`, `time.nist.gov`

9. **Check and repair WMI**: Check WMI interface and attempt repair if broken. Tron uses WMI for a lot of stuff including ISO date format conversion, OEM bloatware removal, and various other things, so having it functioning is critical

10. **[McAfee Stinger](https://www.mcafee.com/en-us/consumer-corporate/mcafee-labs/free-tools/stinger.html)**: Anti-malware/rootkit/virus standalone scanner from McAfee. Does not support plain-text logs so we save HTML log to Tron's `%LOGPATH%`. Tron executes Stinger as follows:

  ```
  stinger32.exe --GO --SILENT --PROGRAM --REPORTPATH="%LOGPATH%" --RPTALL --DELETE
  ```

11. **[TDSS Killer](http://usa.kaspersky.com/downloads/TDSSKiller)**: Anti-rootkit utility from Kaspersky Labs. Tron executes TDSSKiller as follows:

  ```
  tdsskiller.exe -l %TEMP%\tdsskiller.log -silent -tdlfs -dcexact -accepteula -accepteulaksn
  ```

12. **Backup registry:**: Use [erunt](http://www.larshederer.homepage.t-online.de/erunt/) to backup the registry prior to commencing scans

13. **VSS purge**: Purge oldest set of Volume Shadow Service files (basically snapshot-in-time copies of files). Malware can often hide out here

14. **Reduce system restore space**: Restrict System Restore to only use 7% of available hard drive space

15. **Disable sleep mode**: Tron uses `caffeine.exe` to disable sleep mode when the script starts. At the end of the script it resets power settings to Windows defaults. Use the `-p` switch to prevent resetting power settings to Windows default.


## STAGE 1: Tempclean

*[link to Stage 1 code](https://github.com/bmrf/tron/blob/master/resources/stage_1_tempclean/stage_1_tempclean.bat)*

1. **Internet Explorer cleanup**: Executes only on Internet Explorer v7 and up. Runs the following built-in Windows tool to clean and reset Internet Explorer:

  ```
  rundll32.exe inetcpl.cpl,ClearMyTracksByProcess 4351
  ```


2. **[CCLeaner](https://www.piriform.com/ccleaner)**: CCLeaner utility by Piriform. Used to clean temp files before running AV scanners. Note that CCleaner wipes `%AppData%` Local Storage. Edit [ccleaner.ini](https://github.com/bmrf/tron/blob/master/resources/stage_1_tempclean/ccleaner/ccleaner.ini) and change `(App)Local Storage*=True` to `(App)Local Storage*=False` if you don't want this behavior. Also note that Tron automatically preserves most common login cookies (Chase.com, gmail.com, etc). Use the `-scc` switch to leave ALL cookies intact (not recommended)

3. **[TempFileCleanup.bat](https://github.com/bmrf/tron/blob/master/resources/stage_1_tempclean/tempfilecleanup/TempFileCleanup.bat)**: Script I wrote to clean some areas that other tools seem to miss

4. **[USB Device Cleanup](http://www.uwe-sieber.de/drivetools_e.html#drivecleanup)**: Uninstalls unused or not present USB devices from the system (non-existent thumb drives, etc etc). Uses `drivecleanup.exe` from [Uwe Sieber](http://www.uwe-sieber.de/)

5. **[Cleanup duplicate downloads](https://github.com/jeremitu/finddupe)**: Searches for and delete duplicate files found in the Downloads folders of each user profile (`ChromeInstaller(1).exe`, `ChromeInstaller(2)exe`, etc). Does not touch any other folders. Uses a UTF-8-friendly port Sentex's original [Find Dupe](http://www.sentex.net/~mwandel/finddupe/) utility

6. **Clear Windows event logs**: Back up Windows event logs to `%LOGPATH%` directory, then clear all entries

7. **Clear Windows Update cache**: Purge uninstaller files for already-installed Windows Updates. Typically frees up quite a bit of space. Accomplished via this command:
    
    ```
    rmdir /s /q %windir%\softwaredistribution\download
    ```

8. **Flush BranchCache cache**: Tron executes the command `netsh branchcache flush` to flush any cached data in the BranchCache (win7 and up only)


## STAGE 2: De-bloat

*[link to Stage 2 code](https://github.com/bmrf/tron/blob/master/resources/stage_2_de-bloat/stage_2_de-bloat.bat)*

1. **OEM de-bloat** (by name): Use WMI to attempt to uninstall any program listed in [this file](https://github.com/bmrf/tron/blob/master/resources/stage_2_de-bloat/oem/programs_to_target_by_name.txt):

  ```
  \tron\resources\stage_2_de-bloat\oem\programs_to_target_by_name.txt
  ```

2. **OEM de-bloat** (by GUID): Use WMI to attempt to remove specific list of GUIDs listed in [this file](https://github.com/bmrf/tron/blob/master/resources/stage_2_de-bloat/oem/programs_to_target_by_GUID.txt):

  ```
  \tron\resources\stage_2_de-bloat\oem\programs_to_target_by_GUID.txt
  ```
  
3. **Toolbar & BHOs** (by GUID): Use WMI to attempt to remove specific list of GUIDs listed in [this file](https://github.com/bmrf/tron/blob/master/resources/stage_2_de-bloat/oem/toolbars_BHOs_to_target_by_GUID.txt): 
  
  ```
  \tron\resources\stage_2_de-bloat\oem\toolbars_BHOs_to_target_by_GUID.txt
  ```

4. **Metro de-bloat**: Remove many built-in Metro apps that aren't commonly used (does NOT remove things like Calculator, Paint, etc) then purges them from the cache (can always fetch later from Windows Update). On Windows 8/8.1, removes all stock "Modern" apps. On Windows 10 and up, only removes a certain specific Modern apps. You can see the full list of Metro apps removed [here](https://github.com/bmrf/tron/blob/master/resources/stage_2_de-bloat/metro/metro_Microsoft_modern_apps_to_target_by_name.ps1) (Microsoft) and [here](https://github.com/bmrf/tron/blob/master/resources/stage_2_de-bloat/metro/metro_3rd_party_modern_apps_to_target_by_name.ps1) (OEM/3rd party). Use the `-sdb` switch (skip *all* de-bloat) or `-m` switch (skip only Metro de-bloat) to skip this action. Like the GUID lists above, you can also customize these files to add or remove apps from the target list. Note that the Metro de-bloat PowerShell scripts also support standalone execution, if for example you JUST want to remove Metro bloat from a machine.

5. **Remove OneDrive integration**: Remove forced OneDrive integration (Windows 10 only). Tron first checks if any files exist in the default OneDrive folder (`%USERPROFILE%\OneDrive\`) and skips removal if any are found. As a additional safety precaution, Tron leaves the OneDrive folder intact regardless whether OneDrive is removed or not. Use the `-sor` switch to skip OneDrive removal entirely.

## STAGE 3: Disinfect

*[link to Stage 3 code](https://github.com/bmrf/tron/blob/master/resources/stage_3_disinfect/stage_3_disinfect.bat)*

1. **[Clear CryptNet SSL cache](https://github.com/bmrf/tron/issues/86)**: Wipe the Windows CryptNet SSL certificate cache by executing this command:  `certutil -URLcache * delete`

2. **[Malwarebytes Anti-Malware](https://www.malwarebytes.org/)**: Anti-malware scanner. Because there is no command-line support for MBAM, we simply install it and continue with the rest of the script. This way a tech can click **Scan** whenever they're around, but the script doesn't stall waiting for user input. Use the `-sa` or `-sm` switches to skip this component. Use the `-pmb` switch to NOT uninstall it at the end of the script

3. **[Malwarebytes AdwCleaner](https://support.malwarebytes.com/hc/en-us/articles/360050633534-Commands-for-Malwarebytes-AdwCleaner)**: Command-line anti-virus scanner. Use the `-sa` or `-sac` switches to skip this component

4. **[KVRT](http://www.kaspersky.com/antivirus-removal-tool)**: Kaspersky Virus Removal Tool. Use the `-sa` or `-sk` switches to skip this component

5. **[Sophos Virus Removal Tool](https://www.sophos.com/en-us/products/free-tools/virus-removal-tool.aspx)**: Command-line anti-virus scanner. Use the `-v` switch to get more verbose output. Use the `-sa` or `-ss` switches to skip this component


## STAGE 4: Repair

*[link to Stage 4 code](https://github.com/bmrf/tron/blob/master/resources/stage_4_repair/stage_4_repair.bat)*

0. **MSI installer cleanup**: Use the Microsoft `msizap.exe` utility to remove orphaned MSI installer files from the installer cache

1. **[System File Checker](https://support.microsoft.com/en-us/kb/929833)**: Microsoft utility for checking the filesystem for errors and attempting to repair if found. Tron runs this on Windows Vista and up only (XP and below require a reboot)

2. **[DISM image check & repair](https://support.microsoft.com/en-us/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system)**: Microsoft utility for checking the Windows Image Store (sort of a more powerful System File Checker). Windows 8 and up only

3. **chkdsk**: Checks disk for errors and schedules a chkdsk with repair at next reboot (marks volume dirty) if errors are found

4. **Disable Windows** "**telemetry**": Disable Windows "telemetry" (user tracking), Windows 7 and up only. Tron removes the "bad" updates Microsoft pushed to Windows 7/8/8.1 systems after the Windows 10 release. These updates backport the surveillance/spyware functions that are by default present in Windows 10. See the code ([Win7/8/8.1](https://github.com/bmrf/tron/blob/master/resources/stage_4_repair/disable_windows_telemetry/purge_windows_7-8-81_telemetry.bat), [Win10](https://github.com/bmrf/tron/blob/master/resources/stage_4_repair/disable_windows_telemetry/purge_windows_10_telemetry.bat)) to see exactly which KB's are removed. Tron also stops and deletes the `DiagTrack` ("Diagnostics Tracking Service") service. If the system is running Windows 10, Tron does a more in-depth disabling of the Windows telemetry features, including automatically applying all the immunizations from the [Spybot Anti-Beacon](https://www.safer-networking.org/spybot-anti-beacon/) and [O&O ShutUp10](https://www.oo-software.com/en/shutup10) tools. Go over the code in `\tron\resources\stage_4_repair\disable_windows_telemetry\` to see exactly what is removed and disabled. NOTE: This section can take a while to run, DO NOT CANCEL IT. Use the `-str` switch to just turn telemetry off instead of removing it

5. **Disable Windows 10 upgrade nagger**: Disables the Windows 10 upgrade nagger on Windows 7/8/8.1 by flipping the appropriate registry switches. Users can still manually upgrade the machine if they desire, but it will no longer nag via the system tray, auto-download, or auto-install Windows 10 without their permission

6. **Network repair**: Tron performs minor network repair. Specifically it runs these commands: `ipconfig /flushdns`, `netsh interface ip delete arpcache`, `netsh winsock reset catalog`

7. **File extension repair**: Tron repairs most default file extensions with a batch file that loops through a series of registry files stored in `\tron\resources\stage_4_repair\repair_file_extensions\`


## STAGE 5: Patch

*[link to Stage 5 code](https://github.com/bmrf/tron/blob/master/resources/stage_5_patch/stage_5_patch.bat)*

Tron updates these programs if they exist on the system. If a program does not already exist on the system, it is not installed:

1. **[7-Zip](http://7-zip.org/faq.html)**: Open-source compression and extraction tool. Use the `-sap` switch to skip this action

2. **Adobe Flash Player**: Used by YouTube and various other sites. Use the `-sap` switch to skip this action

3. **Windows updates**: Runs Windows update via this command:  `wuauclt /detectnow /updatenow`. Use the `-swu` switch to skip this action. If bundled WSUS Offline updates are detected, Tron executes those instead. Use the `-swo` switch to force skipping WSUS Offline updates even if they're present in the relevant directory. See [Executing bundled WSUS Offline updates](#executing-bundled-wsus-offline-updates) above for more information on using offline update packages with Tron

4. **DISM base reset**: Recompile the "Windows Image Store" (SxS store). This typically results in multiple GB's of space freed up. Windows 8 and up only. Any Windows Updates installed *prior* to this point will become "baked in" (uninstallable). Use the `-sdc` switch to skip this action


## STAGE 6: Optimize

*[link to Stage 6 code](https://github.com/bmrf/tron/blob/master/resources/stage_6_optimize/stage_6_optimize.bat)*

1. **Page file reset**: Reset the system page file settings to "let Windows manage the page file." Accomplished via this command:

    `%WMIC% computersystem where name="%computername%" set AutomaticManagedPagefile=True`

    Use the `-spr` switch to skip this action

2. **[Defraggler](https://www.piriform.com/defraggler)**: Command-line defrag tool from Piriform that's a little faster than the built-in Windows defragmenter. Defrag is automatically skipped if the system drive is an SSD, or if any SMART errors are detected. Use the `-sd` switch to force Tron to ALWAYS skip defrag


## STAGE 7: Wrap-up

*stage-specific code is in [tron.bat](https://github.com/bmrf/tron/blob/master/tron.bat)*

1. **generate summary logs**: Generate before and after logs detailing which files were deleted and which programs were removed. These are placed in `<LOGPATH>\tron_summary_logs`. Additionally, if `-er` switch was used or `EMAIL_REPORT` variable was set, these logs will be attached to the email that is sent out

2. **email_report**: Send an email report with the log file attached when Tron is finished. Requires you to specify your SMTP settings in `\resources\stage_7_wrap-up\email_report\SwithMailSettings.xml`

3. **upload debug logs**: Upload 'tron.log' and the system GUID dump (list of all installed program GUIDs) and Metro app list dump to the Tron developer (vocatus). Please use this option if possible, log files are extremely helpful in developing Tron! NOTE: `tron.log` can contain personal information like names of files on the system, the computer name, user name, etc, so if you're concerned about this please look through a Tron log first to understand what will be sent. I don't care what files are on random systems on the Internet, but just something to be aware of

4. **Remove Malwarebytes**: Automatically remove the Malwarebytes installation. Use the `-pmb` switch to skip this and leave it on the system

## STAGE 8: Custom Scripts

*stage-specific code is in [tron.bat](https://github.com/bmrf/tron/blob/master/tron.bat)*

1. **Execute custom scripts**: Tron will execute any `.bat` files placed in the `\tron\resources\stage_8_custom_scripts` directory. See [Executing Custom/3rd-party Scripts](#executing-3rd-party-custom-scripts) above for more information

## STAGE 9: Manual tools

Tron does not run these automatically because most do not support command-line use, or are only useful in special cases.

1. **[ADSSpy](http://www.bleepingcomputer.com/download/ads-spy/)**: Scans for hidden NTFS Alternate Data Streams

2. **[aswMBR](http://public.avast.com/~gmerek/aswMBR.htm)**: Rootkit scanner

3. **[autoruns](https://technet.microsoft.com/en-us/sysinternals/bb963902.aspx)**: Examine and remove programs that run at startup

4. **[ComboFix](http://www.bleepingcomputer.com/download/combofix/)**: The "scorched-earth policy" of malware removal. Only works on Windows XP through Windows 8 (no Windows 8.1 or above)

5. **[Junkware Removal Tool](http://thisisudax.org/)**: Temp file and random junkware remover

6. **[Net Adapter Repair](http://www.bleepingcomputer.com/download/netadapter-repair-all-in-one/)**: Utility to repair most aspects of Windows network connections

7. **Remote Support Reboot Config**: Tool to quickly configure auto-login and other parameters for running Tron via a remote connection. Thanks to reddit.com/user/cuddlychops06

8. **Safe Mode Boot Selector.bat**: Batch file to quickly select bootup method to use (Safe Mode, Network, etc). Thanks to reddit.com/user/cuddlychops06

9. **ServicesRepair.exe**: ESET utility for fixing broken Windows services

10. **Tron Reset Tool**: Tool to quickly reset Tron if it gets interrupted or breaks while running

| NAME       | Tron, an automated PC cleanup script                                                        |
| :--------- | :------------------------------------------------------------------------------------------ |
| AUTHOR     | vocatus on [reddit.com/r/TronScript](https://reddit.com/r/tronscript) (`vocatus.gate@gmail`) // PGP ID: [0x07d1490f82a211a2](http://pool.sks-keyservers.net:11371/pks/lookup?op=get&search=0x07D1490F82A211A2) |
| BACKGROUND | Why the name? Tron "Fights for the User"                                               |

# DO NOT DOWNLOAD TRON FROM GITHUB, IT WILL NOT WORK!! YOU NEED THE ENTIRE PACKAGE FROM [/r/TronScript](https://www.reddit.com/r/TronScript) !!

I got tired of running these utilities manually and decided to just script everything, so Tron is essentially a glorified batch file that automates a variety of tasks to clean up and disinfect Windows machines.

# CONTENTS
1. [Usage Summary](#use)

2. [Command-Line Use](#command-line-use)

3. [Script Interruption](#script-interruption)

4. [Notes on Safe Mode](#safe-mode)

5. [Sending a Post-Run Email Report](#email-report)

6. [Changing Defaults](#change-defaults-advanced)

7. [Executing Custom/3rd-party Scripts](#executing-3rd-party-custom-scripts)

7. [Pack Integrity](#integrity)

8. [License](#license)

9. [Contact Info](#other)

10. [Full description of ALL actions](#full-tron-description)

# USE

0. FIRST THINGS FIRST: If there are pending Windows updates, reboot the machine and allow them to install. This isn't *required* but is strongly recommended.

1. [Boot into Safe Mode with Network Support](#safe-mode). If you skip this step Tron will prompt you to automatically reboot into Safe Mode. NOTE: Sometimes Tron works better in Normal mode, and sometimes Safe Mode. You don't *have* to run Tron in Safe Mode, but in general it seems to have better results that way which is why it's generally recommended.

2. Copy `tron.bat` and the `\resources` folder to the **Desktop** of target machine and run `tron.bat` as an **ADMINISTRATOR** 

3. Wait anywhere from **3-10 hours** (yes, it really takes that long; no, do **not** cancel it in the middle of it running)

  *Note: You'll need to manually click "scan" in the MBAM window that appears part of the way through Stage 3: Disinfect. Tron will continue in the background with its other tasks while waiting for you though, so the script won't stall if you're not around to hit "scan" immediately.*

4. **Reboot**

By default the master log file is at `C:\Logs\tron\tron.log`. If you want to change this, read the section on changing defaults below.

Tron will briefly check for a newer version when it starts up and notify you if one is available. It will also automatically download updates to the Stage 2: De-bloat lists of unwanted programs to target.

Depending how badly the system is infected, it could take anywhere from 3 to 10 hours to run. I've personally observed times between 4-8 hours, and one user reported a run time of 30 hours. Basically set it and forget it.


# COMMAND-LINE USE

Command-line use is fully supported. All flags are optional and can be used simultaneously. *

    tron.bat [-a -asu -c -d -dev -e -er -m -o -p -r -sa -sb -sd -sdc -sdu -se -sfr
              -sk -sm -sp -spr -srr -ss -str -sw -udl -v -x] | [-h]

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

     -sdb Skip de-bloat (OEM bloatware removal; implies -m)

     -sd  Skip defrag (force Tron to ALWAYS skip Stage 5 defrag)
     
     -sdc Skip DISM component (SxS store) cleanup
     
     -sdu Skip debloat update. Prevent Tron from auto-updating the S2 debloat lists

     -se  Skip Event Log backup and clear (don't clear Windows Event Logs)

     -sk  Skip Kaspersky Virus Rescue Tool (KVRT) scan

     -sm  Skip Malwarebytes Anti-Malware (MBAM) installation

     -sp  Skip patches (do not patch 7-Zip, Java Runtime, Adobe Flash or Reader)

     -spr Skip page file reset (don't set to "Let Windows manage the page file")

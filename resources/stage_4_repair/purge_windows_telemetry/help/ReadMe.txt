MTRT - Microsoft Telemetry Removal Tool - v2.2
Author: spexdi
For Windows 7 / 8 / 8.1 / 10

===========
== About ==
===========

The Microsoft Telemetry Removal Tool (or MTRT) is an automated script that aims to be the most current and complete collection of knowledge found on the internet pertaining to helping Windows 7/8/8.1/10 users rid themselves of as much Windows 10 "features" and notifications as possible.


==============
== Features ==
==============

This tool covers many areas of the decontamination process, such as:

   - Windows Update Settings: Changed to notify but not download update, optional updates are not packaged with important updates, and PC will not auto-reboot after update.
   - Disable Gwx/Skydrive/Spynet/Telemetry
   - Disable (Or Delete) Telemetry scheduled tasks
   - Delete Diagnostic Tracking Service and attempt to lock down log file
   - Disable Remote Registry
   - Remove OneDrive (Windows 10)s
   - Disable WER and WEC
   - Delete xBox Live services
   - Tons of registry entries applied to help protect your privacy
   - Block hosts: Through the HOSTS file and PersistentRoutes
   - Delete the Windows.~BT, Windows.~WS and Windows.old folders, then attempt to lock them.
   - Remove and block evil updates: updates are uninstalled and then ignored in windows updates.
   		
===========
== Usage ==
===========

Run MTRT.cmd as Admin and let the tool do the work for you. It will take a while, so if you are using it in a tech situation, copy from USB to local PC before running. A log file will be created in this help directory.

You can edit some variables at the top of the MTRT.cmd file

===========
== Files ==
===========

MTRT.cmd							- Main Program, run as Admin
	\data\Reg.ini					- List of registry folders to reset permissions on, as well as entries to set	**Open with spreadsheet app, don't merge Delimeters, and it's  VERY easy to work with.
	\data\HideWindowsUpdates.vbs	- File called on to hide updates
	\data\hosts.ini					- Entries being added to HOSTS file.				Use # to comment out any line
	\data\KB.ini					- Current list of KB's being removed.				Use # to comment out any line
	\data\PersistentRoutes.ini		- Entries being added to PersistentRoutes.			Use # to comment out any line
	\data\SchedTasks.ini			- List of scheduled tasks to be disabled. 			Use # to comment out any line
	\data\setacl.exe				- Program used to parse acl.ini and set registry permissions
	
	\help\Clear PersistentRoutes.bat		- Used to clear the table if needed
	\help\Edit system HOSTS file.lnk		- Admin shortcut to edit your system HOSTS file
	\help\etc - Shortcut.lnk				- Shortcut to the HOSTS folder
	\help\ReadMe.txt						- This file
	\help\MTRT_Log.log						- Logfile created if run as Standalone app
	\help\View PersistentRoutes.bat			- View your current list of PersistentRoutes installed
	\help\Windows 10 Router HOSTS to block.txt	- If possible, these addresses should be added to an outbound filter on your actual router


=====================
== Version History ==
=====================

12/10/2015	v2.2	- Fix issue with script being killed during onedrive removal (thanks /u/ssjkakaroto!)
					- Added router blocking txt info
					- Metro apps list removed (feature creep)

08/10/2015  v2.1	- More KBs and Reg entries added
					- HideWindowsUpdate.vbs tweaked, should hopefully run better now 

01/10/2015	v2.0	- Windows 10 support added!
					- Metro apps list added
					- Compatible with Tron_script https://www.reddit.com/r/TronScript/
					- INI files have data on which OS to apply certain settings to, you are welcome to customize and disable whatever you need, or add your own custom entries!
					- Command Logging and Dry Run features added
					- Lots of registry keys, tasks, and IPs added

19/09/2015	v1.2	- Minor typo fixes

13/09/2015	v1.1	- Added KB3065988
					- Windows.old folder cleaned
					- Diagnostic Tracking Service log file cleared and locked down
					- Added ACL.ini, hosts.ini, KB.ini, PersistentRoutes.ini, SchedTasks.ini:
					  Entries can be added or removed without having to update script
					- Windows.~BT, Windows.~WS and Windows.old folders locked down after delete
					- OS now detected, now only attempts to uninstall/hide relevant updates.
					- Massive code cleanup/tweaking
					- dmwappushservice (WiFiSense) removed (Win10)
					- HOSTS IP fix removed (No longer using Spybot Anti-Beacon, this script does more)

11/09/2015	v1.0	- Initial release


======================
== Bad Updates List ==
======================

WINDOWS 7 AND 8
2902907		Microsoft Security Essentials update?, update was pulled by Microsoft
2922324		Description not available, Update was pulled by Microsoft
2976987		Description not available
3012973 	Upgrade to Windows 10
3015249 	Update that adds telemetry points to consent.exe in Windows 8.1 and Windows 7
3022345 	Update for customer experience and diagnostic telemetry (replaced by 3080149)
3035583 	Update installs get Windows 10 app in Windows 8.1 and Windows 7 SP1
3068707		Update for customer experience and diagnostic telemetry, update may be pulled
3068708 	Update for customer experience and diagnostic telemetry
3075249 	Update that adds telemetry points to consent.exe in Windows 8.1 and Windows 7
3080149 	Update for customer experience and diagnostic telemetry (replaces 3022345)

WINDOWS 7 ONLY
971033		Update for Windows Activation Technologies
2952664 	Update for upgrading Windows 7
2977759 	Update for Windows 7 RTM
2990214 	Update that enables you to upgrade from Windows 7 to a later version of Windows
3021917 	Update for Windows 7 SP1 for performance improvements
3050265 	Windows Update client for Windows 7: June 2015
3065987 	Windows Update Client for Windows 7 and Windows Server 2008 R2: July 2015
3075851 	Windows Update Client for Windows 7 and Windows Server 2008 R2: August 2015
3083324 	Windows Update Client for Windows 7 and Windows Server 2008 R2: September 2015

WINDOWS 8 ONLY
2976978 	Update for Windows 8.1 and Windows 8
3014460 	Update for Windows Insider Preview / upgrade to Windows 10
3044374 	Update that enables you to upgrade from Windows 8.1 to Windows 10
3050267 	Windows Update client for Windows 8.1: June 2015
3065988 	Windows Update Client for Windows 8.1 and Windows Server 2012 R2: July 2015
3075853 	Windows Update Client for Windows 8.1 and Windows Server 2012 R2: August 2015
3083325 	Windows Update Client for Windows 8.1 and Windows Server 2012 R2: September 2015


============
== Thanks ==
============

thepower for his script that was used as a launchpad and tip about the acl (voat.co/v/technology/comments/459263)
qua-z for the tips on the scheduled tasks (np.reddit.com/r/pcmasterrace/comments/3g7hr0)
Colin Bowern for the Hide Windows update vbs (http://serverfault.com/a/341318)
BlockWindows for the hosts (blockwindows.wordpress.com)
Spybot Anti-Beacon: great tool, helped me catch a few reg keys that other missed (forums.spybot.info/showthread.php?72686)
Most current list of bad KB updates (techne.alaya.net/?p=12499)
spexdi for code compilation
More KB's (wilderssecurity.com/threads/379151)
xvitaly & azizLIGHT for more KB's (gist.github.com/xvitaly/eafa75ed2cb79b3bd4e9)
win10-unfu**k (https://github.com/Dfkt/win10-unfuck)
Debloat-Windows-10: https://github.com/W4RH4WK/Debloat-Windows-10
===============================
== Known limitations / To Do ==
===============================

 - Hiding windows updates doesn't always seem to work even when it reports it did, suggest manually checking after reboot. (May remove this in the near future if performance doesn't improve)
 - Thinking about adding a variable option + ini to configure whether to disable or attempt delete of services. Currently hard-coded
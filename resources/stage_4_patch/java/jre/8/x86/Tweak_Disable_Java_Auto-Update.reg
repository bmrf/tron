Windows Registry Editor Version 5.00

; Disable all Java irritations

; For matching architecture Java installations on matching architecture version of Windows
[HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Update\Policy] 
"EnableJavaUpdate"=dword:00000000 
"NotifyDownload"=dword:00000000 
"EnableAutoUpdateCheck"=dword:00000000
"NotifyInstall"=dword:00000000
"Frequency"=dword:01110000
"UpdateSchedule"=dword:00000000
"PromptAutoUpdateCheck"=-

; For 32-bit Java installations on a 64-bit version of Windows
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy] 
"EnableJavaUpdate"=dword:00000000 
"NotifyDownload"=dword:00000000 
"EnableAutoUpdateCheck"=dword:00000000
"PromptAutoUpdateCheck"=-

; More madness. Deletes the Startup task (if it exists)
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run]
"SunJavaUpdateSched"=-

; Deletes the Startup task (if it exists)
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run]
"SunJavaUpdateSched"=-

; Disable all "Sponsor" tag-along installers (McAfee, Google toolbar, etc), for matching architecture Java installations on matching architecture version of Windows
[HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft]
"SPONSORS"="DISABLE"

; Disable all "Sponsor" tag-along installers (McAfee, Google toolbar, etc), for 32-bit Java installations on a 64-bit version of Windows
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft]
"SPONSORS"="DISABLE"

; Disables Java browser integration
;[-HKEY_LOCAL_MACHINE\Software\Wow6432Node\JavaSoft\Java Plug-in]

:: Batch file to uninstall a specific list of programs by GUID
:: Called by Tron in Stage 2: De-bloat
:: Initial list by reddit.com/user/tuxedo_jack, modifications for use in Tron by reddit.com/user/vocatus
:: Add any GUID uninstall commands to this list to target them for removal
@echo off


:::::::::::::::
:: GUID LIST ::
:::::::::::::::

:: Adobe Refresh Manager
start /wait msiexec /x {AC76BA86-0804-1033-1959-001824147215} /qn /norestart

:: AMD Accelerated Video Transcoding
start /wait msiexec /x {A6AFFBD8-D006-967F-51AF-0120F0261080} /qn /norestart

:: AMD Catalyst Control Center - Branding
start /wait msiexec /x {24D38277-CE6E-4E12-A2EE-F46832A4FA2F} /qn /norestart

:: AMD OEM Application Profile
start /wait msiexec /x {C89A97B6-F991-EBB5-77B7-927BCF420EBE} /qn /norestart

:: Ask Toolbar
start /wait msiexec /x {4F524A2D-5637-006A-76A7-A758B70C0300} /qn /norestart
start /wait msiexec /x {86D4B82A-ABED-442A-BE86-96357B70F4FE} /qn /norestart

:: Best Buy pc app
start /wait msiexec /x {FBBC4667-2521-4E78-B1BD-8706F774549B} /qn /norestart
if exist "%ProgramData%\{D8EAE~1\Best Buy pc app Setup.msi" start /wait msiexec /x "%ProgramData%\{D8EAE~1\Best Buy pc app Setup.msi" /qn /norestart

:: Bing Bar
start /wait msiexec /x {3365E735-48A6-4194-9988-CE59AC5AE503} /qn /norestart
start /wait msiexec /x {C28D96C0-6A90-459E-A077-A6706F4EC0FC} /qn /norestart
start /wait msiexec /x {77F8A71E-3515-4832-B8B2-2F1EDBD2E0F1} /qn /norestart

:: Bing Desktop
start /wait msiexec /x {7D095455-D971-4D4C-9EFD-9AF6A6584F3A} /qn /norestart

:: Connect To Tech-Support (malware)
start /wait msiexec /x {A22B8513-EA8C-46A1-9735-F5BE971C368D} /qn /norestart

:: CyberLink Power2Go 8
start /wait msiexec /x {2A87D48D-3FDF-41fd-97CD-A1E370EFFFE2} /qn /norestart

:: CyberLink PhotoDirector 5
start /wait msiexec /x {5A454EC5-217A-42a5-8CE1-2DDEC4E70E01} /qn /norestart

:: CyberLink PowerDVD 12
start /wait msiexec /x {B46BEA36-0B71-4A4E-AE41-87241643FA0A} /qn /norestart

:: CyberLink PowerDirector 12
start /wait msiexec /x {E1646825-D391-42A0-93AA-27FA810DA093} /qn /norestart

:: CyberLink Power Media Player 14
start /wait msiexec /x {32C8E300-BDB4-4398-92C2-E9B7D8A233DB} /qn /norestart

:: CyberLink LabelPrint
start /wait msiexec /x {C59C179C-668D-49A9-B6EA-0121CCFC1243} /qn /norestart

:: CyberLink YouCam
start /wait msiexec /x {A9CEDD6E-4792-493e-BB35-D86D2E188A5A} /qn /norestart

:: Dell Access
start /wait msiexec /x {F839C6BD-E92E-48FA-9CE6-7BFAF94F7096} /qn /norestart

:: Dell Backup and Recovery Manager
start /wait msiexec /x {975DFE7C-8E56-45BC-A329-401E6B1F8102} /qn /norestart
start /wait msiexec /x {50B4B603-A4C6-4739-AE96-6C76A0F8A388} /qn /norestart
start /wait msiexec /x {731B0E4D-F4C7-450C-95B0-E1A3176B1C75} /qn /norestart
rd /s /q %SystemDrive%\dell\dbrm

:: Dell Client System Update
start /wait msiexec /x {69093D49-3DD1-4FB5-A378-0D4DB4CF86EA} /qn /norestart
start /wait msiexec /x {04566294-A6B6-4462-9721-031073EB3694} /qn /norestart
start /wait msiexec /x {2B2B45B1-3CA0-4F8D-BBB3-AC77ED46A0FE} /qn /norestart

:: Dell Command | Update
start /wait msiexec /x {EC542D5D-B608-4145-A8F7-749C02BE6D94} /qn /norestart

:: Dell Command | Power
start /wait msiexec /x {DDDAF4A7-8B7D-4088-AECC-6F50E594B4F5} /qn /norestart

:: Dell ControlPoint
start /wait msiexec /x {A9C61491-EF2F-4ED8-8E10-FB33E3C6B55A} /qn /norestart

:: Dell ControlVault Host Components Installer
start /wait msiexec /x {5A26B7C0-55B1-4DA8-A693-E51380497A5E} /qn /norestart

:: Dell Datasafe Online
start /wait msiexec /x {7EC66A95-AC2D-4127-940B-0445A526AB2F} /qn /norestart

:: Dell Digital Delivery
WMIC product where name="Dell Digital Delivery" call uninstall /nointeractive

:: Dell Dock
start /wait msiexec /x {E60B7350-EA5F-41E0-9D6F-E508781E36D2} /qn /norestart

:: Dell "Feature Enhancement" Pack
start /wait msiexec /x {992D1CE7-A20F-4AB0-9D9D-AFC3418844DA} /qn /norestart

:: Dell Getting Started Guide
start /wait msiexec /x {7DB9F1E5-9ACB-410D-A7DC-7A3D023CE045} /qn /norestart

:: Dell Power Manager
start /wait msiexec /x {CAC1E444-ECC4-4FF8-B328-5E547FD608F8} /qn /norestart

:: Dell Protected Workspace
WMIC product where name="Dell Protected Workspace" call uninstall /nointeractive

:: Dell Support Center
start /wait msiexec /x {0090A87C-3E0E-43D4-AA71-A71B06563A4A} /qn /norestart

:: DisableMSDefender
start /wait msiexec /x {74FE39A0-FB76-47CD-84BA-91E2BBB17EF2} /qn /norestart

:: DTS Sound
start /wait msiexec /x {793B70D2-41E9-46AB-9DDC-B34C99D07DB5} /qn /norestart
start /wait msiexec /x {F8EB8FFC-C535-49A1-A84D-CC75CB2D6ADA} /qn /norestart

:: EA Download Manager
start /wait msiexec /x {EF7E931D-DC84-471B-8DB6-A83358095474} /qn /norestart

:: Embassy Suite
start /wait msiexec /x {20A4AA32-B3FF-4A0B-853C-ACDDCD6CB344} /qn /norestart

:: Energy Star
start /wait msiexec /x {465CA2B6-98AF-4E77-BE22-A908C34BB9EC} /qn /norestart

:: Energy Star Digital Logo
start /wait msiexec /x {BD1A34C9-4764-4F79-AE1F-112F8C89D3D4} /qn /norestart

:: Epson Customer Participation
start /wait msiexec /x {814FA673-A085-403C-9545-747FC1495069} /qn /norestart

:: ESC Home Page Plugin
start /wait msiexec /x {E738A392-F690-4A9D-808E-7BAF80E0B398} /qn /norestart

:: Get Dropbox (also called "Dropbox 25 GB" or "Dropbox 15 GB")
start /wait msiexec /x {597A58EC-42D6-4940-8739-FB94491B013C} /qn /norestart

:: Google Toolbar for Internet Explorer
start /wait msiexec /x {18455581-E099-4BA8-BC6B-F34B2F06600C} /qn /norestart

:: Google Update Helper
start /wait msiexec /x {60EC980A-BDA2-4CB6-A427-B07A5498B4CA} /qn /norestart
start /wait msiexec /x {A92DAB39-4E2C-4304-9AB6-BC44E68B55E2} /qn /norestart

:: Hewlett-Packard ACLM.NET v1.2.2.3
start /wait msiexec /x {6F340107-F9AA-47C6-B54C-C3A19F11553F} /qn /norestart

:: HP ActiveCheck component for HP Active Support Libary
start /wait msiexec /x {254C37AA-6B72-4300-84F6-98A82419187E} /qn /norestart

:: HP 3D DriveGuard
start /wait msiexec /x {E8D0E2B8-B64B-44BC-8E01-00DDACBDF78A} /qn /norestart

:: HP 64 Bit HP CIO Components Installer
start /wait msiexec /x {FF21C3E6-97FD-474F-9518-8DCBE94C2854} /qn /norestart

:: HP BufferChm
start /wait msiexec /x {FA0FF682-CC70-4C57-93CD-E276F3E7537E} /qn /norestart

:: HP Customer Experience Enhancements
start /wait msiexec /x {07FA4960-B038-49EB-891B-9F95930AA544} /qn /norestart
start /wait msiexec /x {C9EF1AAF-B542-41C8-A537-1142DA5D4AEC} /qn /norestart

:: HP Connected Music
start /wait msiexec /x {8126E380-F9C6-4317-9CEE-9BBDDAB676E5} /qn /norestart

:: HP CoolSense
start /wait msiexec /x {1504CF6F-8139-497F-86FC-46174B67CF7F} /qn /norestart

:: HP Documentation
start /wait msiexec /x {C8D60CF4-BE7A-487E-BD36-535111BDB0FE} /qn /norestart
start /wait msiexec /x {06600E94-1C34-40E2-AB09-D30AECF78172} /qn /norestart

:: HP DisableMSDefender (disables Microsoft Defender...wtf?)
start /wait msiexec /x {74FE39A0-FB76-47CD-84BA-91E2BBB17EF2} /qn /norestart

:: HP GPBaseService2 (popups)
start /wait msiexec /x {BB3447F6-9553-4AA9-960E-0DB5310C5779} /qn /norestart

:: HP Product Assistant
start /wait msiexec /x {150B6201-E9E6-4DFB-960E-CCBD53FBDDED} /qn /norestart

:: HP PostScript Converter
start /wait msiexec /x {6E14E6D6-3175-4E1A-B934-CAB5A86367CD} /qn /norestart

:: HP Recovery Manager
start /wait msiexec /x {64BAA990-F1FC-4145-A7B1-E41FBBC9DA47} /qn /norestart

:: HP Registration Service
start /wait msiexec /x {D1E8F2D7-7794-4245-B286-87ED86C1893C} /qn /norestart

:: HP Setup
start /wait msiexec /x {438363A8-F486-4C37-834C-4955773CB3D3} /qn /norestart

:: HP SimplePass
start /wait msiexec /x {314FAD12-F785-4471-BCE8-AB506642B9A1} /qn /norestart

:: HP SmartWebPrinting
start /wait msiexec /x {8FF6F5CA-4E30-4E3B-B951-204CAAA2716A} /qn /norestart

:: HP Status Alerts
start /wait msiexec /x {9D1DE902-8058-4555-A16A-FBFAA49587DB} /qn /norestart

:: HP Solution Center
start /wait msiexec /x {BC5DD87B-0143-4D14-AAE6-97109614DC6B} /qn /norestart

:: HP Support Assistant
start /wait msiexec /x {8C696B4B-6AB1-44BC-9416-96EAC474CABE} /qn /norestart
start /wait msiexec /x {904822F1-6C7D-4B91-B936-6A1C0810544C} /qn /norestart
start /wait msiexec /x {61EB474B-67A6-47F4-B1B7-386851BAB3D0} /qn /norestart

:: HP Support Information
start /wait msiexec /x {B2B7B1C8-7C8B-476C-BE2C-049731C55992} /qn /norestart

:: HP Support Solutions Framework
start /wait msiexec /x {D7D5F438-26EF-45AB-AB89-C476FBCF8584} /qn /norestart

:: HP System Event Utility
start /wait msiexec /x {8B4EE87E-6D40-4C91-B5E8-0DC77DC412F1} /qn /norestart

:: HP "Toolbox" (hidden)
start /wait msiexec /x {292F0F52-B62D-4E71-921B-89A682402201} /qn /norestart

:: HP Update
start /wait msiexec /x {912D30CF-F39E-4B31-AD9A-123C6B794EE2} /qn /norestart

:: HP Utility Center
start /wait msiexec /x {B7B82520-8ECE-4743-BFD7-93B16C64B277} /qn /norestart

:: Intel Trusted Connect Client
start /wait msiexec /x {44B72151-611E-429D-9765-9BA093D7E48A} /qn /norestart

:: Intel(R) Technology Access
start /wait msiexec /x {413fe921-b226-41c8-bc3c-574074ceec4d} /qn /norestart
start /wait msiexec /x {583882E7-EA75-4BF0-94FA-7DD5A3731C76} /qn /norestart

:: Intel(R) Trusted Connect Service Client
start /wait msiexec /x {1B444AF9-1DBE-4884-8F35-969BEFCF69A8} /qn /norestart
start /wait msiexec /x {7D84E343-A23D-451C-B123-0195B2D903A6} /qn /norestart

:: Intel(R) Trusted Execution Engine
start /wait msiexec /x {E14B99BA-3282-4990-8BD7-20FD584A217F} /qn /norestart

:: Intel(R) Trusted Execution Engine Driver
start /wait msiexec /x {4021582A-4C27-4482-A287-5D49B80DB48F} /qn /norestart

:: Intel(R) Management Engine Components
start /wait msiexec /x {5D1BFBB8-4923-4388-9559-C86F5D9E2740} /qn /norestart
start /wait msiexec /x {B434599E-E35F-4612-9803-A2FB7A8E066B} /qn /norestart

:: Intel(R) ME UninstallLegacy
start /wait msiexec /x {FD37351B-3074-4652-8188-1B3FB784EC4E} /qn /norestart
start /wait msiexec /x {C9A90201-B2DE-44D0-A618-EF8C9060D318} /qn /norestart
start /wait msiexec /x {ECA145AF-55D0-42BA-870F-4213F0198A46} /qn /norestart

:: Intel Update
start /wait msiexec /x {78091D68-706D-4893-B287-9F1DFB24F7AF} /qn /norestart

:: Intel Update Manager
start /wait msiexec /x {608E1B9B-A2E8-4A1F-8BAB-874EB0DD25E3} /qn /norestart
start /wait msiexec /x {43FA4AC8-46F8-423F-96FD-9A7D67048F1C} /qn /norestart

:: Intel(R) Rapid Storage Technology
start /wait msiexec /x {205AE40D-8AD7-4F29-A430-DD2168DA562D} /qn /norestart
start /wait msiexec /x {409CB30E-E457-4008-9B1A-ED1B9EA21140} /qn /norestart

:: Java Auto Updater
start /wait msiexec /x {4A03706F-666A-4037-7777-5F2748764D10} /qn /norestart
start /wait msiexec /x {CCB6114E-9DB9-BD54-5AA0-BC5123329C9D} /qn /norestart

:: Kaspersky Internet Security
start /wait msiexec /x {793B70D2-41E9-46AB-9DDC-B34C99D07DB5} /qn /norestart

:: Lenovo Message Center Plus
start /wait msiexec /x {3849486C-FF09-4F5D-B491-3E179D58EE15} /qn /norestart

:: Lenovo Metrics Collector SDK
start /wait msiexec /x {DDAA788F-52E6-44EA-ADB8-92837B11BF26} /qn /norestart
start /wait msiexec /x {C2B5B5B0-2545-4E94-B4BA-548D4BF0B196} /qn /norestart

:: Lenovo Patch Utility
start /wait MsiExec /X {C6FB6B4A-1378-4CD3-9CD3-42BA69FCBD43} /qn /norestart

:: Lenovo Reach and REACHit
start /wait msiexec /x {3245D8C8-7FE0-4FD4-B04B-2720A333D592} /qn /norestart
start /wait msiexec /x {0B5E0E89-4BCA-4035-BBA1-D1439724B6E2} /qn /norestart
start /wait msiexec /x {4532E4C5-C84D-4040-A044-ECFCC5C6995B} /qn /norestart

:: Lenovo Registration
start /wait msiexec /x {6707C034-ED6B-4B6A-B21F-969B3606FBDE} /qn /norestart

:: Lenovo SMB Customizations
start /wait msiexec /x {AFD7B869-3B70-40C7-8983-769256BA3BD2} /qn /norestart

:: Lenovo Solution Center
start /wait msiexec /x {63942F7E-3646-45EC-B8A9-EAC40FEB66DB} /qn /norestart
start /wait msiexec /x {13BD494D-9ACD-420B-A291-E145DED92EF6} /qn /norestart
start /wait msiexec /x {4C2B6F96-3AED-4E3F-8DCE-917863D1E6B1} /qn /norestart
start /wait msiexec /x {1CA74803-5CB2-4C03-BDBE-061EDC81CC7F} /qn /norestart

:: Lenovo System Update
start /wait msiexec /x {25C64847-B900-48AD-A164-1B4F9B774650} /qn /norestart
start /wait msiexec /x {8675339C-128C-44DD-83BF-0A5D6ABD8297} /qn /norestart
start /wait msiexec /x {C9335768-C821-DD44-38FB-A0D5A6DB2879} /qn /norestart

:: Lenovo User Guide
start /wait msiexec /x {13F59938-C595-479C-B479-F171AB9AF64F} /qn /norestart

:: Lenovo Warranty Info
start /wait msiexec /x {FD4EC278-C1B1-4496-99ED-C0BE1B0AA521} /qn /norestart

:: Lenovo Web Start
if exist "%LOCALAPPDATA%\Pokki\Engine\HostAppService.exe" "%LOCALAPPDATA%\Pokki\Engine\HostAppService.exe" /UNINSTALL04bb6df446330549a2cb8d67fbd1a745025b7bd1

:: McAfee LiveSafe - Internet Security
if exist %ProgramFiles(x86)%\McAfee\MSC\mcuihost.exe %ProgramFiles(x86)%\McAfee\MSC\mcuihost.exe /body:misp://MSCJsRes.dll::uninstall.html /id:uninstall
if exist %ProgramFiles%\McAfee\MSC\mcuihost.exe %ProgramFiles%\McAfee\MSC\mcuihost.exe /body:misp://MSCJsRes.dll::uninstall.html /id:uninstall

:: Microsoft Search Enhancement Pack
start /wait msiexec /x {4CBA3D4C-8F51-4D60-B27E-F6B641C571E7} /qn /norestart

:: Microsoft DVD App Installation for Microsoft.WindowsDVDPlayer_2019.6.11761.0_neutral_~_8wekyb3d8bbwe (x64)
start /wait msiexec /x {986E003C-E56D-5A47-110E-D3C81F0E8535} /qn /norestart

:: Network64, malware
start /wait msiexec /x {6BFAB6C1-6D46-46DB-A538-A269907C9F2F} /qn /norestart

:: Office 2013 C2R Suite
start /wait msiexec /x {90150000-0138-0409-0000-0000000FF1CE} /qn /norestart
start /wait msiexec /x "C:\ProgramData\Microsoft\OEMOffice15\OOBE\x86\oemoobe.msi" /qn /norestart

:: opensource
start /wait msiexec /x {3677D4D8-E5E0-49FC-B86E-06541CF00BBE} /qn /norestart

:: PlayReady PC Runtime amd64
start /wait msiexec /x {BCA9334F-B6C9-4F65-9A73-AC5A329A4D04} /qn /norestart

:: Recovery Manager
start /wait msiexec /x {44B2A0AB-412E-4F8C-B058-D1E8AECCDFF5} /qn /norestart
start /wait msiexec /x {C7231F7C-6530-4E65-ADA6-5B392CF5BEB1} /qn /norestart

:: RealDownloader
start /wait msiexec /x {C8E8D2E3-EF6A-4B1D-A09E-7B27EBE2F3CE} /qn /norestart

:: Roxio File Backup
start /wait msiexec /x {60B2315F-680F-4EB3-B8DD-CCDC86A7CCAB} /qn /norestart

:: Roxio BackOnTrack
start /wait msiexec /x {5A06423A-210C-49FB-950E-CB0EB8C5CEC7} /qn /norestart

:: Samsung SW Update (disables Windows Update; very bad)
start /wait msiexec /x {AAFEFB05-CF98-48FC-985E-F04CD8AD620D} /qn /norestart

:: swMSM -  Shockwave Player Merge Module
start /wait msiexex /x {612C34C7-5E90-47D8-9B5C-0F717DD82726} /qn /norestart

:: Skype Click 2 Call
start /wait msiexec /x {6D1221A9-17BF-4EC0-81F2-27D30EC30701} /qn /norestart

:: Toshiba Audio Enhancement
start /wait msiexec /x {1515F5E3-29EA-4CD1-A981-032D88880F09} /qn /norestart

:: Toshiba Display Utility
start /wait msiexec /x {0B39C39A-3ECE-4582-9C91-842D22819A24} /qn /norestart

:: Toshiba Application Installer
start /wait msiexec /x {21A63CA3-75C0-4E56-B602-B7CD2EF6B621} /qn /norestart
start /wait msiexec /x {970472D0-F5F9-4158-A6E3-1AE49EFEF2D3} /qn /norestart

:: Toshiba App Place
start /wait msiexec /x {ED3CBA78-488F-4E8C-B33F-8E3BF4DDB4D2} /qn /norestart

:: Toshiba Book Place
start /wait msiexec /x {11244D6B-9842-440F-8579-6A4D771A0D9B} /qn /norestart
start /wait msiexec /x {92C7DC44-DAD3-49FE-B89B-F92C6BA9A331} /qn /norestart

:: Toshiba Bulletin Board
start /wait msiexec /x {C14518AF-1A0F-4D39-8011-69BAA01CD380} /qn /norestart

:: Toshiba Desktop Assist
start /wait msiexec /x {95CCACF0-010D-45F0-82BF-858643D8BC02} /qn /norestart

:: Toshiba System Driver
start /wait msiexec /x {1E6A96A1-2BAB-43EF-8087-30437593C66C} /qn /norestart

:: TOSHIBA Eco Utility
start /wait msiexec /x {72EFCFA8-3923-451D-AF52-7CE9D87BC2A1} /qn /norestart
start /wait msiexec /x {5944B9D4-3C2A-48DE-931E-26B31714A2F7} /qn /norestart

:: TOSHIBA Recovery Media Creator
start /wait msiexec /x {B65BBB06-1F8E-48F5-8A54-B024A9E15FDF} /qn /norestart

:: Toshiba Password Utility
start /wait msiexec /x {26BB68BB-CF93-4A12-BC6D-A3B6F53AC8D9} /qn /norestart

:: Toshiba User's Guide
start /wait msiexec /x {3384E1D9-3F18-4A98-8655-180FEF0DFC02} /qn /norestart

:: TOSHIBARegistration
start /wait msiexec /x {5AF550B4-BB67-4E7E-82F1-2C4300279050} /qn /norestart

:: Toshiba ReelTime
start /wait msiexec /x {24811C12-F4A9-4D0F-8494-A7B8FE46123C} /qn /norestart

:: TOSHBA VIDEO PLAYER
start /wait msiexec /x {FF07604E-C860-40E9-A230-E37FA41F103A} /qn /norestart

:: TOSHIBA Quality Application
start /wait msiexec /x {E69992ED-A7F6-406C-9280-1C156417BC49} /qn /norestart

:: Toshiba Service Station
start /wait msiexec /x {0DFA8761-7735-4DE8-A0EB-2286578DCFC6} /qn /norestart
start /wait msiexec /x {6499E894-43F8-458B-AE35-724F4732BCDE} /qn /norestart

:: Toshiba System Settings
start /wait msiexec /x {B040D5C9-C9AA-430A-A44E-696656012E61} /qn /norestart
start /wait msiexec /x {05A55927-DB9B-4E26-BA44-828EBFF829F0} /qn /norestart

:: Toshiba Value Added Package
start /wait msiexec /x {066CFFF8-12BF-4390-A673-75F95EFF188E} /qn /norestart

:: Toshiba Wireless LAN Indicator
start /wait msiexec /x {CDADE9BC-612C-42B8-B929-5C6A823E7FF9} /qn /norestart

:: TrayApp
start /wait msiexec /x {CD31E63D-47FD-491C-8117-CF201D0AFAB5} /qn /norestart

:: Trend Micro Trial
start /wait msiexec /x {BED0B8A2-2986-49F8-90D6-FA008D37A3D2} /qn /norestart

:: Trend Micro Worry-Free Business Security Trial
start /wait msiexec /x {0A07E717-BB5D-4B99-840B-6C5DED52B277} /qn /norestart

:: WildTangent GUIDs. Thanks to /u/mnbitcoin
start /wait msiexec /x {23170F69-40C1-2702-0938-000001000000} /qn /norestart
start /wait msiexec /x {EE691BD9-2B2C-6BFB-6389-ABAF5AD2A4A1} /qn /norestart
start /wait msiexec /x {6E3610B2-430D-4EB0-81E3-2B57E8B9DE8D} /qn /norestart
start /wait msiexec /x {9E9EF3EC-22BC-445C-A883-D8DB2908698D} /qn /norestart
:: \/ "Delicious Emilys Childhood Memories Premium Edition"....wtf
start /wait msiexec /x {FC0ADA4D-8FA5-4452-8AFF-F0A0BAC97EF7} /qn /norestart
start /wait msiexec /x {6F340107-F9AA-47C6-B54C-C3A19F11553F} /qn /norestart
start /wait msiexec /x {DD7C5FC1-DCA5-487A-AF23-658B1C00243F} /qn /norestart
start /wait msiexec /x {0F929651-F516-4956-90F2-FFBD2CD5D30E} /qn /norestart
start /wait msiexec /x {89C7E0A7-4D9D-4DCC-8834-A9A2B92D7EBB} /qn /norestart
start /wait msiexec /x {9B56B031-A6C0-4BB7-8F61-938548C1B759} /qn /norestart
start /wait msiexec /x {0C0F368E-17C4-4F28-9F1B-B1DA1D96CF7A} /qn /norestart
start /wait msiexec /x {36AC0D1D-9715-4F13-B6A4-86F1D35FB4DF} /qn /norestart
start /wait msiexec /x {03D562B5-C4E2-4846-A920-33178788BE00} /qn /norestart

:: Windows Live Family Safety // Disabled by Vocatus for Tron (some family systems may be using this)
::start /wait msiexec /x {5F611ADA-B98C-4DBB-ADDE-414F08457ECF} /qn /norestart

:: Windows Live Toolbar
start /wait msiexec /x {995F1E2E-F542-4310-8E1D-9926F5A279B3} /qn /norestart

:: WinZip
start /wait msiexec /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240ED} /qn /norestart

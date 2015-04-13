:: Batch file to uninstall a specific list of programs by GUID
:: Called by Tron in Stage 2: De-bloat
:: Initial list by reddit.com/user/tuxedo_jack, modifications for use in Tron by reddit.com/user/vocatus
:: Add any GUID uninstall commands to this list to target them for removal
@echo off


::::::::::::::::::::::::::
:: Interactive Removals ::
::::::::::::::::::::::::::
:: If you uncomment these, they will STOP Tron while waiting for user input! Only left here for reference.

:: Dell Backup and Restore
::"%ProgramFiles(x86)%\InstallShield Installation Information\{0ED7EE95-6A97-47AA-AD73-152C08A15B04}\setup.exe" -runfromtemp -l0x0409  -removeonly

:: McAfee Security Scan
::"%ProgramFiles%\McAfee Security Scan\uninstall.exe" /S
::"%ProgramFiles(x86)%\McAfee Security Scan\uninstall.exe" /S


:::::::::::::::::::::
:: Silent Removals ::
:::::::::::::::::::::

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

:: Dell Access
start /wait msiexec /x {F839C6BD-E92E-48FA-9CE6-7BFAF94F7096} /qn /norestart

:: Dell Backup and Recovery Manager
start /wait msiexec /x {975DFE7C-8E56-45BC-A329-401E6B1F8102} /qn /norestart
start /wait msiexec /x {50B4B603-A4C6-4739-AE96-6C76A0F8A388} /qn /norestart
start /wait msiexec /x {731B0E4D-F4C7-450C-95B0-E1A3176B1C75} /qn /norestart
rd /s /q C:\dell\dbrm

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

:: Embassy Suite
start /wait msiexec /x {20A4AA32-B3FF-4A0B-853C-ACDDCD6CB344} /qn /norestart

:: Epson Customer Participation
start /wait msiexec /x {814FA673-A085-403C-9545-747FC1495069} /qn /norestart

:: ESC Home Page Plugin
start /wait msiexec /x {E738A392-F690-4A9D-808E-7BAF80E0B398} /qn /norestart

:: HP Customer Experience Enhancements
start /wait msiexec /x {07FA4960-B038-49EB-891B-9F95930AA544} /qn /norestart

:: HP Connected Music
start /wait msiexec /x {8126E380-F9C6-4317-9CEE-9BBDDAB676E5} /qn /norestart

:: HP PostScript Converter
start /wait msiexec /x {6E14E6D6-3175-4E1A-B934-CAB5A86367CD} /qn /norestart

:: HP Registration Service
start /wait msiexec /x {D1E8F2D7-7794-4245-B286-87ED86C1893C} /qn /norestart

:: HP SimplePass
start /wait msiexec /x {314FAD12-F785-4471-BCE8-AB506642B9A1} /qn /norestart

:: HP Status Alerts
start /wait msiexec /x {9D1DE902-8058-4555-A16A-FBFAA49587DB} /qn /norestart

:: HP Support Assistant
start /wait msiexec /x {8C696B4B-6AB1-44BC-9416-96EAC474CABE} /qn /norestart

:: HP Update
start /wait msiexec /x {912D30CF-F39E-4B31-AD9A-123C6B794EE2} /qn /norestart

:: HP Utility Center
start /wait msiexec /x {B7B82520-8ECE-4743-BFD7-93B16C64B277} /qn /norestart

:: Intel Trusted Connect Client
start /wait msiexec /x {44B72151-611E-429D-9765-9BA093D7E48A} /qn /norestart

:: Intel Update
start /wait msiexec /x {78091D68-706D-4893-B287-9F1DFB24F7AF} /qn /norestart

:: Intel Update Manager
start /wait msiexec /x {608E1B9B-A2E8-4A1F-8BAB-874EB0DD25E3} /qn /norestart

:: Java Auto Updater
start /wait msiexec /x {4A03706F-666A-4037-7777-5F2748764D10} /qn /norestart
start /wait msiexec /x {CCB6114E-9DB9-BD54-5AA0-BC5123329C9D} /qn /norestart

:: Lenovo Message Center Plus
start /wait msiexec /x {3849486C-FF09-4F5D-B491-3E179D58EE15} /qn /norestart

:: Lenovo Metrics Collector SDK
start /wait msiexec /x {DDAA788F-52E6-44EA-ADB8-92837B11BF26} /qn /norestart

:: Lenovo Patch Utility
start /wait MsiExec /X {C6FB6B4A-1378-4CD3-9CD3-42BA69FCBD43} /qn /norestart

:: Lenovo Reach
start /wait msiexec /x {3245D8C8-7FE0-4FD4-B04B-2720A333D592} /qn /norestart
start /wait msiexec /x {0B5E0E89-4BCA-4035-BBA1-D1439724B6E2} /qn /norestart

:: Lenovo Registration
start /wait msiexec /x {6707C034-ED6B-4B6A-B21F-969B3606FBDE} /qn /norestart

:: Lenovo SMB Customizations
start /wait msiexec /x {AFD7B869-3B70-40C7-8983-769256BA3BD2} /qn /norestart

:: Lenovo Solution Center
start /wait msiexec /x {63942F7E-3646-45EC-B8A9-EAC40FEB66DB} /qn /norestart
start /wait msiexec /x {13BD494D-9ACD-420B-A291-E145DED92EF6} /qn /norestart
start /wait msiexec /x {4C2B6F96-3AED-4E3F-8DCE-917863D1E6B1} /qn /norestart

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

:: Microsoft Search Enhancement Pack
start /wait msiexec /x {4CBA3D4C-8F51-4D60-B27E-F6B641C571E7} /qn /norestart

:: Office 2013 C2R Suite
start /wait msiexec /x {90150000-0138-0409-0000-0000000FF1CE} /qn /norestart
start /wait msiexec /x "C:\ProgramData\Microsoft\OEMOffice15\OOBE\x86\oemoobe.msi" /qn /norestart

:: Roxio File Backup
start /wait msiexec /x {60B2315F-680F-4EB3-B8DD-CCDC86A7CCAB} /qn /norestart

:: Roxio BackOnTrack
start /wait msiexec /x {5A06423A-210C-49FB-950E-CB0EB8C5CEC7} /qn /norestart

:: Skype Click 2 Call
start /wait msiexec /x {6D1221A9-17BF-4EC0-81F2-27D30EC30701} /qn /norestart

:: Toshiba ReelTime
start /wait msiexec /x {24811C12-F4A9-4D0F-8494-A7B8FE46123C} /qn /norestart

:: Toshiba Book Place
start /wait msiexec /x {92C7DC44-DAD3-49FE-B89B-F92C6BA9A331} /qn /norestart

:: Toshiba Value Added Package
start /wait msiexec /x {066CFFF8-12BF-4390-A673-75F95EFF188E} /qn /norestart

:: Toshiba Wireless LAN Indicator
start /wait msiexec /x {CDADE9BC-612C-42B8-B929-5C6A823E7FF9} /qn /norestart

:: Toshiba Bulletin Board
start /wait msiexec /x {C14518AF-1A0F-4D39-8011-69BAA01CD380}  /qn /norestart

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

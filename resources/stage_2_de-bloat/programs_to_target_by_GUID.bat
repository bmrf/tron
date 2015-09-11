:: Batch file to uninstall a specific list of programs by GUID
:: Called by Tron in Stage 2: De-bloat
:: Initial list by reddit.com/user/tuxedo_jack, modifications for use in Tron by reddit.com/user/vocatus
:: Add any GUID uninstall commands to this list to target them for removal
@echo off


:::::::::::::::
:: GUID LIST ::
:::::::::::::::

:: Adobe Bridge 1.0
start /wait msiexec /x {B74D4E10-1033-0000-0000-000000000001} /qn /norestart

:: Adobe Content Viewer
start /wait msiexec /x {483A865C-A74A-12BF-1276-D0111A488F50} /qn /norestart

:: Adobe Community Help
start /wait msiexec /x {A127C3C0-055E-38CF-B38F-1E85F8BBBFFE} /qn /norestart

:: Adobe Common File Installer
start /wait msiexec /x {8EDBA74D-0686-4C99-BFDD-F894678E5B39} /qn /norestart

:: Adobe Help Center 1.0
start /wait msiexec /x {E9787678-1033-0000-8E67-000000000001} /qn /norestart

:: Adobe Help Manager
start /wait msiexec /x {AF37176A-78CA-545B-34EF-8B6A21514DD1} /qn /norestart

:: Adobe Media Player
start /wait msiexec /x {39F6E2B4-CFE8-C30A-66E8-489651F0F34C} /qn /norestart

:: Adobe Refresh Manager
start /wait msiexec /x {AC76BA86-0804-1033-1959-001824147215} /qn /norestart

:: AMD Accelerated Video Transcoding
start /wait msiexec /x {A6AFFBD8-D006-967F-51AF-0120F0261080} /qn /norestart

:: AMD Catalyst Control Center - Branding
start /wait msiexec /x {24D38277-CE6E-4E12-A2EE-F46832A4FA2F} /qn /norestart

:: AMD OEM Application Profile
start /wait msiexec /x {C89A97B6-F991-EBB5-77B7-927BCF420EBE} /qn /norestart

:: AMD Wireless Display v3.0
start /wait msiexec /x {0A2E1907-D0DE-0D01-CA64-CB0AB0BFE539} /qn /norestart
start /wait msiexec /x {426582A8-202F-D13C-8BD5-F00551BAFC93} /qn /norestart
start /wait msiexec /x {630E5EF7-72F8-9E5D-BEF5-ED85B698E160} /qn /norestart
start /wait msiexec /x {C16CD4C0-48EE-0F40-C9FD-0778EAF73FBD} /qn /norestart
start /wait msiexec /x {D7C275A6-3266-0FBC-2D84-17A6AC226F01} /qn /norestart
start /wait msiexec /x {ED273D26-E354-1A5B-A0D0-CB5258D43BD2} /qn /norestart

:: ArcSoft Magic-i Visual Effects 2, ArcSoft WebCam Companion 3 and 4
start /wait msiexec /x {B1893E3F-9BDF-443F-BED0-1AAA2D9E0D68} /qn /norestart
start /wait msiexec /x {DE8AAC73-6D8D-483E-96EA-CAEDDADB9079} /qn /norestart
start /wait msiexec /x {B77DE05C-7C84-4011-B93F-A29D0D2840F4} /qn /norestart

:: Ashampoo Burning Studio FREE v.1.14.5
start /wait msiexec /x {91B33C97-91F8-FFB3-581B-BC952C901685} /qn /norestart

:: Ask Toolbar
start /wait msiexec /x {4F524A2D-5637-006A-76A7-A758B70C0300} /qn /norestart
start /wait msiexec /x {86D4B82A-ABED-442A-BE86-96357B70F4FE} /qn /norestart

:: ASUS Ai Charger
start /wait msiexec /x {7FB64E72-9B0E-4460-A821-040C341E414A} /qn /norestart

:: AVG 2015
start /wait msiexec /x {3B3927B0-0A21-4B4C-9FF3-AB4C42E2AF79} /qn /norestart
start /wait msiexec /x {966F007B-0D8A-44A6-A6C3-5395983C356D} /qn /norestart
start /wait msiexec /x {0B7BE3CA-AF33-4CE3-BC27-1456C96EF996} /qn /norestart
start /wait msiexec /x {7A5DB14B-14B0-4F09-A130-BF60503B4248} /qn /norestart

:: AzureBay Screen Saver
start /wait msiexec /x {958A793F-F1D2-4A90-B6A5-C52E2D74E8FE} /qn /norestart

:: Best Buy pc app
start /wait msiexec /x {FBBC4667-2521-4E78-B1BD-8706F774549B} /qn /norestart
if exist "%ProgramData%\{D8EAE~1\Best Buy pc app Setup.msi" start /wait msiexec /x "%ProgramData%\{D8EAE~1\Best Buy pc app Setup.msi" /qn /norestart

:: Bing Bar
start /wait msiexec /x {3365E735-48A6-4194-9988-CE59AC5AE503} /qn /norestart
start /wait msiexec /x {C28D96C0-6A90-459E-A077-A6706F4EC0FC} /qn /norestart
start /wait msiexec /x {77F8A71E-3515-4832-B8B2-2F1EDBD2E0F1} /qn /norestart
start /wait msiexec /x {1AE46C09-2AB8-4EE5-88FB-08CD0FF7F2DF} /qn /norestart
start /wait msiexec /x {49977584-B20E-46AB-818F-845815378904} /qn /norestart

:: Bing Desktop
start /wait msiexec /x {7D095455-D971-4D4C-9EFD-9AF6A6584F3A} /qn /norestart

:: CA Pest Patrol Realtime Protection 001.001.0034
start /wait msiexec /x {F05A5232-CE5E-4274-AB27-44EB8105898D} /qn /norestart

:: Catalyst Control Center - Branding 1.00.0000
start /wait msiexec /x {FB90923E-F94F-4343-A084-F0AB39305C8B} /qn /norestart

:: Catalyst Control Center Graphics Previews Common 2010.1110.1539.28046
start /wait msiexec /x {190A9F41-85D0-CDB3-AA2D-A076D30953C9} /qn /norestart

:: CCC Help files. Too many to individually list, Google each GUID for more info
start /wait msiexec /x {8328BF7C-818B-9D36-BA79-0D5BE45620F0} /qn /norestart
start /wait msiexec /x {63DEFBAD-3265-AD54-E29E-9D2862F2A549} /qn /norestart
start /wait msiexec /x {F0BACABE-F496-5F33-6E36-80D7A9FC2FE6} /qn /norestart
start /wait msiexec /x {75396B8A-2911-D9A1-A608-B4EB3A2CD37C} /qn /norestart
start /wait msiexec /x {30B5D9AB-BBEF-204C-3358-3F9D975E59A7} /qn /norestart
start /wait msiexec /x {A3BB948E-71DF-F10D-2441-16BC8A61E225} /qn /norestart
start /wait msiexec /x {81230599-8908-7D96-2B59-91B13738CC0D} /qn /norestart
start /wait msiexec /x {2D0DC4B9-2782-7B15-1501-A03AE797E03A} /qn /norestart
start /wait msiexec /x {4A38D588-649B-1EB1-6A57-75B45C33B7F3} /qn /norestart
start /wait msiexec /x {8C7D5970-4345-91BA-1581-167DEB552F65} /qn /norestart
start /wait msiexec /x {8E95E884-5F00-3046-02CA-ABC28C6BBD44} /qn /norestart
start /wait msiexec /x {9B76FA03-3D4A-81A1-1868-10E00020260F} /qn /norestart
start /wait msiexec /x {A5E85D15-785C-518C-B32C-EE2F70AFF121} /qn /norestart
start /wait msiexec /x {8FD03154-3788-0AB2-9BE7-3F62A860F38F} /qn /norestart
start /wait msiexec /x {8932E88F-DD0E-9AD4-1C7F-B3A570A02EB6} /qn /norestart
start /wait msiexec /x {A0DB4A2B-5AD0-310D-FFA3-50E749FF8305} /qn /norestart
start /wait msiexec /x {B3CBABCC-5027-F2AD-B26F-3CA1500DAEE2} /qn /norestart
start /wait msiexec /x {73833816-D0FB-A4A0-1E8D-26B1ABE12836} /qn /norestart
start /wait msiexec /x {C8B57F0F-1582-CA83-A51D-26B5A542623A} /qn /norestart
start /wait msiexec /x {3EE9FFB6-F2FD-3A11-27E7-6A86A5A08EC0} /qn /norestart
start /wait msiexec /x {C98C1CA9-FF57-CA5F-84A8-F2F270F3735B} /qn /norestart
start /wait msiexec /x {1CC59E4A-A43D-FA88-E26E-568632554FDC} /qn /norestart
start /wait msiexec /x {7268F803-2887-2E4F-C193-3223979A76CC} /qn /norestart
start /wait msiexec /x {3C0DB13A-2D73-410A-6169-4FD83D8F1E3D} /qn /norestart
start /wait msiexec /x {E866E52C-1F56-4CCF-0071-CA915F8CFEDA} /qn /norestart
start /wait msiexec /x {F66299DC-055A-DA2D-4D1C-91F71EDD0129} /qn /norestart
start /wait msiexec /x {AB6D8A9C-2781-32B9-7B6F-07262A44767C} /qn /norestart
start /wait msiexec /x {F5D245CC-C332-1E8E-CCB1-75E0C3C4D6F1} /qn /norestart
start /wait msiexec /x {DC890E2E-FD12-96D2-1B2C-0EA08DE15553} /qn /norestart
start /wait msiexec /x {DC5825EF-21F2-86B4-1B64-FFF6AC1A6C05} /qn /norestart
start /wait msiexec /x {53EF1C4D-0705-98F2-1889-A69BBF9F03F3} /qn /norestart
start /wait msiexec /x {8603DA4D-0A19-0B06-9916-2F71B7898CE5} /qn /norestart
start /wait msiexec /x {4A85AE1B-9727-261D-9EAF-07C1AECCF977} /qn /norestart

:: Comcast Desktop Software (v1.2.0.9) 23
start /wait msiexec /x {CEF7211D-CE3A-44C4-B321-D84A2099AE94} /qn /norestart

:: Connect To Tech-Support (malware)
start /wait msiexec /x {A22B8513-EA8C-46A1-9735-F5BE971C368D} /qn /norestart

:: CyberLink Blu-ray Disc Suite
start /wait msiexec /x {1FBF6C24-C1FD-4101-A42B-0C564F9E8E79} /qn /norestart

:: CyberLink Power2Go
start /wait msiexec /x {2A87D48D-3FDF-41fd-97CD-A1E370EFFFE2} /qn /norestart
start /wait msiexec /x {40BF1E83-20EB-11D8-97C5-0009C5020658} /qn /norestart

:: CyberLink PhotoDirector 5
start /wait msiexec /x {5A454EC5-217A-42a5-8CE1-2DDEC4E70E01} /qn /norestart

:: CyberLink PowerDVD 12 and DX
start /wait msiexec /x {B46BEA36-0B71-4A4E-AE41-87241643FA0A} /qn /norestart
start /wait msiexec /x {6811CAA0-BF12-11D4-9EA1-0050BAE317E1} /qn /norestart

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

:: Dell Feature Enhancement Pack
start /wait msiexec /x {992D1CE7-A20F-4AB0-9D9D-AFC3418844DA} /qn /norestart

:: Dell Getting Started Guide
start /wait msiexec /x {7DB9F1E5-9ACB-410D-A7DC-7A3D023CE045} /qn /norestart

:: Dell Power Manager
start /wait msiexec /x {CAC1E444-ECC4-4FF8-B328-5E547FD608F8} /qn /norestart

:: Dell Protected Workspace
wmic product where name="Dell Protected Workspace" call uninstall /nointeractive

:: Dell Resource CD
start /wait msiexec /x {42929F0F-CE14-47AF-9FC7-FF297A603021} /qn /norestart

:: Dell Support Center
start /wait msiexec /x {0090A87C-3E0E-43D4-AA71-A71B06563A4A} /qn /norestart

:: Desktop Doctor 2.5.5
start /wait msiexec /x {D87149B3-7A1D-4548-9CBF-032B791E5908} /qn /norestart

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

:: Facebook Messenger 2.1.4814.0
start /wait msiexec /x {7204BDEE-1A48-4D95-A964-44A9250B439E} /qn /norestart

:: Facebook Video Calling 3.1.0.521
start /wait msiexec /x {2091F234-EB58-4B80-8C96-8EB78C808CF7} /qn /norestart

:: Find Junk Files 1.51
start /wait msiexec /x {9FE8D71A-BEBC-48F3-9479-E5E25AE2A4F0} /qn /norestart

:: FlashCatch browser plugin
start /wait msiexec /x {A0AB2980-1FDD-4b6c-940C-FC87C84F05B7} /qn /norestart

:: Get Dropbox (also called "Dropbox 25 GB" or "Dropbox 15 GB")
start /wait msiexec /x {597A58EC-42D6-4940-8739-FB94491B013C} /qn /norestart

:: GeekBuddy
start /wait msiexec /x {17004FB0-9CFD-43DC-BB2D-E2BA612D98D0} /qn /norestart

:: Google Toolbar for Internet Explorer
start /wait msiexec /x {18455581-E099-4BA8-BC6B-F34B2F06600C} /qn /norestart
start /wait msiexec /x {2318C2B1-4965-11d4-9B18-009027A5CD4F} /qn /norestart

:: Google Update Helper
start /wait msiexec /x {60EC980A-BDA2-4CB6-A427-B07A5498B4CA} /qn /norestart
start /wait msiexec /x {A92DAB39-4E2C-4304-9AB6-BC44E68B55E2} /qn /norestart

:: Hewlett-Packard ACLM.NET
start /wait msiexec /x {6F340107-F9AA-47C6-B54C-C3A19F11553F} /qn /norestart

:: HP 3D DriveGuard
start /wait msiexec /x {E8D0E2B8-B64B-44BC-8E01-00DDACBDF78A} /qn /norestart

:: HP 64 Bit HP CIO Components Installer
start /wait msiexec /x {FF21C3E6-97FD-474F-9518-8DCBE94C2854} /qn /norestart
start /wait msiexec /x {BC741628-0AFC-405C-8946-DD46D1005A0A} /qn /norestart

:: HP ActiveCheck component for HP Active Support Libary
start /wait msiexec /x {254C37AA-6B72-4300-84F6-98A82419187E} /qn /norestart

:: HP BufferChm
start /wait msiexec /x {FA0FF682-CC70-4C57-93CD-E276F3E7537E} /qn /norestart

:: HP Customer Experience Enhancements
start /wait msiexec /x {07FA4960-B038-49EB-891B-9F95930AA544} /qn /norestart
start /wait msiexec /x {C9EF1AAF-B542-41C8-A537-1142DA5D4AEC} /qn /norestart

:: HP CustomerResearchQFolder
start /wait msiexec /x {6F5E2F4A-377D-4700-B0E3-8F7F7507EA15} /qn /norestart

:: HP Connected Music
start /wait msiexec /x {8126E380-F9C6-4317-9CEE-9BBDDAB676E5} /qn /norestart

:: HP CoolSense
start /wait msiexec /x {1504CF6F-8139-497F-86FC-46174B67CF7F} /qn /norestart

:: HP D2400_Help
start /wait msiexec /x {7EF7CCB0-52BF-4947-BE6E-E47D586E8842} /qn /norestart

:: HP Deskjet 2510 series Setup Guide 
start /wait msiexec /x {216C7F38-4BBC-4E9A-8392-C9FA21B54386} /qn /norestart

:: HP Deskjet 3050 J610 series Help 140.0.63.63
start /wait msiexec /x {F7632A9B-661E-4FD9-B1A4-3B86BC99847F} /qn /norestart

:: HP Deskjet 3050 J610 series Product Improvement Study 22.0.334.0
start /wait msiexec /x {FEB2C4AA-661E-483F-9626-21A8ACFD10F2} /qn /norestart

:: HP DeviceManagementQFolder
start /wait msiexec /x {AB5D51AE-EBC3-438D-872C-705C7C2084B0} /qn /norestart

:: HP Documentation
start /wait msiexec /x {C8D60CF4-BE7A-487E-BD36-535111BDB0FE} /qn /norestart
start /wait msiexec /x {06600E94-1C34-40E2-AB09-D30AECF78172} /qn /norestart

:: HPDiagnosticAlert
start /wait msiexec /x {B6465A32-8BE9-4B38-ADC5-4B4BDDC10B0D} /qn /norestart
start /wait msiexec /x {846B5DED-DC8C-4E1A-B5B4-9F5B39A0CACE} /qn /norestart

:: HP DisableMSDefender (disables Microsoft Defender...wtf?)
start /wait msiexec /x {74FE39A0-FB76-47CD-84BA-91E2BBB17EF2} /qn /norestart

:: HP ENVY 4500 series Help
start /wait msiexec /x {95BECC50-22B4-4FCA-8A2E-BF77713E6D3A} /qn /norestart

:: HP eSupportQFolder
start /wait msiexec /x {66E6CE0C-5A1E-430C-B40A-0C90FF1804A8} /qn /norestart

:: HP GPBaseService2 (popups)
start /wait msiexec /x {BB3447F6-9553-4AA9-960E-0DB5310C5779} /qn /norestart

:: HP MarketResearch
start /wait msiexec /x {95D08F4E-DFC2-4ce3-ACB7-8C8E206217E9} /qn /norestart
start /wait msiexec /x {D360FA88-17C8-4F14-B67F-13AAF9607B12} /qn /norestart

:: HPPhotoGadget
start /wait msiexec /x {CAE4213F-F797-439D-BD9E-79B71D115BE3} /qn /norestart

:: HPPhotoSmartDiscLabelContent1, DiscLabel_PrintOnDisc, disclabelplugin, DiscLabel_PaperLabel
start /wait msiexec /x {681B698F-C997-42C3-B184-B489C6CA24C9} /qn /norestart
start /wait msiexec /x {20EFC9AA-BBC1-4DFD-81FF-99654F71CBF8} /qn /norestart
start /wait msiexec /x {B28635AB-1DF3-4F07-BFEA-975D911B549B} /qn /norestart
start /wait msiexec /x {D9D8F2CF-FE2D-4644-9762-01F916FE90A9} /qn /norestart

:: HP Photosmart Essential
start /wait msiexec /x {EB21A812-671B-4D08-B974-2A347F0D8F70} /qn /norestart
start /wait msiexec /x {D79113E7-274C-470B-BD46-01B10219DF6A} /qn /norestart

:: HP Product Assistant
start /wait msiexec /x {150B6201-E9E6-4DFB-960E-CCBD53FBDDED} /qn /norestart
start /wait msiexec /x {67D3F1A0-A1F2-49b7-B9EE-011277B170CD} /qn /norestart

:: HP Product Detection
start /wait msiexec /x {A436F67F-687E-4736-BD2B-537121A804CF} /qn /norestart

:: HP Product Improvement Study
start /wait msiexec /x {E3D43596-7E26-479E-B718-77CB3D9270F6} /qn /norestart

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
start /wait msiexec /x {A36CD345-625C-4d6c-B3E2-76E1248CB451} /qn /norestart

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

:: HP UnloadSupport (hidden)
start /wait msiexec /x {E06F04B9-45E6-4AC0-8083-85F7515F40F7} /qn /norestart

:: HP Update
start /wait msiexec /x {912D30CF-F39E-4B31-AD9A-123C6B794EE2} /qn /norestart
start /wait msiexec /x {787D1A33-A97B-4245-87C0-7174609A540C} /qn /norestart
start /wait msiexec /x {97486FBE-A3FC-4783-8D55-EA37E9D171CC} /qn /norestart

:: HP Utility Center
start /wait msiexec /x {B7B82520-8ECE-4743-BFD7-93B16C64B277} /qn /norestart

:: HP WebReg
start /wait msiexec /x {179C56A4-F57F-4561-8BBF-F911D26EB435} /qn /norestart
start /wait msiexec /x {8EE94FD8-5F52-4463-A340-185D16328158} /qn /norestart

:: Instant Housecall Specialist Sign-in
start /wait msiexec /x {4A89B7B3-EB5B-4B33-B7B4-99E69792C081} /qn /norestart

:: Intel(R) Identity Protection Technology
start /wait msiexec /x {C01A86F5-56E7-101F-9BC9-E3F1025EB779} /qn /norestart

:: Intel(R) Management Engine Components
start /wait msiexec /x {5D1BFBB8-4923-4388-9559-C86F5D9E2740} /qn /norestart
start /wait msiexec /x {B434599E-E35F-4612-9803-A2FB7A8E066B} /qn /norestart
start /wait msiexec /x {65153EA5-8B6E-43B6-857B-C6E4FC25798A} /qn /norestart

:: Intel(R) ME UninstallLegacy
start /wait msiexec /x {FD37351B-3074-4652-8188-1B3FB784EC4E} /qn /norestart
start /wait msiexec /x {C9A90201-B2DE-44D0-A618-EF8C9060D318} /qn /norestart
start /wait msiexec /x {ECA145AF-55D0-42BA-870F-4213F0198A46} /qn /norestart

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

:: Intel(R) Turbo Boost Technology
start /wait msiexec /x {D6C630BF-8DBB-4042-8562-DC9A52CB6E7E} /qn /norestart

:: Intel Update
start /wait msiexec /x {78091D68-706D-4893-B287-9F1DFB24F7AF} /qn /norestart

:: Intel Update Manager
start /wait msiexec /x {608E1B9B-A2E8-4A1F-8BAB-874EB0DD25E3} /qn /norestart
start /wait msiexec /x {43FA4AC8-46F8-423F-96FD-9A7D67048F1C} /qn /norestart

:: Intel(R) Rapid Storage Technology
start /wait msiexec /x {205AE40D-8AD7-4F29-A430-DD2168DA562D} /qn /norestart
start /wait msiexec /x {409CB30E-E457-4008-9B1A-ED1B9EA21140} /qn /norestart
start /wait msiexec /x {3E29EE6C-963A-4aae-86C1-DC237C4A49FC} /qn /norestart

:: Intel WiMAX Tutorial
start /wait msiexec /x {4F26C164-9373-4974-8F43-E0F2176AF937} /qn /norestart

:: _is1 iolo technologies' System Mechanic Professional and UniBlue DriverScanner
start /wait msiexec /x {BBD3F66B-1180-4785-B679-3F91572CD3B4} /qn /norestart
start /wait msiexec /x {C2F8CA82-2BD9-4513-B2D1-08A47914C1DA} /qn /norestart

:: iSEEK AnswerWorks English Runtime
start /wait msiexec /x {18A8E78B-9EF2-496E-B310-BCD8E4C1DAB3} /qn /norestart
start /wait msiexec /x {DBCC73BA-C69A-4BF5-B4BF-F07501EE7039} /qn /norestart

:: Java Auto Updater
start /wait msiexec /x {4A03706F-666A-4037-7777-5F2748764D10} /qn /norestart
start /wait msiexec /x {CCB6114E-9DB9-BD54-5AA0-BC5123329C9D} /qn /norestart

:: Kaspersky Lab Network Agent
start /wait msiexec /x {786A9F7E-CFEC-451F-B3C4-22EB11550FD8} /qn /norestart

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

:: Logitech eReg
start /wait msiexec /x {3EE9BCAE-E9A9-45E5-9B1C-83A4D357E05C} /qn /norestart

:: SSN Librarian (some sketchy Russian program)
start /wait msiexec /x {1D425886-3FE1-41AA-8D7A-E432CE29A4AE} /qn /norestart

:: McAfee LiveSafe - Internet Security
if exist %ProgramFiles(x86)%\McAfee\MSC\mcuihost.exe %ProgramFiles(x86)%\McAfee\MSC\mcuihost.exe /body:misp://MSCJsRes.dll::uninstall.html /id:uninstall
if exist %ProgramFiles%\McAfee\MSC\mcuihost.exe %ProgramFiles%\McAfee\MSC\mcuihost.exe /body:misp://MSCJsRes.dll::uninstall.html /id:uninstall

:: Media Gallery
start /wait msiexec /x {115B60D5-BBDB-490E-AF2E-064D37A3CE01} /qn /norestart

:: Microsoft Application Error Reporting
start /wait msiexec /x {95120000-00B9-0409-1000-0000000FF1CE} /qn /norestart

:: Microsoft Office 2007 "Get Started Tab" for PowerPoint, Excel, and Word
start /wait msiexec /x {5AE5DB70-5CE6-4876-A83E-8246CC36FC28} /qn /norestart
start /wait msiexec /x {AB706D91-2242-4E1D-B4D0-1ED35387F5A7} /qn /norestart
start /wait msiexec /x {68B52EFD-86CC-486E-A8D0-A3A1554CB5BC} /qn /norestart

:: Microsoft Office Click-to-Run 2010 14.0.4763.1000
start /wait msiexec /x {90140000-006D-0409-1000-0000000FF1CE} /qn /norestart

:: Microsoft Office File Validation Add-In (frequently causes Excel to hang)
start /wait msiexec /x {90140000-2005-0000-0000-0000000FF1CE} /qn /norestart

:: Microsoft Search Enhancement Pack
start /wait msiexec /x {4CBA3D4C-8F51-4D60-B27E-F6B641C571E7} /qn /norestart

:: Microsoft DVD App Installation for Microsoft.WindowsDVDPlayer_2019.6.11761.0_neutral_~_8wekyb3d8bbwe (x64)
start /wait msiexec /x {986E003C-E56D-5A47-110E-D3C81F0E8535} /qn /norestart

:: Network64, HP? malware?
start /wait msiexec /x {6BFAB6C1-6D46-46DB-A538-A269907C9F2F} /qn /norestart
start /wait msiexec /x {48C0866E-57EB-444C-8371-8E4321066BC3} /qn /norestart

:: Nuance Cloud Connector
start /wait msiexec /x {EEE31B2B-F517-4BD2-8F92-57E4AE938BA3} /qn /norestart

:: Nuance PDF Viewer Plus
start /wait msiexec /x {042A6F10-F770-4886-A502-B795DCF2D3B5} /qn /norestart

:: NVIDIA HD Aadio Driver
start /wait msiexec /x {B2FE1952-0186-46C3-BAEC-A80AA35AC5B8} /qn /norestart

:: Office 2013 C2R Suite
start /wait msiexec /x {90150000-0138-0409-0000-0000000FF1CE} /qn /norestart
start /wait msiexec /x "C:\ProgramData\Microsoft\OEMOffice15\OOBE\x86\oemoobe.msi" /qn /norestart

:: opensource
start /wait msiexec /x {3677D4D8-E5E0-49FC-B86E-06541CF00BBE} /qn /norestart

:: PlayReady PC Runtime amd64
start /wait msiexec /x {BCA9334F-B6C9-4F65-9A73-AC5A329A4D04} /qn /norestart

:: PlayStation(R)Network Downloader (hidden)
start /wait msiexec /x {B6659DD8-00A7-4A24-BBFB-C1F6982E5D66} /qn /norestart

:: PlayStation(R)Store (hidden)
start /wait msiexec /x {0E532C84-4275-41B3-9D81-D4A1A20D8EE7} /qn /norestart

:: PSE10 STI Installer
start /wait msiexec /x {11D08055-939C-432b-98C3-E072478A0CD7} /qn /norestart

:: QuickTime 7
start /wait msiexec /x {3D2CBC2C-65D4-4463-87AB-BB2C859C1F3E} /qn /norestart
start /wait msiexec /x {AF0CE7C0-A3E4-4D73-988B-B29187EC6E9A} /qn /norestart
start /wait msiexec /x {627FFC10-CE0A-497F-BA2B-208CAC638010} /qn /norestart

:: Recovery Manager
start /wait msiexec /x {44B2A0AB-412E-4F8C-B058-D1E8AECCDFF5} /qn /norestart
start /wait msiexec /x {C7231F7C-6530-4E65-ADA6-5B392CF5BEB1} /qn /norestart

:: RealDownloader
start /wait msiexec /x {C8E8D2E3-EF6A-4B1D-A09E-7B27EBE2F3CE} /qn /norestart

:: Roxio BackOnTrack
start /wait msiexec /x {5A06423A-210C-49FB-950E-CB0EB8C5CEC7} /qn /norestart

:: Roxio DirectXInstallService
start /wait msiexec /x {098122AB-C605-4853-B441-C0A4EB359B75} /qn /norestart

:: Roxio Easy CD and DVD Burning
start /wait msiexec /x {537BF16E-7412-448C-95D8-846E85A1D817} /qn /norestart

:: Roxio File Backup
start /wait msiexec /x {60B2315F-680F-4EB3-B8DD-CCDC86A7CCAB} /qn /norestart

:: Samsung MagicTunePremium (monitor selection app)
start /wait msiexec /x {79E9C7C5-4FCC-4DFF-B79E-17319E9522F3} /qn /norestart

:: Samsung Story Album Viewer
start /wait msiexec /x {698BBAD8-B116-495D-B879-0F07A533E57F} /qn /norestart

:: Samsung SW Update (disables Windows Update; very bad)
start /wait msiexec /x {AAFEFB05-CF98-48FC-985E-F04CD8AD620D} /qn /norestart

:: ShufflePlusVLOI
start /wait msiexec /x {0A80329D-1B59-4F10-8D1D-924C59B2840B} /qn /norestart

:: Skype Click 2 Call
start /wait msiexec /x {6D1221A9-17BF-4EC0-81F2-27D30EC30701} /qn /norestart

:: SlimCleaner Plus and SlimDrivers
start /wait msiexec /x {0C0F368E-17C4-4F28-9F1B-B1DA1D96CF7A} /qn /norestart
start /wait msiexec /x {5AD12E7A-D739-4451-9BD1-3610EC56D8F5} /qn /norestart

:: Sonic CinePlayer Decoder Pack
start /wait msiexec /x {8D337F77-BE7F-41A2-A7CB-D5A63FD7049B} /qn /norestart

:: Sony Media Go
start /wait msiexec /x {167A1F6A-9BF2-4B24-83DB-C6D659F680EA} /qn /norestart

:: Sony Messenger (Oasis2Service)
start /wait msiexec /x {E50FC5DB-7CBD-407D-A46E-0C13E45BC386} /qn /norestart

:: Sony OOBE
start /wait msiexec /x {18894D16-5448-4BF9-A128-F7E937322F91} /qn /norestart

:: Sony Quick Web Access
start /wait msiexec /x {13EC74A6-4707-4D26-B9B9-E173403F3B08} /qn /norestart

:: Sony Reader for PC
start /wait msiexec /x {CF5B430D-C563-4EE6-803D-A8A133DFCE5E} /qn /norestart

:: Sony Remote Play with Playstation(R)3
start /wait msiexec /x {D56DA747-5FDB-4AD5-9A6A-3481C0ED44BD} /qn /norestart

:: Sony TrackID(TM) with BRAVIA (poor Shazzam clone)
start /wait msiexec /x {858B32BD-121C-4AC8-BD87-CE37C51C03E2} /qn /norestart
start /wait msiexec /x {2F41EF61-A066-4EBF-84F8-21C1B317A780} /qn /norestart

:: Sony VCCx64, VCCx86, VIx64, and VIx86
start /wait msiexec /x {549AD5FB-F52D-4307-864A-C0008FB35D96} /qn /norestart
start /wait msiexec /x {DF184496-1CA2-4D07-92E7-0BD251D7DEF0} /qn /norestart
start /wait msiexec /x {D55EAC07-7207-44BD-B524-0F063F327743} /qn /norestart
start /wait msiexec /x {D17C2A58-E0EA-4DD7-A2D6-C448FD25B6F6} /qn /norestart

:: Sony VMLx86, VPMx64, VSNx64, VSNx86, VSSTx64, VSSTx86, VU5x64, VU5x86, VU5x86, and VWSTx86
start /wait msiexec /x {02E0F3DE-3FB4-435C-B727-9C9E9EE4ACA4} /qn /norestart
start /wait msiexec /x {DBEAA361-F8A4-4298-B41C-9E9DCB9AAB84} /qn /norestart
start /wait msiexec /x {F2611404-06BF-4E67-A5B7-8DB2FFC1CBF6} /qn /norestart
start /wait msiexec /x {A49A517F-5332-4665-922C-6D9AD31ADD4F} /qn /norestart
start /wait msiexec /x {4F31AC31-0A28-4F5A-8416-513972DA1F79} /qn /norestart
start /wait msiexec /x {B24BB74E-8359-43AA-985A-8E80C9219C70} /qn /norestart
start /wait msiexec /x {6B7DE186-374B-4873-AEC1-7464DA337DD6} /qn /norestart
start /wait msiexec /x {9D12A8B5-9D41-4465-BF11-70719EB0CD02} /qn /norestart
start /wait msiexec /x {D2D23D08-D10E-43D6-883C-78E0B2AC9CC6} /qn /norestart
start /wait msiexec /x {B8991D99-88FD-41F2-8C32-DB70278D5C30} /qn /norestart

:: swMSM -  Shockwave Player Merge Module (hidden)
start /wait msiexec /x {612C34C7-5E90-47D8-9B5C-0F717DD82726} /qn /norestart

:: Spybot - Search & Destroy
start /wait msiexec /x {B4092C6D-E886-4CB2-BA68-FE5A88D31DE6} /qn /norestart

:: Symantec WebReg
start /wait msiexec /x {CCB9B81A-167F-4832-B305-D2A0430840B3} /qn /norestart

:: System Requirements Lab for Intel
start /wait msiexec /x {04C4B49D-45D9-4A28-9ED1-B45CBD99B8C7} /qn /norestart
start /wait msiexec /x {76CE5B47-F5A4-4E5C-99A0-CEFF6146EA4A} /qn /norestart

:: Toshiba Audio Enhancement
start /wait msiexec /x {1515F5E3-29EA-4CD1-A981-032D88880F09} /qn /norestart

:: Toshiba Application Installer
start /wait msiexec /x {21A63CA3-75C0-4E56-B602-B7CD2EF6B621} /qn /norestart
start /wait msiexec /x {970472D0-F5F9-4158-A6E3-1AE49EFEF2D3} /qn /norestart

:: Toshiba App Place
start /wait msiexec /x {ED3CBA78-488F-4E8C-B33F-8E3BF4DDB4D2} /qn /norestart

:: TOSHIBA Assist
start /wait msiexec /x {1B87C40B-A60B-4EF3-9A68-706CF4B69978} /qn /norestart

:: Toshiba Book Place
start /wait msiexec /x {11244D6B-9842-440F-8579-6A4D771A0D9B} /qn /norestart
start /wait msiexec /x {92C7DC44-DAD3-49FE-B89B-F92C6BA9A331} /qn /norestart
start /wait msiexec /x {39187A4B-7538-4BE7-8BAD-9E83303793AA} /qn /norestart

:: Toshiba Bulletin Board
start /wait msiexec /x {C14518AF-1A0F-4D39-8011-69BAA01CD380} /qn /norestart
start /wait msiexec /x {229C190B-7690-40B7-8680-42530179F3E9} /qn /norestart

:: Toshiba Desktop Assist
start /wait msiexec /x {95CCACF0-010D-45F0-82BF-858643D8BC02} /qn /norestart

:: TOSHIBA Disc Creator 2.1.0.4 for x64
start /wait msiexec /x {5DA0E02F-970B-424B-BF41-513A5018E4C0} /qn /norestart

:: Toshiba Display Utility
start /wait msiexec /x {0B39C39A-3ECE-4582-9C91-842D22819A24} /qn /norestart

:: TOSHIBA Eco Utility
start /wait msiexec /x {72EFCFA8-3923-451D-AF52-7CE9D87BC2A1} /qn /norestart
start /wait msiexec /x {5944B9D4-3C2A-48DE-931E-26B31714A2F7} /qn /norestart

:: TOSHIBA HDD/SDD Alert 3.1.64.6
start /wait msiexec /x {D4322448-B6AF-4316-B859-D8A0E84DCB38} /qn /norestart

:: TOSHIBA Media Controller and TOSHIBA Media Controller Plug-in 1.0.5.11
start /wait msiexec /x {983CD6FE-8320-4B80-A8F6-0D0366E0AA22} /qn /norestart
start /wait msiexec /x {F26FDF57-483E-42C8-A9C9-EEE1EDB256E0} /qn /norestart

:: Toshiba Password Utility
start /wait msiexec /x {26BB68BB-CF93-4A12-BC6D-A3B6F53AC8D9} /qn /norestart

:: TOSHIBA Quality Application
start /wait msiexec /x {E69992ED-A7F6-406C-9280-1C156417BC49} /qn /norestart

:: TOSHIBARegistration
start /wait msiexec /x {5AF550B4-BB67-4E7E-82F1-2C4300279050} /qn /norestart

:: TOSHIBA Recovery Media Creator
start /wait msiexec /x {B65BBB06-1F8E-48F5-8A54-B024A9E15FDF} /qn /norestart

:: Toshiba ReelTime
start /wait msiexec /x {24811C12-F4A9-4D0F-8494-A7B8FE46123C} /qn /norestart

:: Toshiba Service Station
start /wait msiexec /x {0DFA8761-7735-4DE8-A0EB-2286578DCFC6} /qn /norestart
start /wait msiexec /x {6499E894-43F8-458B-AE35-724F4732BCDE} /qn /norestart

:: TOSHIBA Speech System Appplications, SR Engine(U.S.), TTS Engine(U.S.)
start /wait msiexec /x {EE033C1F-443E-41EC-A0E2-559B539A4E4D} /qn /norestart
start /wait msiexec /x {008D69EB-70FF-46AB-9C75-924620DF191A} /qn /norestart
start /wait msiexec /x {3FBF6F99-8EC6-41B4-8527-0A32241B5496} /qn /norestart

:: Toshiba System Driver
start /wait msiexec /x {1E6A96A1-2BAB-43EF-8087-30437593C66C} /qn /norestart

:: Toshiba System Settings
start /wait msiexec /x {B040D5C9-C9AA-430A-A44E-696656012E61} /qn /norestart
start /wait msiexec /x {05A55927-DB9B-4E26-BA44-828EBFF829F0} /qn /norestart

:: Toshiba Utility Common Driver (hidden)
start /wait msiexec /x {12688FD7-CB92-4A5B-BEE4-5C8E0574434F} /qn /norestart

:: Toshiba User's Guide
start /wait msiexec /x {3384E1D9-3F18-4A98-8655-180FEF0DFC02} /qn /norestart

:: Toshiba Value Added Package
start /wait msiexec /x {066CFFF8-12BF-4390-A673-75F95EFF188E} /qn /norestart

:: TOSHIBA Web Camera Application
start /wait msiexec /x {5E6F6CF3-BACC-4144-868C-E14622C658F3} /qn /norestart

:: TOSHIBA VIDEO PLAYER
start /wait msiexec /x {FF07604E-C860-40E9-A230-E37FA41F103A} /qn /norestart

:: Toshiba Wireless LAN Indicator
start /wait msiexec /x {CDADE9BC-612C-42B8-B929-5C6A823E7FF9} /qn /norestart

:: TrayApp
start /wait msiexec /x {CD31E63D-47FD-491C-8117-CF201D0AFAB5} /qn /norestart
start /wait msiexec /x {FF075778-6E50-47ed-991D-3B07FD4E3250} /qn /norestart

:: Trend Micro Trial
start /wait msiexec /x {BED0B8A2-2986-49F8-90D6-FA008D37A3D2} /qn /norestart

:: Trend Micro Worry-Free Business Security Trial
start /wait msiexec /x {0A07E717-BB5D-4B99-840B-6C5DED52B277} /qn /norestart

:: VAIO - Media Gallery
start /wait msiexec /x {7C7BC722-BB95-4A6E-9373-DA706D83430B} /qn /norestart

:: VAIO - PMB
start /wait msiexec /x {B6A98E5F-D6A7-46FB-9E9D-1F7BF443491C} /qn /norestart

:: VAIO - PMB VAIO Edition Guide (and associated "Plugin" GUIDs)
start /wait msiexec /x {339F9B4D-00CB-4C1C-BED8-EC86A9AB602A} /qn /norestart
start /wait msiexec /x {133D3F07-D558-46CE-80E8-F4D75DBBAD63} /qn /norestart
start /wait msiexec /x {270380EB-8812-42E1-8289-53700DB840D2} /qn /norestart
start /wait msiexec /x {8356CB97-A48F-44CB-837A-A12838DC4669} /qn /norestart

:: VAIO - Remote Keyboard, Remote Keyboard with PlayStation(R)3, Remote Play with Playstation(R)3
start /wait msiexec /x {7396FB15-9AB4-4B78-BDD8-24A9C15D2C65} /qn /norestart
start /wait msiexec /x {6466EF6E-700E-470F-94CB-D0050302C84E} /qn /norestart
start /wait msiexec /x {E682702C-609C-4017-99E7-3129C163955F} /qn /norestart
start /wait msiexec /x {07441A52-E208-478A-92B7-5C337CA8C131} /qn /norestart

:: VAIO Care, VAIO Care Recovery, VAIO Help and Support
start /wait msiexec /x {D9FFE40D-1A85-4541-992C-5EF505F391A4} /qn /norestart
start /wait msiexec /x {471F7C0A-CA3A-4F4C-8346-DE36AD5E23D1} /qn /norestart
start /wait msiexec /x {6ED1750E-F44F-4635-8F0D-B76B9262B7FB} /qn /norestart
start /wait msiexec /x {AD3E7141-A22E-40F1-A7A4-55E898AE35E3} /qn /norestart

:: VAIO Control Center, CPU Fan Diagnostic, Data Restore Tool, and Easy Connect
start /wait msiexec /x {8E797841-A110-41FD-B17A-3ABC0641187A} /qn /norestart
start /wait msiexec /x {BCE6E3D7-B565-4E1B-AC77-F780666A35FB} /qn /norestart
start /wait msiexec /x {3267B2E9-9DF5-4251-87C8-33412234C77F} /qn /norestart
start /wait msiexec /x {57B955CE-B5D3-495D-AF1B-FAEE0540BFEF} /qn /norestart
start /wait msiexec /x {7C80D30A-AC02-4E3F-B95D-29F0E4FF937B} /qn /norestart

:: VAIO Gate, Gate Default, Help and Support, Improvement, and Manual
start /wait msiexec /x {A7C30414-2382-4086-B0D6-01A88ABA21C3} /qn /norestart
start /wait msiexec /x {AE5F3379-8B81-457E-8E09-7E61D941AFA4} /qn /norestart
start /wait msiexec /x {B7546697-2A80-4256-A24B-1C33163F535B} /qn /norestart
start /wait msiexec /x {0164FA3B-182D-4237-B22A-081C0B55E0D3} /qn /norestart
start /wait msiexec /x {3A26D9BD-0F73-432D-B522-2BA18138F7EF} /qn /norestart
start /wait msiexec /x {C6E893E7-E5EA-4CD5-917C-5443E753FCBD} /qn /norestart

:: VAIO Sample Contents, Satisfaction Survey., Transfer Support VAIO Update
start /wait msiexec /x {547C9EB4-4CA6-402F-9D1B-8BD30DC71E44} /qn /norestart
start /wait msiexec /x {5DDAFB4B-C52E-468A-9E23-3B0CEEB671BF} /qn /norestart
start /wait msiexec /x {0899D75A-C2FC-42EA-A702-5B9A5F24EAD5} /qn /norestart
start /wait msiexec /x {9FF95DA2-7DA1-4228-93B7-DED7EC02B6B2} /qn /norestart

:: VIP Access (Lenovo-installed OEM bloatware for Verisign)
start /wait msiexec /x {E8D46836-CD55-453C-A107-A59EC51CB8DC} /qn /norestart

:: WOT for Internet Explorer plugin
start /wait msiexec /x {373B90E1-A28C-434C-92B6-7281AFA6115A} /qn /norestart

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

:: Windows 7 USB/DVD Download Tool
start /wait msiexec /x {CCF298AF-9CE1-4B26-B251-486E98A34789} /qn /norestart

:: Windows Live Family Safety // Disabled by Vocatus for Tron (some family systems may be using this)
::start /wait msiexec /x {5F611ADA-B98C-4DBB-ADDE-414F08457ECF} /qn /norestart

:: Windows Live Sign-in Assistant
start /wait msiexec /x {CE52672C-A0E9-4450-8875-88A221D5CD50} /qn /norestart
start /wait msiexec /x {1B8ABA62-74F0-47ED-B18C-A43128E591B8} /qn /norestart
start /wait msiexec /x {9B48B0AC-C813-4174-9042-476A887592C7} /qn /norestart

:: Windows Live Toolbar
start /wait msiexec /x {995F1E2E-F542-4310-8E1D-9926F5A279B3} /qn /norestart

:: WinZip
start /wait msiexec /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240ED} /qn /norestart

:: Xmarks for IE
start /wait msiexec /x {ABFA6EAE-C9C0-4B39-B722-02094EF6B889} /qn /norestart

:: YouTube Downloader 2.7.2
start /wait msiexec /x {1a413f37-ed88-4fec-9666-5c48dc4b7bb7} /qn /norestart

:: Zinio Alert Messenger
start /wait msiexec /x {D2E707E8-090E-EC5B-4833-1CA694FB7460} /qn /norestart

:: ZoneAlarm Antivirus, Firewall, and Security
start /wait msiexec /x {043A5C25-EC0E-4152-A53B-73065A4315DF} /qn /norestart
start /wait msiexec /x {537317B1-FB59-4578-953F-544914A8F25F} /qn /norestart
start /wait msiexec /x {9A121E1B-1E87-4F37-BC9C-F8D073047942} /qn /norestart

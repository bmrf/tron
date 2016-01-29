:: Batch file to uninstall a specific list of programs by GUID
:: Called by Tron in Stage 2: De-bloat
:: Initial list by reddit.com/user/tuxedo_jack, modifications for use in Tron by reddit.com/user/vocatus and many, many, many others
:: Add any GUID uninstall commands to this list to target them for removal
@echo off


:::::::::::::::
:: GUID LIST ::
:::::::::::::::

:: Absolute Notifier // Absolute Reminder
start /wait msiexec /qn /norestart /x {40F4FF7A-B214-4453-B973-080B09CED019}
start /wait msiexec /qn /norestart /x {FB500000-0010-0000-0000-074957833700}

:: Acer abDocs
start /wait msiexec /qn /norestart /x {CA4FE8B0-298C-4E5D-A486-F33B126D6A0A}
start /wait msiexec /qn /norestart /x {DCBF3379-246B-47E1-8173-639B63940838}
start /wait msiexec /qn /norestart /x {DCBF3379-246B-47E1-8173-639B63940838}

:: Acer abFiles
start /wait msiexec /qn /norestart /x {13885028-098C-4799-9B71-27DAC96502D5}

:: Acer abMedia
start /wait msiexec /qn /norestart /x {E9AF1707-3F3A-49E2-8345-4F2D629D0876}

:: Acer abPhoto
start /wait msiexec /qn /norestart /x {B5AD89F2-03D3-4206-8487-018298007DD0}

:: Acer AOP Framework
start /wait msiexec /qn /norestart /x {4A37A114-702F-4055-A4B6-16571D4A5353}

:: Acer Bluetooth Win7 Suite -64 7.2.0.56
start /wait msiexec /qn /norestart /x {FCD6D60F-AF2B-49E3-ABC4-A4C96B56225D}

:: Acer Care Center
start /wait msiexec /qn /norestart /x {A424844F-CDB3-45E2-BB77-1DDE4A091E76}
start /wait msiexec /qn /norestart /x {1AF41E84-3408-499A-8C93-8891F0612719}

:: Acer DriverSetupUtility
start /wait msiexec /qn /norestart /x {2B51C83A-465D-4EA9-9CDC-1ED95ED09AC6}

:: Acer Explorer Agent
start /wait msiexec /qn /norestart /x {4D0F42CF-1693-43D9-BDC8-19141D023EE0}

:: Acer Launch Manager
start /wait msiexec /qn /norestart /x {C18D55BD-1EC6-466D-B763-8EEDDDA9100E}

:: Acer Portal
start /wait msiexec /qn /norestart /x {A5AD0B17-F34D-49BE-A157-C8B3D52ACD13}

:: Acer Power Management
start /wait msiexec /qn /norestart /x {91F52DE4-B789-42B0-9311-A349F10E5479}

:: Acer Quick Access
start /wait msiexec /qn /norestart /x {C1FA525F-D701-4B31-9D32-504FC0CF0B98}
start /wait msiexec /qn /norestart /x {E3678E72-78E3-4F91-A9FB-913876FF6DA2}

:: Acer Recovery Management // Disabled by /u/kamakaze_chickn for Tron
::start /wait msiexec /qn /norestart /x {07F2005A-8CAC-4A4B-83A2-DA98A722CA61}

:: Acer Tour / Acer Product Registration
start /wait msiexec /qn /norestart /x {94389919-B0AA-4882-9BE8-9F0B004ECA35}
start /wait msiexec /qn /norestart /x {DA20E1A8-07CB-4EE7-9B72-A7E28C953F0E}

:: Acer Updater // Same GUID used by "Gateway Updater" (?)
start /wait msiexec /qn /norestart /x {EE171732-BEB4-4576-887D-CB62727F01CA}

:: Acer User Experience Improvement Program Framework and associated GUIDs
start /wait msiexec /qn /norestart /x {12A718F2-2357-4D41-9E1F-18583A4745F7}
start /wait msiexec /qn /norestart /x {978724F6-1863-4DD5-9E66-FB77F5AB5613}

:: Acer Video Player
start /wait msiexec /qn /norestart /x {B6846F20-4821-11E3-8F96-0800200C9A66}

:: Accidental Damage Services Agreement
start /wait msiexec /qn /norestart /x {EBE939ED-4612-45FD-A39E-77AC199C4273}

:: AccuWeather.com Cirrus
start /wait msiexec /qn /norestart /x {808625C0-412D-2343-CA00-9C19A9671101}

:: Acrobat.com (various versions)
start /wait msiexec /qn /norestart /x {6D8D64BE-F500-55B6-705D-DFD08AFE0624}
start /wait msiexec /qn /norestart /x {287ECFA4-719A-2143-A09B-D6A12DE54E40}
start /wait msiexec /qn /norestart /x {E7C97E98-4C2D-BEAF-5D2F-CC45A2F95D90}
start /wait msiexec /qn /norestart /x {77DCDCE3-2DED-62F3-8154-05E745472D07}

:: Ad-Aware Web Companion (various versions) // Ad-Aware Updater
start /wait msiexec /qn /norestart /x {88B10E3E-8911-4FAC-8663-CCF6E33C58B3}
start /wait msiexec /qn /norestart /x {FABDFEBE-A430-48B4-89F2-B35594E43965}
start /wait msiexec /qn /norestart /x {902C3D36-9254-437D-98AC-913B78E60864}

:: Adobe Content Viewer
start /wait msiexec /qn /norestart /x {483A865C-A74A-12BF-1276-D0111A488F50}

:: Adobe Community Help
start /wait msiexec /qn /norestart /x {A127C3C0-055E-38CF-B38F-1E85F8BBBFFE}

:: Adobe Download Assistant
start /wait msiexec /qn /norestart /x {5C804EBB-475F-4555-A225-1D6573F158BD}
start /wait msiexec /qn /norestart /x {DE3A9DC5-9A5D-6485-9662-347162C7E4CA}

:: Adobe Help Center 1.0
start /wait msiexec /qn /norestart /x {E9787678-1033-0000-8E67-000000000001}

:: Adobe Help Manager
start /wait msiexec /qn /norestart /x {AF37176A-78CA-545B-34EF-8B6A21514DD1}
start /wait msiexec /qn /norestart /x {ACEB2BAF-96DF-48FD-ADD5-43842D4C443D}

:: Adobe Media Player
start /wait msiexec /qn /norestart /x {39F6E2B4-CFE8-C30A-66E8-489651F0F34C}

:: Adobe Refresh Manager
start /wait msiexec /qn /norestart /x {AC76BA86-0804-1033-1959-001824147215}
start /wait msiexec /qn /norestart /x {A2BCA9F1-566C-4805-97D1-7FDC93386723}
start /wait msiexec /qn /norestart /x {AC76BA86-0804-1033-1959-001802114130}
start /wait msiexec /qn /norestart /x {AC76BA86-0804-1033-1959-001824144531}

:: Adobe Setup (various versions)
start /wait msiexec /qn /norestart /x {11A955CD-4398-405A-886D-E464C3618FBF}
start /wait msiexec /qn /norestart /x {1D181764-DCD0-41B8-AA7B-0A599F027A72}
start /wait msiexec /qn /norestart /x {7C548501-3501-468A-A443-CC42F5B3626B}

:: Adobe Widget Browser
start /wait msiexec /qn /norestart /x {EFBE6DD5-B224-96E5-72B9-68D328CB12A6}

:: Advertising Center 0.0.0.2
start /wait msiexec /qn /norestart /x {3784D297-8089-43B6-B57F-11B7E96413CD}

:: Alienware Customer Surveys
start /wait msiexec /qn /norestart /x {13A3A271-B2AA-486C-9AD5-F272079BB9B5}

:: AlignmentUtility (various versions)
start /wait msiexec /qn /norestart /x {4C5E314A-31CA-4223-9A90-CE0C4D5800A4}
start /wait msiexec /qn /norestart /x {B0D59FDC-FEAB-49A2-9B5A-E5E0A8F9D7E0}

:: Amazon 1Button App
start /wait msiexec /qn /norestart /x {134E190A-CE2A-4436-BDEB-387CC36A96C9}
start /wait msiexec /qn /norestart /x {EBCCD2B7-FCA9-4714-97A4-CBC48E544BB2}

:: AMD Accelerated Video Transcoding // Drag-and-Drop Transcoding
start /wait msiexec /qn /norestart /x {A6AFFBD8-D006-967F-51AF-0120F0261080}
start /wait msiexec /qn /norestart /x {8642397F-CF08-6B30-A477-A039BBAA511E}
start /wait msiexec /qn /norestart /x {9427FF53-EEF7-6D70-73AE-596A6B0CBC36}
start /wait msiexec /qn /norestart /x {D77162FE-B7B2-8E1E-D80D-89DE6217DF13}
start /wait msiexec /qn /norestart /x {BBA5B0EB-5746-C279-2A12-2AF046FD37CD}
start /wait msiexec /qn /norestart /x {6F483F38-6162-7606-1D0B-054852C8E011}
start /wait msiexec /qn /norestart /x {E7ACB435-E0B4-4770-77DE-ED38887CD133}
start /wait msiexec /qn /norestart /x {ABD675FF-147C-689A-50B9-6DC57DE4044F}
start /wait msiexec /qn /norestart /x {3BF3599D-7F28-C60B-1C5D-82BFD4E5EF33}
start /wait msiexec /qn /norestart /x {D1822C34-F342-B6AA-6369-899C9D2A9227}
start /wait msiexec /qn /norestart /x {F6BF49D7-479E-23FE-A8A9-63D193D05697}
start /wait msiexec /qn /norestart /x {8F2415FA-72F2-F029-0450-4EB2FAE484C5}
start /wait msiexec /qn /norestart /x {8E7CCFB3-4102-6A32-8C4F-202B7AB7C8E3}

:: AMD Catalyst Control Center - Branding
start /wait msiexec /qn /norestart /x {24D38277-CE6E-4E12-A2EE-F46832A4FA2F}

:: AMD Drag and Drop Transcoding (various versions)
start /wait msiexec /qn /norestart /x {0336B81E-E745-7FE9-74D5-157EBCDF71E3}
start /wait msiexec /qn /norestart /x {503F672D-6C84-448A-8F8F-4BC35AC83441}
start /wait msiexec /qn /norestart /x {5D2B5E19-C333-4519-3D32-AAB8EEE9ACA4}
start /wait msiexec /qn /norestart /x {D42B82F2-116E-8588-D868-5E98EF9B0CF8}
start /wait msiexec /qn /norestart /x {FEA214BD-EE6F-B3B9-FE9E-80D2B14849D5}
start /wait msiexec /qn /norestart /x {CF84CD21-FC52-857E-AF41-9DEE9C76D245}

:: AMD OEM Application Profile
start /wait msiexec /qn /norestart /x {C89A97B6-F991-EBB5-77B7-927BCF420EBE}

:: AMD Problem Report Wizard  //  ATI Problem Report Wizard
start /wait msiexec /qn /norestart /x {149FBD36-6E9E-2035-42B0-59D91714138D}
start /wait msiexec /qn /norestart /x {8A079327-5B79-24B5-9E95-91960E763CB2}
start /wait msiexec /qn /norestart /x {C36C7280-879A-D8A7-570F-844CB6E5F7E8}
start /wait msiexec /qn /norestart /x {2E794F67-DAC1-C4A3-9128-0C841DF8A1BE}

:: AMD Wireless Display v3.0
start /wait msiexec /qn /norestart /x {0A2E1907-D0DE-0D01-CA64-CB0AB0BFE539}
start /wait msiexec /qn /norestart /x {426582A8-202F-D13C-8BD5-F00551BAFC93}
start /wait msiexec /qn /norestart /x {630E5EF7-72F8-9E5D-BEF5-ED85B698E160}
start /wait msiexec /qn /norestart /x {C16CD4C0-48EE-0F40-C9FD-0778EAF73FBD}
start /wait msiexec /qn /norestart /x {D7C275A6-3266-0FBC-2D84-17A6AC226F01}
start /wait msiexec /qn /norestart /x {ED273D26-E354-1A5B-A0D0-CB5258D43BD2}
start /wait msiexec /qn /norestart /x {1D33EC42-4787-56CD-8137-95D8418FFEE8}
start /wait msiexec /qn /norestart /x {678F0819-823E-D737-3FD1-13EF6D9AE2EC}

:: AOLIcon (lol)
start /wait msiexec /qn /norestart /x {FFC7F03B-7069-4F7B-B0A5-9C173E898AC9}

:: ArcSoft Magic-i Visual Effects 2 // ArcSoft WebCam Companion 3 and 4 // Family Paint // WebCam Message Board
start /wait msiexec /qn /norestart /x {B1893E3F-9BDF-443F-BED0-1AAA2D9E0D68}
start /wait msiexec /qn /norestart /x {DE8AAC73-6D8D-483E-96EA-CAEDDADB9079}
start /wait msiexec /qn /norestart /x {B77DE05C-7C84-4011-B93F-A29D0D2840F4}
start /wait msiexec /qn /norestart /x {2B2F5B94-F377-41A2-8DA8-899BC538A4E1}
start /wait msiexec /qn /norestart /x {7D44F1E8-968F-48D8-A966-2890A2CFFC6F}

:: Ashampoo Burning Studio FREE v.1.14.5
start /wait msiexec /qn /norestart /x {91B33C97-91F8-FFB3-581B-BC952C901685}

:: Ask Search App by Ask
start /wait msiexec /qn /norestart /x {43C423D9-E6D6-4607-ADC9-EBB54F690C57}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-A758B70C1500}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-A758B70C2201}

:: ASPCA and CWA Reminder misc programs (we-care.com Macy's nagware)
start /wait msiexec /qn /norestart /x {7E482AF6-AA1F-4CC5-BA13-0536675F5744}
start /wait msiexec /qn /norestart /x {987F1753-1F42-4DF2-A5EA-0CCB777F3EB0}
start /wait msiexec /qn /norestart /x {E4FB0B39-C991-4EE7-95DD-1A1A7857D33D}
start /wait msiexec /qn /norestart /x {1F1E283D-23D9-4E09-B967-F46A053FEA89}
start /wait msiexec /qn /norestart /x {0228288D-975E-42F7-9993-E91A82E6BBD9}
start /wait msiexec /qn /norestart /x {6F5E2F4A-377D-4700-B0E3-8F7F7507EA15}
start /wait msiexec /qn /norestart /x {B618B8E1-FB71-4237-8361-C3EA3EF15EF7}
start /wait msiexec /qn /norestart /x {A6558E2A-FAF9-4570-AA49-6328D0354517}

:: ASUS Ai Charger
start /wait msiexec /qn /norestart /x {7FB64E72-9B0E-4460-A821-040C341E414A}

:: ASUS AudioWizard
start /wait msiexec /qn /norestart /x {57E770A2-2BAF-4CAA-BAA3-BD896E2254D3}

:: ASUS: Fast Boot by ASUS
start /wait msiexec /qn /norestart /x {13F4A7F3-EABC-4261-AF6B-1317777F0755}

:: ASUS FlipLock
start /wait msiexec /qn /norestart /x {7C7F8DAC-8ADA-4B86-BCB6-48B6FFB673DD}

:: ASUS Live Update
start /wait msiexec /qn /norestart /x {FA540E67-095C-4A1B-97BA-4D547DEC9AF4}

:: ASUS Security Protect Manager
start /wait msiexec /qn /norestart /x {DF21F1DB-80C6-11D3-9483-B03D0EC10000}

:: ASUS Screensaver
start /wait msiexec /qn /norestart /x {0FBEEDF8-30FA-4FA3-B31F-C9C7E7E8DFA2}

:: ASUS Smart Gesture
start /wait msiexec /qn /norestart /x {4D3286A6-F6AB-498A-82A4-E4F040529F3D}

:: ASUS Splendid Video Enhancement Technology
start /wait msiexec /qn /norestart /x {0969AF05-4FF6-4C00-9406-43599238DE0D}

:: ASUS USB Charger Plus
start /wait msiexec /qn /norestart /x {A859E3E5-C62F-4BFA-AF1D-2B95E03166AF}

:: ASUS Windows 7 Starter Helper
start /wait msiexec /qn /norestart /x {D381FF29-7CFB-4D4E-B92A-C4EDDC696614}

:: ASUS WinFlash
start /wait msiexec /qn /norestart /x {FFCF82EC-895F-4AC8-925E-3412FE25EF62}

:: AVG // Disabled for Tron by /u/vocatus on feedback from /u/ComputersByte, /u/spexdi, /u/Chimaera12 and /u/agent-squirrel
:: start /wait msiexec /qn /norestart /x {5893E1FC-A43A-4F82-8EB6-FF61DC84A92B

:: AVG 2013 // Disabled for Tron by /u/vocatus on feedback from /u/ComputersByte, /u/spexdi, /u/Chimaera12 and /u/agent-squirrel
:: start /wait msiexec /qn /norestart /x {C09E8C9E-A243-430E-8811-7C7C36BD8A71}
:: start /wait msiexec /qn /norestart /x {9EF01972-D320-49A9-BA40-BED677587E32}

:: AVG 2014 // Disabled for Tron by /u/vocatus on feedback from /u/ComputersByte, /u/spexdi, /u/Chimaera12 and /u/agent-squirrel
:: start /wait msiexec /qn /norestart /x {FC3B3A5D-7058-4627-9F1E-F95CC38B6054}
:: start /wait msiexec /qn /norestart /x {524569AC-B3EE-468B-BFD5-19A89EA7CE8E}
:: start /wait msiexec /qn /norestart /x {91569630-3DDC-43EB-9425-E6C41431D535}
:: start /wait msiexec /qn /norestart /x {A64D4055-F3E5-40E7-982A-C1FC10C3B4AF}
:: start /wait msiexec /qn /norestart /x {B53BE722-137D-4A7C-BC7A-F495DF36AF59}
:: start /wait msiexec /qn /norestart /x {F4735E8D-3570-4606-A4E9-0BE44F3B0DFC}

:: AVG 2015 // Disabled for Tron by /u/vocatus on feedback from /u/ComputersByte, /u/spexdi, /u/Chimaera12 and /u/agent-squirrel
:: start /wait msiexec /qn /norestart /x {3B3927B0-0A21-4B4C-9FF3-AB4C42E2AF79}
:: start /wait msiexec /qn /norestart /x {966F007B-0D8A-44A6-A6C3-5395983C356D}
:: start /wait msiexec /qn /norestart /x {0B7BE3CA-AF33-4CE3-BC27-1456C96EF996}
:: start /wait msiexec /qn /norestart /x {7A5DB14B-14B0-4F09-A130-BF60503B4248}
:: start /wait msiexec /qn /norestart /x {CEEAE734-B717-41D1-BF50-378EC081C6B1}
:: start /wait msiexec /qn /norestart /x {6B171EFC-F41F-4055-A4DE-5B9480DA17AA}

:: AVG 2016 // Disabled for Tron by /u/vocatus on feedback from /u/ComputersByte, /u/spexdi, /u/Chimaera12 and /u/agent-squirrel
:: start /wait msiexec /qn /norestart /x {5F717F1E-A958-47A7-9602-4D9DDC8E0E03}

:: AVG PC TuneUp 2015
start /wait msiexec /qn /norestart /x {4AC74ED1-719B-46DA-8B8A-340FBF892291}
start /wait msiexec /qn /norestart /x {A996C182-3724-4DF1-A4BC-66154FE57DFE}

:: Avira Launcher
start /wait msiexec /qn /norestart /x {EA226E08-91E7-4F05-B61E-3EDBBBEB15BB}
start /wait msiexec /qn /norestart /x {315dd168-0794-4cf1-8355-f195cde642fc}

:: AzureBay Screen Saver
start /wait msiexec /qn /norestart /x {958A793F-F1D2-4A90-B6A5-C52E2D74E8FE}

:: Best Buy pc app
start /wait msiexec /qn /norestart /x {FBBC4667-2521-4E78-B1BD-8706F774549B}
if exist "%ProgramData%\{D8EAE~1\Best Buy pc app Setup.msi" start /wait msiexec /x "%ProgramData%\{D8EAE~1\Best Buy pc app Setup.msi" /qn /norestart

:: Bing Bar, Bing Rewards Client Installer and Bing Bar Platform
start /wait msiexec /qn /norestart /x {3365E735-48A6-4194-9988-CE59AC5AE503}
start /wait msiexec /qn /norestart /x {C28D96C0-6A90-459E-A077-A6706F4EC0FC}
start /wait msiexec /qn /norestart /x {77F8A71E-3515-4832-B8B2-2F1EDBD2E0F1}
start /wait msiexec /qn /norestart /x {1AE46C09-2AB8-4EE5-88FB-08CD0FF7F2DF}
start /wait msiexec /qn /norestart /x {49977584-B20E-46AB-818F-845815378904}
start /wait msiexec /qn /norestart /x {A0BBC906-9A33-4C79-A26A-758ED3503769}
start /wait msiexec /qn /norestart /x {1E03DB52-D5CB-4338-A338-E526DD4D4DB1}
start /wait msiexec /qn /norestart /x {3611CA6C-5FCA-4900-A329-6A118123CCFC}
start /wait msiexec /qn /norestart /x {61EDBE71-5D3E-4AB7-AD95-E53FEAF68C17}
start /wait msiexec /qn /norestart /x {6ACE7F46-FACE-4125-AE86-672F4F2A6A28}
start /wait msiexec /qn /norestart /x {B4089055-D468-45A4-A6BA-5A138DD715FC}
start /wait msiexec /qn /norestart /x {A7E8CB11-B09E-46F8-9BAE-B2E01EBF7E51}

:: Bing Desktop
start /wait msiexec /qn /norestart /x {7D095455-D971-4D4C-9EFD-9AF6A6584F3A}

:: Blio (eBook reader app)
start /wait msiexec /qn /norestart /x {741006D1-7B2B-4E33-B2B0-831F282EEF64}

:: Business Complete Care Services Agreement
start /wait msiexec /qn /norestart /x {A3BE3F1E-2472-4211-8735-E8239BE49D9F}

:: Browser Address Error Redirector
start /wait msiexec /qn /norestart /x {DF9A6075-9308-4572-8932-A4316243C4D9}

:: CA Pest Patrol Realtime Protection 001.001.0034
start /wait msiexec /qn /norestart /x {F05A5232-CE5E-4274-AB27-44EB8105898D}

:: Camtasia (various versions) // Disabled for Tron by /u/vocatus per https://www.reddit.com/r/TronScript/comments/3nvfqj/guid_list_update_and_a_couple_of_questions/
:: start /wait msiexec /qn /norestart /x {DB93E2C2-851F-44B2-B09C-351D2C624AE1}
:: start /wait msiexec /qn /norestart /x {7A0735CD-5B9D-4FAF-A717-CF99619DDAF8}
:: start /wait msiexec /qn /norestart /x {4974F6DC-BA3F-4708-9CF2-8F8B28A8E1C3}
:: start /wait msiexec /qn /norestart /x {6D791152-409B-48C9-8050-E31D3B1CDDF0}
:: start /wait msiexec /qn /norestart /x {008FD9E3-5F74-42FC-ACF9-B72AB7ED85E3}
:: start /wait msiexec /qn /norestart /x {051E55AD-CCE1-4D3B-BA6A-88AD3F656C23}
:: start /wait msiexec /qn /norestart /x {296C22B8-5355-4C13-B42B-C06B1A5D1B4E}
:: start /wait msiexec /qn /norestart /x {21680605-EAEA-4A34-9C25-F44BB813CC3E}
:: start /wait msiexec /qn /norestart /x {BC256BAA-A3D1-438F-ABE8-14E56FF6ECBA}
:: start /wait msiexec /qn /norestart /x {FE95684E-62F9-49A1-988E-C88A123DBB18}
:: start /wait msiexec /qn /norestart /x {BB62BAD9-AAAB-4552-B304-A3787EC2475B}
:: start /wait msiexec /qn /norestart /x {94F167B1-395E-483C-9D12-20F077D7B4A9}
:: start /wait msiexec /qn /norestart /x {EDBD11F4-45C8-4028-BC1A-FFE74DE37CB4}
:: start /wait msiexec /qn /norestart /x {85BA4B05-A25A-4ABC-A637-14C1F7C6A1FA}
:: start /wait msiexec /qn /norestart /x {2919BC46-3875-4175-A60E-71861076DE99}
:: start /wait msiexec /qn /norestart /x {1875B4A0-974E-49C9-A817-99D14E19F5F8}
:: start /wait msiexec /qn /norestart /x {F11EC76D-794E-4B72-BD73-4EC73498F4A8}
:: start /wait msiexec /qn /norestart /x {D01C1100-5746-41C3-B309-29D674B92E2A}
:: start /wait msiexec /qn /norestart /x {4325407D-1B78-475B-971A-7266BF17C293}
:: start /wait msiexec /qn /norestart /x {0AC51B58-A50C-40F6-B991-523D730945DD}
:: start /wait msiexec /qn /norestart /x {E42B58B2-D4A2-4632-8745-BFF041FBB4D9}
:: start /wait msiexec /qn /norestart /x {2172CD50-F0DF-43D0-9C1F-7BD964D0289B}
:: start /wait msiexec /qn /norestart /x {31591351-2BAE-4B88-8943-B18402D8112A}
:: start /wait msiexec /qn /norestart /x {639B2D77-2476-4605-A5D7-8C5D816952C3}
:: start /wait msiexec /qn /norestart /x {462A7AF7-6DCE-4609-97E4-A7BBE0B46DEF}
:: start /wait msiexec /qn /norestart /x {F63723C9-BF65-4339-B98C-D6FC2A96182B}
:: start /wait msiexec /qn /norestart /x {1884FF01-9F27-4D61-A6F2-85AA0A4B42A8}
:: start /wait msiexec /qn /norestart /x {59D59A58-7421-4836-9E5C-6D39B005ED78}
:: start /wait msiexec /qn /norestart /x {030EBB17-26C3-4C81-A14D-22AB5D2986EC}
:: start /wait msiexec /qn /norestart /x {7E01BCC1-806C-4826-97E0-15426F0D1CC9}
:: start /wait msiexec /qn /norestart /x {962C7B98-BEA8-45B9-8D56-2F3CBCA4F16B}
:: start /wait msiexec /qn /norestart /x {DAC80429-24C7-44F9-828C-9740142FA620}
:: start /wait msiexec /qn /norestart /x {95CF0C2A-6B62-4C11-A7BB-FD137CCCB0D6}
:: start /wait msiexec /qn /norestart /x {DDBA1A68-E2A5-4C88-B96B-4F21DF964DED}
:: start /wait msiexec /qn /norestart /x {2865F201-43B8-4CCC-9106-FE554F32138F}
:: start /wait msiexec /qn /norestart /x {DE612AA6-7629-42F8-93CE-0D43A1BB5033}
:: start /wait msiexec /qn /norestart /x {5EB67AA7-CC7C-4047-8A18-4B7D30FF8E5C}
:: start /wait msiexec /qn /norestart /x {8C8AEE08-F427-452F-95B4-B36ECE4FADE3}
:: start /wait msiexec /qn /norestart /x {F8492A18-EEBC-42B1-AF88-807BA37C43DA}
:: start /wait msiexec /qn /norestart /x {D2756F6B-BC48-4792-8E3E-0B7053630B1D}
:: start /wait msiexec /qn /norestart /x {71A6F5AA-EBDC-4BDF-B231-35B98FA3B9AE}
:: start /wait msiexec /qn /norestart /x {8F0459D3-EEE8-414E-9CE1-36C00A19D507}
:: start /wait msiexec /qn /norestart /x {CFBC28D9-F7D0-4725-871B-E8A22703ECCB}
:: start /wait msiexec /qn /norestart /x {D3317ECB-5C48-4A6B-8C84-7457A9410159}
:: start /wait msiexec /qn /norestart /x {BA14C68E-AEDC-4395-BB16-B3D365CF26AF}
:: start /wait msiexec /qn /norestart /x {8073CD13-1B0E-446A-A678-9589A2EFFB92}
:: start /wait msiexec /qn /norestart /x {1667846F-BC00-4CE6-ADA5-1CE122C33FE2}
:: start /wait msiexec /qn /norestart /x {FB8A7032-9682-451E-9E64-89C25CD9E43B}
:: start /wait msiexec /qn /norestart /x {DB25BCF6-2C58-473E-A2B6-6F77311F79D1}
:: start /wait msiexec /qn /norestart /x {368C2E4B-A37E-466B-958E-C0CD6D6964F4}
:: start /wait msiexec /qn /norestart /x {6E30B8A2-4AAA-487E-A80F-E147A9D084DD}
:: start /wait msiexec /qn /norestart /x {8F4934B1-83CB-4BFC-8A90-40FF4530115D}
:: start /wait msiexec /qn /norestart /x {A27DAE1A-995D-451F-9CCB-C7BF698E4ED4}
:: start /wait msiexec /qn /norestart /x {D2F1FCB3-A65C-4BAA-A665-E498C9E80945}
:: start /wait msiexec /qn /norestart /x {720F2C5A-DE7A-42A4-B08F-AD504B555155}
:: start /wait msiexec /qn /norestart /x {64025BB4-168A-44E5-A10D-37D38A8E0124}
:: start /wait msiexec /qn /norestart /x {870A52F4-A2EB-4187-97EA-654BD11A4C6C}
:: start /wait msiexec /qn /norestart /x {40FEB178-1855-45A7-B988-F44F1FA896B7}
:: start /wait msiexec /qn /norestart /x {222AB816-01E5-43B3-A10D-3F355FAAE513}
:: start /wait msiexec /qn /norestart /x {8A3F916F-F9EB-469D-8C09-42273B8C1A66}
:: start /wait msiexec /qn /norestart /x {AC89E267-9561-405B-B07F-DD5AAF92D042}
:: start /wait msiexec /qn /norestart /x {CF9072B6-A82D-4E3E-8F3C-31614CB150EB}
:: start /wait msiexec /qn /norestart /x {D4B7F322-6CFA-4CEE-AAE4-C5ADFA67F83C}
:: start /wait msiexec /qn /norestart /x {933B3C90-AEA9-41EB-B555-6A38ADEC50A1}
:: start /wait msiexec /qn /norestart /x {D85DD9A0-45CF-435B-98CB-144269DFE8A0}
:: start /wait msiexec /qn /norestart /x {957B1FBE-BDB3-4BCC-A3D8-70A0E4A23360}
:: start /wait msiexec /qn /norestart /x {6BDB867A-7975-40B5-93CE-11F133E1CDA9}
:: start /wait msiexec /qn /norestart /x {6A1A98D3-E814-4E84-B683-69800993380B}
:: start /wait msiexec /qn /norestart /x {7DB2CB6A-7248-4DC0-82FE-491D3570807E}
:: start /wait msiexec /qn /norestart /x {2790A7CF-0EBD-4728-9364-6B63C5E680E3}
:: start /wait msiexec /qn /norestart /x {B35C8CCE-95A1-45A4-BAB7-46154F60D8B2}
:: start /wait msiexec /qn /norestart /x {80A19900-E0FA-425B-A1F6-0F7C013CE45A}
:: start /wait msiexec /qn /norestart /x {6467DEB1-C20C-44F0-B25C-7A21F264D4F3}
:: start /wait msiexec /qn /norestart /x {1EFB479B-C396-4E5B-BBB5-A845C59383CD}
:: start /wait msiexec /qn /norestart /x {4786D940-0F26-43A4-98B5-4CAC01CD9FBE}
:: start /wait msiexec /qn /norestart /x {D43CBD3F-F4CB-4780-A686-CFD3775FC2A1}
:: start /wait msiexec /qn /norestart /x {ADC02977-F2BA-4F25-A550-B754562107A0}
:: start /wait msiexec /qn /norestart /x {A1433F59-803E-4CFF-911D-847B22149A6B}
:: start /wait msiexec /qn /norestart /x {5EE6CCD2-6142-4D09-8803-D31312574DC5}
:: start /wait msiexec /qn /norestart /x {E729BCE1-294E-4364-8170-84036E7696E1}
:: start /wait msiexec /qn /norestart /x {944321D8-225A-410E-932C-B8B219DF07D5}
:: start /wait msiexec /qn /norestart /x {CD019882-E447-4F30-8FA4-521478BEE8E9}
:: start /wait msiexec /qn /norestart /x {8F8BB210-4F82-4818-BF80-1CB57A62B996}
:: start /wait msiexec /qn /norestart /x {8375085C-00D4-43EA-8E65-263E8C738E08}
:: start /wait msiexec /qn /norestart /x {BCFE8F84-3EB8-40AD-B52F-F07B64F927AA}
:: start /wait msiexec /qn /norestart /x {2FD5A4CA-421B-4C9E-952B-EA5B98B40AC3}
:: start /wait msiexec /qn /norestart /x {85B51189-8F56-4338-9928-E1BFD7DB9211}
:: start /wait msiexec /qn /norestart /x {3614C95F-1376-4551-BDED-EC6B79E74D60}
:: start /wait msiexec /qn /norestart /x {967635DD-BA84-45AC-82EC-908D415B71A2}
:: start /wait msiexec /qn /norestart /x {5E25963C-8033-4EC2-BDEA-0869E75611C7}
:: start /wait msiexec /qn /norestart /x {9B8F134C-3A56-4365-A3FA-BD1824FD1B89}
:: start /wait msiexec /qn /norestart /x {AD4F337C-7752-415A-9602-DF17B4F46E68}
:: start /wait msiexec /qn /norestart /x {C7FDA25B-9A0F-487B-9502-35ABBF701599}
:: start /wait msiexec /qn /norestart /x {BCBE985F-DE7D-41EA-A8AB-A575AEEDBDBD}
:: start /wait msiexec /qn /norestart /x {823FCD0D-756D-44BE-A546-1D4D9FBBEA8C}
:: start /wait msiexec /qn /norestart /x {990B884F-569C-5078-DD76-8BE91A569291}
:: start /wait msiexec /qn /norestart /x {7D263751-40FB-D719-9F42-B62B67553D6F}
:: start /wait msiexec /qn /norestart /x {BD37CF23-3458-BFD1-7583-F8FFC37561F2}
:: start /wait msiexec /qn /norestart /x {931991F4-99D4-95A6-1235-EAA599884AC6}
:: start /wait msiexec /qn /norestart /x {C2471823-76DB-B529-F037-8D02CAC5DE5E}
:: start /wait msiexec /qn /norestart /x {1FAB6902-546D-9060-D0C8-4B502160AA06}
:: start /wait msiexec /qn /norestart /x {DAE76FE1-BD65-3251-1B6F-6B519A661A1F}
:: start /wait msiexec /qn /norestart /x {FE3E16F2-D838-7B5F-A31E-2D55757D18E7}
:: start /wait msiexec /qn /norestart /x {BF34B28A-4D50-439A-6B6B-13EA41235E43}
:: start /wait msiexec /qn /norestart /x {9E77F8EF-588E-D11B-697F-5514B97779DF}
:: start /wait msiexec /qn /norestart /x {571F7B9B-96B8-E1B8-E198-0458BF5F80C4}
:: start /wait msiexec /qn /norestart /x {3D516940-6675-41C1-E3DA-E3D358A7C207}
:: start /wait msiexec /qn /norestart /x {0AB6726B-2C04-75E6-D30A-AA8C0E26E46A}
:: start /wait msiexec /qn /norestart /x {3253D3E5-C08E-E22B-BA99-DE88F520CBB3}
:: start /wait msiexec /qn /norestart /x {82EE309C-B63C-1AAA-79AB-8A5E5986B687}
:: start /wait msiexec /qn /norestart /x {B9818C90-560C-8DC7-E254-38323B9A41EA}
:: start /wait msiexec /qn /norestart /x {E7809829-3AC8-FBFA-2001-0D9BEBE51386}
:: start /wait msiexec /qn /norestart /x {1D74451F-B220-E2E4-7FCD-520AA66F1A85}
:: start /wait msiexec /qn /norestart /x {B740C369-EA8D-2FDB-4265-CB70DD08095D}
:: start /wait msiexec /qn /norestart /x {2CC1453B-3385-F6FF-735F-F3BA36758715}
:: start /wait msiexec /qn /norestart /x {F79997CC-F030-93C6-7882-92DC241D7C07}
:: start /wait msiexec /qn /norestart /x {7540EB6A-FE9B-4EE2-37D9-A88DC87AA9E6}

:: Canon Easy-WebPrint EX toolbar
start /wait msiexec /qn /norestart /x {759D9886-0C6F-4498-BAB6-4A5F47C6C72F}

:: Cozi Express. "Cozi Express is a "wrapper" around Microsoft Internet Explorer that provides a streamlined user interface." No thanks.
start /wait msiexec /qn /norestart /x {EA1F3D6C-A6F5-4CDC-B0D3-9C56C06B4D29}

:: Casino'Touch for Microsoft Windows
start /wait msiexec /qn /norestart /x {44F55387-1032-486F-88E0-A58FEAA97BE4}

:: Catalyst Control Center - Branding
start /wait msiexec /qn /norestart /x {FB90923E-F94F-4343-A084-F0AB39305C8B}
start /wait msiexec /qn /norestart /x {01E6CFB0-2EAA-A019-7894-18986696E711}
start /wait msiexec /qn /norestart /x {0C37C41C-3BD1-256C-3C82-B5C707776249}
start /wait msiexec /qn /norestart /x {104A2DA8-93BF-00B1-D6F5-97F83340F272}
start /wait msiexec /qn /norestart /x {19145121-B4FB-D7DF-2900-16E96E8C8E83}
start /wait msiexec /qn /norestart /x {1FE5BFA8-C0E0-68FD-52DD-42FB11B3B160}
start /wait msiexec /qn /norestart /x {21AEC16B-1C21-81B4-DA88-2235CC1F7E39}
start /wait msiexec /qn /norestart /x {2480B673-194C-3C4B-1523-4C20F354E40C}
start /wait msiexec /qn /norestart /x {2726B6FF-D8F9-8F29-2A7D-8192AAE79D3F}
start /wait msiexec /qn /norestart /x {30BF4E6C-D866-46F7-A4F6-81A45E97706E}
start /wait msiexec /qn /norestart /x {358DF310-8B72-6178-4CDA-A6DB6616E477}
start /wait msiexec /qn /norestart /x {36C0C3FC-6B7E-467A-81DB-6E4532B44374}
start /wait msiexec /qn /norestart /x {3E275667-C19E-1AC0-A9EC-6D37AE67469C}
start /wait msiexec /qn /norestart /x {544587B1-B057-F0B3-7B19-6898ADBED9AC}
start /wait msiexec /qn /norestart /x {648B4A01-F609-1D4E-556C-0F18B54E9E1C}
start /wait msiexec /qn /norestart /x {71E65D48-AC13-814E-413B-F31E142D11CE}
start /wait msiexec /qn /norestart /x {A2DADCDD-694A-528E-C53B-A22B7C657039}
start /wait msiexec /qn /norestart /x {CA89CAC3-0A6C-3B72-F48C-EABC2A84FCC9}
start /wait msiexec /qn /norestart /x {CD05F1BC-FC63-1E93-4094-82BC33662E76}
start /wait msiexec /qn /norestart /x {D9803478-F222-AC9C-48FB-1F4D6B54F1FF}
start /wait msiexec /qn /norestart /x {DDD0527D-837F-5695-F2B7-941418FD9C01}
start /wait msiexec /qn /norestart /x {E21A8F3C-1ACB-46B1-CE72-E9CF09549DED}
start /wait msiexec /qn /norestart /x {E437ABBE-10E1-2CE5-F908-2FE8D611C88B}
start /wait msiexec /qn /norestart /x {EB4901E9-48AE-0A2E-8747-1269A390B72D}

:: Catalyst Control Center Graphics Previews Common (various version numbers)
start /wait msiexec /qn /norestart /x {190A9F41-85D0-CDB3-AA2D-A076D30953C9}
start /wait msiexec /qn /norestart /x {AA725670-A7B4-D1B0-4EF5-F4B2E418C9F4}
start /wait msiexec /qn /norestart /x {4841F481-1272-A1BE-D424-78628D252426}
start /wait msiexec /qn /norestart /x {DCA43467-6F0F-CC7B-B944-F54AA1752BBE}
start /wait msiexec /qn /norestart /x {B4205456-1F3F-7156-5EE2-DA1045FD7207}
start /wait msiexec /qn /norestart /x {22139F5D-9405-455A-BDEB-658B1A4E4861}
start /wait msiexec /qn /norestart /x {9C72C2F4-7DDE-9A3E-630D-BDAFFCFBD4B9}
start /wait msiexec /qn /norestart /x {C7151D49-868B-B1F3-4E5D-ADA0E69FCB6E}
start /wait msiexec /qn /norestart /x {49FE4B97-0E1E-F9EC-2123-4DFA80064694}
start /wait msiexec /qn /norestart /x {E9A1960E-7756-2299-C700-DC7CA6EDD6E4}
start /wait msiexec /qn /norestart /x {8452B997-80A4-B2F9-9CAD-00A3FA45AD92}
start /wait msiexec /qn /norestart /x {A1ACD45F-0D8E-0566-0EC0-530CDCD7E8F4}
start /wait msiexec /qn /norestart /x {DBA6B3EF-A8C0-4EB2-9554-3A7879838580}
start /wait msiexec /qn /norestart /x {0F943E47-5762-2CBD-4762-ED2F2EB520F6}
start /wait msiexec /qn /norestart /x {E63184B2-FA1E-F6AC-6CE3-E59DC4F1E3D4}
start /wait msiexec /qn /norestart /x {19A492A0-888F-44A0-9B21-D91700763F62}
start /wait msiexec /qn /norestart /x {E5441D19-417C-8C34-3F31-CCBD563C946E}
start /wait msiexec /qn /norestart /x {568B558F-259C-1314-9D2E-E639179E6D33}
start /wait msiexec /qn /norestart /x {6768141D-31CA-44E4-A827-8C95D22467F4}
start /wait msiexec /qn /norestart /x {76582A2F-F5FD-BF58-C69F-1E9AB9CBDF6A}
start /wait msiexec /qn /norestart /x {DCB72B24-65FC-C9E1-6E67-5C2E90339329}
start /wait msiexec /qn /norestart /x {7A185D7D-6683-C6D6-8BDD-3D7E8AD9E618}
start /wait msiexec /qn /norestart /x {BC5B6AD1-0581-3EB5-00FB-39A5203B7CA0}
start /wait msiexec /qn /norestart /x {69D85106-CBD8-0F32-DD9E-7F39F5533E19}
start /wait msiexec /qn /norestart /x {50BFCE80-042B-E53F-05EF-ACA0CC16A0DF}
start /wait msiexec /qn /norestart /x {9A3F65CA-78FA-4749-004B-23743CF642D1}
start /wait msiexec /qn /norestart /x {78237D85-8F06-3755-21AF-9F46F0BBC19F}

:: CCC Catalyst Control Center multi-lingual Help files. Too many to individually list, Google each GUID for more info
start /wait msiexec /qn /norestart /x {0EB8D099-E537-E3D3-039A-CBC50899C25B}
start /wait msiexec /qn /norestart /x {9A8C9B7D-C894-A9FE-755B-B97ADF16D966}
start /wait msiexec /qn /norestart /x {39D18BB4-D8F9-5940-6A7B-DA74A3BCA57C}
start /wait msiexec /qn /norestart /x {7CC68CB2-A3A6-27FC-9102-8103BF368AA8}
start /wait msiexec /qn /norestart /x {3225B377-6E8E-78F1-4CD9-7C90F503BCFE}
start /wait msiexec /qn /norestart /x {CAE3D1CA-7211-E7E3-F045-414ACFA5222E}
start /wait msiexec /qn /norestart /x {9028A63D-BF53-69A5-95EF-5123B2348051}
start /wait msiexec /qn /norestart /x {96ACB628-825A-29A2-2ADC-BF7D7E211C59}
start /wait msiexec /qn /norestart /x {4248147D-9E2D-D1BD-4B51-26399FEC4626}
start /wait msiexec /qn /norestart /x {90C443D7-A615-D053-A662-020A8F1C0B03}
start /wait msiexec /qn /norestart /x {385943E3-7958-9084-42EB-B0D3933FC4E4}
start /wait msiexec /qn /norestart /x {29A389C5-0345-C38A-2ADE-7EB39281B46B}
start /wait msiexec /qn /norestart /x {FE7A3EC9-93A9-1B25-0A9C-A0E460A6CFD1}
start /wait msiexec /qn /norestart /x {B288921F-8BCC-6CE5-2997-450DC5D96A54}
start /wait msiexec /qn /norestart /x {037F0FF4-E80E-48DB-389B-A7890E45E18E}
start /wait msiexec /qn /norestart /x {C7A5AD8E-0C1C-7D88-28DD-2FF801ABD310}
start /wait msiexec /qn /norestart /x {408D0747-D910-6303-11B3-331A43D792F9}
start /wait msiexec /qn /norestart /x {F3B6E13B-8949-D194-D2F3-628B16EFAB14}
start /wait msiexec /qn /norestart /x {5490AEC3-909E-8B5C-E51E-A1BB5385D9DA}
start /wait msiexec /qn /norestart /x {180ED4E8-9E9F-5D1A-00F9-8F886D376E73}
start /wait msiexec /qn /norestart /x {1B38B23D-449A-AD28-6F4F-E8796FFB8DF9}
start /wait msiexec /qn /norestart /x {1B2F4C89-8E27-4FC5-4B89-156FB31D5133}
start /wait msiexec /qn /norestart /x {2DD25842-EE28-844F-0769-A0C55F9137D3}
start /wait msiexec /qn /norestart /x {56D662DD-FA46-9CFA-0F61-548F2C231F95}
start /wait msiexec /qn /norestart /x {706DDDCA-FC25-26D8-8E2C-DCC5E95351CD}
start /wait msiexec /qn /norestart /x {06A6B4EA-ACCF-277B-7B3B-6B83D60B61B3}
start /wait msiexec /qn /norestart /x {5A216534-EFDA-0AAA-E716-DA6771244656}
start /wait msiexec /qn /norestart /x {10047D9D-3EC2-F25F-AEE5-250AB94D96A6}
start /wait msiexec /qn /norestart /x {BA34CE69-4E00-3FC5-D06D-F8093E58313F}
start /wait msiexec /qn /norestart /x {9D4757D6-6C0D-B98D-CCA5-BB00D0E91872}
start /wait msiexec /qn /norestart /x {7FF60ABB-CA0D-0B6E-A078-3B94470E0B68}
start /wait msiexec /qn /norestart /x {5EBEDD03-4E31-C4AF-D54F-26C3454E6596}
start /wait msiexec /qn /norestart /x {A0F7297E-23F3-201A-F17A-F49E16E9DE10}
start /wait msiexec /qn /norestart /x {C019EF7D-A6D6-65EE-76BD-C73E6E0F3EC6}
start /wait msiexec /qn /norestart /x {D8928939-B9F5-58CB-168B-77F84ADFAC98}
start /wait msiexec /qn /norestart /x {5E980195-F909-70F7-6269-4169FDB31886}
start /wait msiexec /qn /norestart /x {E8758B5B-DAD2-3CF2-234A-D560B8EED49E}
start /wait msiexec /qn /norestart /x {450E48EF-A565-5D5F-05F2-695C2AEEBFFB}
start /wait msiexec /qn /norestart /x {1EC5E39E-ECEE-2433-5F9C-F6BB5D81E0F3}
start /wait msiexec /qn /norestart /x {158A29A7-EDBD-F732-FA4F-966D77F54863}
start /wait msiexec /qn /norestart /x {4780F387-6962-2A7A-2816-9F5DCD50B350}
start /wait msiexec /qn /norestart /x {88BDB715-7ABF-5A56-F383-FF9CBB6E1390}
start /wait msiexec /qn /norestart /x {95A78205-B06E-0126-3D96-13D40E89E9F8}
start /wait msiexec /qn /norestart /x {3DD893E2-ED51-EBEF-A8EC-AC0EFBA6F124}
start /wait msiexec /qn /norestart /x {0539BDDF-F755-D9E5-01DD-C849A8FEAFBA}
start /wait msiexec /qn /norestart /x {7CD296DF-92C6-0AFA-2266-52D2E9E6F94A}
start /wait msiexec /qn /norestart /x {637C66DF-2C30-92D5-FF70-4C6BF78A70B8}
start /wait msiexec /qn /norestart /x {8DA5268F-0878-6946-18C5-AC119E909E45}
start /wait msiexec /qn /norestart /x {5059FE9E-985A-5042-4E40-0599893F1BD4}
start /wait msiexec /qn /norestart /x {317F1B3D-6D11-845F-78A4-A7043709BE98}
start /wait msiexec /qn /norestart /x {561F34EC-58FD-012E-97E9-FD602FE05793}
start /wait msiexec /qn /norestart /x {88ED4B4B-737C-436A-1986-5C11DAE3AF58}
start /wait msiexec /qn /norestart /x {868A261B-F138-F634-809D-FB055FBD64D7}
start /wait msiexec /qn /norestart /x {55B3618A-C140-9255-4A2E-DFDA4FA73079}
start /wait msiexec /qn /norestart /x {80D7F879-2B6B-A962-7CDB-9D44EBF94179}
start /wait msiexec /qn /norestart /x {7646ABF9-134D-E4D4-6CAB-BDCC6C1B757E}
start /wait msiexec /qn /norestart /x {9334EE39-4008-DADF-312A-959732D2BA89}
start /wait msiexec /qn /norestart /x {C3949029-D1B6-7C46-8924-D923632D25C6}
start /wait msiexec /qn /norestart /x {B5B56A67-A778-EC49-933C-A16ACDDB36AA}
start /wait msiexec /qn /norestart /x {CB875A37-DCFE-D05D-0D46-56FF566687F3}
start /wait msiexec /qn /norestart /x {9F405B46-9A78-F808-F993-A7F9F97B31A4}
start /wait msiexec /qn /norestart /x {7998A135-B567-5CBB-0C0A-D7095D9AD198}
start /wait msiexec /qn /norestart /x {7D524964-6AB4-2712-5B65-80770A1C080F}
start /wait msiexec /qn /norestart /x {7CD40554-C923-6261-534B-B81F37519864}
start /wait msiexec /qn /norestart /x {597AB871-BC7D-29EC-2DB5-F29C32FBD6A3}
start /wait msiexec /qn /norestart /x {972315D0-3943-6BAB-CCC8-4B6E9F844390}
start /wait msiexec /qn /norestart /x {1E2ABB89-F7F3-8D64-3345-27E5735AA20C}
start /wait msiexec /qn /norestart /x {990B884F-569C-5078-DD76-8BE91A569291}
start /wait msiexec /qn /norestart /x {CD4005E4-E612-14BB-1BC4-636AE955D995}
start /wait msiexec /qn /norestart /x {EB938F46-2780-1AF2-2579-A41EA96F8C1F}
start /wait msiexec /qn /norestart /x {AA90CE8A-A77C-3CEB-DCD8-56DFDEDE808F}
start /wait msiexec /qn /norestart /x {D05EA7FA-B112-103C-FBBE-8163B1B33A30}
start /wait msiexec /qn /norestart /x {221BFD98-55F8-C64E-C2FA-56694133DB69}
start /wait msiexec /qn /norestart /x {2904E0A2-B74F-EFAD-A523-46D0F64B3B4A}
start /wait msiexec /qn /norestart /x {A8170CD1-F477-12A2-FCDE-E93759682F6F}
start /wait msiexec /qn /norestart /x {8B5938FB-35EA-DF7F-E1FF-EB3E577E7125}
start /wait msiexec /qn /norestart /x {F2569C93-029A-D00E-560F-40954008865B}
start /wait msiexec /qn /norestart /x {9E77F8EF-588E-D11B-697F-5514B97779DF}
start /wait msiexec /qn /norestart /x {99D70190-1870-B004-820B-6DCFD622703F}
start /wait msiexec /qn /norestart /x {6DEE7496-3ED6-DE4C-9BEF-1E7F247CAAD1}
start /wait msiexec /qn /norestart /x {27282E77-DB14-5769-2032-F381343DAA31}
start /wait msiexec /qn /norestart /x {5CF1C22A-11DA-C6AC-7E66-289A858F5C46}
start /wait msiexec /qn /norestart /x {CE24C50B-3A91-3880-4F4D-9EDD595E01DF}
start /wait msiexec /qn /norestart /x {5C97100A-CBFA-F752-1CC4-8D59BB06DA51}
start /wait msiexec /qn /norestart /x {5A1AE61E-393A-DE99-4733-AB36127B36F6}
start /wait msiexec /qn /norestart /x {D33FFCDF-6B95-3586-F8B8-27CE5FF728C6}
start /wait msiexec /qn /norestart /x {1D74451F-B220-E2E4-7FCD-520AA66F1A85}
start /wait msiexec /qn /norestart /x {1D9F8C88-F76A-6B07-2276-98DF1173901B}
start /wait msiexec /qn /norestart /x {086E1D65-EF19-280C-5616-7A87A6B95F88}
start /wait msiexec /qn /norestart /x {2BC2EDB2-6F5C-3058-D312-B991AB26E870}
start /wait msiexec /qn /norestart /x {1935505D-28FE-0FFE-9EB6-6AF73397C7BE}
start /wait msiexec /qn /norestart /x {00CCB6C5-DD11-F614-5955-FACAFA2C80F7}
start /wait msiexec /qn /norestart /x {01CD9E78-5D95-C7FB-EC23-64B39130EE31}
start /wait msiexec /qn /norestart /x {020BA2C3-6D2E-78D0-9294-E4DDE937AE01}
start /wait msiexec /qn /norestart /x {029C5BE5-462A-2FB8-5C54-362AFEEA7D44}
start /wait msiexec /qn /norestart /x {031F80EB-1FE5-45EF-9DE2-E2F5AF01259F}
start /wait msiexec /qn /norestart /x {03B2606F-6D79-81DD-6A43-88D7F00CDD09}
start /wait msiexec /qn /norestart /x {049CA153-97D5-B668-E17D-EBA7D3B6FF2C}
start /wait msiexec /qn /norestart /x {050FFD99-5C2F-9A1F-416E-AE0F4651CCB1}
start /wait msiexec /qn /norestart /x {062ABD24-47F8-D865-BCB6-A724A94BC9A5}
start /wait msiexec /qn /norestart /x {063B9998-A8C5-84A0-77A7-18F4844CF358}
start /wait msiexec /qn /norestart /x {0655C185-FD48-5EBA-484A-CD530291F44D}
start /wait msiexec /qn /norestart /x {06EC2942-D573-D6BD-3964-9D874353DDD7}
start /wait msiexec /qn /norestart /x {070232F8-068B-1FF6-B5C4-F8F38E09C7E1}
start /wait msiexec /qn /norestart /x {073AB210-9BDA-2F64-6B41-494F35C1E73F}
start /wait msiexec /qn /norestart /x {0866F9CF-ABEA-0DCC-BF9F-29CE382B7D8D}
start /wait msiexec /qn /norestart /x {092D7377-3DB8-B59E-7226-8B66AC437440}
start /wait msiexec /qn /norestart /x {0A143C9B-DCE4-5089-E3DE-12BBCA178C12}
start /wait msiexec /qn /norestart /x {0B15A8C3-3B8A-F229-A880-82EA62908425}
start /wait msiexec /qn /norestart /x {0B23199B-B1CF-3D51-BB10-671DF99FC026}
start /wait msiexec /qn /norestart /x {0BF79EF6-BD51-8FF9-35DE-290FBD97EC44}
start /wait msiexec /qn /norestart /x {0CA35BA7-09C8-800A-7080-0F822D7096EF}
start /wait msiexec /qn /norestart /x {0D3161D2-BFF2-1CD8-A951-EDFA4095DEEB}
start /wait msiexec /qn /norestart /x {0E28CD09-29FD-119F-5544-815FBEBD69C2}
start /wait msiexec /qn /norestart /x {0E786111-4DE4-FE39-FBDF-6BF28A318F7B}
start /wait msiexec /qn /norestart /x {0F7BFF8F-274A-05FE-2D37-A0C644424871}
start /wait msiexec /qn /norestart /x {0F8D819B-1AE4-E88B-1C03-610107019E30}
start /wait msiexec /qn /norestart /x {0FBFA28A-C373-53BD-C553-58D6F6553D92}
start /wait msiexec /qn /norestart /x {100E80FD-AAC1-89BA-B008-F1B8EBE7C668}
start /wait msiexec /qn /norestart /x {104DE091-6C4F-C5A9-F619-5D6C965A0296}
start /wait msiexec /qn /norestart /x {1078B6F2-93D7-FDB8-E8E2-84A61AB669CA}
start /wait msiexec /qn /norestart /x {10F16BA8-BBEB-20C7-DF4D-22C6E19A9A80}
start /wait msiexec /qn /norestart /x {110DE0FF-32D1-6203-ACDF-279DFA792DA1}
start /wait msiexec /qn /norestart /x {115BAB0B-AB04-E481-76F5-82D90C3049A6}
start /wait msiexec /qn /norestart /x {11E875AA-DF42-811E-96D9-5054A5A474B5}
start /wait msiexec /qn /norestart /x {1205F38A-449D-D189-DA2C-812700240426}
start /wait msiexec /qn /norestart /x {12ABA680-4BF6-E22B-0EEC-6E3D90B70635}
start /wait msiexec /qn /norestart /x {12F80942-5FE0-7CE9-F1B3-121795A32054}
start /wait msiexec /qn /norestart /x {13464292-6666-B2DB-1B0C-A3FE14DAD1F9}
start /wait msiexec /qn /norestart /x {13FF5C00-EC03-D752-9302-141BE27B3C19}
start /wait msiexec /qn /norestart /x {142C4779-8446-4458-3FC4-76195D41241C}
start /wait msiexec /qn /norestart /x {14ADD362-A9D0-DB6D-6445-A99F8EDA5559}
start /wait msiexec /qn /norestart /x {15030405-7B1E-7300-1C6C-9FE98BA68CB4}
start /wait msiexec /qn /norestart /x {15412249-0AFA-D2A1-E7E2-E57AE1A96781}
start /wait msiexec /qn /norestart /x {15775C9B-CD12-BDAF-F5FA-E06A7CB4F25D}
start /wait msiexec /qn /norestart /x {18E58A5D-D8BD-EF4B-006A-104E5FE8CB13}
start /wait msiexec /qn /norestart /x {1950EACB-6D88-F21E-4B25-26ECDD0C62A7}
start /wait msiexec /qn /norestart /x {19EAB36E-A979-0870-F58F-6F4F34017D29}
start /wait msiexec /qn /norestart /x {86372151-A7B9-BB84-9D98-0B914A55C6F1}
start /wait msiexec /qn /norestart /x {19F2D706-4834-2DD2-D12E-C10E75A57C81}
start /wait msiexec /qn /norestart /x {1A30F95F-68D7-27DC-8C60-1A9A01EB2B50}
start /wait msiexec /qn /norestart /x {1A4AABD1-8619-9747-3914-0B50A2B420EA}
start /wait msiexec /qn /norestart /x {1A6752E1-966B-9D1F-F6B7-DDBCA6FC87ED}
start /wait msiexec /qn /norestart /x {1B01541D-B1B8-8B7E-E82B-70551A1AF961}
start /wait msiexec /qn /norestart /x {1BF82343-8EE6-8B76-90CF-31059B9D1842}
start /wait msiexec /qn /norestart /x {1C22B23F-47AE-B9EC-8D40-1383B4CCA3E2}
start /wait msiexec /qn /norestart /x {1CB8B169-534E-6F89-CDF9-0B812FBACF9A}
start /wait msiexec /qn /norestart /x {1CDB842D-9C18-5EBC-91D4-C6F8DA0AE7CE}
start /wait msiexec /qn /norestart /x {1DA0220A-454D-C668-763E-B232686FC505}
start /wait msiexec /qn /norestart /x {1DE3F8C9-9F64-0F84-1512-06A15746C004}
start /wait msiexec /qn /norestart /x {1E32C2AB-9722-5F41-7BDE-24B5AFD2BCE6}
start /wait msiexec /qn /norestart /x {1E4062A9-EC7A-A6E9-348E-58B30D6EEADA}
start /wait msiexec /qn /norestart /x {1F4B31CD-3824-5E93-060C-D333BFA36C6E}
start /wait msiexec /qn /norestart /x {204F0053-6818-D50D-B132-55D5D0D1125D}
start /wait msiexec /qn /norestart /x {2058DA53-D5F2-D8D9-7325-39B0E367D1E1}
start /wait msiexec /qn /norestart /x {2070F457-B044-FCEE-B6DA-CB2C12CD76A5}
start /wait msiexec /qn /norestart /x {2090B6D0-E025-5A67-9838-8F1D5768E643}
start /wait msiexec /qn /norestart /x {210DD1FC-AAF8-4357-25FE-89E699BDB62E}
start /wait msiexec /qn /norestart /x {2144B7B3-F251-6371-B2DB-071B9ECAC5A8}
start /wait msiexec /qn /norestart /x {21CA031D-7805-5F8B-7A19-7954D5041A79}
start /wait msiexec /qn /norestart /x {2226CEE6-E82A-AAD8-BA76-178734BBD484}
start /wait msiexec /qn /norestart /x {222F2F2B-63FF-8B2C-05AE-8D418E66331B}
start /wait msiexec /qn /norestart /x {224CA902-F494-FD2A-4211-771454ED464B}
start /wait msiexec /qn /norestart /x {228CDD95-4069-8D94-7584-82BDE9A68B63}
start /wait msiexec /qn /norestart /x {23AFE193-77EE-5A15-0FE2-1EA7407E0D53}
start /wait msiexec /qn /norestart /x {243A6B8F-203D-EDAD-350D-15393AD822CD}
start /wait msiexec /qn /norestart /x {D83D5480-00CF-9FC9-95CF-60F5E92D8735}
start /wait msiexec /qn /norestart /x {244DFA33-CAE6-6D3A-BD58-B65EAD0AF73C}
start /wait msiexec /qn /norestart /x {252FC4D1-4056-7237-6B19-4C66D0CF45A9}
start /wait msiexec /qn /norestart /x {26070CDA-A7C5-2114-0533-38DE06C65E7F}
start /wait msiexec /qn /norestart /x {267D591E-CC5C-9951-890A-97BD66717E30}
start /wait msiexec /qn /norestart /x {2696556B-1D2B-26B3-75B1-52F342C150D0}
start /wait msiexec /qn /norestart /x {2701BCE6-FAAF-7F58-5993-78D631439450}
start /wait msiexec /qn /norestart /x {EA6358BC-1DDA-882D-8642-15DBC063192C}
start /wait msiexec /qn /norestart /x {2746C43F-4D85-73C6-8ADC-C38453C3531E}
start /wait msiexec /qn /norestart /x {27B201A5-A73B-1E7E-0C62-978A1B4A6696}
start /wait msiexec /qn /norestart /x {285C9F30-3BF8-697B-BD1D-353435E94B78}
start /wait msiexec /qn /norestart /x {288306FF-D5B5-7398-0617-E52F625C6797}
start /wait msiexec /qn /norestart /x {28CA24E3-D323-3900-9519-4FFE9984EC53}
start /wait msiexec /qn /norestart /x {29725F9E-027A-22DC-7B17-9413A5C5E51C}
start /wait msiexec /qn /norestart /x {29967A7C-6E18-91CD-BBE4-9C09F401E950}
start /wait msiexec /qn /norestart /x {2AD4FF67-43E9-77AD-D90C-584F950E2D12}
start /wait msiexec /qn /norestart /x {2AF5D46E-6313-EC1D-1EA6-D542ECA0525A}
start /wait msiexec /qn /norestart /x {2C0988B9-3BEA-7A45-2A67-BD0267973878}
start /wait msiexec /qn /norestart /x {2CAF2C07-3219-8143-0E1C-EB1E20223171}
start /wait msiexec /qn /norestart /x {2CB90FEE-EAAF-A572-72CF-014DDF5333F0}
start /wait msiexec /qn /norestart /x {2CF48C8D-38F6-09E3-C24D-69999191726F}
start /wait msiexec /qn /norestart /x {2D1C2307-58C4-86FC-CC3F-F8B5EAD52E5C}
start /wait msiexec /qn /norestart /x {2DF4CDD9-C5BD-4DBB-3BB8-99E38D36BBBE}
start /wait msiexec /qn /norestart /x {2E1BA46C-A45B-F2C8-1197-0CEB4EB77F70}
start /wait msiexec /qn /norestart /x {2E5C47CE-9025-D797-8912-B3D7AC6AB5A0}
start /wait msiexec /qn /norestart /x {2E85AE1F-7F71-4B34-5002-5B6CF42FEACC}
start /wait msiexec /qn /norestart /x {2F5EB64A-814B-1884-DFEC-B30A212DCF2C}
start /wait msiexec /qn /norestart /x {3042F44D-53BB-5430-64D3-550FE514A4BB}
start /wait msiexec /qn /norestart /x {3088B508-7EE1-EC64-4FFD-C4901378CE7D}
start /wait msiexec /qn /norestart /x {30F8E944-0BC9-9D90-D5DF-C606BAC6BD10}
start /wait msiexec /qn /norestart /x {31DFAE28-8D77-B418-4217-AEB3396EAE82}
start /wait msiexec /qn /norestart /x {31E4C3BB-2E7A-714B-65AF-2F8C711149E9}
start /wait msiexec /qn /norestart /x {322DAA48-8F9B-FF15-2121-44E685B9F69F}
start /wait msiexec /qn /norestart /x {32531CE8-014A-A2A4-C25A-DE9BA5B269F5}
start /wait msiexec /qn /norestart /x {338CD56F-1CDC-CF32-33F6-DED2DF92284E}
start /wait msiexec /qn /norestart /x {33BE1592-4175-7719-4604-5233D7434F92}
start /wait msiexec /qn /norestart /x {33CDC947-0D8B-E2DB-FAED-A0026156F2B2}
start /wait msiexec /qn /norestart /x {33E799D0-A9D7-E79E-1319-3B7EE918F946}
start /wait msiexec /qn /norestart /x {3436866E-2C3A-AC6F-C6CF-1ABFF5FB69A3}
start /wait msiexec /qn /norestart /x {344DE092-12CA-34F6-DD4D-0812340D9EF7}
start /wait msiexec /qn /norestart /x {3528D412-5EEA-AAEA-AF64-9ADEE903D7D5}
start /wait msiexec /qn /norestart /x {35E16D5D-3E57-4D32-47A9-4FFAFFB638BB}
start /wait msiexec /qn /norestart /x {35EFBB88-4757-7F73-CDE7-D8B9E3819103}
start /wait msiexec /qn /norestart /x {367EE587-F92B-E3E4-3816-99297A40751D}
start /wait msiexec /qn /norestart /x {369F62CC-BAE9-CCDF-C4D3-8F2B3A398609}
start /wait msiexec /qn /norestart /x {36A44ED0-1D3F-736D-9F06-D8685A9CFD79}
start /wait msiexec /qn /norestart /x {375444C6-3CF6-B995-CDB0-F625C295E946}
start /wait msiexec /qn /norestart /x {376F223B-0DF0-51E8-C51D-CA36F92914AE}
start /wait msiexec /qn /norestart /x {3778B802-8E2C-04B0-2C1B-7C2A8F981824}
start /wait msiexec /qn /norestart /x {39159BE7-2B24-D59B-18CF-878DFE0D9E32}
start /wait msiexec /qn /norestart /x {3929A50B-9EEB-D8FC-1420-BD29DBD836BF}
start /wait msiexec /qn /norestart /x {395B4CDF-79F3-C9ED-D869-DD4275298BFC}
start /wait msiexec /qn /norestart /x {399D5E57-36C2-0856-77F4-5E06A4DF50EA}
start /wait msiexec /qn /norestart /x {3A4C8B8E-AF20-25E1-35B8-2E8115BFC2B6}
start /wait msiexec /qn /norestart /x {3A577334-7C90-55BC-1878-F5862FA268B2}
start /wait msiexec /qn /norestart /x {3BE2E4AA-C164-FEB5-6C82-BBBC90C88915}
start /wait msiexec /qn /norestart /x {3BF289E3-933B-F421-3B59-F6BB0D285B09}
start /wait msiexec /qn /norestart /x {3C636207-EA73-E114-4FDE-39CA74F229F5}
start /wait msiexec /qn /norestart /x {3C82A584-4651-2CE2-9E2D-F9B1F158CB8D}
start /wait msiexec /qn /norestart /x {3CB6BA0C-6BC5-E543-221A-AA4DEBB6F4B5}
start /wait msiexec /qn /norestart /x {3CBC0CD2-18F0-523D-DA6A-B224C3C4B2CF}
start /wait msiexec /qn /norestart /x {3D06658D-C32D-CEAC-E92C-68CDFA13E21C}
start /wait msiexec /qn /norestart /x {3D5238BD-B6F7-0325-4577-7B1DD3AC539F}
start /wait msiexec /qn /norestart /x {3D8BC028-6977-2124-8314-A480AFD53C20}
start /wait msiexec /qn /norestart /x {3DEDF1B0-B2A5-EDCE-F698-5C38B3717CA1}
start /wait msiexec /qn /norestart /x {3E13E92F-464A-00D3-E497-FB7D4107B696}
start /wait msiexec /qn /norestart /x {3E79966D-59AB-B5F5-19FD-898F4F0B5F32}
start /wait msiexec /qn /norestart /x {3F5AF1A5-68C6-63B6-9550-B0BBDEFCA76F}
start /wait msiexec /qn /norestart /x {40B415DD-63CB-7269-F7F8-BD2A06792785}
start /wait msiexec /qn /norestart /x {41416465-D2EB-9DAC-8539-6339BB5A7436}
start /wait msiexec /qn /norestart /x {4254F42D-4906-9791-A236-5DCC0096A896}
start /wait msiexec /qn /norestart /x {430E2D32-6EA9-E6E4-80A1-84047694A45B}
start /wait msiexec /qn /norestart /x {431EF42B-83EB-CD76-38D4-1DC2E4C044F4}
start /wait msiexec /qn /norestart /x {44BD56AB-0427-EAAD-4E41-73192A7FE778}
start /wait msiexec /qn /norestart /x {44D822AA-DA6D-1915-4B64-60D06AE613CE}
start /wait msiexec /qn /norestart /x {44F7C005-42DF-B48D-5310-EDCCEBCD2CD0}
start /wait msiexec /qn /norestart /x {46458556-5C46-79A9-A6FF-81DF1F8B2729}
start /wait msiexec /qn /norestart /x {4690C2F0-0019-8675-DE47-2A842E44F988}
start /wait msiexec /qn /norestart /x {4707D0D8-B9F3-255B-DD9F-D1C287DE8147}
start /wait msiexec /qn /norestart /x {473B7FDE-3021-C9D2-9DB3-2B09DF840567}
start /wait msiexec /qn /norestart /x {480C3278-56A7-3F05-3829-6DC5D4B0CB06}
start /wait msiexec /qn /norestart /x {48614A34-564D-1F2B-7D2E-8814113BDEA8}
start /wait msiexec /qn /norestart /x {48CA048A-3C5B-391E-7FF0-F36F434CB1B6}
start /wait msiexec /qn /norestart /x {491C731F-F54D-864B-928D-436692D42133}
start /wait msiexec /qn /norestart /x {4958364A-733A-D443-AF75-6880899AC7A4}
start /wait msiexec /qn /norestart /x {49FD3CE5-1839-7EEA-D7D3-17A23826B859}
start /wait msiexec /qn /norestart /x {4A6A8D33-09CD-FD44-4BF0-999E8A6E93C8}
start /wait msiexec /qn /norestart /x {4B055C77-BC0F-623F-5A73-F7D5012987DB}
start /wait msiexec /qn /norestart /x {4B6B8CE2-0E90-9108-1488-F70111AF8D8C}
start /wait msiexec /qn /norestart /x {4CA4D9FC-212C-9F69-E760-DB4BEB34FEB5}
start /wait msiexec /qn /norestart /x {4D7340CA-7D10-C5BC-4DA6-F3F685BAF0FF}
start /wait msiexec /qn /norestart /x {4DE0D937-FEB0-0D89-C8D6-35F600300BD4}
start /wait msiexec /qn /norestart /x {4E0C50EF-85BF-A1C0-307E-99473244B65F}
start /wait msiexec /qn /norestart /x {4E81DBF0-CAB2-3EC7-18A3-0B0E8BA67FB9}
start /wait msiexec /qn /norestart /x {4F01D33E-6FDF-2A63-8AD9-CBDC4735E80D}
start /wait msiexec /qn /norestart /x {5175254C-4F5C-61DF-9647-306994652857}
start /wait msiexec /qn /norestart /x {519D68B8-A768-4CDC-E4C9-B115D49CED93}
start /wait msiexec /qn /norestart /x {51D383BC-D988-8C1E-FAA1-BC5260A32A87}
start /wait msiexec /qn /norestart /x {526B6DD3-0C43-2C13-7DF8-44D20D4E9853}
start /wait msiexec /qn /norestart /x {52FB1497-BBDD-F46F-2ADE-407148D63C65}
start /wait msiexec /qn /norestart /x {998042A4-4186-9410-B434-03292C6FD4EE}
start /wait msiexec /qn /norestart /x {5312A73B-4DA5-C48E-D15E-857E582A50E7}
start /wait msiexec /qn /norestart /x {532B7184-DB64-3DB0-0312-611FFC288F7F}
start /wait msiexec /qn /norestart /x {5377D0E6-0B77-5C94-A3F8-2A7C0E5791A1}
start /wait msiexec /qn /norestart /x {5385F887-7F0F-8D37-4D52-677F7C928887}
start /wait msiexec /qn /norestart /x {5402616A-ED3B-8FD4-9E3D-8A409178B524}
start /wait msiexec /qn /norestart /x {54D05374-2428-7BE0-58CD-CE8031163DE6}
start /wait msiexec /qn /norestart /x {54ED5964-9FEF-C9F8-F5D7-2663AFFD0C13}
start /wait msiexec /qn /norestart /x {55B013D5-14E7-C0B1-CE42-9C567AAEE3C9}
start /wait msiexec /qn /norestart /x {564F4D90-C0B0-A0B9-8C36-F19D28D6B861}
start /wait msiexec /qn /norestart /x {571C0874-A931-EEFE-E89D-8F912F633B9F}
start /wait msiexec /qn /norestart /x {58DBB034-F439-9FC4-361C-A990EA8CDA2D}
start /wait msiexec /qn /norestart /x {59718697-4BCF-F43F-3E62-727C9ADE899C}
start /wait msiexec /qn /norestart /x {597CE475-4F62-89EE-A81E-DB509DA0CBB2}
start /wait msiexec /qn /norestart /x {597D764C-00A1-B174-33C2-93C9A4E73E21}
start /wait msiexec /qn /norestart /x {59776556-45C9-0D23-5C4E-734C5E5FC2F3}
start /wait msiexec /qn /norestart /x {59D0F36A-875A-BC78-2AF6-EC93CD24F6AA}
start /wait msiexec /qn /norestart /x {5AF1BA3B-8B09-6459-4834-840E6B47BCFF}
start /wait msiexec /qn /norestart /x {5BC757F1-5DE7-AD3C-81E8-81CAAC6D5889}
start /wait msiexec /qn /norestart /x {5BF85137-0015-8591-E83C-EC121B2928AF}
start /wait msiexec /qn /norestart /x {5BF8D06C-9B8C-085A-A093-DC5117108CD7}
start /wait msiexec /qn /norestart /x {5C6AFE98-08BF-086A-300D-18F77D284966}
start /wait msiexec /qn /norestart /x {5C757800-27E8-2AE3-889A-8B959AE689F8}
start /wait msiexec /qn /norestart /x {5D3EC645-B957-36A1-068A-FE8450963669}
start /wait msiexec /qn /norestart /x {5E2C8F1A-AC86-FBCD-B3E4-EBF9E747BC4D}
start /wait msiexec /qn /norestart /x {5EE4A17C-DA9D-1A22-6D35-561BB29A38E6}
start /wait msiexec /qn /norestart /x {5FE625A7-E8D6-2E41-4693-F6AC6310C467}
start /wait msiexec /qn /norestart /x {610A0147-10AB-D148-B6E1-503E40A444B9}
start /wait msiexec /qn /norestart /x {615B68AE-FDAF-937F-229C-10B77F039D55}
start /wait msiexec /qn /norestart /x {61B90A4D-8CC9-2FED-2495-AC8C9467C984}
start /wait msiexec /qn /norestart /x {624B2C5A-4343-E681-8BF7-838D792D8561}
start /wait msiexec /qn /norestart /x {640D8EB2-3EBC-AFD7-7BE0-05C267EB39E2}
start /wait msiexec /qn /norestart /x {641A5FC9-9B5C-6D83-AA49-FD2C967EF67F}
start /wait msiexec /qn /norestart /x {6446F083-76CD-553B-8261-0E1297A7214C}
start /wait msiexec /qn /norestart /x {64F18837-72CE-DC38-899C-260AF20F979A}
start /wait msiexec /qn /norestart /x {65A472D0-CACC-38CD-65EE-426815ADC3D9}
start /wait msiexec /qn /norestart /x {662A52A4-FE70-9435-47C6-30079DA87C01}
start /wait msiexec /qn /norestart /x {662CB116-3477-ADD3-2C9D-5BC2806B1294}
start /wait msiexec /qn /norestart /x {667E73A4-61C4-1224-B3A9-8A3B0422151E}
start /wait msiexec /qn /norestart /x {66A42477-F80D-1A4F-08D8-D58697836EE5}
start /wait msiexec /qn /norestart /x {674DAE26-3C3C-2D20-1BB4-82B380142E78}
start /wait msiexec /qn /norestart /x {6756EE57-D98E-1EAD-B246-5AFFE2C6F63E}
start /wait msiexec /qn /norestart /x {67A4760F-9804-CCF6-C319-27840ED77924}
start /wait msiexec /qn /norestart /x {683081FF-DED0-CCB2-01C6-DEB1133DC7B1}
start /wait msiexec /qn /norestart /x {6913316C-BD32-1A90-515F-D7B374FAF0B5}
start /wait msiexec /qn /norestart /x {69850346-A30F-B771-3D3D-2FCB0E074992}
start /wait msiexec /qn /norestart /x {69C82DDB-3FBC-EBEC-AE0A-3ABF1F3BD39B}
start /wait msiexec /qn /norestart /x {6A376E3F-FBA3-6498-3B8D-B8D6169008D2}
start /wait msiexec /qn /norestart /x {6A9EF47E-D49A-2EFC-20A1-A92DE7F826DF}
start /wait msiexec /qn /norestart /x {6B79FF31-157D-14C5-E321-6AB2F7703A1D}
start /wait msiexec /qn /norestart /x {6BE5E4A9-D88B-532D-26E6-883C32BF098A}
start /wait msiexec /qn /norestart /x {6C4AD4F5-8560-4F1E-BC0C-7A883B695F6E}
start /wait msiexec /qn /norestart /x {6CA2BE46-A562-8CA4-1C33-CC2681B2DDA1}
start /wait msiexec /qn /norestart /x {6D6B211B-084E-030D-6160-F7926D3E84FA}
start /wait msiexec /qn /norestart /x {6E2D214F-29AF-8A3F-61E2-531435A40949}
start /wait msiexec /qn /norestart /x {6E2E52A3-DF0A-4EDC-B4F1-267E0FEC691B}
start /wait msiexec /qn /norestart /x {6E594B4E-D394-BDEE-E9FF-4E6EBC30FB3A}
start /wait msiexec /qn /norestart /x {6EBDE2A2-0CFB-9134-A859-68A0002B3FA6}
start /wait msiexec /qn /norestart /x {6F076041-F337-5F67-75E7-6C1324D43EC6}
start /wait msiexec /qn /norestart /x {6F7396CA-B0BA-AD24-83C8-4FF670291F48}
start /wait msiexec /qn /norestart /x {6FB0A543-370D-AF7D-78E6-570FAA9D9AAD}
start /wait msiexec /qn /norestart /x {708AEF44-AC54-8421-69E1-9FED4335FF18}
start /wait msiexec /qn /norestart /x {722D6A37-C815-1945-1EE8-091348F3D388}
start /wait msiexec /qn /norestart /x {72CCBA55-F7D7-C56F-7EB6-0A6EE4D3FDC0}
start /wait msiexec /qn /norestart /x {0B807A4C-9C30-813D-A0CA-EAB53CAFE2A5}
start /wait msiexec /qn /norestart /x {75B9B936-BB09-B904-FE0F-52954DB68DAA}
start /wait msiexec /qn /norestart /x {3C66507C-38BA-F30D-8193-49ACC455AC20}
start /wait msiexec /qn /norestart /x {768012C6-AB93-3FDE-C3F6-6C0606948568}
start /wait msiexec /qn /norestart /x {768A7F56-650B-F84F-DF95-EB1926AB5A8F}
start /wait msiexec /qn /norestart /x {76B72651-1E7A-27C4-EAC6-81468BB968C2}
start /wait msiexec /qn /norestart /x {780B8B1A-3BE2-CFB3-3B07-4C5938A4FE3F}
start /wait msiexec /qn /norestart /x {162851FA-B8FC-2DBF-0AB1-432EDFB9E311}
start /wait msiexec /qn /norestart /x {78C07322-CA1D-98B6-14CE-476F125081B2}
start /wait msiexec /qn /norestart /x {78E6BC53-F765-2629-C028-9F3CD49F70D4}
start /wait msiexec /qn /norestart /x {796AC831-1AB8-711F-B770-A33DEA183440}
start /wait msiexec /qn /norestart /x {7A9C67EF-05A8-499F-56A2-C467A4FE6DEE}
start /wait msiexec /qn /norestart /x {7B07D38E-4952-A687-F360-4A177374F644}
start /wait msiexec /qn /norestart /x {7C5B13DA-6A68-86C7-ED29-610CA0F49555}
start /wait msiexec /qn /norestart /x {7CBFE744-729C-268F-CDF7-196E580AFF48}
start /wait msiexec /qn /norestart /x {7CEAD718-2DFC-6AD9-E7D6-68D4668BEF60}
start /wait msiexec /qn /norestart /x {7DA0C5CE-9817-CDB2-F061-F72D0CB6EEB3}
start /wait msiexec /qn /norestart /x {7DB63154-92A4-12AE-364F-DE9C7B459720}
start /wait msiexec /qn /norestart /x {7DD62206-7B6C-E32E-BD11-B49B3B089D16}
start /wait msiexec /qn /norestart /x {7DDB0239-17CA-9552-5665-CA4845EB61B0}
start /wait msiexec /qn /norestart /x {7E5568FC-FF2D-372E-2334-BB5079901F8B}
start /wait msiexec /qn /norestart /x {7E56FAC8-B027-45A4-6723-FCE33A4281AE}
start /wait msiexec /qn /norestart /x {7EEC0824-2AFB-570D-643F-3794B283FF3F}
start /wait msiexec /qn /norestart /x {7F3B7E0B-0575-A74A-9F8F-F5B2349B3093}
start /wait msiexec /qn /norestart /x {7F6F4427-27B9-B8D5-7CF7-0F6BFC2ABCE5}
start /wait msiexec /qn /norestart /x {7F9EA30A-2DD4-81B6-8A08-719EB8683C40}
start /wait msiexec /qn /norestart /x {7FA82763-D04B-A656-159B-BD8847176377}
start /wait msiexec /qn /norestart /x {7FBD3794-1BA2-F0CB-57DD-AED6E6221AC6}
start /wait msiexec /qn /norestart /x {8028C06A-E347-1E20-7DC4-8B18ACC7B130}
start /wait msiexec /qn /norestart /x {80B875EF-04C3-9007-BB8E-1D60F32303BE}
start /wait msiexec /qn /norestart /x {8181B50E-0E33-DE07-AAB2-E71BBBDBF288}
start /wait msiexec /qn /norestart /x {81A84F7A-E4F4-84F2-8DB9-48D303F6D509}
start /wait msiexec /qn /norestart /x {81EDA038-2320-B7E2-4D78-E12C2D55CE75}
start /wait msiexec /qn /norestart /x {81F93FA5-BA87-322F-2166-4D1F0FFE196E}
start /wait msiexec /qn /norestart /x {82796189-9C5E-A314-79B1-E8C32FD5EFC4}
start /wait msiexec /qn /norestart /x {82C2F4FF-B768-12D6-E53D-62C8E17E8662}
start /wait msiexec /qn /norestart /x {832C84C3-ADE3-31EF-9206-43EF77B098D6}
start /wait msiexec /qn /norestart /x {83F8B662-32C3-D1B6-8048-35ED4B94DC87}
start /wait msiexec /qn /norestart /x {843ECB1D-05D7-2A0F-38BF-37891DDF4E34}
start /wait msiexec /qn /norestart /x {853A06A7-1FBA-F42A-3DBE-1E06E8B07510}
start /wait msiexec /qn /norestart /x {8603EC92-211C-738F-0E1E-6A1F528728C5}
start /wait msiexec /qn /norestart /x {86557367-811F-4C6D-05D8-9352FB75EA8D}
start /wait msiexec /qn /norestart /x {8676226D-E23E-8701-778F-7DE0E12DA452}
start /wait msiexec /qn /norestart /x {86C01B84-205E-B98D-11E5-94C5BEDC316A}
start /wait msiexec /qn /norestart /x {86FB6880-0EE2-6EF4-7539-C0BCE7E5FA83}
start /wait msiexec /qn /norestart /x {89A6150B-0CE8-AA44-F24B-FD8DCC058ACC}
start /wait msiexec /qn /norestart /x {89A9984B-F134-3EE4-0790-1FBBF5E7CBF7}
start /wait msiexec /qn /norestart /x {89CA8C53-9CE5-B628-AA17-11F232F1E726}
start /wait msiexec /qn /norestart /x {89D8BC7A-7EDB-782A-10F9-49759C3BBC6E}
start /wait msiexec /qn /norestart /x {8A368DA6-3814-A344-BB1E-C8EB69B865B6}
start /wait msiexec /qn /norestart /x {8A4A81D1-9305-8B3D-1DC5-6DDCFE5C3973}
start /wait msiexec /qn /norestart /x {8A640069-9784-701E-AC8E-84F62C42D1A3}
start /wait msiexec /qn /norestart /x {8AA00ADE-A6AA-18A3-054B-A3B990DC41A0}
start /wait msiexec /qn /norestart /x {8AA0FB20-9A21-56FF-8C4E-86732A070808}
start /wait msiexec /qn /norestart /x {8AEE0BF9-A6A9-98E6-56B3-B14D2510B0D3}
start /wait msiexec /qn /norestart /x {8AF6FD93-A657-8178-79B2-F925318CC1D3}
start /wait msiexec /qn /norestart /x {8B619E05-80B3-20A1-5C1C-FDCDEC394344}
start /wait msiexec /qn /norestart /x {8B8EE744-5D73-3AAC-52FB-43517C1CFA0B}
start /wait msiexec /qn /norestart /x {8BC68157-FCCA-8D16-FCF8-9744A4DD8C0F}
start /wait msiexec /qn /norestart /x {8CAD09D7-D021-1A49-E9D4-A3C07EAB06FC}
start /wait msiexec /qn /norestart /x {8D0957A4-8EE7-E273-0BFC-9B235BEAA41A}
start /wait msiexec /qn /norestart /x {8D2A81D8-AABF-673B-08BE-EF7A80295F14}
start /wait msiexec /qn /norestart /x {8EE5C3FC-369F-5980-8F32-EB62771A43DF}
start /wait msiexec /qn /norestart /x {8EFC331E-07A7-B196-7EA7-549A0CFE07CB}
start /wait msiexec /qn /norestart /x {8FBCF2BD-063E-F861-A82D-F09191E9B7B9}
start /wait msiexec /qn /norestart /x {90BA5BAB-4108-5CC7-8421-00EEAD6D51DF}
start /wait msiexec /qn /norestart /x {9162CD39-6DD5-0624-6CC6-14806B5F9B8F}
start /wait msiexec /qn /norestart /x {91D6CD01-358C-B88A-665E-2C0A59BF8FB1}
start /wait msiexec /qn /norestart /x {91E8293B-C357-D092-8CCB-E19DA083D86C}
start /wait msiexec /qn /norestart /x {923AF325-6007-1AAC-EB63-857A9592A9EC}
start /wait msiexec /qn /norestart /x {93098E43-2743-1551-447F-2699E9591E9C}
start /wait msiexec /qn /norestart /x {93870EF8-B00B-E5CD-00D6-301992AADD0A}
start /wait msiexec /qn /norestart /x {949CCACC-A20F-0FB5-8A8E-C64773CBCF74}
start /wait msiexec /qn /norestart /x {5DAF0789-3F9E-3529-2147-8BAABD8E1C70}
start /wait msiexec /qn /norestart /x {94C1F0A5-2DE9-98A6-8EC7-0DC8EAA9471B}
start /wait msiexec /qn /norestart /x {951B0E3B-C10A-CC53-FE74-3B1BD78A843E}
start /wait msiexec /qn /norestart /x {954680D5-B7C6-E5BA-9B62-09A5AB1F8022}
start /wait msiexec /qn /norestart /x {95749C5B-BC37-41E3-8D39-EEF4C21A2825}
start /wait msiexec /qn /norestart /x {9583AB6F-8E8B-C767-2A8F-09063A8F66AD}
start /wait msiexec /qn /norestart /x {95919D2E-A36B-33DF-5F67-0DFB995750A3}
start /wait msiexec /qn /norestart /x {95B8F519-8C35-9010-A63C-51B3E0EE8D4E}
start /wait msiexec /qn /norestart /x {95CEC285-7B63-3D66-0B3F-EF0D9116375C}
start /wait msiexec /qn /norestart /x {96140ACF-01DD-4DA9-4406-195B6A688ED6}
start /wait msiexec /qn /norestart /x {96FC9301-FC68-BA30-4637-326BA0EF9027}
start /wait msiexec /qn /norestart /x {9739158D-EDED-D628-9865-1460B5A7FAE3}
start /wait msiexec /qn /norestart /x {97E33108-2206-087B-9399-29F5201AAC98}
start /wait msiexec /qn /norestart /x {9809124C-0C4C-2367-7889-1E16D8EF1AAF}
start /wait msiexec /qn /norestart /x {9919B071-F93A-8BFD-6A65-01D560121DC5}
start /wait msiexec /qn /norestart /x {999DEF5D-E7F4-2C35-C579-8C77E80FEA47}
start /wait msiexec /qn /norestart /x {99D7CAA1-BFBD-BBF6-A1C2-572FA1E7B439}
start /wait msiexec /qn /norestart /x {99F4774B-2931-11FD-E747-FD8AD1BEA8AB}
start /wait msiexec /qn /norestart /x {9A11B8B8-97EB-2966-21C4-AF9A675CCD0F}
start /wait msiexec /qn /norestart /x {9A7DA27F-7ABA-8734-A966-6C8752929F3A}
start /wait msiexec /qn /norestart /x {9B3CC933-5EF7-A868-7B74-1A227394566E}
start /wait msiexec /qn /norestart /x {07BCE548-3F4B-7755-56DA-D48ABEA1C495}
start /wait msiexec /qn /norestart /x {9BE678EF-1CDB-8FBE-9DC1-F0289F481C5B}
start /wait msiexec /qn /norestart /x {9D3A232F-57E6-595E-1F77-637AFF16580C}
start /wait msiexec /qn /norestart /x {44BF2578-5228-88C6-DB9E-F55F6CB7DF05}
start /wait msiexec /qn /norestart /x {9D7E098D-5693-D2F9-BBE5-4F5A56032FB4}
start /wait msiexec /qn /norestart /x {9DE88E5C-AA88-FEE6-4D97-55494C5E132B}
start /wait msiexec /qn /norestart /x {9E60B43A-50D6-057F-8EA6-8286CE00A65C}
start /wait msiexec /qn /norestart /x {A15CC4B9-8429-E99D-DCF9-6C7789774D94}
start /wait msiexec /qn /norestart /x {A1BBB15D-7A76-A03F-1593-8237E0BC0F63}
start /wait msiexec /qn /norestart /x {A1F261C8-C63C-346C-C4D9-D497AA425F3C}
start /wait msiexec /qn /norestart /x {A1FB4B86-129B-3C86-8DD8-440B60D50514}
start /wait msiexec /qn /norestart /x {A1FE540C-114E-05D5-3334-1C25C38937C3}
start /wait msiexec /qn /norestart /x {A282AFAB-F862-FF2E-44FB-22AA15E54AAA}
start /wait msiexec /qn /norestart /x {A29C234F-F367-CEA0-1E8E-CB45F11445D8}
start /wait msiexec /qn /norestart /x {A3232358-1FD7-973B-2D09-971C914CA8F8}
start /wait msiexec /qn /norestart /x {A36CBCBC-10B5-EBC0-1219-95830657FF98}
start /wait msiexec /qn /norestart /x {A3703A3B-FDCF-4349-4B2E-A189A2B90B51}
start /wait msiexec /qn /norestart /x {A3806AB7-AB46-7672-A825-F9AE0DE6910A}
start /wait msiexec /qn /norestart /x {A3A79AC5-63B0-F600-73CA-AC66239FA1A5}
start /wait msiexec /qn /norestart /x {A3D1D38D-9C85-7BEB-5AC8-EC2D90E2882A}
start /wait msiexec /qn /norestart /x {A440179F-D169-B9DA-B478-6CE97FDB3D4C}
start /wait msiexec /qn /norestart /x {A60F4402-4CCE-E695-64C6-F0636ACC347F}
start /wait msiexec /qn /norestart /x {A619A488-A4BA-F2A0-72FA-4C484B93DC0F}
start /wait msiexec /qn /norestart /x {A63CF864-8A19-6FB2-2D18-C4AD48D1F161}
start /wait msiexec /qn /norestart /x {A69EAF80-2710-6AD2-8515-2C27CE1B5802}
start /wait msiexec /qn /norestart /x {A6E1EE9D-01DD-82FD-BDBC-193BCEF9FD5C}
start /wait msiexec /qn /norestart /x {A79024ED-1969-334A-1ED6-16753F9DE377}
start /wait msiexec /qn /norestart /x {A7CEA571-43AC-95FE-4F08-22C401FC2824}
start /wait msiexec /qn /norestart /x {A7F248B5-B784-E149-124F-ABE878BC725F}
start /wait msiexec /qn /norestart /x {A826CCC4-C0BA-97B4-F1DB-E68CD45D1133}
start /wait msiexec /qn /norestart /x {A8A759FC-44FD-EBA6-8A18-F2F550DCEC83}
start /wait msiexec /qn /norestart /x {A9F7150E-1426-9043-B97B-BAE039BC32F4}
start /wait msiexec /qn /norestart /x {AB13F192-49FC-A065-F15C-746B10CC43C8}
start /wait msiexec /qn /norestart /x {ABAB6355-CA0E-C46F-A0E6-82F3E19A33A2}
start /wait msiexec /qn /norestart /x {AC53C6FB-C339-42EB-0F2D-746D3FE3B32C}
start /wait msiexec /qn /norestart /x {ACA45C32-8432-2058-BE80-006E7908D804}
start /wait msiexec /qn /norestart /x {ACB0E869-A344-C30E-D0DB-37AE9203917F}
start /wait msiexec /qn /norestart /x {AD3A5061-3579-6600-6171-EEF6460CDDC7}
start /wait msiexec /qn /norestart /x {ADBCAA59-C242-4B31-FF51-354159417118}
start /wait msiexec /qn /norestart /x {ADCFBADB-040C-90AC-A2C5-EB71BAB0738B}
start /wait msiexec /qn /norestart /x {AE548812-D611-608D-61C6-7E40F28573A2}
start /wait msiexec /qn /norestart /x {AE72A9DF-CF98-6D61-841E-32EBD9A2A74E}
start /wait msiexec /qn /norestart /x {AEF3AB2B-0B52-E47E-CA66-55E11D41EA04}
start /wait msiexec /qn /norestart /x {AFA3730E-752C-4961-BE92-6667923C82B3}
start /wait msiexec /qn /norestart /x {B024C404-F156-84BF-621D-629DF71E7456}
start /wait msiexec /qn /norestart /x {B02AF4F2-1B8F-73B2-F097-03F2D0ABE221}
start /wait msiexec /qn /norestart /x {B06A41D0-2F55-3AC0-14E7-2CE108273414}
start /wait msiexec /qn /norestart /x {B079957C-3276-4B9F-DB08-D1CA8C090D9E}
start /wait msiexec /qn /norestart /x {B15E6BBB-6AB4-3B2B-54AE-A1B874FA5469}
start /wait msiexec /qn /norestart /x {B199030E-1082-F3BF-2BB9-0080D72876BD}
start /wait msiexec /qn /norestart /x {B1AEF127-E01A-40D8-3CDC-F4C76BF2A42B}
start /wait msiexec /qn /norestart /x {B32690A6-6C4A-D2E4-B5B7-F5F69241EB9A}
start /wait msiexec /qn /norestart /x {B3A9A482-18D2-431B-EF33-FD62C86D3A86}
start /wait msiexec /qn /norestart /x {B42A8EA7-2A15-2E30-651E-DD47C000301D}
start /wait msiexec /qn /norestart /x {B462A229-4CCA-CD9F-D704-A888D0947DC1}
start /wait msiexec /qn /norestart /x {B51AB07E-912A-B33B-323D-7F87EB15A357}
start /wait msiexec /qn /norestart /x {B68D391C-32C6-798E-C78F-83C1797B162A}
start /wait msiexec /qn /norestart /x {B74F087B-FE65-F00C-A756-538AF2B6B49E}
start /wait msiexec /qn /norestart /x {B7B3C4FA-98FE-FEC7-073E-00677B8F0978}
start /wait msiexec /qn /norestart /x {B7D77E59-3CBF-AEEE-3BB6-73F144CE2FCE}
start /wait msiexec /qn /norestart /x {B898ABBB-4723-84B5-04C4-32A15F9DBD48}
start /wait msiexec /qn /norestart /x {B8B66A0A-F2D1-6C12-28A6-8BE40EF745BA}
start /wait msiexec /qn /norestart /x {B9259945-753D-A9AD-3133-E8900086902A}
start /wait msiexec /qn /norestart /x {B976E52C-93A3-5CD1-FF67-658877850EDD}
start /wait msiexec /qn /norestart /x {BA2A229A-11BB-BC94-A737-A995E56CCA57}
start /wait msiexec /qn /norestart /x {BBB9D421-42DE-4553-0249-6A3E1FD991C8}
start /wait msiexec /qn /norestart /x {BC63AEF9-1367-9F7C-5926-52E56450EDCD}
start /wait msiexec /qn /norestart /x {BDD1D64B-3B7E-8BA4-0197-B307A14DFBA9}
start /wait msiexec /qn /norestart /x {BE2548AA-9E21-F1C2-2FCF-C6F8E7477FAD}
start /wait msiexec /qn /norestart /x {69AE8CC0-E854-5E39-39AB-222D0AE00135}
start /wait msiexec /qn /norestart /x {BEDC570A-C947-D0C8-3014-A1EAA042779D}
start /wait msiexec /qn /norestart /x {BF5509A0-250A-25EA-0C19-61505E9EBA13}
start /wait msiexec /qn /norestart /x {BF7B0100-A146-730D-367D-63BE6797BC81}
start /wait msiexec /qn /norestart /x {C118B9C6-BCE5-629D-F9CF-F61BCAD285D9}
start /wait msiexec /qn /norestart /x {C11D9D08-C2CE-942E-4C18-A47A98D41D3B}
start /wait msiexec /qn /norestart /x {C125CF1B-32B7-A63B-4DBE-72555A1D4730}
start /wait msiexec /qn /norestart /x {C1E2D27F-B363-588E-8859-9EF7F4EBF418}
start /wait msiexec /qn /norestart /x {C223DA1D-4DA3-8F26-CAAD-C193A229F25B}
start /wait msiexec /qn /norestart /x {C2E21D9B-8AD7-588F-9BE9-70054C864D20}
start /wait msiexec /qn /norestart /x {C2EE0EA6-826F-63EA-8751-E2F3714DBA40}
start /wait msiexec /qn /norestart /x {C313DD4D-3961-89F9-7457-443B1F6F28DF}
start /wait msiexec /qn /norestart /x {C317E681-9114-153B-D8C5-F82F74DD33CA}
start /wait msiexec /qn /norestart /x {C38F2DCF-CAA7-3C4C-680B-0DA98E638805}
start /wait msiexec /qn /norestart /x {C39DBC22-001D-46B3-9B19-A181BBA6430D}
start /wait msiexec /qn /norestart /x {C4464620-2BEC-AAE0-9462-7E97362EBC06}
start /wait msiexec /qn /norestart /x {C45FB733-E259-A7FF-5C9F-4FC68CC69365}
start /wait msiexec /qn /norestart /x {C4799AAA-CE52-D2F1-63C8-E6D5106C78E0}
start /wait msiexec /qn /norestart /x {C4EE2BA3-EEA5-9650-86E0-0405ECA5C22C}
start /wait msiexec /qn /norestart /x {C6113C72-D134-F23D-748B-B48C47C9C351}
start /wait msiexec /qn /norestart /x {C6182116-5F2D-9949-B42B-06073E86A98A}
start /wait msiexec /qn /norestart /x {C69EA753-0D3F-E48B-8C98-7F6310DC29B8}
start /wait msiexec /qn /norestart /x {C6A344E9-6D72-560C-4A5E-93E6CA0EDDF7}
start /wait msiexec /qn /norestart /x {C6B40F8E-7785-7585-A166-2D6C10A6ED6E}
start /wait msiexec /qn /norestart /x {C740E6DF-2131-F63F-190D-C47791107254}
start /wait msiexec /qn /norestart /x {C806408C-EFE8-22E3-0E3C-2680B4A31CDF}
start /wait msiexec /qn /norestart /x {C94AAA8B-4152-3F32-E94E-E23503D21EAC}
start /wait msiexec /qn /norestart /x {CB8F9326-774F-8800-DADE-51160D0C5B6F}
start /wait msiexec /qn /norestart /x {CC6BAF1B-A73F-293B-802C-E221044C85BB}
start /wait msiexec /qn /norestart /x {CC6C7F05-AF23-65BD-702D-705EAB723578}
start /wait msiexec /qn /norestart /x {CDC8A707-DD65-E68B-6C0F-1C1F748DC4A8}
start /wait msiexec /qn /norestart /x {CE8CEDD1-FCE6-F13D-D5BE-95D0EEDBC230}
start /wait msiexec /qn /norestart /x {CF78008E-D6BC-399F-0FDB-AF94A39E427A}
start /wait msiexec /qn /norestart /x {D10D4895-3630-B0A7-B575-7D1735E588A7}
start /wait msiexec /qn /norestart /x {D298995C-4824-F44B-3EB7-035BD22B5190}
start /wait msiexec /qn /norestart /x {D42498FB-9561-9575-C2AC-766F737F4ACF}
start /wait msiexec /qn /norestart /x {D5B7F1A3-2CA6-4C5C-EFB6-4AA5772F5310}
start /wait msiexec /qn /norestart /x {D6399FF6-7BDF-F604-E493-76B47CF59C15}
start /wait msiexec /qn /norestart /x {D639E1C4-98AE-E960-5405-09614753781B}
start /wait msiexec /qn /norestart /x {D64B1BF5-0057-BA0E-0A0F-38AE12520BD8}
start /wait msiexec /qn /norestart /x {D69AF3B0-C06C-5F96-D855-DEB079847230}
start /wait msiexec /qn /norestart /x {D6F32A43-1081-717E-1BD6-6168F5CA5035}
start /wait msiexec /qn /norestart /x {D6F71904-5D85-4C9F-2131-B676459618D0}
start /wait msiexec /qn /norestart /x {D7500D20-78EF-EBEE-C1EF-A9FA57297BDB}
start /wait msiexec /qn /norestart /x {D76AC809-CCC1-6198-4970-A63FA5CF7DCB}
start /wait msiexec /qn /norestart /x {D76F5B21-4C2C-9A2B-99ED-D018534C54A4}
start /wait msiexec /qn /norestart /x {D814C606-0199-4A7D-D517-79DC2B3EB7F0}
start /wait msiexec /qn /norestart /x {D889ECAE-D516-363D-0CEC-17F1D2E1AA81}
start /wait msiexec /qn /norestart /x {D8F9F4CB-41A1-CF15-39A2-75F28E0B9991}
start /wait msiexec /qn /norestart /x {D9199DDB-B5EE-BF67-7C85-31790A8B5D85}
start /wait msiexec /qn /norestart /x {D95F9D89-65EF-CD20-4CB3-28293335CAE8}
start /wait msiexec /qn /norestart /x {D963788E-2A2E-0673-A874-1F516B3861B1}
start /wait msiexec /qn /norestart /x {DA05AADA-6407-9E45-7843-45F7393F7A15}
start /wait msiexec /qn /norestart /x {DA675EE2-4C04-9699-0EE2-7EF9FE7AB870}
start /wait msiexec /qn /norestart /x {DAE053AB-7E01-1F2B-F6A2-8BF124CF5266}
start /wait msiexec /qn /norestart /x {DB4BD1F4-C444-3253-F1DC-CD9A11679960}
start /wait msiexec /qn /norestart /x {DC0B9AC0-506D-C0C1-B22F-A2B16FED3D51}
start /wait msiexec /qn /norestart /x {DC47D46D-8874-D83A-6612-9DA3175861B2}
start /wait msiexec /qn /norestart /x {DCD2FE91-FFE7-7F08-F9E1-2CA4BDA00DF4}
start /wait msiexec /qn /norestart /x {DD631F08-F0C4-B2EB-5620-D69E406B0391}
start /wait msiexec /qn /norestart /x {DE6846F8-22E3-A581-E29A-61280F94B333}
start /wait msiexec /qn /norestart /x {DF09BCD9-3556-77A6-8984-1CA95F8E1078}
start /wait msiexec /qn /norestart /x {DF169640-259F-94BA-D667-44DAD367A57B}
start /wait msiexec /qn /norestart /x {DF2567E1-8185-C90C-46EA-45069CB478FF}
start /wait msiexec /qn /norestart /x {DF73BEDD-8A09-A6E2-462B-3BDF398BAFB2}
start /wait msiexec /qn /norestart /x {E06F7C95-4D68-63D9-2231-AA5F8E186FCB}
start /wait msiexec /qn /norestart /x {E0835E27-F4CE-6A1C-7B51-2BCF637F8C23}
start /wait msiexec /qn /norestart /x {E0DE2996-A443-5FEA-30B7-9395E0F3A7CC}
start /wait msiexec /qn /norestart /x {E277DDEB-9395-77FA-E273-A2BD084CEE0C}
start /wait msiexec /qn /norestart /x {E2F52AC2-B925-C18F-E1AE-42FBD46ECAC7}
start /wait msiexec /qn /norestart /x {E3E97F8C-1949-1FE1-D3A2-E2E61172A69B}
start /wait msiexec /qn /norestart /x {E42C0921-20D7-24FA-D61D-8628BD44E551}
start /wait msiexec /qn /norestart /x {E6041920-6D08-2466-E672-A15B040B5004}
start /wait msiexec /qn /norestart /x {E7117563-58FF-5A50-664D-619DA8B5E3BF}
start /wait msiexec /qn /norestart /x {E7284035-606E-00E1-155E-5B9A973C8CFA}
start /wait msiexec /qn /norestart /x {E7535CDD-6B74-9268-C538-88B17FEEF6C0}
start /wait msiexec /qn /norestart /x {E86271D2-CA95-3F92-6E6C-5037008B6006}
start /wait msiexec /qn /norestart /x {E87A8D96-5795-A788-18A2-3BCC20B09E7C}
start /wait msiexec /qn /norestart /x {27097D4A-8146-4B79-D157-4871F5AFBBA2}
start /wait msiexec /qn /norestart /x {E8EE10CF-31E4-CA63-BD94-B0157BBB2444}
start /wait msiexec /qn /norestart /x {D5465517-574A-0325-2248-A9F3C48452B6}
start /wait msiexec /qn /norestart /x {E9463114-898C-7C2A-2C47-E9ABC63F5D43}
start /wait msiexec /qn /norestart /x {E9E50689-AE67-DAB4-310E-36A5BD2599D3}
start /wait msiexec /qn /norestart /x {EA8CC2F2-BC30-141C-92B6-CC870B4B2977}
start /wait msiexec /qn /norestart /x {EB295AF7-C2D1-D911-9E62-F288874B96F4}
start /wait msiexec /qn /norestart /x {EB766D4A-C56C-946D-F74D-43C78FE4521E}
start /wait msiexec /qn /norestart /x {EB9993A8-F5C4-C77A-2426-7AACB5D6946C}
start /wait msiexec /qn /norestart /x {EBC36A11-EEC7-D07B-2A6A-B463057E2956}
start /wait msiexec /qn /norestart /x {EBCD5E4C-F14A-B147-39FE-906F75AC4ACE}
start /wait msiexec /qn /norestart /x {ECBA87BC-CF4F-9ECA-177C-B709BA6D524C}
start /wait msiexec /qn /norestart /x {ECBBBDE9-E3B1-7C26-63C1-6D87309D2644}
start /wait msiexec /qn /norestart /x {ED0D7699-1943-0C29-7465-6530F8DE2DA2}
start /wait msiexec /qn /norestart /x {EDA37E8F-9CB3-6F5F-9E3B-63FF08C18792}
start /wait msiexec /qn /norestart /x {EDA5BB56-AAF4-6889-AD8E-E25A17BD140B}
start /wait msiexec /qn /norestart /x {EDEA3747-D395-AB89-7D3B-E497ACAA6FF3}
start /wait msiexec /qn /norestart /x {EDFA892D-594D-C921-35FF-B6E5CFD2487C}
start /wait msiexec /qn /norestart /x {EE590EC6-FC5D-A092-CD69-05F4FB38AD99}
start /wait msiexec /qn /norestart /x {EE7DF38A-750E-FF7E-44FB-6335009442CB}
start /wait msiexec /qn /norestart /x {EEF14371-2D24-5A2D-0EF2-22010DB4CFA6}
start /wait msiexec /qn /norestart /x {EF1AB451-B478-78E3-F1D0-E3BCB5095C92}
start /wait msiexec /qn /norestart /x {EF317D09-93BA-ABE1-AAF0-25BC2CC6AE5C}
start /wait msiexec /qn /norestart /x {F127DA21-9A8D-1752-588E-12929E6C0F47}
start /wait msiexec /qn /norestart /x {F15D95BE-2F78-9E92-2520-37DB0F685475}
start /wait msiexec /qn /norestart /x {F1DD6B42-08C8-8491-C0F0-2296B6200EBE}
start /wait msiexec /qn /norestart /x {F3688EEB-7274-6C61-E8A6-A91E163B5E04}
start /wait msiexec /qn /norestart /x {F36D6137-FD4C-1F67-7B2A-815BB05BB825}
start /wait msiexec /qn /norestart /x {F3C7FDC9-0B49-A5EC-7987-3C17D7045462}
start /wait msiexec /qn /norestart /x {F421C17C-73AC-CB44-698F-6C125393E863}
start /wait msiexec /qn /norestart /x {F4A6308C-55E6-57DF-95BB-AEEF374B469A}
start /wait msiexec /qn /norestart /x {F4AFE9FD-82C1-AC56-63CA-5667CFF5353F}
start /wait msiexec /qn /norestart /x {F56BBEB1-E982-0A07-0004-1CBC8E5B534E}
start /wait msiexec /qn /norestart /x {F579CC33-014A-C84F-DD0F-C3157B7307DB}
start /wait msiexec /qn /norestart /x {F600ED39-BA0C-A127-EAB7-057DF0A327E0}
start /wait msiexec /qn /norestart /x {F62C60A3-2E8A-8108-2F87-5CDD5A4E3162}
start /wait msiexec /qn /norestart /x {F69A7711-61C3-E5DB-EAFD-10C3216BF237}
start /wait msiexec /qn /norestart /x {F6A55E40-3B9D-8024-EB0A-798E4AA9C744}
start /wait msiexec /qn /norestart /x {F7175D1D-E905-B9C7-93E1-81F57AD160E7}
start /wait msiexec /qn /norestart /x {F726BEEB-A0A7-778A-F55B-51C779C7848E}
start /wait msiexec /qn /norestart /x {F7904AF8-BA7C-CF33-538F-CFB4B012FB3A}
start /wait msiexec /qn /norestart /x {F7C43A36-54DF-4B6A-8198-B616B32AAFB1}
start /wait msiexec /qn /norestart /x {F84C1DC6-4B39-1A34-AD6E-A6EE49A3DD78}
start /wait msiexec /qn /norestart /x {F8FBF4C7-5ADA-66B1-6509-09E05C257963}
start /wait msiexec /qn /norestart /x {F9048FF8-45E1-8BD4-0161-468F777BA2B4}
start /wait msiexec /qn /norestart /x {F92E6F47-C50C-7115-4040-EDBEB34023BD}
start /wait msiexec /qn /norestart /x {F93C6125-3F24-0EBA-4CC6-378AE2560861}
start /wait msiexec /qn /norestart /x {685202C9-9DA0-9AEA-51C8-7A700CFCB175}
start /wait msiexec /qn /norestart /x {F955A735-0DD7-8808-7881-B2ADAD0203DA}
start /wait msiexec /qn /norestart /x {FA957EDD-031D-D6EF-BEC5-EA7544D4AD0B}
start /wait msiexec /qn /norestart /x {FB3F7ACE-1633-5A41-250A-FA00E95EE402}
start /wait msiexec /qn /norestart /x {FBE81DAC-D8EA-1B8B-C521-7FA39E83B515}
start /wait msiexec /qn /norestart /x {FC00DD7E-8EBD-DAF9-B345-6643818AC242}
start /wait msiexec /qn /norestart /x {FC18709C-C93F-6BF7-904A-43B0125725ED}
start /wait msiexec /qn /norestart /x {FC1DCE80-2E83-A938-1450-A846B851E264}
start /wait msiexec /qn /norestart /x {FD9C3389-A508-8F73-3B26-BDEB63671A3C}
start /wait msiexec /qn /norestart /x {FDD69799-37B2-9ACE-F70C-ABD1F96FD04C}
start /wait msiexec /qn /norestart /x {FDF2FE33-426D-45C2-4E70-76C162F1B790}
start /wait msiexec /qn /norestart /x {FE1A4EA6-D680-DB6D-62CC-8C88CF85C1C5}
start /wait msiexec /qn /norestart /x {FE59DF1D-F3DC-2B06-DF69-257890B220E3}
start /wait msiexec /qn /norestart /x {FEFF81BF-B911-6755-FBDE-09547BDFD0A2}
start /wait msiexec /qn /norestart /x {FF10AC4D-3349-99DA-3E58-5197CEA1D833}
start /wait msiexec /qn /norestart /x {FFCF34B9-A0B1-2E2B-7D7E-8FAB4A781CC9}
start /wait msiexec /qn /norestart /x {37DBC990-C514-3821-D6FB-12E0745AA990}
start /wait msiexec /qn /norestart /x {D9CBA021-DB41-9736-923F-52E3E426912D}
start /wait msiexec /qn /norestart /x {31BC0B51-0676-A531-3940-1818B609EEA7}
start /wait msiexec /qn /norestart /x {504819D1-3C0A-2695-0007-BBDFA5936D68}
start /wait msiexec /qn /norestart /x {69DF4822-9B16-CE04-7587-22E09FB5FD1D}
start /wait msiexec /qn /norestart /x {968C0E92-6DA9-5784-9A0B-1061D0CB2C14}
start /wait msiexec /qn /norestart /x {9DB45EC2-90E7-642D-7CF9-5AC2FBDC14F7}
start /wait msiexec /qn /norestart /x {AA0E1433-8F16-AA01-E8E9-E6408579D0D8}
start /wait msiexec /qn /norestart /x {11BC8F83-7260-65EB-3E0A-FA7AC894B42D}

:: CITIZEN bloatware (printer)
start /wait msiexec /qn /norestart /x {546D97C7-9DF6-4A2D-BE02-2C0B25FFE1E3}
start /wait msiexec /qn /norestart /x {39688AE1-0398-4133-942C-EECA9BBD64CC}

:: Clickfree // Disabled by /u/kamakaze_chickn for Tron
::start /wait msiexec /qn /norestart /x {1EB9B986-CECA-4E05-B454-C9343EE9DDE7}

:: Comcast Desktop Software (v1.2.0.9) 23
start /wait msiexec /qn /norestart /x {CEF7211D-CE3A-44C4-B321-D84A2099AE94}

:: Connect To Tech-Support (malware)
start /wait msiexec /qn /norestart /x {A22B8513-EA8C-46A1-9735-F5BE971C368D}

:: Consumer In-Home Service Agreement
start /wait msiexec /qn /norestart /x {F7DA7A20-8EC4-4960-95E5-5531D518B97E}

:: Corel DVD MovieFactory // Photo Album // WinDVD // Direct DiscRecorder
start /wait msiexec /qn /norestart /x {1DF03ECE-6AF4-414E-B118-C316F151A9A2}
start /wait msiexec /qn /norestart /x {5C1F18D2-F6B7-4242-B803-B5A78648185D}
start /wait msiexec /qn /norestart /x {50F68032-B5B7-4513-9116-C978DBD8F27A}
start /wait msiexec /qn /norestart /x {FC09380E-74BE-41F5-8353-E97113969040}

:: Coupon Network 12.10.2.4058
start /wait msiexec /qn /norestart /x {6B66E18F-BC5C-47AC-A66C-9F0814A8A0EB}

:: Create Recovery Media 1.20.0.00
start /wait msiexec /qn /norestart /x {C15914CB-2F62-4A58-86C1-69F90A2AA5EE}

:: CyberLink Blu-ray Disc Suite; CyberLink MediaEspresso shares this GUID
start /wait msiexec /qn /norestart /x {1FBF6C24-C1FD-4101-A42B-0C564F9E8E79}

:: CyberLink MakeDisc
start /wait msiexec /qn /norestart /x {0456ebd7-5f67-4ab6-852e-63781e3f389c}

:: CyberLink Media Suite 10
start /wait msiexec /qn /norestart /x {8DE5BF1E-6857-47C9-84FC-3DADF459493F}

:: CyberLink MediaShow, MediaSmart DVD/Photo/Video
start /wait msiexec /qn /norestart /x {E3739848-5329-48E3-8D28-5BBD6E8BE384}
start /wait msiexec /qn /norestart /x {D12E3E7F-1B13-4933-A915-16C7DD37A095}
start /wait msiexec /qn /norestart /x {80E158EA-7181-40FE-A701-301CE6BE64AB}
start /wait msiexec /qn /norestart /x {6DAF8CDC-9B04-413B-A0F2-BCC13CF8A5BF}

:: CyberLink Power2Go
start /wait msiexec /qn /norestart /x {2A87D48D-3FDF-41fd-97CD-A1E370EFFFE2}
start /wait msiexec /qn /norestart /x {40BF1E83-20EB-11D8-97C5-0009C5020658}
start /wait msiexec /qn /norestart /x {34D95765-2D5A-470F-A39F-BC9DEAAAF04F}
start /wait msiexec /qn /norestart /x {40BF1E83-20EB-11D8-97C5-0009C5020658}

:: CyberLink PowerDVD // Disabled by /u/kamakaze_chickn for Tron
::start /wait msiexec /qn /norestart /x {D6E853EC-8960-4D44-AF03-7361BB93227C}
::start /wait msiexec /qn /norestart /x {DEC235ED-58A4-4517-A278-C41E8DAEAB3B}
::start /wait msiexec /qn /norestart /x {A8516AC9-AAF1-47F9-9766-03E2D4CDBCF8}
::start /wait msiexec /qn /norestart /x {CB099890-1D5F-11D5-9EA9-0050BAE317E1}
::start /wait msiexec /qn /norestart /x {2BF2E31F-B8BB-40A7-B650-98D28E0F7D47}
::start /wait msiexec /qn /norestart /x {B46BEA36-0B71-4A4E-AE41-87241643FA0A}

:: CyberLink PowerDirector // PowerProducer // PowerRecover
start /wait msiexec /qn /norestart /x {607679B0-485D-45B0-A5FA-7464130FE570}
start /wait msiexec /qn /norestart /x {B0B4F6D2-F2AE-451A-9496-6F2F6A897B32}
start /wait msiexec /qn /norestart /x {F232C87C-6E92-4775-8210-DFE90B7777D9}
start /wait msiexec /qn /norestart /x {B7A0CE06-068E-11D6-97FD-0050BACBF861}

:: CyberLink PhotoDirector // PhotoNow // PhotoShowExpress // PictureMover
start /wait msiexec /qn /norestart /x {5A454EC5-217A-42a5-8CE1-2DDEC4E70E01}
start /wait msiexec /qn /norestart /x {39337565-330E-4ab6-A9AE-AC81E0720B10}
start /wait msiexec /qn /norestart /x {FC6C7107-7D72-41A1-A031-3CE751159BAB}
start /wait msiexec /qn /norestart /x {4862344A-A39C-4897-ACD4-A1BED5163C5A}
start /wait msiexec /qn /norestart /x {D36DD326-7280-11D8-97C8-000129760CBE}
start /wait msiexec /qn /norestart /x {3250260C-7A95-4632-893B-89657EB5545B}
start /wait msiexec /qn /norestart /x {1896E712-2B3D-45eb-BCE9-542742A51032}

:: CyberLink DX
start /wait msiexec /qn /norestart /x {6811CAA0-BF12-11D4-9EA1-0050BAE317E1}

:: CyberLink PowerDirector 12
start /wait msiexec /qn /norestart /x {E1646825-D391-42A0-93AA-27FA810DA093}

:: CyberLink Power Media Player 14
start /wait msiexec /qn /norestart /x {32C8E300-BDB4-4398-92C2-E9B7D8A233DB}

:: CyberLink LabelPrint
start /wait msiexec /qn /norestart /x {C59C179C-668D-49A9-B6EA-0121CCFC1243}

:: CyberLink YouCam
start /wait msiexec /qn /norestart /x {A9CEDD6E-4792-493e-BB35-D86D2E188A5A}
start /wait msiexec /qn /norestart /x {A81EB5BC-F764-308A-B979-0F8F078DAB29}
start /wait msiexec /qn /norestart /x {01FB4998-33C4-4431-85ED-079E3EEFE75D}

:: Dashlane Upgrade Service
start /wait msiexec /qn /norestart /x {2B89F58C-32F7-46EC-A448-AECDF1F22B7B}

:: Dell Access
start /wait msiexec /qn /norestart /x {F839C6BD-E92E-48FA-9CE6-7BFAF94F7096}

:: Dell Backup and Recovery Manager
start /wait msiexec /qn /norestart /x {975DFE7C-8E56-45BC-A329-401E6B1F8102}
start /wait msiexec /qn /norestart /x {50B4B603-A4C6-4739-AE96-6C76A0F8A388}
start /wait msiexec /qn /norestart /x {731B0E4D-F4C7-450C-95B0-E1A3176B1C75}
start /wait msiexec /qn /norestart /x {AB2FDE4F-6BED-4E9E-B676-3DCCEBB1FBFE}
start /wait msiexec /qn /norestart /x {43CAC9A1-1993-4F65-9096-7C9AFC2BBF54}
start /wait msiexec /qn /norestart /x {97308CC9-FAED-4A1C-9593-64B2F1FD852D}
start /wait msiexec /qn /norestart /x {4DEF2722-7EB8-4C5F-8F0A-0295A310002A}
start /wait msiexec /qn /norestart /x {AE9EB677-66F4-40C0-9269-35067D8C555B}
if exist %SystemDrive%\dell\dbrm rd /s /q %SystemDrive%\dell\dbrm

:: Dell Best of Web 1.00.0000
start /wait msiexec /qn /norestart /x {BC8233D8-59BA-4D40-92B9-4FDE7452AA8B}

:: Dell CinePlayer 3
start /wait msiexec /qn /norestart /x {39A6407B-DD99-410D-8EA2-280788F8423B}

:: Dell Client System Update (various versions)
start /wait msiexec /qn /norestart /x {2B25AEE3-D191-4735-870E-28743D727ED8}
start /wait msiexec /qn /norestart /x {03A9F528-A754-460F-B2C1-AC125A147114}

:: Dell Command | Power Manager 2.0.0
start /wait msiexec /qn /norestart /x {DB82968B-57A4-4397-81A5-ECAB21B5DFCD}

:: Dell Command | Update 2.0.0
start /wait msiexec /qn /norestart /x {E45D7941-F3F0-4E8E-AD55-DCE2FE0AE6D8}

:: Dell Control Point (various versions)
start /wait msiexec /qn /norestart /x {0DB0EA38-E806-44ED-A892-489F2E305080}
start /wait msiexec /qn /norestart /x {2E55EEFD-2162-4A7D-9158-EDB0305603A6}
start /wait msiexec /qn /norestart /x {74F7662C-B1DB-489E-A8AC-07A06B24978B}
start /wait msiexec /qn /norestart /x {24F2AD94-CC1B-4294-B184-D4D31A3186A7}
start /wait msiexec /qn /norestart /x {4B3230C5-F069-416B-9169-1B84A216ED6A}

:: Dell ControlVault (various versions and components); this is Dell-branded biometric software
start /wait msiexec /qn /norestart /x {693A23FB-F28B-4F7A-A720-4C1263F97F43}
start /wait msiexec /qn /norestart /x {5905F42D-3F5F-4916-ADA6-94A3646AEE76}
start /wait msiexec /qn /norestart /x {54C04D53-C3C3-46EA-A75F-7AFF4BEB727C}
start /wait msiexec /qn /norestart /x {FEFDCDCF-C49C-45D0-AAF8-5345858ADEC7}
start /wait msiexec /qn /norestart /x {6A7F4379-B2EE-444F-AC4A-C5379B1CF95E}
start /wait msiexec /qn /norestart /x {815D96BA-2FC6-4F61-9BE3-2CFE446E8ECF}
start /wait msiexec /qn /norestart /x {90B2EE35-59D0-4A1F-B125-9F678D46A955}
start /wait msiexec /qn /norestart /x {8B5D0146-5187-40F5-9DD8-15DAF2D11902}

:: Dell Customer Connect
start /wait msiexec /qn /norestart /x {FCD9CD52-7222-4672-94A0-A722BA702FD0}
start /wait msiexec /qn /norestart /x {99E581C6-471C-46CA-989E-3B17EB7E3F27}

:: Dell Data Protection (various versions and components)
start /wait msiexec /qn /norestart /x {CCDF8E78-6102-470A-BBE4-9AF13694C716}
start /wait msiexec /qn /norestart /x {04566294-A6B6-4462-9721-031073EB3694}
start /wait msiexec /qn /norestart /x {7FA89EC8-023D-4AEA-94E2-32820FBBDC44}
start /wait msiexec /qn /norestart /x {AC474F86-9A17-4BCB-8B15-11ABFD5B7F95}
start /wait msiexec /qn /norestart /x {05FDD00D-1C45-44D1-AB3F-C24D45C39457}

:: Dell Data Services 1.2.7.0
start /wait msiexec /qn /norestart /x {812AA6D3-5BEB-4577-88B1-00998B91AB41}

:: Dell Data Vault 1.1.0.6
start /wait msiexec /qn /norestart /x {2B2B45B1-3CA0-4F8D-BBB3-AC77ED46A0FE}

:: Dell DataSafe Online (various versions)
start /wait msiexec /qn /norestart /x {11F1920A-56A2-4642-B6E0-3B31A12C9288}

:: Dell Digital Content Portal
start /wait msiexec /qn /norestart /x {C7FB1A71-D808-4CD2-997D-837B39EA7EB0}

:: Dell Digital Delivery (various versions)
start /wait msiexec /qn /norestart /x {2A0F2CC5-3065-492C-8380-B03AA7106B1A}
start /wait msiexec /qn /norestart /x {4688EB75-28E2-4731-9BCB-55E624F7CD45}
start /wait msiexec /qn /norestart /x {B7FB9195-E9FC-4316-930E-D799D5D712F7}
start /wait msiexec /qn /norestart /x {D605CD24-103D-4DB6-B572-653851213C46}
start /wait msiexec /qn /norestart /x {B9CD9EC9-2566-4064-8599-4A3B742946F4}

:: Dell Dock 1.0.0
start /wait msiexec /qn /norestart /x {F336F89D-8C5A-432C-8EA9-DA19377AD591}

:: Dell Dock 2
start /wait msiexec /qn /norestart /x {C39A4E1F-9AF1-4FE1-A80E-A5B867FABB42}

:: Dell Driver Reset Tool 1.02.0000
start /wait msiexec /qn /norestart /x {55E79447-F6B0-46CB-9F58-F82DAC9C2286}

:: Dell Edoc Viewer
start /wait msiexec /qn /norestart /x {8EBA8727-ADC2-477B-9D9A-1A1836BE4E05}

:: Dell Feature Enhancement Pack 2.2.1
start /wait msiexec /qn /norestart /x {98CB551E-EDB1-4535-82A6-E3258597F64E}

:: Dell Foundation Services (various versions)
start /wait msiexec /qn /norestart /x {8E80AF23-17B4-4611-B28E-68A114B23488}
start /wait msiexec /qn /norestart /x {CF5E8D60-A1FD-4BF2-9EDD-EA8C05F784A9}
start /wait msiexec /qn /norestart /x {91E2DDB6-DC13-4585-8A10-04C6AB6F87A4}

:: Dell Games (Dell-branded WildTangent games)
:: These two FOR loops should catch ALL Dell games, in theory at least
:: Basically, loop through the games subdirectory, and if an "Uninstall.exe" exists ANYWHERE, run it with the /silent flag
for /r "%ProgramFiles%\WildTangent\Dell Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )
for /r "%ProgramFiles(x86)%\WildTangent\Dell Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )

:: Dell Getting Started Guide 1.00.0000
start /wait msiexec /qn /norestart /x {7B7D73E7-79D5-4133-AB7A-E27BB5F64725}

:: Dell Help and Support
start /wait msiexec /qn /norestart /x {A00269ED-FD88-4907-834B-60B70DCE82C5}
start /wait msiexec /qn /norestart /x {E474CE8D-1D47-4C68-8845-F5DA9DE26D72}

:: Dell Help and Support Customization (hidden)
start /wait msiexec /qn /norestart /x {4E5563B6-DE0A-4F3B-A5D6-15789FD12D9B}

:: Dell Home Systems Service Agreement 2.0.0
start /wait msiexec /qn /norestart /x {AB2CED80-0F16-476F-8769-30A363562F16}

:: Dell _IsIcoRes.exe
start /wait msiexec /qn /norestart /x {CD31E63D-47FD-491C-8117-CF201D0AFAB5}

:: Dell mDrWifi
start /wait msiexec /qn /norestart /x {90CC4231-94AC-45CD-991A-0253BFAC0650}
start /wait msiexec /qn /norestart /x {A0F925BF-5C55-44C2-A4E7-5A4C59791C29}

:: Dell Mobile Broadband Utility 3.00.23.003
start /wait msiexec /qn /norestart /x {C8B8C745-D288-41B4-9512-01E397F77449}

:: Dell Mobile Broadband Utility 3.00.96.007
start /wait msiexec /qn /norestart /x {AA2AFD30-F80C-401C-9B85-03A05A2F7EFD}

:: Dell MusicStage 1.4.162.0
start /wait msiexec /qn /norestart /x {EC542D5D-B608-4145-A8F7-749C02BE6D94}

:: Dell Music, Photos & Videos Launcher
start /wait msiexec /qn /norestart /x {E4761915-C73A-4ef4-BB14-E380AB1D1CFB}

:: Dell My Dell Client Framework
start /wait msiexec /qn /norestart /x {9CC89556-3578-48DD-8408-04E66EBEF401}

:: Dell Open Print Driver 1.31.7527.0
start /wait msiexec /qn /norestart /x {B96348BD-6B0D-42E3-80B1-FA6718067BFE}

:: Dell PhotoStage 1.5.0.30
start /wait msiexec /qn /norestart /x {E3BFEE55-39E2-4BE0-B966-89FE583822C1}

:: Dell Power Manager
start /wait msiexec /qn /norestart /x {E4335E82-17B3-460F-9E70-39D9BC269DB3}
start /wait msiexec /qn /norestart /x {BF1F9D57-57A1-4E87-A8E8-41F2B2AD6F53}

:: Dell Product Registration
start /wait msiexec /qn /norestart /x {287348C8-8B47-4C36-AF28-441A3B7D8722}
start /wait msiexec /qn /norestart /x {236F9DDF-B9BA-420A-9775-FBBA7B06475B}
start /wait msiexec /qn /norestart /x {93870CD7-7A8D-4880-9BEF-95382F44E848}
start /wait msiexec /qn /norestart /x {2A0F2CC5-3065-492C-8380-B03AA7106B1A}
start /wait msiexec /qn /norestart /x {B96204EB-3051-4B4F-9534-ED13FE7095D1}

:: Dell Protected Workspace 2.3.15835
start /wait msiexec /qn /norestart /x {DDDAF4A7-8B7D-4088-AECC-6F50E594B4F5}

:: Dell Repository Manager v1.9.0 1.9.0
start /wait msiexec /qn /norestart /x {2117290E-B7AD-4ACF-AEA4-3DE91A1063AF}

:: Dell Resource CD 1.00.0000
start /wait msiexec /qn /norestart /x {F6CB42B9-F033-4152-8813-FF11DA8E6A78}

:: Dell Security Innovation TSS 2.1.42
start /wait msiexec /qn /norestart /x {524C544D-2D53-5000-76A7-A758B70C2201}

:: Dell Solution Center 1.00.0000
start /wait msiexec /qn /norestart /x {11DB380B-48CF-46EA-8B03-51874E2733C9}

:: Dell Support Center (various versions)
start /wait msiexec /qn /norestart /x {E2CAA395-66B3-4772-85E3-6134DBAB244E}
start /wait msiexec /qn /norestart /x {644B991F-B109-4360-9DA3-40CDAD13961C}

:: Dell SupportAssistAgent 1.1.0.47
start /wait msiexec /qn /norestart /x {284D3B99-E8F5-4411-A7DD-7072EFCF3A46}

:: Dell System E-support Tool 2.2
start /wait msiexec /qn /norestart /x {13766F76-6C8C-4E57-A9F3-3212D1C6E0D1}

:: Dell System Manager (various versions)
start /wait msiexec /qn /norestart /x {0B72160B-9F67-47C0-858F-5A0074162148}
start /wait msiexec /qn /norestart /x {C73A3942-84C8-4597-9F9B-EE227DCBA758}

:: Dell System Restore 2.00.0000
start /wait msiexec /qn /norestart /x {7358D71A-DEFE-47DB-910A-B1CAC9C9D7C1}

:: Dell Trusted Drive Manager
start /wait msiexec /qn /norestart /x {6AC87FB3-ACFC-4416-890C-8976D5A9B371}
start /wait msiexec /qn /norestart /x {A093D83F-429A-4AB2-A0CD-1F7E9C7B764A}
start /wait msiexec /qn /norestart /x {236EBEF4-8DE5-4E0E-8FD0-27D94F772FF0}
start /wait msiexec /qn /norestart /x {98E68EAC-A3B3-4ECA-8110-84CBCFFF2878}
start /wait msiexec /qn /norestart /x {DDD6BE8C-9AFA-48F1-A6AE-3BD596E2EB0B}

:: Dell Unified Wireless Suite 1.0.158
start /wait msiexec /qn /norestart /x {D850CB7E-72BC-4510-BA4F-48932BFAB295}

:: Dell Update 1.7.1015.0
start /wait msiexec /qn /norestart /x {DA24AEC5-5BD8-4248-AADE-16BB620E4E62}

:: Dell_DTM_X64 1.0.0.6
start /wait msiexec /qn /norestart /x {FF79C05D-1E19-4FE5-BDD4-AAAFC28DDDDD}

:: Dell_SWEQ 1.0.0.4
start /wait msiexec /qn /norestart /x {E95696A0-D7C9-4BEC-971E-FC2995DA2055}

:: DellAccess (various versions)
start /wait msiexec /qn /norestart /x {20A4AA32-B3FF-4A0B-853C-ACDDCD6CB344}
start /wait msiexec /qn /norestart /x {DC14FF2A-EB53-4093-847D-9314E9555BB6}

:: Dell Client System Update
start /wait msiexec /qn /norestart /x {69093D49-3DD1-4FB5-A378-0D4DB4CF86EA}

:: Dell ControlPoint
start /wait msiexec /qn /norestart /x {A9C61491-EF2F-4ED8-8E10-FB33E3C6B55A}

:: Dell ControlVault Host Components Installer
start /wait msiexec /qn /norestart /x {5A26B7C0-55B1-4DA8-A693-E51380497A5E}

:: Dell Customer Connect
start /wait msiexec /qn /norestart /x {124DE80C-9BFE-4D04-A8D9-69C5019DEEBF}

:: Dell Datasafe Online
start /wait msiexec /qn /norestart /x {7EC66A95-AC2D-4127-940B-0445A526AB2F}

:: Dell Digital Delivery
start /wait msiexec /qn /norestart /x {AB7F2792-2ED1-4C5C-9F28-680E5110BF72}

:: Dell Dock
start /wait msiexec /qn /norestart /x {E60B7350-EA5F-41E0-9D6F-E508781E36D2}

:: Dell DVDSentry
start /wait msiexec /qn /norestart /x {5B54DDC3-0ACC-4722-9C23-C3F07AF4825D}

:: Dell Embassy Suite
start /wait msiexec /qn /norestart /x {53333479-6A52-4816-8497-5C52B67ED339}
start /wait msiexec /qn /norestart /x {5F5CBF39-BD29-43C8-B63A-B9758F0FD090}
start /wait msiexec /qn /norestart /x {7EC46A4C-E659-418E-A65A-BD7FC82D4C48}
start /wait msiexec /qn /norestart /x {8055B6B2-4BF1-4A0B-849C-941EA5A16044}
start /wait msiexec /qn /norestart /x {131A2659-99A9-4A89-B012-22A898EAE9DA}

:: Dell Feature Enhancement Pack
start /wait msiexec /qn /norestart /x {992D1CE7-A20F-4AB0-9D9D-AFC3418844DA}

:: Dell Getting Started Guide
start /wait msiexec /qn /norestart /x {7DB9F1E5-9ACB-410D-A7DC-7A3D023CE045}

:: Dell misc help and support GUIDs
start /wait msiexec /qn /norestart /x {9EDA3DD1-130D-4EE1-A3D2-5A3D795CC8C9}

:: Dell Power Manager
start /wait msiexec /qn /norestart /x {CAC1E444-ECC4-4FF8-B328-5E547FD608F8}

:: Dell Protected Workspace
wmic product where name="Dell Protected Workspace" call uninstall /nointeractive 2>nul

:: Dell QuickSet32 and QuickSet64 // Disabled by /u/kamakaze_chickn for Tron; hotkey drivers
::start /wait msiexec /qn /norestart /x {ED2A3C11-3EA8-4380-B59C-F2C1832731B0}
::start /wait msiexec /qn /norestart /x {C4972073-2BFE-475D-8441-564EA97DA161}

:: Dell Resource CD
start /wait msiexec /qn /norestart /x {42929F0F-CE14-47AF-9FC7-FF297A603021}

:: Dell Support Center
start /wait msiexec /qn /norestart /x {0090A87C-3E0E-43D4-AA71-A71B06563A4A}

:: :: Dell VideoStage
start /wait msiexec /qn /norestart /x {DCE0E79A-B9AC-41AC-98C1-7EF0538BCA7F}

:: Dell Wave Crypto Runtime // Infrastructure Installer // Support Software Installer // ESC Home Page Plugin // Preboot Manager // Private Information Manager
start /wait msiexec /qn /norestart /x {8A2EF9A3-F1A8-4160-8C7D-4CADA7883BD1}
start /wait msiexec /qn /norestart /x {30C2392C-C7D6-4FE2-9617-05D2C6E9D3EE}
start /wait msiexec /qn /norestart /x {14CFC674-CD4F-4BE5-8B68-07BA3FE941FF}
start /wait msiexec /qn /norestart /x {777FF553-493D-4068-BAC7-EE2D73DB7434}
start /wait msiexec /qn /norestart /x {07D618CD-B016-438A-ADC9-A75BD23F85CE}
start /wait msiexec /qn /norestart /x {5F160A36-29D0-4AE0-986C-671A564BC0D4}
start /wait msiexec /qn /norestart /x {90DB5C39-360F-4187-9D56-E3B013CEEF73}
start /wait msiexec /qn /norestart /x {86A9BBDF-9B6D-4E3D-810E-23C9079C6217}
start /wait msiexec /qn /norestart /x {5FDA8F6A-E87C-484B-BDE2-12C1BE199149}
start /wait msiexec /qn /norestart /x {67154CF5-2C33-41C2-A9F2-A4FBC29482AD}
start /wait msiexec /qn /norestart /x {29D07FB4-A026-4E1F-B9A2-8C9EC0E2FEBB}
start /wait msiexec /qn /norestart /x {083CE5FA-E750-4594-B8D1-13994B297A02}
start /wait msiexec /qn /norestart /x {8C0600A3-E772-4FC8-A67D-ED110E69665C}
start /wait msiexec /qn /norestart /x {A8991BF1-A3DC-4110-836A-C467AF9B71E8}
start /wait msiexec /qn /norestart /x {79B520D5-CE72-4661-A054-804BC3412516}
start /wait msiexec /qn /norestart /x {3C19BFFB-0393-43E7-A48D-6B8374D7E54E}
start /wait msiexec /qn /norestart /x {B330548B-1EBE-429C-AA47-FC12748FA18F}
start /wait msiexec /qn /norestart /x {3A6BE9F4-5FC8-44BB-BE7B-32A29607FEF6}
start /wait msiexec /qn /norestart /x {0149ECF0-D825-4892-A468-065F2009328A}
start /wait msiexec /qn /norestart /x {CA2F6FAD-D8CD-42C1-B04D-6E5B1B1CFDCC}
start /wait msiexec /qn /norestart /x {0B0A2153-58A6-4244-B458-25EDF5FCD809}

:: Desktop Doctor 2.5.5
start /wait msiexec /qn /norestart /x {D87149B3-7A1D-4548-9CBF-032B791E5908}

:: DIBS 1.7.0
start /wait msiexec /qn /norestart /x {2EA870FA-585F-4187-903D-CB9FFD21E2E0}

:: Dolby Advanced Audio // Home Theater
start /wait msiexec /qn /norestart /x {B26438B4-BF51-49C3-9567-7F14A5E40CB9}
start /wait msiexec /qn /norestart /x {936CFA73-585F-4F5E-AB62-1350FE16E5FC}
start /wait msiexec /qn /norestart /x {7E3D8FA1-6092-469A-955B-68FC4A2C67CA}

:: Download Windows Universal Tools 14.0.22823
start /wait msiexec /qn /norestart /x {7C361160-7ADC-46CE-AFDC-D10C6EADD032}

:: Driver Detective 8.0.1
start /wait msiexec /qn /norestart /x {177CD779-4EEC-43C5-8DEA-4E0EC103624B}

:: Driver Manager 8.1
start /wait msiexec /qn /norestart /x {27F1E086-5691-4EB8-8BA1-5CBA87D67EB5}

:: Dropbox Setup // shared with Dropbox Update Helper
start /wait msiexec /qn /norestart /x {099218A5-A723-43DC-8DB5-6173656A1E94}

:: Dropbox Update Helper 1.3.27.33
start /wait msiexec /qn /norestart /x {4640FDE1-B83A-4376-84ED-86F86BEE2D41}

:: DTS Sound
start /wait msiexec /qn /norestart /x {793B70D2-41E9-46AB-9DDC-B34C99D07DB5}
start /wait msiexec /qn /norestart /x {F8EB8FFC-C535-49A1-A84D-CC75CB2D6ADA}
start /wait msiexec /qn /norestart /x {1BDEB6E2-6706-4132-A5D3-99190C6BECD8}
start /wait msiexec /qn /norestart /x {2DFA9084-CEB3-4A48-B9F7-9038FEF1B8F4}
start /wait msiexec /qn /norestart /x {4E91898E-4DED-4B17-94F0-FA61AACCDEB0}

:: EA Download Manager (deprecated, replaced with Origin)
start /wait msiexec /qn /norestart /x {EF7E931D-DC84-471B-8DB6-A83358095474}

:: eBay Worldwide
start /wait msiexec /qn /norestart /x {8549CF08-D327-4B73-9036-75564C0BBCFC}
start /wait msiexec /qn /norestart /x {91589413-6675-4C27-8AFC-EFB9103B90A5}
start /wait msiexec /qn /norestart /x {3DC26EA7-03E3-4353-9424-EEB7A34A7504}

:: Energy Star // Energy Star Digital Logo
start /wait msiexec /qn /norestart /x {465CA2B6-98AF-4E77-BE22-A908C34BB9EC}
start /wait msiexec /qn /norestart /x {51CB3204-2129-4D74-8AF8-3AEB52793969}
start /wait msiexec /qn /norestart /x {AC768037-7079-4658-AC24-2897650E0ABE}
start /wait msiexec /qn /norestart /x {BD1A34C9-4764-4F79-AE1F-112F8C89D3D4}

:: Epson Customer Participation
start /wait msiexec /qn /norestart /x {814FA673-A085-403C-9545-747FC1495069}
start /wait msiexec /qn /norestart /x {4BB82AD9-0CF6-4E14-BD75-C1AB657C2914}

:: Epson Event Manager
start /wait msiexec /qn /norestart /x {3F29268A-F53A-4387-9F2B-E9368A823178}
start /wait msiexec /qn /norestart /x {2970697F-2A11-4588-8B7F-97322D1CCF3C}
start /wait msiexec /qn /norestart /x {03B8AA32-F23C-4178-B8E6-09ECD07EAA47}
start /wait msiexec /qn /norestart /x {10144CFE-D76C-4CFA-81A1-37A1642349A3}

:: Epson Software Updater
start /wait msiexec /qn /norestart /x {A3B308B9-BE96-4334-816F-3D82B19A7DE2}
start /wait msiexec /qn /norestart /x {B307472F-7BD9-4040-9255-CE6D6A1196A3}
start /wait msiexec /qn /norestart /x {E1BAD1BA-C0E8-4018-9281-E7D2C6B07474}
start /wait msiexec /qn /norestart /x {FA7EE274-7370-43B7-9A45-A39B17CCCDC5}

:: ESC Home Page Plugin
start /wait msiexec /qn /norestart /x {E738A392-F690-4A9D-808E-7BAF80E0B398}

:: EyesStare
start /wait msiexec /qn /norestart /x {490CB685-FC44-42E3-BD31-461775BB7DEC}

:: Facebook Messenger 2.1.4814.0
start /wait msiexec /qn /norestart /x {7204BDEE-1A48-4D95-A964-44A9250B439E}

:: Facebook Video Calling 3.1.0.521
start /wait msiexec /qn /norestart /x {2091F234-EB58-4B80-8C96-8EB78C808CF7}

:: File Association Helper
start /wait msiexec /qn /norestart /x {6D6ADF03-B257-4EA5-BBC1-1D145AF8D514}

:: Find Junk Files 1.51
start /wait msiexec /qn /norestart /x {9FE8D71A-BEBC-48F3-9479-E5E25AE2A4F0}

:: FishingJoy
start /wait msiexec /qn /norestart /x {A3C599FA-2CDD-43DB-B062-09A52CA9BFC6}

:: FlashCatch browser plugin
start /wait msiexec /qn /norestart /x {A0AB2980-1FDD-4b6c-940C-FC87C84F05B7}

:: Fooz Kids
start /wait msiexec /qn /norestart /x {13C0A937-797F-847A-7FF5-010EAC327493}
start /wait msiexec /qn /norestart /x {8D68CE08-9A14-4B7B-9857-3C646A2F34C7}

:: Fruits
start /wait msiexec /qn /norestart /x {AA39BFDE-71E5-46A6-A10B-44C2F45A341E}

:: Fujitsu Button Utilities 7.04.1209.2010
start /wait msiexec /qn /norestart /x {EC314CDF-3521-482B-A21C-65AC95664814}

:: Fujitsu Display Manager 7.00.20.212
start /wait msiexec /qn /norestart /x {191C41F6-4BA8-4D3D-BBC5-AAC8F3077E3F}

:: Fujitsu Driver Update 1.3.0012
start /wait msiexec /qn /norestart /x {32782FFE-4BAC-48A4-A4FA-532560515E48}

:: Fujitsu Fingerprint Authentication Library 1.00.49.0
start /wait msiexec /qn /norestart /x {C8E4B31D-337C-483D-822D-16F11441669B}

:: Fujitsu Hotkey Utility
start /wait msiexec /qn /norestart /x {9FC6AD75-5B07-46E2-B80D-E9C13BBF45E0}
start /wait msiexec /qn /norestart /x {C32028B6-E056-429C-B839-0DCF21528E71}

:: Fujitsu MobilityCenter Extension Utility
start /wait msiexec /qn /norestart /x {0C216C82-F950-4C79-A63E-322C7280AC30}
start /wait msiexec /qn /norestart /x {E8A5B78F-4456-4511-AB3D-E7BFFB974A7A}

:: Fujitsu Security Panel // Security Panel for Supervisor
start /wait msiexec /qn /norestart /x {17F82182-0E3D-4A14-8843-5ECBFAF4F12F}
start /wait msiexec /qn /norestart /x {0EFDF2F9-836D-4EB7-A32D-038BD3F1FB2A}

:: Fujitsu System Extension Utility 2.1.1.0
start /wait msiexec /qn /norestart /x {DED08875-D1AE-4E66-BE84-BB746019B9F9}

:: Garmin Elevated Installer; known to cause popups and crash frequently
start /wait msiexec /qn /norestart /x {D4D065E1-3ABF-41D0-B385-FC6F027F4D00}
start /wait msiexec /qn /norestart /x {4694981D-8031-4526-90BE-E5F7FB80CBB8}

:: Garmin WebUpdater
start /wait msiexec /qn /norestart /x {338ADB80-9C9E-4C71-9403-798057D7FFA6}

:: Gateway Explorer Agent; shared by Acer Explorer Agent
start /wait msiexec /qn /norestart /x {4D0F42CF-1693-43D9-BDC8-19141D023EE0}

:: Gateway Games (Gateway-branded WildTangent games)
:: These two FOR loops should catch ALL Gateway games, in theory at least
:: Basically, loop through the games subdirectory, and if an "Uninstall.exe" exists ANYWHERE, run it with the /silent flag
for /r "%ProgramFiles%\Gateway Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )
for /r "%ProgramFiles(x86)%\Gateway Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )

:: Get Dropbox (also called "Dropbox 25 GB" or "Dropbox 15 GB")
start /wait msiexec /qn /norestart /x {597A58EC-42D6-4940-8739-FB94491B013C}

:: GeekBuddy
start /wait msiexec /qn /norestart /x {17004FB0-9CFD-43DC-BB2D-E2BA612D98D0}

:: Google Update Helper
start /wait msiexec /qn /norestart /x {60EC980A-BDA2-4CB6-A427-B07A5498B4CA}
start /wait msiexec /qn /norestart /x {A92DAB39-4E2C-4304-9AB6-BC44E68B55E2}
start /wait msiexec /qn /norestart /x {A4DE5CD7-96D6-3979-8C39-E864396AFFC0}
start /wait msiexec /qn /norestart /x {5BAA8884-F661-464B-B5B2-5C6C632BFC21}

:: Hewlett-Packard ACLM.NET
start /wait msiexec /qn /norestart /x {6F340107-F9AA-47C6-B54C-C3A19F11553F}
start /wait msiexec /qn /norestart /x {06FCC605-92A1-4A1C-B7D1-85E5778290A4}

:: Hewlett-Packard Asset Agent for Health Check
start /wait msiexec /qn /norestart /x {669D4A35-146B-4314-89F1-1AC3D7B88367}

:: HP
start /wait msiexec /qn /norestart /x {B2EE25B9-5B00-4ACF-94F0-92433C28C39E}
start /wait msiexec /qn /norestart /x {3023EBDA-BF1B-4831-B347-E5018555F26E}

:: HP 3.00.xxxx (various versions)
start /wait msiexec /qn /norestart /x {2F518061-89DB-4AF0-9A7A-2BF73B60E6F0}
start /wait msiexec /qn /norestart /x {912D30CF-F39E-4B31-AD9A-123C6B794EE2}
start /wait msiexec /qn /norestart /x {F9569D00-4576-46C8-B6C7-207A4FD39745}

:: HP 3D DriveGuard
start /wait msiexec /qn /norestart /x {E8D0E2B8-B64B-44BC-8E01-00DDACBDF78A}
start /wait msiexec /qn /norestart /x {E5823036-6F09-4D0A-B05C-E2BAA129288A}
start /wait msiexec /qn /norestart /x {0C57987A-A03A-4B95-A309-D23F78F406CA}
start /wait msiexec /qn /norestart /x {55CA337D-2BE3-4AA4-BA1E-652F4C02E893}
start /wait msiexec /qn /norestart /x {675D093B-815D-47FD-AB2C-192EC751E8E2}
start /wait msiexec /qn /norestart /x {5B08AF35-B699-4A44-BB89-3E51E70611E8}
start /wait msiexec /qn /norestart /x {C05002F1-06F8-4A15-B6F8-E4DC655C28AA}
start /wait msiexec /qn /norestart /x {6BA7C52E-4071-47CC-9060-ABB143862DB0}
start /wait msiexec /qn /norestart /x {ADE2F6A7-E7BD-4955-BD66-30903B223DDF}
start /wait msiexec /qn /norestart /x {07E79F52-1D78-4081-814E-BF093FF7A1BF}
start /wait msiexec /qn /norestart /x {F792E5B0-11C4-4C68-8A63-FB5F52749180}
start /wait msiexec /qn /norestart /x {130E5108-547F-4482-91EE-F45C784E08C7}
start /wait msiexec /qn /norestart /x {D79A02E9-6713-4335-9668-AAC7474C0C0E}
start /wait msiexec /qn /norestart /x {54CE68A8-4F2D-4328-B1F7-D6C720405F7F}
start /wait msiexec /qn /norestart /x {299625B9-6C69-462C-9CEA-8E06D878B1C5}

:: HP 64 Bit HP CIO Components Installer
start /wait msiexec /qn /norestart /x {FF21C3E6-97FD-474F-9518-8DCBE94C2854}
start /wait msiexec /qn /norestart /x {BC741628-0AFC-405C-8946-DD46D1005A0A}

:: HP ActiveCheck component for HP Active Support Libary
start /wait msiexec /qn /norestart /x {254C37AA-6B72-4300-84F6-98A82419187E}
start /wait msiexec /qn /norestart /x {CBB639E0-B534-4827-97B5-CA1A4CA985B5}

:: HP Active Support Library
start /wait msiexec /qn /norestart /x {0A47BAFF-D4FF-4BD3-96CA-02A22EA62722}
::%ProgramFiles%\InstallShield Installation Information\{0A47BAFF-D4FF-4BD3-96CA-02A22EA62722}\setup.exe -runfromtemp -l0x0409
::%ProgramFiles(x86)%\InstallShield Installation Information\{0A47BAFF-D4FF-4BD3-96CA-02A22EA62722}\setup.exe -runfromtemp -l0x0409

:: HP Advisor
start /wait msiexec /qn /norestart /x {403996EB-2DCE-4C43-A2B8-2B956880772D}
start /wait msiexec /qn /norestart /x {40FB8D7C-6FF8-4AF2-BC8B-0B1DB32AF04B}

:: HP Auto
start /wait msiexec /qn /norestart /x {CB7D766C-879F-4800-BB09-3D29E306EF63}
start /wait msiexec /qn /norestart /x {CC4D56B7-6F18-470B-8734-ABCD75BCF4F1}

:: HP Boot Optimizer
start /wait msiexec /qn /norestart /x {1341D838-719C-4A05-B50F-49420CA1B4BB}

:: HP BufferChm
start /wait msiexec /qn /norestart /x {FA0FF682-CC70-4C57-93CD-E276F3E7537E}
start /wait msiexec /qn /norestart /x {2EEA7AA4-C203-4b90-A34F-19FB7EF1C81C}
start /wait msiexec /qn /norestart /x {62230596-37E5-4618-A329-0D21F529A86F}
start /wait msiexec /qn /norestart /x {687FEF8A-8597-40b4-832C-297EA3F35817}

:: HP BPDSoftware (various versions); known to create annoying error messages and popups at system boot
start /wait msiexec /qn /norestart /x {20D48DD8-06BA-4d5a-9796-6C7582F07947}
start /wait msiexec /qn /norestart /x {38DAE5F5-EC70-4aa5-801B-D11CA0A33B41}
start /wait msiexec /qn /norestart /x {508CE680-CAF5-4d0a-86E5-84E7B0701F26}
start /wait msiexec /qn /norestart /x {268C2D6E-CDE9-47CD-87D9-A87710966709}
start /wait msiexec /qn /norestart /x {671B4BAD-D681-4d29-9498-D8BF3F1A389D}
start /wait msiexec /qn /norestart /x {6CC080F1-2E00-41D5-BE47-A3BC784E9DFB}
start /wait msiexec /qn /norestart /x {AFB69549-3AAE-4433-A99B-673B8A513379}

:: HP C4400_Help
start /wait msiexec /qn /norestart /x {4F923F90-46D1-4492-9CC6-13FBBA00E7EC}

:: HP Cards_Calendar_OrderGift_DoMorePlugout 1.00.0000
start /wait msiexec /qn /norestart /x {C918E3D8-208F-43DB-B346-6299D59336D7}

:: HP CinemaNow Media Manager
start /wait msiexec /qn /norestart /x {A5E65B95-F016-474D-BC0D-6AF64412BBDF}

:: HP Client Security Manager (various versions)
start /wait msiexec /qn /norestart /x {39930586-2677-432B-B928-F970FB43F46F}
start /wait msiexec /qn /norestart /x {3B46DFDA-6155-423B-BCBB-F1C267E4ADD9}
start /wait msiexec /qn /norestart /x {3AF15EEA-8EDF-4393-BB6C-CF8A9986486A}
start /wait msiexec /qn /norestart /x {CA19DC3C-DA9E-40B1-B501-710F437604C0}
start /wait msiexec /qn /norestart /x {D5510D28-D0E4-433E-A0F3-EE3FCECA60D2}
start /wait msiexec /qn /norestart /x {167AA1D5-8412-44BC-A003-B7A3662D1CE2}
start /wait msiexec /qn /norestart /x {82E616DB-8BE9-46B7-AE42-60200985AD78}

:: HP Client Services 1.1.12938.3539
start /wait msiexec /qn /norestart /x {28074A47-851D-4599-A270-87609F58EB57}

:: HP Color LaserJet Pro MFP M476 Scan Shortcuts 32.0.74.0
start /wait msiexec /qn /norestart /x {B411AD10-1BC9-4939-8848-BC5E66F662B7}

:: HP Connected Remote
start /wait msiexec /qn /norestart /x {F1DD6CD2-6734-4089-9EF5-441F51E083B6}
start /wait msiexec /qn /norestart /x {F243A34B-AB7F-4065-B770-B85B767C247C}

:: HP Connection Manager (various versions)
start /wait msiexec /qn /norestart /x {04C23662-CE15-48BE-AF77-7BD9028934E7}
start /wait msiexec /qn /norestart /x {7940DAB9-AC72-4422-8908-DCF58C2C1D21}
start /wait msiexec /qn /norestart /x {226837D8-0BF8-4CBE-BAB2-8F07E2C2B4DD}
start /wait msiexec /qn /norestart /x {40FB8D7C-6FF8-4AF2-BC8B-0B1DB32AF04B}
start /wait msiexec /qn /norestart /x {EB58480C-0721-483C-B354-9D35A147999F}
start /wait msiexec /qn /norestart /x {7B7FF4D0-D4E2-4E8E-908D-90AB01BC4568}

:: HP CoolSense
start /wait msiexec /qn /norestart /x {85DF2EED-08BC-46FB-90DA-28B0D0A8E8A8}
start /wait msiexec /qn /norestart /x {DFD6EBE3-F0DA-4E24-9202-37AF8D20888B}
start /wait msiexec /qn /norestart /x {ADDF4B84-5D28-4EAE-8511-EF808C8BC81C}
start /wait msiexec /qn /norestart /x {1504CF6F-8139-497F-86FC-46174B67CF7F}
start /wait msiexec /qn /norestart /x {59F8C5AA-91BD-423D-BF05-09A80F39898F}
start /wait msiexec /qn /norestart /x {11AF9A96-6D83-4C3B-8DCB-16EA2A358E3F}

:: HP Copy (various versions)
start /wait msiexec /qn /norestart /x {3C92B2E6-380D-4fef-B4DF-4A3B4B669771}
start /wait msiexec /qn /norestart /x {55D003F4-9599-44BF-BA9E-95D060730DD3}

:: HP CUE Status (various versions)
start /wait msiexec /qn /norestart /x {5B025634-7D5B-4B8D-BE2A-7943C1CF2D5D}
start /wait msiexec /qn /norestart /x {CE938F96-2EDD-4377-942A-1B877616E523}
start /wait msiexec /qn /norestart /x {A0B9F8DF-C949-45ed-9808-7DC5C0C19C81}
start /wait msiexec /qn /norestart /x {03A7C57A-B2C8-409b-92E5-524A0DFD0DD3}
start /wait msiexec /qn /norestart /x {0EF5BEA9-B9D3-46d7-8958-FB69A0BAEACC}

:: HP Customer Experience Enhancements / HP Advisor / HP Customer Feedback / HP Launch Box
start /wait msiexec /qn /norestart /x {07FA4960-B038-49EB-891B-9F95930AA544}
start /wait msiexec /qn /norestart /x {C9EF1AAF-B542-41C8-A537-1142DA5D4AEC}
start /wait msiexec /qn /norestart /x {07F6DC37-0857-4B68-A675-4E35989E85E3}
start /wait msiexec /qn /norestart /x {07FA4960-B038-49EB-891B-9F95930AA544}
start /wait msiexec /qn /norestart /x {73A43E42-3658-4DD9-8551-FACDA3632538}
start /wait msiexec /qn /norestart /x {AB5E289E-76BF-4251-9F3F-9B763F681AE0}
start /wait msiexec /qn /norestart /x {9DBA770F-BF73-4D39-B1DF-6035D95268FC}
start /wait msiexec /qn /norestart /x {BF1E75D0-E7AF-4BEA-9FBC-567F0C54BDF9}
start /wait msiexec /qn /norestart /x {C27C82E4-9C53-4D76-9ED3-A01A3D5EE679}
start /wait msiexec /qn /norestart /x {C9EF1AAF-B542-41C8-A537-1142DA5D4AEC}
start /wait msiexec /qn /norestart /x {57A5AEC1-97FC-474D-92C4-908FCC2253D4}

:: HP CustomerResearchQFolder
start /wait msiexec /qn /norestart /x {7206B668-FEE0-455B-BB1F-9B5A2E0EC94A}

:: HP Connected Music
start /wait msiexec /qn /norestart /x {8126E380-F9C6-4317-9CEE-9BBDDAB676E5}

:: HP D2400_Help
start /wait msiexec /qn /norestart /x {7EF7CCB0-52BF-4947-BE6E-E47D586E8842}

:: HP Deskjet 2510 series Setup Guide
start /wait msiexec /qn /norestart /x {216C7F38-4BBC-4E9A-8392-C9FA21B54386}

:: HP Deskjet Series Help
start /wait msiexec /qn /norestart /x {F7632A9B-661E-4FD9-B1A4-3B86BC99847F}
start /wait msiexec /qn /norestart /x {97C1C98D-6AE5-4C71-9B00-EBBD9E014450}

:: HP Destinations
start /wait msiexec /qn /norestart /x {5E487136-B52E-4856-8F5F-FCDF5E5FC5EE}
start /wait msiexec /qn /norestart /x {D99A8E3A-AE5A-4692-8B19-6F16D454E240}
start /wait msiexec /qn /norestart /x {EF9E56EE-0243-4BAD-88F4-5E7508AA7D96}

:: HP Device Access Manager
start /wait msiexec /qn /norestart /x {D7BC5D88-FC93-46D6-B7B0-145C2E168A95}
start /wait msiexec /qn /norestart /x {2642BE09-1F9F-4E18-AAD4-0258B9BCE611}
start /wait msiexec /qn /norestart /x {9EC0BE64-2C6C-428A-A4C2-E7EDF831B29A}
start /wait msiexec /qn /norestart /x {DBCD5E64-7379-4648-9444-8A6558DCB614}
start /wait msiexec /qn /norestart /x {BD7204BA-DD64-499E-9B55-6A282CDF4FA4}
start /wait msiexec /qn /norestart /x {55B52830-024A-443E-AF61-61E1E71AFA1B}

:: HP DeviceManagementQFolder
start /wait msiexec /qn /norestart /x {AB5D51AE-EBC3-438D-872C-705C7C2084B0}
start /wait msiexec /qn /norestart /x {F769B78E-FF0E-4db5-95E2-9F4C8D6352FE}

:: HP Discover hp Touchpoint Manager
start /wait msiexec /qn /norestart /x {74C4DA32-D4FD-406B-AEA3-6781757C8EC3}
start /wait msiexec /qn /norestart /x {37EC8980-A8E5-411D-8CDD-CB1CCA95057F}

:: HP DisplayLink Core Software and DisplayLink Graphics
start /wait msiexec /qn /norestart /x {796E076A-82F7-4D49-98C8-DEC0C3BC733A}
start /wait msiexec /qn /norestart /x {33023FE8-9028-416A-8A5C-C115B59DD538}
start /wait msiexec /qn /norestart /x {0DE76F90-E993-47C7-BF6A-2B385492D490}
start /wait msiexec /qn /norestart /x {2021896F-CECA-463C-A7A8-9949A13910F7}
start /wait msiexec /qn /norestart /x {7BB949B9-EB47-47E4-814D-88F8CD301543}
start /wait msiexec /qn /norestart /x {D21BDA13-5E4C-401D-8353-2543251B40E2}
start /wait msiexec /qn /norestart /x {A4D282D0-1B48-481B-9E52-5F0B001A2BAB}
start /wait msiexec /qn /norestart /x {34412EC4-6A3C-454F-AF8B-75B0A0DF00AB}
start /wait msiexec /qn /norestart /x {861C4DFA-E691-4BA6-BE6B-D5BA211990B6}
start /wait msiexec /qn /norestart /x {3B1040BE-8AB0-4D80-A68E-029D70A0868B}
start /wait msiexec /qn /norestart /x {70E2B27F-0B7F-41B2-8145-E7377BC9F75A}
start /wait msiexec /qn /norestart /x {8C2259F3-35F4-4663-87BF-9F5F6AE6C4F7}
start /wait msiexec /qn /norestart /x {12F5A080-A6EE-4FCC-B355-80CBBF33FAA0}
start /wait msiexec /qn /norestart /x {89E40591-0404-4769-88E7-F649C95AE151}
start /wait msiexec /qn /norestart /x {65B2569D-303B-41EC-B38C-0934963BC3AD}
start /wait msiexec /qn /norestart /x {D9D8900B-CFEB-44C6-B417-D6308B5B145D}
start /wait msiexec /qn /norestart /x {29E6A126-BB06-41CF-B12D-E6A56261328D}

:: HP Documentation
start /wait msiexec /qn /norestart /x {73A33079-D1A0-4469-8903-C4A48B4975E2}
start /wait msiexec /qn /norestart /x {C8D60CF4-BE7A-487E-BD36-535111BDB0FE}
start /wait msiexec /qn /norestart /x {06600E94-1C34-40E2-AB09-D30AECF78172}
start /wait msiexec /qn /norestart /x {025D3904-FA39-4AA2-A05B-9EFAAF36B1F2}
start /wait msiexec /qn /norestart /x {1F0493F6-311D-44E5-A9E6-F0D4C63FB8FD}
start /wait msiexec /qn /norestart /x {5340A3C6-4169-484A-ADA7-63BCF5C557A0}
start /wait msiexec /qn /norestart /x {7573D7E5-02BB-4903-80EB-36073A99BC8D}
start /wait msiexec /qn /norestart /x {791A06E2-340F-43B0-8FAB-62D151339362}
start /wait msiexec /qn /norestart /x {8327F6D2-C8CC-49B5-B8D1-46C83909650E}
start /wait msiexec /qn /norestart /x {84F0C8C0-263A-4B3A-888D-2A5FDEA15401}
start /wait msiexec /qn /norestart /x {8ABB6A99-E2D5-47E4-905A-2FD4657D235E}
start /wait msiexec /qn /norestart /x {9867A917-5D17-40DE-83BA-BEA5293194B1}
start /wait msiexec /qn /norestart /x {A6365256-0FBA-4DCD-88CE-D92A4DC9328E}
start /wait msiexec /qn /norestart /x {A1CFA587-90D4-4DE6-B200-68CC0F92252F}
start /wait msiexec /qn /norestart /x {53AE55F3-8E99-4776-A347-06222894ECD3}
start /wait msiexec /qn /norestart /x {95CC589C-8D98-4539-9878-4E6A342304F2}
start /wait msiexec /qn /norestart /x {9D20F550-4222-49A7-A7A7-7CAAB2E16C9C}
start /wait msiexec /qn /norestart /x {89A12FD9-8FA0-4EB9-AE9A-34C7EB25C25B}

:: HP DocProc
start /wait msiexec /qn /norestart /x {676981B7-A2D9-49D0-9F4C-03018F131DA9}
start /wait msiexec /qn /norestart /x {C29C1940-CB85-4F3B-906C-33FEE0E67103}
start /wait msiexec /qn /norestart /x {679EC478-3FF9-4987-B2FF-C2C2B27532A2}
start /wait msiexec /qn /norestart /x {9B362566-EC1B-4700-BB9C-EC661BDE2175}

:: HPDiagnosticAlert
start /wait msiexec /qn /norestart /x {B6465A32-8BE9-4B38-ADC5-4B4BDDC10B0D}
start /wait msiexec /qn /norestart /x {846B5DED-DC8C-4E1A-B5B4-9F5B39A0CACE}

:: HP DisableMSDefender (disables Microsoft Defender...wtf?)
start /wait msiexec /qn /norestart /x {74FE39A0-FB76-47CD-84BA-91E2BBB17EF2}
start /wait msiexec /qn /norestart /x {AF9E97C1-7431-426D-A8D5-ABE40995C0B1}

:: HP Drive Encryption for HP ProtectTools
start /wait msiexec /qn /norestart /x {B05372A4-5AF0-4343-BA7B-2745E30A2D23}
start /wait msiexec /qn /norestart /x {34E6F14D-68F9-486D-87BA-6AA8431F3F44}

:: HP Easy Setup - Frontend
start /wait msiexec /qn /norestart /x {40F7AED3-0C7D-4582-99F6-484A515C73F2}
::"%ProgramFiles%\InstallShield Installation Information\{40F7AED3-0C7D-4582-99F6-484A515C73F2}\setup.exe" -l0x9  -removeonly

:: HP Energy Star
start /wait msiexec /qn /norestart /x {FC0ADA4D-8FA5-4452-8AFF-F0A0BAC97EF7}
start /wait msiexec /qn /norestart /x {0FA995CC-C849-4755-B14B-5404CC75DC24}

:: HP ENVY 4500 series Help
start /wait msiexec /qn /norestart /x {95BECC50-22B4-4FCA-8A2E-BF77713E6D3A}

:: HP ESU for Microsoft Windows (Windows update hijacker)
start /wait msiexec /qn /norestart /x {240B2BF7-E7E6-425C-A2A4-A3149189BF7F}
start /wait msiexec /qn /norestart /x {A5F1C701-E150-4A86-A7F8-9E9225C2AE52}
start /wait msiexec /qn /norestart /x {6349342F-9CEF-4A70-995A-2CF3704C2603}
start /wait msiexec /qn /norestart /x {22706ADC-74A1-43A0-ABAE-47F84966B909}
start /wait msiexec /qn /norestart /x {2BF5E9CC-C55D-4B0F-ACAF-FFE77F333CD8}
start /wait msiexec /qn /norestart /x {A351CC1B-C92C-4F37-8109-9F6D33ACF5EF}
start /wait msiexec /qn /norestart /x {722A2876-B382-4AB5-8CC9-007FF5B28641}

:: HP eSupportQFolder
start /wait msiexec /qn /norestart /x {66E6CE0C-5A1E-430C-B40A-0C90FF1804A8}
start /wait msiexec /qn /norestart /x {8894A6A7-547D-4326-B4BC-FB62B9075CE2}

:: HP File Sanitizer
start /wait msiexec /qn /norestart /x {53D3E126-699A-4D92-AA66-6560D573553E}
start /wait msiexec /qn /norestart /x {60F90886-FAEE-4768-9817-093AB0F30540}

:: HP FWUpdateEDO2
start /wait msiexec /qn /norestart /x {415FA9AD-DA10-4ABE-97B6-5051D4795C90}

:: HP Games
:: These two FOR loops should catch ALL HP games, in theory at least
:: Basically, loop through the HP Games subdirectory, and if an "Uninstall.exe" exists ANYWHERE, run it with the /silent flag
for /r "%ProgramFiles%\HP Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )
for /r "%ProgramFiles(x86)%\HP Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )

:: HP GPBaseService2 (popups)
start /wait msiexec /qn /norestart /x {BB3447F6-9553-4AA9-960E-0DB5310C5779}

:: HP Insight Diagnostics Online Edition for Windows 9.3.0
start /wait msiexec /qn /norestart /x {DBE16A07-DDFF-4453-807A-212EF93916E0}

:: HP Launch Box
start /wait msiexec /qn /norestart /x {9CAB2212-0732-4827-8EC4-61D8EF0AA65B}

:: HP misc Help, eDocs and User Guide GUIDs (various versions for various products; most of these should be caught in the wildcard scan)
start /wait msiexec /qn /norestart /x {11C9A461-DD9D-4C71-85A4-6DCE7F99CC44}
start /wait msiexec /qn /norestart /x {B6B9006D-5A0A-4F17-B69A-42F48C1FC30C}
start /wait msiexec /qn /norestart /x {445CC807-9384-47FA-A2B6-FFE970352B88}
start /wait msiexec /qn /norestart /x {F90A86C9-7779-47DD-AC06-8EE832C55F55}
start /wait msiexec /qn /norestart /x {1575F408-60AC-4a37-904A-931117272926}
start /wait msiexec /qn /norestart /x {4B322C8E-8775-4f20-8978-ED63DB4770C4}
start /wait msiexec /qn /norestart /x {7E60EE8D-0914-444E-A682-7703BDDEB5EB}
start /wait msiexec /qn /norestart /x {DE13432E-F0C1-4842-A5BA-CC997DA72A70}
start /wait msiexec /qn /norestart /x {A4966638-798C-45B9-B5BF-07D3E63B58C2}
start /wait msiexec /qn /norestart /x {7F94FB03-6617-4442-9817-CDDB36EAE529}
start /wait msiexec /qn /norestart /x {86BC184E-CFCD-48D5-829A-666A36C6ACC9}
start /wait msiexec /qn /norestart /x {B8454F30-79EC-4959-BCF1-3776DEC406AB}
start /wait msiexec /qn /norestart /x {BCFAA37D-A6DB-43BF-A351-43F183E52D07}
start /wait msiexec /qn /norestart /x {5C76ED0D-0F6F-4985-8B34-F9AE7834848F}
start /wait msiexec /qn /norestart /x {74038F40-03AE-4785-865B-07EC7F6A5E97}
start /wait msiexec /qn /norestart /x {04D66C1E-E5E2-483C-8715-916C42703924}
start /wait msiexec /qn /norestart /x {5D3E11CE-2C9A-44E3-A561-ED9BAC439E83}
start /wait msiexec /qn /norestart /x {83A375B6-6FC2-4F8A-948E-E506DB9DCDF0}
start /wait msiexec /qn /norestart /x {D2A2E5CD-801A-4B8D-8119-F79449A09B67}
start /wait msiexec /qn /norestart /x {F6D61EC9-347B-4019-9F8E-E24169F7C330}
start /wait msiexec /qn /norestart /x {2A186F69-BCC4-4529-9F24-A8FFB7F4E1C9}
start /wait msiexec /qn /norestart /x {6357258D-2BF9-49E7-A9EF-0C609D52C46D}
start /wait msiexec /qn /norestart /x {563ADFC1-38E6-4EF0-8763-7CDA8289944B}
start /wait msiexec /qn /norestart /x {C1223A79-3983-4877-B162-75031E7CE322}
start /wait msiexec /qn /norestart /x {DDEBEA89-2B5A-4E5B-8702-369882BB3F52}
start /wait msiexec /qn /norestart /x {BD019D8F-25B9-49D6-B301-07AFF65E35DD}
start /wait msiexec /qn /norestart /x {4989DD05-86FB-4CA2-96C5-923DFAD89DA3}
start /wait msiexec /qn /norestart /x {55D8D1AB-94C2-498F-A165-608B834A30EA}
start /wait msiexec /qn /norestart /x {274E6D9A-7CCD-4D67-9660-639486F466B2}
start /wait msiexec /qn /norestart /x {92AB9371-D327-4D56-9BDD-B38A671A631D}
start /wait msiexec /qn /norestart /x {32A4CF00-9FAC-47c8-9B37-91CC23815D64}
start /wait msiexec /qn /norestart /x {6357D25F-A9C9-4CC7-A1FB-0DCF344E7C40}
start /wait msiexec /qn /norestart /x {1F670068-9589-4DC7-8FE4-1D0D13AF2526}
start /wait msiexec /qn /norestart /x {E1AE0CB7-1333-4728-8520-CB3F88A252B4}

:: HP Picasso Media Center Add-In
start /wait msiexec /qn /norestart /x {55979C41-7D6A-49CC-B591-64AC1BBE2C8B}

:: HP MarketResearch
start /wait msiexec /qn /norestart /x {95D08F4E-DFC2-4ce3-ACB7-8C8E206217E9}
start /wait msiexec /qn /norestart /x {D360FA88-17C8-4F14-B67F-13AAF9607B12}

:: HP MediaSmart SmartMenu
start /wait msiexec /qn /norestart /x {5A5F45AE-0250-4C34-9D89-F10BDDEE665F}
start /wait msiexec /qn /norestart /x {A3B64280-DE4C-40F0-86BB-CCB2A6056BA2}
start /wait msiexec /qn /norestart /x {88E60521-1E4E-4785-B9F1-1798A4BD0C30}
start /wait msiexec /qn /norestart /x {9DEF9686-CCB2-47B7-BF83-B49EA21FA016}

:: HP MediaSmart DVD
start /wait msiexec /qn /norestart /x {DCCAD079-F92C-44DA-B258-624FC6517A5A}

:: HP MediaSmart/TouchSmart Netflix (various versions)
start /wait msiexec /qn /norestart /x {34FF930E-DBF9-4858-BAB5-BAC957BF616E}
start /wait msiexec /qn /norestart /x {2D5E3D2B-919F-407C-8757-E64827518BB6}
start /wait msiexec /qn /norestart /x {BB1C717E-376C-4AA1-8940-81BFC38D9778}

:: HP MyRoom 10.0.0274
start /wait msiexec /qn /norestart /x {BB760C1D-98F4-4E38-8CC4-3B67329AA981}
start /wait msiexec /qn /norestart /x {9B9B8EE4-2EDB-41C2-AF2E-63E75D37CDDF}

:: HPProductAssistant (shows up as Network, hidden)
start /wait msiexec /qn /norestart /x {7910018D-02CF-4410-A7E5-CF5C10D05B7F}
start /wait msiexec /qn /norestart /x {8A27C0FE-87C7-4169-BF5A-05BF94F70A54}
start /wait msiexec /qn /norestart /x {21706D5B-A09C-42F1-95B5-CBDFE20F9852}

:: HP Product Improvement Study
start /wait msiexec /qn /norestart /x {446CCB22-B632-4A1D-BF84-DA8DB0575F98}
start /wait msiexec /qn /norestart /x {C927FC7E-4061-44AC-BE09-496AF6BAC131}
start /wait msiexec /qn /norestart /x {4B3264AA-951A-4A6B-B837-125224261F12}
start /wait msiexec /qn /norestart /x {791D3241-C6A4-417F-82E6-00543B6E5012}

:: HP Privacy Manager for HP ProtectTools
start /wait msiexec /qn /norestart /x {D69F9215-B06A-4ADF-A464-E2607B2FA296}

:: HP Odometer 2.10.0000
start /wait msiexec /qn /norestart /x {B899AE89-9B09-4F11-B299-A1209CAB8D00}

:: HP On Screen Display (various versions)
start /wait msiexec /qn /norestart /x {9ADABDDE-9644-461B-9E73-83FA3EFCAB50}
start /wait msiexec /qn /norestart /x {D734D743-2385-46ED-9B3E-168A24A9E1A9}
start /wait msiexec /qn /norestart /x {EC8D12E4-A73C-4C27-B1C7-E9683052E556}

:: HP PageLift
start /wait msiexec /qn /norestart /x {708ABF62-5D7A-4550-823A-1F9EFA63645A}
start /wait msiexec /qn /norestart /x {7059BDA7-E1DB-442C-B7A1-6144596720A4}
start /wait msiexec /qn /norestart /x {274A948D-DD41-4B8F-B66F-0F4AD233200F}

:: HPPhotoGadget
start /wait msiexec /qn /norestart /x {CAE4213F-F797-439D-BD9E-79B71D115BE3}

:: HPPhotoSmartDiscLabelContent1, DiscLabel_PrintOnDisc, disclabelplugin, DiscLabel_PaperLabel
start /wait msiexec /qn /norestart /x {681B698F-C997-42C3-B184-B489C6CA24C9}
start /wait msiexec /qn /norestart /x {20EFC9AA-BBC1-4DFD-81FF-99654F71CBF8}
start /wait msiexec /qn /norestart /x {B28635AB-1DF3-4F07-BFEA-975D911B549B}
start /wait msiexec /qn /norestart /x {D9D8F2CF-FE2D-4644-9762-01F916FE90A9}

:: HP Photosmart Essential
start /wait msiexec /qn /norestart /x {EB21A812-671B-4D08-B974-2A347F0D8F70}
start /wait msiexec /qn /norestart /x {D79113E7-274C-470B-BD46-01B10219DF6A}
start /wait msiexec /qn /norestart /x {BAC712C6-4061-4C9F-AB58-A5C53E76704A}

:: HP Product Assistant
start /wait msiexec /qn /norestart /x {150B6201-E9E6-4DFB-960E-CCBD53FBDDED}
start /wait msiexec /qn /norestart /x {67D3F1A0-A1F2-49b7-B9EE-011277B170CD}
start /wait msiexec /qn /norestart /x {36FDBE6E-6684-462b-AE98-9A39A1B200CC}
start /wait msiexec /qn /norestart /x {9D1B99B7-DAD8-440d-B4FB-1915332FBCC2}
start /wait msiexec /qn /norestart /x {C75CDBA2-3C86-481e-BD10-BDDA758F9DFF}
start /wait msiexec /qn /norestart /x {83F51BBA-48BE-4BB6-B96A-F4AAE4C462F9}

:: HP Product Detection
start /wait msiexec /qn /norestart /x {A436F67F-687E-4736-BD2B-537121A804CF}

:: HP Product Documentation Launcher // Product_SF_Min_QFolder // ProductContext
start /wait msiexec /qn /norestart /x {710F7B0F-A679-4314-8E69-E868B660FAEA}
start /wait msiexec /qn /norestart /x {89CEAE14-DD0F-448E-9554-15781EC9DB24}
start /wait msiexec /qn /norestart /x {414C803A-6115-4DB6-BD4E-FD81EA6BC71C}
start /wait msiexec /qn /norestart /x {5962ABC1-427C-4651-B6FC-187A9F653AEF}
start /wait msiexec /qn /norestart /x {6E4EE9B5-F69D-4455-B430-40FA5F0DC988}

:: HP Product Improvement Study (various versions)
start /wait msiexec /qn /norestart /x {E3D43596-7E26-479E-B718-77CB3D9270F6}
start /wait msiexec /qn /norestart /x {A90F92B7-3C3F-4AEF-B281-31DD17BB73CA}
start /wait msiexec /qn /norestart /x {37839D69-6DA4-4125-B33A-30DE86345DF4}
start /wait msiexec /qn /norestart /x {FEB2C4AA-661E-483F-9626-21A8ACFD10F2}
start /wait msiexec /qn /norestart /x {D2064264-3162-4DB1-AFE0-167BEFBBCD9C}
start /wait msiexec /qn /norestart /x {32797608-0840-4645-BE1B-37AFFB18908A}
start /wait msiexec /qn /norestart /x {988D55BB-08DE-43C9-8D16-3751361E2A79}

:: HP PostScript Converter
start /wait msiexec /qn /norestart /x {6E14E6D6-3175-4E1A-B934-CAB5A86367CD}

:: HP Power Assistant
start /wait msiexec /qn /norestart /x {3C33FD2E-6B21-4CD3-B41A-A7331D467617}

:: HP Power Data
start /wait msiexec /qn /norestart /x {42DBA167-C25D-49CE-BBAF-DEC25E737DA8}

:: HP Power Manager
start /wait msiexec /qn /norestart /x {8704FEEF-A6A8-4E7E-B124-BD6122C66E2C}
start /wait msiexec /qn /norestart /x {E35A3B13-78CD-4967-8AC8-AA9FDA693EDE}

:: HP Product Detection
start /wait msiexec /qn /norestart /x {A436F67F-687E-4736-BD2B-537121A804CF}
start /wait msiexec /qn /norestart /x {424CECC6-CEB1-4A5F-9A42-ADE64F035DEB}

:: HP ProtectTools GUIDs. Too many to list, Google each GUID for more information
start /wait msiexec /qn /norestart /x {A40F60B1-F1E1-452E-96A5-FF97F9A2D102}
start /wait msiexec /qn /norestart /x {EEAFE1E5-076B-430A-96D9-B567792AFA88}
start /wait msiexec /qn /norestart /x {EEEB604C-C1A7-4f8c-B03F-56F9C1C9C45F}
start /wait msiexec /qn /norestart /x {6F8071B2-5ECA-4A71-8E5D-7E2FE8174559}
start /wait msiexec /qn /norestart /x {1868D30B-72C7-41E8-9657-69C5DFE1C768}
start /wait msiexec /qn /norestart /x {9D380C34-58B7-4FF9-9DB8-05685AAD93D4}
start /wait msiexec /qn /norestart /x {3E9BC837-E48E-4964-AFFD-7AB40EBA5C50}
start /wait msiexec /qn /norestart /x {71EE298A-7B6D-4303-8438-C3E50567DA1F}
start /wait msiexec /qn /norestart /x {3F728815-C7E8-40EA-8D1A-F7B8E2382325}
start /wait msiexec /qn /norestart /x {D5D422B9-6976-4E98-8DDF-9632CB515D7E}
start /wait msiexec /qn /norestart /x {6D4839CB-28B4-4070-8CA7-612CA92CA3D0}
start /wait msiexec /qn /norestart /x {29AB47F0-C5A3-401F-8A84-3324F2DC8E46}
start /wait msiexec /qn /norestart /x {B0781FBD-8AD6-4658-A031-9815E1AC5047}
start /wait msiexec /qn /norestart /x {55B30AF2-7331-4436-9318-D9EA45A42F79}
start /wait msiexec /qn /norestart /x {B004600E-4A10-448B-8CDD-4ADB25A24042}

:: hp psc 1200 series 1.10.0000
start /wait msiexec /qn /norestart /x {C88F84E5-AE23-44BD-922C-2ABEACACAF7A}

:: HP Quick Launch and Quick Start (various versions)
start /wait msiexec /qn /norestart /x {E92D47A1-D27D-430A-8368-0BAFD956507D}
start /wait msiexec /qn /norestart /x {BAD0FA60-09CF-4411-AE6A-C2844C8812FA}
start /wait msiexec /qn /norestart /x {2856A1C2-70C5-4EC3-AFF7-E5B51E5530A2}
start /wait msiexec /qn /norestart /x {E4A80DC6-8475-4AD9-9952-5E4437889563}
start /wait msiexec /qn /norestart /x {6B7AB1ED-B64E-4545-A8E7-F9E071E12B6F}
start /wait msiexec /qn /norestart /x {566BB063-0E28-4273-A748-690BE86A7E26}

:: HP QuickLook
start /wait msiexec /qn /norestart /x {24795E98-3D9E-4661-BA6F-BC6A4FB820CE}

:: HP QuickTransfer
start /wait msiexec /qn /norestart /x {E7004147-2CCA-431C-AA05-2AB166B9785D}

:: HP QuickWeb
start /wait msiexec /qn /norestart /x {BB4FC2AD-DF12-4EE1-8AA7-2C0A26B5E2FB}
start /wait msiexec /qn /norestart /x {7861911B-4270-498A-8F7A-FCF0570F4877}

:: HP Recovery Manager
start /wait msiexec /qn /norestart /x {528AB81B-D65A-4AB0-A2B6-82B51A087D01}
start /wait msiexec /qn /norestart /x {64BAA990-F1FC-4145-A7B1-E41FBBC9DA47}
start /wait msiexec /qn /norestart /x {D817481A-193E-4332-A4F3-E19132F744F0}
start /wait msiexec /qn /norestart /x {6369FC9E-FC8D-493F-AD87-D51FAB492705}
start /wait msiexec /qn /norestart /x {DB97D0DE-0AA1-413C-8398-92C7FA3F4A67}
start /wait msiexec /qn /norestart /x {4F46FDB9-B906-47BF-B3D5-C62E01B3C5EE}
start /wait msiexec /qn /norestart /x {98C4DE92-27C8-482C-8431-514828756E80}

:: HP Registration Service
start /wait msiexec /qn /norestart /x {D1E8F2D7-7794-4245-B286-87ED86C1893C}
start /wait msiexec /qn /norestart /x {C0C9A493-51CB-4F3F-A296-5B5E410C338E}
start /wait msiexec /qn /norestart /x {D1E7D876-6B86-4B35-A93D-15B0D6C43EAF}
start /wait msiexec /qn /norestart /x {C2E428EB-116E-41C0-9E84-B22DE9CCA42F}

:: HP Remote Solution
start /wait msiexec /qn /norestart /x {C611CF88-969D-43E6-A877-D6D6439DD081}

:: HP Rescue and Recovery
start /wait msiexec /qn /norestart /x {C81D8576-F1B1-4E3A-9DC3-DF1B664962F0}

:: HP Setup
start /wait msiexec /qn /norestart /x {438363A8-F486-4C37-834C-4955773CB3D3}
start /wait msiexec /qn /norestart /x {F5E7D9AF-60F6-4A30-87E3-4EA94D322CE1}

:: HP SimplePass // Disabled by /u/kamakaze_chickn for Tron; "fingerprint reader driver and can produce an error code in DevMan if missing"
::start /wait msiexec /qn /norestart /x {314FAD12-F785-4471-BCE8-AB506642B9A1}
::start /wait msiexec /qn /norestart /x {F1390872-2500-4408-A46C-CD16C960C661}
::start /wait msiexec /qn /norestart /x {BBEB46E1-810D-449F-A9C5-4D60F3BF187D}
::start /wait msiexec /qn /norestart /x {30E20E5D-5E4E-4874-A35A-952DB3582C29}

:: HP Security Assistant 3.0.4
start /wait msiexec /qn /norestart /x {ED1BD69A-07E3-418C-91F1-D856582581BF}

:: HP Setup 9.1.15453.4066
start /wait msiexec /qn /norestart /x {42D10994-A566-495D-A5E7-D0C6B5C6B35C}

:: HP Setup Manager 1.1.13253.3682
start /wait msiexec /qn /norestart /x {AE2F1669-5B1F-47C5-B639-78D74DD0BCE4}

:: HP SmartWebPrinting
start /wait msiexec /qn /norestart /x {8FF6F5CA-4E30-4E3B-B951-204CAAA2716A}
start /wait msiexec /qn /norestart /x {DC635845-46D3-404B-BCB1-FC4A91091AFA}

:: HP Status Alerts
start /wait msiexec /qn /norestart /x {9D1DE902-8058-4555-A16A-FBFAA49587DB}

:: HP SoftPaq Download Manager
start /wait msiexec /qn /norestart /x {3F019647-AC80-4859-B023-42D9DA71953F}
start /wait msiexec /qn /norestart /x {5B4F3B85-83F0-4BBF-9052-7A38B6B09634}
start /wait msiexec /qn /norestart /x {46235FF7-2CBE-4A84-BEDA-87348D1F7850}
start /wait msiexec /qn /norestart /x {20D6301E-0A14-4238-841D-45ECA567DB69}
start /wait msiexec /qn /norestart /x {FC3C2B77-6800-48C6-A15D-9D1031130C16}
start /wait msiexec /qn /norestart /x {34C821CA-6B55-44A0-8A9B-2EF471D6019E}
start /wait msiexec /qn /norestart /x {6821D775-9303-46DD-977A-2D97CA18B054}
start /wait msiexec /qn /norestart /x {2DA697D7-FED3-4DE2-A174-92A2A12F9688}

:: HP Software Framework
start /wait msiexec /qn /norestart /x {B6F5C6D8-C443-4B55-932F-AE11B5743FC4}
start /wait msiexec /qn /norestart /x {285F722C-0E45-47DE-B38E-5B3B10FA4A7C}
start /wait msiexec /qn /norestart /x {95EEB814-D454-4176-A6B5-D708CB48064F}
start /wait msiexec /qn /norestart /x {6663B59B-E9CE-44CA-8654-7BE9060D653D}
start /wait msiexec /qn /norestart /x {DAE3B13B-5097-4EAE-BC26-C463377BD80E}
start /wait msiexec /qn /norestart /x {DA200FDD-DE3D-4958-8465-C4FBC869544B}

:: HP Software Setup
start /wait msiexec /qn /norestart /x {B1AFAD6F-9192-421F-9DFF-60A59571366B}
start /wait msiexec /qn /norestart /x {65514800-1E09-48D6-B520-3DC70572E891}
start /wait msiexec /qn /norestart /x {D160035A-CFF0-49C6-BE19-B9EFDE4AEBF2}
start /wait msiexec /qn /norestart /x {7ED7BF91-D145-480A-B206-6891576F6935}
start /wait msiexec /qn /norestart /x {B1A4A13D-4665-4ED3-9DFE-F845725FBBD8}
start /wait msiexec /qn /norestart /x {741CFE3A-1C0B-4A7D-8E08-5D78C911C09D}
start /wait msiexec /qn /norestart /x {F4D304D9-7647-4253-957E-44286B8631F4}

:: HP Solution Center
start /wait msiexec /qn /norestart /x {BC5DD87B-0143-4D14-AAE6-97109614DC6B}
start /wait msiexec /qn /norestart /x {A36CD345-625C-4d6c-B3E2-76E1248CB451}

:: HP Support Assistant (various versions)
start /wait msiexec /qn /norestart /x {8C696B4B-6AB1-44BC-9416-96EAC474CABE}
start /wait msiexec /qn /norestart /x {61EB474B-67A6-47F4-B1B7-386851BAB3D0}
start /wait msiexec /qn /norestart /x {4EDD5F10-3961-48C2-ACD9-63D5C125EA8F}
start /wait msiexec /qn /norestart /x {7414C891-720D-4E86-85E5-C3AA898DA9EC}
start /wait msiexec /qn /norestart /x {49524B48-4FE9-4A62-A9FD-1F2258DF5489}
start /wait msiexec /qn /norestart /x {B18EF1BB-63C5-489A-8367-D1A253DFD5DD}
start /wait msiexec /qn /norestart /x {E5C1C126-1687-4868-A3DD-B807176E4970}
start /wait msiexec /qn /norestart /x {6F1C00D2-25C2-4CBA-8126-AE9A6E2E9CD5}
start /wait msiexec /qn /norestart /x {ED84321F-D2C5-46F0-8CAA-DAB8496E9070}
start /wait msiexec /qn /norestart /x {C807BEFB-0F17-41AC-B307-D7B5E1553040}
start /wait msiexec /qn /norestart /x {A3876D50-4A88-4A34-92E1-5D7BC8F886E1}
start /wait msiexec /qn /norestart /x {3A61A282-4F08-4D43-920C-DC30ECE528E8}
start /wait msiexec /qn /norestart /x {E2C8D0C2-1C97-4C05-939A-5B13A0FE655C}
start /wait msiexec /qn /norestart /x {8B2A1CFD-8F88-4081-9E18-99395CC27EE6}
start /wait msiexec /qn /norestart /x {7F2A11F4-EAE8-4325-83EC-E3E99F85169E}
start /wait msiexec /qn /norestart /x {8F2FC505-65FC-41B6-AAA7-55E266418E30}
start /wait msiexec /qn /norestart /x {B8AC1A89-FFD1-4F97-8051-E505A160F562}
start /wait msiexec /qn /norestart /x {7EF08127-4C30-4C05-8CEB-544F8A71C080}
start /wait msiexec /qn /norestart /x {B1E569B6-A5EB-4C97-9F93-9ED2AA99AF0E}
start /wait msiexec /qn /norestart /x {FB4BB287-37F9-4E27-9C4D-2D3882E08EFF}
start /wait msiexec /qn /norestart /x {EE202411-2C26-49E8-9784-1BC1DBF7DE96}
start /wait msiexec /qn /norestart /x {B60DCA15-56A3-4D2D-8747-22CF7D7B588B}

:: HP Support Information
start /wait msiexec /qn /norestart /x {B2B7B1C8-7C8B-476C-BE2C-049731C55992}

:: HP Support Solutions Framework
start /wait msiexec /qn /norestart /x {D7D5F438-26EF-45AB-AB89-C476FBCF8584}
start /wait msiexec /qn /norestart /x {348A1F5B-07B3-4436-9A47-FFE44EFE856E}

:: HP System Default Settings
start /wait msiexec /qn /norestart /x {5C90D8CF-F12A-41C6-9007-3B651A1F0D78}
start /wait msiexec /qn /norestart /x {28FE073B-1230-4BF6-830C-7434FD0C0069}
start /wait msiexec /qn /norestart /x {C422BF2C-E570-4D3E-8718-7C641B190DB2}
start /wait msiexec /qn /norestart /x {39011DEC-8956-401E-8369-421D402FFF52}

:: HP System Event Utility
start /wait msiexec /qn /norestart /x {8B4EE87E-6D40-4C91-B5E8-0DC77DC412F1}
start /wait msiexec /qn /norestart /x {D17A3B70-B75E-4C49-83D6-C17DDF65B35F}

:: hpStatusAlerts
start /wait msiexec /qn /norestart /x {7504A7B0-003E-4875-A454-B627E127E9D9}
start /wait msiexec /qn /norestart /x {06CE2B24-EC8C-4847-AF33-098255B5D32D}
start /wait msiexec /qn /norestart /x {44EB02F5-16E5-42BD-9183-C23EF7620CF3}
start /wait msiexec /qn /norestart /x {46A99EAE-98DA-4BE5-94C3-D41BA4C266DA}
start /wait msiexec /qn /norestart /x {B8DBED1E-8BC3-4d08-B94A-F9D7D88E9BBF}
start /wait msiexec /qn /norestart /x {6470E292-3B55-41DC-B5EB-91C34C5ACB5D}
start /wait msiexec /qn /norestart /x {7C960641-0A27-45C6-96F8-BE4E04A4CC2C}
start /wait msiexec /qn /norestart /x {092FCD1C-5203-4BD1-B4F4-0F0C6B237A6A}
start /wait msiexec /qn /norestart /x {0CCFF6E8-B4D1-416F-8198-B223BA8B1991}
start /wait msiexec /qn /norestart /x {25E11B5A-4817-4296-A260-235AE77B1708}
start /wait msiexec /qn /norestart /x {A1EF28FB-74A8-4157-91E9-9C164CAB10F8}
start /wait msiexec /qn /norestart /x {FDEA674C-478D-455F-9894-D6D4CD4BB304}
start /wait msiexec /qn /norestart /x {71677768-D5DA-4785-8A44-2DFFE33CF70A}
start /wait msiexec /qn /norestart /x {9652051B-BC94-4588-A84B-B9B34660FB5E}
start /wait msiexec /qn /norestart /x {456E4C16-227D-48E4-BA3B-52D1B15CB196}

:: HP Theft Recovery
start /wait msiexec /qn /norestart /x {B9A03B7B-E0FF-4FB3-BA83-762E58A1B0AA}
start /wait msiexec /qn /norestart /x {B1CB7E99-4685-45CB-867E-2FB58EDA0A39}
start /wait msiexec /qn /norestart /x {33C9F24B-1D92-4632-A915-81E3BB1D5D6B}

:: HP "Toolbox" (hidden)
start /wait msiexec /qn /norestart /x {A7D99092-CFCA-AF69-9B61-B4A8784B5F8C}
start /wait msiexec /qn /norestart /x {6BBA26E9-AB03-4FE7-831A-3535584CA002}
start /wait msiexec /qn /norestart /x {292F0F52-B62D-4E71-921B-89A682402201}
start /wait msiexec /qn /norestart /x {0F7C2E47-089E-4d23-B9F7-39BE00100776}
start /wait msiexec /qn /norestart /x {AC13BA3A-336B-45a4-B3FE-2D3058A7B533}

:: HP Total Care Advisor
start /wait msiexec /qn /norestart /x {f32502b5-5b64-4882-bf61-77f23edcac4f}
start /wait msiexec /qn /norestart /x {0DDA7620-4F8B-43B3-8828-CA5EE292FA3B}

:: HP TouchSmart Browser, Calendar, Canvas, Clock, Notes, RSS, Tutorials, Twitter and Weather
start /wait msiexec /qn /norestart /x {4127C2C0-0AC7-4947-9CC1-AACBEFC6EC02}
start /wait msiexec /qn /norestart /x {DE77FE3F-A33D-499A-87AD-5FC406617B40}
start /wait msiexec /qn /norestart /x {03D15668-8F54-47C0-BFF2-6F966E4DF052}
start /wait msiexec /qn /norestart /x {84814E6B-2581-46EC-926A-823BD1C670F6}
start /wait msiexec /qn /norestart /x {4EDBB1CC-C418-443B-A0B0-A94DEA1ED8B2}
start /wait msiexec /qn /norestart /x {55C48613-A2DF-4286-9467-E3BCB23CD8F4}
start /wait msiexec /qn /norestart /x {872B1C80-38EC-4A31-A25C-980820593900}
start /wait msiexec /qn /norestart /x {70F9BF10-3729-4333-BCBE-5218F69582FA}
start /wait msiexec /qn /norestart /x {A535F266-291E-447F-ABE6-0BE17D0CB036}
start /wait msiexec /qn /norestart /x {19484EF1-E27A-43D1-9EEB-685D41888AC8}

:: HP TrayApp (various versions)
start /wait msiexec /qn /norestart /x {FF075778-6E50-47ed-991D-3B07FD4E3250}
start /wait msiexec /qn /norestart /x {4D304678-738E-42a0-931A-2B022F49DEB8}
start /wait msiexec /qn /norestart /x {1EC71BFB-01A3-4239-B6AF-B1AE656B15C0}
start /wait msiexec /qn /norestart /x {1B57D761-768E-4FB8-A6BB-057A977A7C81}
start /wait msiexec /qn /norestart /x {5ACE69F0-A3E8-44eb-88C1-0A841E700180}

:: HP Trust Circles
start /wait msiexec /qn /norestart /x {C4E9E8A4-EEC4-4F9E-B140-520A8B75F430}
start /wait msiexec /qn /norestart /x {0DF3F266-B52E-4309-B3CC-233607DF4E50}

:: HP SolutionCenter
start /wait msiexec /qn /norestart /x {9603DE6D-4567-4b78-B941-849322373DE2}
start /wait msiexec /qn /norestart /x {4A70EF07-7F88-4434-BB61-D1DE8AE93DD4}
start /wait msiexec /qn /norestart /x {3C023AD6-4740-479A-8B7A-B5718F240268}
start /wait msiexec /qn /norestart /x {A5AB9D5E-52E2-440e-A3ED-9512E253C81A}

:: HP UnloadSupport (hidden)
start /wait msiexec /qn /norestart /x {E06F04B9-45E6-4AC0-8083-85F7515F40F7}

:: HP Update, various versions
start /wait msiexec /qn /norestart /x {787D1A33-A97B-4245-87C0-7174609A540C}
start /wait msiexec /qn /norestart /x {97486FBE-A3FC-4783-8D55-EA37E9D171CC}
start /wait msiexec /qn /norestart /x {117BBDE7-472E-4DCD-BAAE-410A0794A335}
start /wait msiexec /qn /norestart /x {6FE8E073-D159-4419-93E2-CE2C5B078562}
start /wait msiexec /qn /norestart /x {DCEA910B-3269-4F5B-A915-D59293004751}
start /wait msiexec /qn /norestart /x {AE856388-AFAD-4753-81DF-D96B19D0A17C}
start /wait msiexec /qn /norestart /x {85D645CF-0F3B-477A-A9C9-194917F1A75B}
start /wait msiexec /qn /norestart /x {2EA3D6B2-157E-4112-A3AB-BF17E16661C3}
start /wait msiexec /qn /norestart /x {6ECB39BD-73C2-44DD-B1A0-898207C58D8B}
start /wait msiexec /qn /norestart /x {962CB079-85E6-405F-8704-1C62365AE46F}
start /wait msiexec /qn /norestart /x {904822F1-6C7D-4B91-B936-6A1C0810544C}
start /wait msiexec /qn /norestart /x {8C6027FD-53DC-446D-BB75-CACD7028A134}

:: HP USB Docking Video (wtf?)
start /wait msiexec /qn /norestart /x {B0069CFA-5BB9-4C03-B1C6-89CE290E5AFE}

:: HP UserGuide, UserProfileManager SDK Snap-in
start /wait msiexec /qn /norestart /x {C23415D8-FE94-4F52-B5C4-0FFA2202C6D9}
start /wait msiexec /qn /norestart /x {F07C2CF8-4C53-4EC3-8162-A6221E36EB88}
start /wait msiexec /qn /norestart /x {8D4B1DDC-0CB5-4908-B740-A385C2F3B6A9}

:: HP Utility Center
start /wait msiexec /qn /norestart /x {B7B82520-8ECE-4743-BFD7-93B16C64B277}
start /wait msiexec /qn /norestart /x {35021DFB-F9CA-402A-89A2-47F91E506465}

:: HP Vision Hardware Diagnostics
start /wait msiexec /qn /norestart /x {D7670221-BF9B-4DFF-B26B-5BE55A87329F}

:: HP Wallpaper 3.0.0.1
start /wait msiexec /qn /norestart /x {11B83AD3-7A46-4C2E-A568-9505981D4C6F}

:: HP Web Camera
start /wait msiexec /qn /norestart /x {C6363DC5-17A4-4E36-B701-9EC719390D48}
start /wait msiexec /qn /norestart /x {C7AE4EC3-9C13-4213-8457-74D16B353F91}

:: HP WebReg
start /wait msiexec /qn /norestart /x {179C56A4-F57F-4561-8BBF-F911D26EB435}
start /wait msiexec /qn /norestart /x {8EE94FD8-5F52-4463-A340-185D16328158}
start /wait msiexec /qn /norestart /x {350C97B0-3D7C-4EE8-BAA9-00BCB3D54227}
start /wait msiexec /qn /norestart /x {29FA38B4-0AE4-4D0D-8A51-6165BB990BB0}
start /wait msiexec /qn /norestart /x {43CDF946-F5D9-4292-B006-BA0D92013021}
start /wait msiexec /qn /norestart /x {087A66B8-1F0F-4a8d-A649-0CFE276AA7C0}
start /wait msiexec /qn /norestart /x {06C4BA69-5210-4707-B5BE-E26D487E1854}
start /wait msiexec /qn /norestart /x {14CF9AF8-10A6-4FA7-9E57-D22DBD644C77}

:: HP Wireless Assistant // Wireless Button Driver // Wireless Hotspot
start /wait msiexec /qn /norestart /x {9AB1B6EC-AEA4-4D78-ADDB-0291BF7230F4}
start /wait msiexec /qn /norestart /x {547607B0-3294-4ECA-8F5E-921404676CBB}
start /wait msiexec /qn /norestart /x {13133E99-B0D5-4143-B832-AAD55C62A41C}
start /wait msiexec /qn /norestart /x {92F7E378-0F27-4D1E-ACAE-2AA7E546D082}
start /wait msiexec /qn /norestart /x {3082CB96-66E8-456D-8326-118A4F5DC0C6}
start /wait msiexec /qn /norestart /x {CFD917BE-F1F6-410E-ABEC-9EC819507D0D}
start /wait msiexec /qn /norestart /x {5601F151-A69F-4E30-8C60-37928124CD07}
start /wait msiexec /qn /norestart /x {EC720706-3F19-4B7F-BDDD-E31D9B3921D2}

:: Instant Housecall Specialist Sign-in
start /wait msiexec /qn /norestart /x {4A89B7B3-EB5B-4B33-B7B4-99E69792C081}

:: Intel Collaborative Processor Performance Control
start /wait msiexec /qn /norestart /x {0E7DAF70-FB54-4B91-B192-7E771C25AEEB}

:: Intel(R) Dynamic Platform and Thermal Framework
start /wait msiexec /qn /norestart /x {654EE65D-FAA4-4EA6-8C07-DC94E6A304D4}

:: Intel IdentityMine Air Hockey
start /wait msiexec /qn /norestart /x {DF5DB383-DEEF-4649-8691-58353C928CCA}

:: Intel(R) Identity Protection Technology
start /wait msiexec /qn /norestart /x {C01A86F5-56E7-101F-9BC9-E3F1025EB779}
start /wait msiexec /qn /norestart /x {BE77874C-0353-49DF-A5BC-36A8FE51D95E}
start /wait msiexec /qn /norestart /x {EAF826C0-245E-4D02-9D51-BA4C98717EAE}

:: Intel(R) Management Engine Components
start /wait msiexec /qn /norestart /x {69AAE674-929D-4A17-B108-623E8FDD6EE7}
start /wait msiexec /qn /norestart /x {6C9B8590-9D31-4802-92A2-0DDFE9708C4C}
start /wait msiexec /qn /norestart /x {B4FF8C31-F307-4873-A244-BBC0233CAD4B}
start /wait msiexec /qn /norestart /x {06F2A7C5-19F0-4962-B8D2-A495B7DD2A30}
start /wait msiexec /qn /norestart /x {8B0B53D2-F5B8-4A67-93B0-5960D6ED6186}

:: Intel(R) ME UninstallLegacy
start /wait msiexec /qn /norestart /x {013FAB2E-017D-4330-8179-B5FE02E7F81C}
start /wait msiexec /qn /norestart /x {FD37351B-3074-4652-8188-1B3FB784EC4E}

:: Intel (R) Pro Alerting Agent
start /wait msiexec /qn /norestart /x {FCDDBA94-7389-49E5-B287-2661460BAF18}

:: Intel(R) Rapid Storage Technology // often the culprit behind BSODs when scanning drives with smartctl
:: ! NOTE: /u/kamakaze_chickn suggested disabling for Tron as it reportedly gives noticable performance improvement over stock msahci driver
::         Please comment on this program at reddit.com/r/TronScript on the main release thread
start /wait msiexec /qn /norestart /x {96714280-14E6-4DF7-BACD-F797C0F17C3D}
start /wait msiexec /qn /norestart /x {205AE40D-8AD7-4F29-A430-DD2168DA562D}
start /wait msiexec /qn /norestart /x {93F692D4-0C4D-4EED-9BFE-657C1D5959FE}

:: Intel(R) Security Assist
start /wait msiexec /qn /norestart /x {4B230374-6475-4A73-BA6E-41015E9C5013}

:: Intel(R) Smart Connect Technology
start /wait msiexec /qn /norestart /x {9B5FD763-5074-474C-B898-24567E6450C8}
start /wait msiexec /qn /norestart /x {DE788AD4-F7CE-4995-ADF8-56174A7B613C}
start /wait msiexec /qn /norestart /x {DBECAE94-4C04-40AC-9AFB-FA9953258EAF}

:: Intel(R) Technology Access
start /wait msiexec /qn /norestart /x {413fe921-b226-41c8-bc3c-574074ceec4d}
start /wait msiexec /qn /norestart /x {583882E7-EA75-4BF0-94FA-7DD5A3731C76}

:: Intel(R) Trusted Connect Service Client
start /wait msiexec /qn /norestart /x {B5E06417-A4AC-4225-B36E-7E34C91616E7}
start /wait msiexec /qn /norestart /x {1B444AF9-1DBE-4884-8F35-969BEFCF69A8}
start /wait msiexec /qn /norestart /x {7D84E343-A23D-451C-B123-0195B2D903A6}
start /wait msiexec /qn /norestart /x {457D6189-416A-44CD-A0A6-D6D75AD25CCF}
start /wait msiexec /qn /norestart /x {EB5FF09B-F44E-416D-ACEC-3AE0BE72C900}
start /wait msiexec /qn /norestart /x {09536BA1-E498-4CC3-B834-D884A67D7E34}
start /wait msiexec /qn /norestart /x {F27A944C-C95A-4DB7-BC8A-AEFD9B1B5E40}
start /wait msiexec /qn /norestart /x {89AFB053-A343-46EF-97E4-D593AD7184E6}
start /wait msiexec /qn /norestart /x {B5E49E64-0C1B-49AD-AE21-119CE68750E9}
start /wait msiexec /qn /norestart /x {6548B189-BEA4-4041-80E0-AEB60548E046}
start /wait msiexec /qn /norestart /x {F4404AFD-2EF3-40C1-8C09-29E5F3B6972B}
start /wait msiexec /qn /norestart /x {3DE97849-544D-4D68-9255-11DF6F9F10D8}
start /wait msiexec /qn /norestart /x {7AB8C73F-03FE-48AE-990C-CCB8D6C4FAB8}
start /wait msiexec /qn /norestart /x {977D1ABF-4089-4CA7-BA33-CC75808B7ACE}
start /wait msiexec /qn /norestart /x {A61059F4-F902-4417-8ED2-20A29972EC40}
start /wait msiexec /qn /norestart /x {3181229B-05DA-46F9-B8D4-4966BDA99A74}
start /wait msiexec /qn /norestart /x {181BBF43-CA17-4E1A-A78D-81E67A57B8A4}
start /wait msiexec /qn /norestart /x {51A66ED3-200E-4147-8D1E-E8D30936FD26}
start /wait msiexec /qn /norestart /x {44B72151-611E-429D-9765-9BA093D7E48A}
start /wait msiexec /qn /norestart /x {5EA6BC70-0CFC-413D-8465-8506B6F46EE0}

:: Intel(R) Wake on Voice 1.0.6
start /wait msiexec /qn /norestart /x {A39CDDD2-3FB3-4C98-BDE9-E3032443417C}

:: Intel(R) Trusted Execution Engine
start /wait msiexec /qn /norestart /x {E14B99BA-3282-4990-8BD7-20FD584A217F}
start /wait msiexec /qn /norestart /x {2D6248C0-4693-4CAB-9922-F05E4015F62A}
start /wait msiexec /qn /norestart /x {176E2755-0A17-42C6-88E2-192AB2131278}

:: Intel(R) Trusted Execution Engine Driver
start /wait msiexec /qn /norestart /x {4021582A-4C27-4482-A287-5D49B80DB48F}
start /wait msiexec /qn /norestart /x {6307E820-0317-4DCE-AAE0-7B6CAD867055}

:: Intel(R) Turbo Boost Technology
start /wait msiexec /qn /norestart /x {D6C630BF-8DBB-4042-8562-DC9A52CB6E7E}
start /wait msiexec /qn /norestart /x {B7368FC9-A295-4A95-A9EB-AFD659BA7B71}

:: Itibiti RTC
start /wait msiexec /qn /norestart /x {730E03E4-350E-48E5-9D3E-4329903D454D}

:: Intel Update
start /wait msiexec /qn /norestart /x {78091D68-706D-4893-B287-9F1DFB24F7AF}

:: Intel Update Manager
start /wait msiexec /qn /norestart /x {608E1B9B-A2E8-4A1F-8BAB-874EB0DD25E3}
start /wait msiexec /qn /norestart /x {43FA4AC8-46F8-423F-96FD-9A7D67048F1C}
start /wait msiexec /qn /norestart /x {75060E95-A018-47BD-BCC5-06DE7DB2744D}
start /wait msiexec /qn /norestart /x {0D01BDA8-C995-40AD-95F8-26B7EA4DCF9F}
start /wait msiexec /qn /norestart /x {83F793B5-8BBF-42FD-A8A6-868CB3E2AAEA}
start /wait msiexec /qn /norestart /x {43A76F9B-48F1-4E0D-A9B4-8E4F6C42E28C}
start /wait msiexec /qn /norestart /x {12914061-EB9B-4AE7-AC7E-0B8A607C7DF4}

:: Intel Viiv(TM) various software GUIDs
start /wait msiexec /qn /norestart /x {A6C48A9F-694A-4234-B3AA-62590B668927}
start /wait msiexec /qn /norestart /x {F007CBCE-D714-4C0B-8CE9-9B0D78116468}

:: Intel WiMAX Tutorial
start /wait msiexec /qn /norestart /x {4F26C164-9373-4974-8F43-E0F2176AF937}

:: _is1 iolo technologies' System Mechanic Professional and UniBlue DriverScanner
start /wait msiexec /qn /norestart /x {BBD3F66B-1180-4785-B679-3F91572CD3B4}
start /wait msiexec /qn /norestart /x {C2F8CA82-2BD9-4513-B2D1-08A47914C1DA}

:: iSEEK AnswerWorks English Runtime
start /wait msiexec /qn /norestart /x {18A8E78B-9EF2-496E-B310-BCD8E4C1DAB3}
start /wait msiexec /qn /norestart /x {DBCC73BA-C69A-4BF5-B4BF-F07501EE7039}
start /wait msiexec /qn /norestart /x {FE0133FE-9AEE-4A36-9F46-749E069540D3}

:: iTunes Library Updater (non Apple PUP) // added by /u/kamakazechickn
start /wait msiexec /qn /norestart /x {38EE230F-F631-451F-8800-E29F5E5C9E7D}

:: Java Auto Updater
start /wait msiexec /qn /norestart /x {4A03706F-666A-4037-7777-5F2748764D10}
start /wait msiexec /qn /norestart /x {CCB6114E-9DB9-BD54-5AA0-BC5123329C9D}
start /wait msiexec /qn /norestart /x {32A3A4F4-B792-11D6-A78A-00B0D0170550}
start /wait msiexec /qn /norestart /x {C270821D-2479-D0F4-1BD1-7BBAF6762A98}

:: Kaspersky Lab Network Agent
start /wait msiexec /qn /norestart /x {786A9F7E-CFEC-451F-B3C4-22EB11550FD8}

:: KnowHow ReadMe (currys/PCWorld bloat)
start /wait msiexec /qn /norestart /x {8AFC7125-0E25-47AA-8444-9DA7940ABBC4}

:: KODAK Share Button App
start /wait msiexec /qn /norestart /x {DE9B51D7-C575-4587-A848-DE95CD7F7684}

:: Lenovo Battery Gauge
start /wait msiexec /qn /norestart /x {B8D3ED8D-A295-44C2-8AE1-56823D44AD1F}

:: Lenovo Baby 365 Comparing
start /wait msiexec /qn /norestart /x {233EE2F2-EDA8-4C70-ABC3-D656D67D2CD5}

:: Lenovo Baby 365 Mammals
start /wait msiexec /qn /norestart /x {33492EF5-7931-45B9-B74F-E4A99068B7C9}

:: Lenovo Baby 365 Matching Roles
start /wait msiexec /qn /norestart /x {3CF4F785-AE86-4882-8D40-16A872F31821}

:: Lenovo Baby 365 Puzzle
start /wait msiexec /qn /norestart /x {B0E359C2-C984-42A4-B046-90EACA6DB037}

:: Lenovo Baby 365 Collage of Waste Materials
start /wait msiexec /qn /norestart /x {ECE59CCF-8619-4700-BD83-484962C959B8}

:: Lenovo Baby 365 Fruits
start /wait msiexec /qn /norestart /x {AA39BFDE-71E5-46A6-A10B-44C2F45A341E}

:: Lenovo Bluetooth with Enhanced Data Rate Software
start /wait msiexec /qn /norestart /x {C6D9ED03-6FCF-4410-9CB7-45CA285F9E11}

:: Lenovo ColorCorner1 // ColorCorner2 // ColorCorner3 // ColorCorner4
start /wait msiexec /qn /norestart /x {2AA72727-59CC-4915-AF99-CDF231854FCD}
start /wait msiexec /qn /norestart /x {475871E9-59B9-4E8E-8CF5-D1A4219976D7}
start /wait msiexec /qn /norestart /x {1D8267E6-F915-440C-B653-3F100CA1FA82}
start /wait msiexec /qn /norestart /x {4967FFBB-75F1-4E43-9031-40F9748D3546}

:: Lenovo Driver & Application Installation
start /wait msiexec /qn /norestart /x {BFECCF2A-F094-4066-8BFA-29CCBB7F6602}

:: Lenovo EasyCamera
start /wait msiexec /qn /norestart /x {E0A7ED39-8CD6-4351-93C3-69CCA00D12B4}

:: Lenovo Education Portal
start /wait msiexec /qn /norestart /x {65487538-FF20-421B-91DB-F6634B8D264C}

:: Lenovo Educational Puzzle - Larsen Introduction Pack
start /wait msiexec /qn /norestart /x {F4904A51-D3CA-451D-A169-6D38CE2C5442}

:: Lenovo Horizon 2 Demo
start /wait msiexec /qn /norestart /x {9DE59A82-7B65-44B5-96EA-00BA4E8598C5}

:: Lenovo Idea Notes
start /wait msiexec /qn /norestart /x {BF601122-9F0A-41A9-BA06-3158D9FB4B80}

:: Lenovo Magic Transfer
start /wait msiexec /qn /norestart /x {AD2B2BD1-A1D7-4798-8FDD-B2A58FD94E68}

:: Lenovo Media Puzzle - Introduction Pack
start /wait msiexec /qn /norestart /x {C03C6D4C-6606-4268-AC4C-23508721F112}

:: Lenovo Message Center Plus
start /wait msiexec /qn /norestart /x {3849486C-FF09-4F5D-B491-3E179D58EE15}
start /wait msiexec /qn /norestart /x {7F8205DE-DDFA-4156-ADA2-766E9CB4FABC}
start /wait msiexec /qn /norestart /x {8C6D6116-B724-4810-8F2D-D047E6B7D68E}
start /wait msiexec /qn /norestart /x {C2C2DB64-1BCE-4FA7-962D-457795ECCEC0}

:: Lenovo Metric Collection SDK
start /wait msiexec /qn /norestart /x {DDAA788F-52E6-44EA-ADB8-92837B11BF26}
start /wait msiexec /qn /norestart /x {C2B5B5B0-2545-4E94-B4BA-548D4BF0B196}
start /wait msiexec /qn /norestart /x {50816F92-1652-4A7C-B9BC-48F682742C4B}

:: Lenovo Mobile Phone Wireless Import
start /wait msiexec /qn /norestart /x {DFB2E0D6-8DDE-49A4-B8F7-03C14DACCBA6}

:: Lenovo Motion Control
start /wait msiexec /qn /norestart /x {0D740B00-2307-44AC-B91B-F3E67444ECA6}
start /wait msiexec /qn /norestart /x {3963D1D4-8723-4EE4-9694-D1078BB26B75}

:: Lenovo OneKey Recovery // Disabled by /u/kamakaze_chickn for Tron
::start /wait msiexec /qn /norestart /x {46F4D124-20E5-4D12-BE52-EC177A7A4B42}

:: Levovo OneKey Optimizer
start /wait msiexec /qn /norestart /x {D5D573DC-D989-4769-9B56-D6A7EA503D7F}

:: Lenovo OneKey Theater
start /wait msiexec /qn /norestart /x {91CC5BAE-A098-40D3-A43B-C0DC7CE263FE}

:: Lenovo Patch Utility
start /wait msiexec /qn /norestart /x {C6FB6B4A-1378-4CD3-9CD3-42BA69FCBD43}

:: Lenovo PowerENGAGE (wtf?)
start /wait msiexec /qn /norestart /x {15B15395-FF53-44E1-ADAD-FCC279E3CA10}

:: Lenovo PhoneCompanion
start /wait msiexec /qn /norestart /x {0F82EA83-B0C5-4AB9-9695-DFE92C5FD57B}

:: Lenovo Photo Master
start /wait msiexec /qn /norestart /x {BC94C56A-3649-420C-8756-2ADEBE399D33}

:: Lenovo Quick Control
start /wait msiexec /qn /norestart /x {4855C42F-5197-4AAD-A50D-5066D2CC4647}

:: Lenovo QuickOptimizer
start /wait msiexec /qn /norestart /x {8D2C871B-1B9F-45AC-9C43-2BB18089CDFA}

:: Lenovo Reach and REACHit
start /wait msiexec /qn /norestart /x {3245D8C8-7FE0-4FD4-B04B-2720A333D592}
start /wait msiexec /qn /norestart /x {0B5E0E89-4BCA-4035-BBA1-D1439724B6E2}
start /wait msiexec /qn /norestart /x {4532E4C5-C84D-4040-A044-ECFCC5C6995B}

:: Lenovo Recommends
start /wait msiexec /qn /norestart /x {267C8BA0-876B-4589-9F14-EFB84ABCEA7F}

:: Lenovo Recovery Media
start /wait msiexec /qn /norestart /x {50DC5136-21E8-48BC-97E5-1AD055F6B0B6}

:: Lenovo Registration
start /wait msiexec /qn /norestart /x {6707C034-ED6B-4B6A-B21F-969B3606FBDE}

:: Lenovo SimpleTap
start /wait msiexec /qn /norestart /x {C0C17EF3-83ED-4956-8638-7354EBE7FFFF}
start /wait msiexec /qn /norestart /x {792920BD-8D8D-4868-AE2F-16F4B05D3AE9}

:: Lenovo Slim USB Keyboard
start /wait msiexec /qn /norestart /x {2DC26D10-CC6A-494F-BEA3-B5BC21126D5E}

:: Lenovo SMB Customizations
start /wait msiexec /qn /norestart /x {AFD7B869-3B70-40C7-8983-769256BA3BD2}

:: Lenovo System Interface Foundation
start /wait msiexec /qn /norestart /x {C2E5CA37-C862-4A69-AC6D-24F450A20C16}

:: Lenovo System Update
start /wait msiexec /qn /norestart /x {25097770-2B1F-49F6-AB9D-1C708B96262A}

:: Lenovo Solution Center
start /wait msiexec /qn /norestart /x {63942F7E-3646-45EC-B8A9-EAC40FEB66DB}
start /wait msiexec /qn /norestart /x {13BD494D-9ACD-420B-A291-E145DED92EF6}
start /wait msiexec /qn /norestart /x {4C2B6F96-3AED-4E3F-8DCE-917863D1E6B1}
start /wait msiexec /qn /norestart /x {494D80C4-3557-4D73-A153-65FE4B3ECDC3}
start /wait msiexec /qn /norestart /x {15730627-A3E2-4EBA-A431-CAD867DADFFD}

:: Lenovo System Update
start /wait msiexec /qn /norestart /x {25C64847-B900-48AD-A164-1B4F9B774650}
start /wait msiexec /qn /norestart /x {8675339C-128C-44DD-83BF-0A5D6ABD8297}
start /wait msiexec /qn /norestart /x {C9335768-C821-DD44-38FB-A0D5A6DB2879}

:: Lenovo ThinkVantage: Active Protection System // Fingerprint Software // System Update
start /wait msiexec /qn /norestart /x {10F5A72A-1E07-4FAE-A7E7-14B10CC66B17}
start /wait msiexec /qn /norestart /x {46A84694-59EC-48F0-964C-7E76E9F8A2ED}
start /wait msiexec /qn /norestart /x {479016BF-5B8D-445F-BE15-A187F25D81C8}

:: Lenovo Updates
start /wait msiexec /qn /norestart /x {A2E1E9F0-0B68-4166-8C7F-85B563B84DF4}

:: Lenovo User Guide
start /wait msiexec /qn /norestart /x {13F59938-C595-479C-B479-F171AB9AF64F}
start /wait msiexec /qn /norestart /x {A923CF0A-44D9-4357-B2E8-0A2352151A3C}

:: Lenovo User Manuals
start /wait msiexec /qn /norestart /x {F07C2CF8-4C53-4EC3-8162-A6221E36EB88}

:: LenovoUtility
start /wait msiexec /qn /norestart /x {6ADA7E88-8D16-4D0D-BC90-2B93AC5E56DA}

:: Lenovo Warranty Info
start /wait msiexec /qn /norestart /x {FD4EC278-C1B1-4496-99ED-C0BE1B0AA521}
start /wait msiexec /qn /norestart /x {EFC9FE7C-ECE8-4282-8F77-FEDCAD374C77}

:: Lenovo Web Start (Pokki Start Menu)
if exist "%LOCALAPPDATA%\Pokki\Engine\HostAppService.exe" "%LOCALAPPDATA%\Pokki\Engine\HostAppService.exe" /UNINSTALL04bb6df446330549a2cb8d67fbd1a745025b7bd1

:: Lenovo Welcome
start /wait msiexec /qn /norestart /x {1CA74803-5CB2-4C03-BDBE-061EDC81CC7F}

:: Lenovo Yoga 3 Pro Demo
start /wait msiexec /qn /norestart /x {A4D294C5-D925-4FEA-9C60-16B8CB92F95A}

:: Level Quality Watcher (outright adware, no pretense of being anything else)
start /wait msiexec /qn /norestart /x {19DC5AB8-0792-4875-8F1B-896C5A9CE6AE}

:: LightScribe
start /wait msiexec /qn /norestart /x {6226477E-444F-4DFE-BA19-9F4F7D4565BC}
start /wait msiexec /qn /norestart /x {A87B11AC-4344-4E5D-8B12-8F471A87DAD9}
start /wait msiexec /qn /norestart /x {D755C7A3-C03E-4460-8C00-AC6E55505FB5}
start /wait msiexec /qn /norestart /x {FA8BFB25-BF48-4F8B-8859-B30810745190}

:: Logitech eReg // Harmony Remote Software // Updater
start /wait msiexec /qn /norestart /x {3EE9BCAE-E9A9-45E5-9B1C-83A4D357E05C}
start /wait msiexec /qn /norestart /x {53735ECE-E461-4FD0-B742-23A352436D3A}
start /wait msiexec /qn /norestart /x {B5DA9D49-9BD8-0F2F-52FC-C7E66BC8D944}

:: LWS Facebook // Gallery // Help_main // Launcher // Motion Detection // Pictures And Video // Twitter // Webcam Software // WLM Plugin // YouTube Plugin
start /wait msiexec /qn /norestart /x {9DAEA76B-E50F-4272-A595-0124E826553D}
start /wait msiexec /qn /norestart /x {21DF0294-6B9D-4741-AB6F-B2ABFBD2387E}
start /wait msiexec /qn /norestart /x {08610298-29AE-445B-B37D-EFBE05802967}
start /wait msiexec /qn /norestart /x {71E66D3F-A009-44AB-8784-75E2819BA4BA}
start /wait msiexec /qn /norestart /x {6F76EC3C-34B1-436E-97FB-48C58D7BEDCD}
start /wait msiexec /qn /norestart /x {B38E9B55-7136-4E66-A084-320512FF3F6F}
start /wait msiexec /qn /norestart /x {1651216E-E7AD-4250-92A1-FB8ED61391C9}
start /wait msiexec /qn /norestart /x {83C8FA3C-F4EA-46C4-8392-D3CE353738D6}
start /wait msiexec /qn /norestart /x {8937D274-C281-42E4-8CDB-A0B2DF979189}
start /wait msiexec /qn /norestart /x {174A3B31-4C43-43DD-866F-73C9DB887B48}

:: ScorpionSaver // ScorpionSaver Services
start /wait msiexec /qn /norestart /x {9B65F9A3-9D24-452A-B6EF-1457D65E4259}
start /wait msiexec /qn /norestart /x {273E1F1A-7B1A-436C-A783-A4A8C97AD036}
start /wait msiexec /qn /norestart /x {6E810AB6-F34E-49A3-A93F-9E503660F718}

:: Setup1 (??)
start /wait msiexec /qn /norestart /x {86091EC1-DD17-4814-A54B-0A634CB8D82C}

:: Snap.Do (browser hijacker)
start /wait msiexec /qn /norestart /x {CC6F61A9-A55E-4D04-A674-7A498CD8B809}

:: Snapfish Picture Mover
start /wait msiexec /qn /norestart /x {029B5901-1F27-4347-9923-E8ACC8F54E15}

:: SSN Librarian (some sketchy Russian program)
start /wait msiexec /qn /norestart /x {1D425886-3FE1-41AA-8D7A-E432CE29A4AE}

:: Steam 1.0.0.0 (malware; not Valve's Steam)
start /wait msiexec /qn /norestart /x {AE8705FB-E13C-40A9-8A2D-68D6733FBFC2}

:: SupportSoft Assisted Service 15 // SupportUtility (various versions)
start /wait msiexec /qn /norestart /x {3002C8EB-2A7E-419B-B77F-5AD7E9F54A5A}
start /wait msiexec /qn /norestart /x {31AF8802-BF43-4C43-984B-EC597CF51505}
start /wait msiexec /qn /norestart /x {5A3F6A80-7913-475E-8B96-477A952CFA43}

:: Macromedia Flash Player 7 (!!)
start /wait msiexec /qn /norestart /x {DA7F7862-AB37-4464-B4CF-1256EC5E4B65}

:: MarketResearch
start /wait msiexec /qn /norestart /x {175F0111-2968-4935-8F70-33108C6A4DE3}
start /wait msiexec /qn /norestart /x {13F00518-807A-4B3A-83B0-A7CD90F3A398}
start /wait msiexec /qn /norestart /x {D2E0F0CC-6BE0-490b-B08B-9267083E34C9}
start /wait msiexec /qn /norestart /x {b145ec69-66f5-11d8-9d75-000129760d75}

:: Maxx Audio Installer
start /wait msiexec /qn /norestart /x {D9428275-602F-4D4B-A921-9CC642B76995}
start /wait msiexec /qn /norestart /x {307032B2-6AF2-46D7-B933-62438DEB2B9A}

:: McAfee LiveSafe - Internet Security
if exist "%ProgramFiles(x86)%\McAfee\MSC\mcuihost.exe" "%ProgramFiles(x86)%\McAfee\MSC\mcuihost.exe" /body:misp://MSCJsRes.dll::uninstall.html /id:uninstall
if exist "%ProgramFiles%\McAfee\MSC\mcuihost.exe" "%ProgramFiles%\McAfee\MSC\mcuihost.exe" /body:misp://MSCJsRes.dll::uninstall.html /id:uninstall

:: McAfee WebAdvisor
start /wait msiexec /qn /norestart /x {35ED3F83-4BDC-4c44-8EC6-6A8301C7413A}

:: McAfee Virtual Technician
start /wait msiexec /qn /norestart /x {8F1A20DC-251D-47B0-91B7-DCA2523EE6C9}

:: Media Gallery
start /wait msiexec /qn /norestart /x {115B60D5-BBDB-490E-AF2E-064D37A3CE01}

:: Microsoft Application Error Reporting
start /wait msiexec /qn /norestart /x {95120000-00B9-0409-1000-0000000FF1CE}

:: Microsoft DVD App Installation for Microsoft.WindowsDVDPlayer_2019.6.11761.0_neutral_~_8wekyb3d8bbwe (x64)
start /wait msiexec /qn /norestart /x {986E003C-E56D-5A47-110E-D3C81F0E8535}

:: Microsoft Mouse and Keyboard Center (various versions) // Disabled by /u/kamakaze_chickn for Tron
::start /wait msiexec /qn /norestart /x {91150000-0051-0000-1000-0000000FF1CE}
::start /wait msiexec /qn /norestart /x {7A56D81D-6406-40E7-9184-8AC1769C4D69}
::start /wait msiexec /qn /norestart /x {B8A9EB6B-E41A-4B69-B996-3BFCFA743E5C}
::start /wait msiexec /qn /norestart /x {E20B2752-0909-4B28-B8A9-A9BE519CA1A1}
::start /wait msiexec /qn /norestart /x {22F9A831-CA56-4406-85FE-47FFB0472804}

:: Microsoft: Feedback Tool by Microsoft
start /wait msiexec /qn /norestart /x {13A5E785-5197-4EAD-8EE3-D660271E49BC}

:: Microsoft Online Services Sign-in Assistant
start /wait msiexec /qn /norestart /x {5D62CA9E-C68A-4BED-A1E9-7D38D9DDC2DB}

:: Microsoft Office 15 Click-to-Run Extensibility Component (various versions)
start /wait msiexec /qn /norestart /x {90150000-008C-0000-0000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90150000-007E-0000-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {D535FC73-1F63-4347-896A-C97A45F11E9C}
start /wait msiexec /qn /norestart /x {90150000-007E-0000-0000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90150000-008C-0409-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90150000-008C-0000-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90150000-008C-0409-0000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90150000-008F-0000-1000-0000000FF1CE}

:: Microsoft Office 16 Click-to-Run
start /wait msiexec /qn /norestart /x {90160000-008C-0000-0000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90160000-008C-0409-0000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90160000-008F-0000-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90160000-008C-0000-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90160000-008C-0409-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90160000-007E-0000-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90160000-008C-0407-0000-0000000FF1CE}

:: Microsoft Office 2003 Web Components
start /wait msiexec /qn /norestart /x {90120000-00A4-0409-0000-0000000FF1CE}

:: Microsoft Office 2007 "Get Started Tab" for PowerPoint, Excel, and Word
start /wait msiexec /qn /norestart /x {5AE5DB70-5CE6-4876-A83E-8246CC36FC28}
start /wait msiexec /qn /norestart /x {AB706D91-2242-4E1D-B4D0-1ED35387F5A7}
start /wait msiexec /qn /norestart /x {68B52EFD-86CC-486E-A8D0-A3A1554CB5BC}

:: Microsoft Office Click-to-Run 2010 14.0.4763.1000
start /wait msiexec /qn /norestart /x {90140000-006D-0409-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90140000-0054-0409-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90140000-006D-0409-0000-0000000FF1CE}

:: Microsoft Office File Validation Add-In (frequently causes Excel to hang)
start /wait msiexec /qn /norestart /x {90140000-2005-0000-0000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90140000-1138-0000-1000-0000000FF1CE}

:: Microsoft Office Groove (various versions); I've NEVER seen anyone use this; if you encounter a user actually using it in the wild let me know and we'll remove it from this list
start /wait msiexec /qn /norestart /x {91120000-00A1-0000-0000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90140000-00A1-0409-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {91140000-0057-0000-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90120000-00B4-0409-0000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90140000-00BA-0000-1000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90140000-00BA-0409-0000-0000000FF1CE}
start /wait msiexec /qn /norestart /x {90120000-00D1-0409-0000-0000000FF1CE}

:: Microsoft OGA Notifier (Windows "Genuine Advantage" popup nagger)
start /wait msiexec /qn /norestart /x {90150000-008F-0000-1000-0000000FF1CE}

:: Microsoft Search Enhancement Pack
start /wait msiexec /qn /norestart /x {4CBA3D4C-8F51-4D60-B27E-F6B641C571E7}
start /wait msiexec /qn /norestart /x {1CAC7A41-583B-4483-9FA5-3E5465AFF8C2}
start /wait msiexec /qn /norestart /x {F0E12BBA-AD66-4022-A453-A1C8A0C4D570}

:: Microsoft Tablet PC Tutorials for Microsoft Windows XP SP2 1.7
start /wait msiexec /qn /norestart /x {F2BF3E35-8AF4-4DFF-8C07-C3B05B8E2126}

:: Modem Diagnostic Tool
start /wait msiexec /qn /norestart /x {779DECD7-E072-4B56-9B6B-BEB5973EEEB5}

:: MobileME Control Panel (deprecated Apple service)
start /wait msiexec /qn /norestart /x {AC2BA148-EE9C-4F1A-AFCE-F38C2C71D29B}
start /wait msiexec /qn /norestart /x {3AC54383-31D1-4907-961B-B12CBB1D0AE8}

:: MSN Explorer Repair Tool
start /wait msiexec /qn /norestart /x {3D36105D-D6C2-413A-9355-7370E8D9125B}

:: MSN Toolbar Platform
start /wait msiexec /qn /norestart /x {C9D43B38-34AD-4EC2-B696-46F42D49D174}

:: muvee autoProducer 6.0
start /wait msiexec /qn /norestart /x {14AF024E-2E3B-49D0-A175-D1C1A06B155A}
:: %ProgramFiles%\InstallShield Installation Information\{14AF024E-2E3B-49D0-A175-D1C1A06B155A}\setup.exe -runfromtemp -l0x0009 -removeonly
:: %ProgramFiles(x86)%\InstallShield Installation Information\{14AF024E-2E3B-49D0-A175-D1C1A06B155A}\setup.exe -runfromtemp -l0x0009 -removeonly

:: MyEpson Portal
start /wait msiexec /qn /norestart /x {3361D415-BA35-4143-B301-661991BA6219}

:: My Way Search Assistant
start /wait msiexec /qn /norestart /x {05F1B866-2372-4E82-9AA8-C64FB11CEF8B}

:: Nero: Welcome App
start /wait msiexec /qn /norestart /x {828175FA-7307-4DBF-95AD-9CEE086B6F45}

:: Nero SyncUP
start /wait msiexec /qn /norestart /x {D92C9CCE-E5F0-4125-977A-0590F3225B74}

:: NetTALK DUO Wifi Management Tool
start /wait msiexec /qn /norestart /x {15D27BA3-6CCD-4848-8925-07EF083492AD}

:: Network64, HP? malware?
start /wait msiexec /qn /norestart /x {6BFAB6C1-6D46-46DB-A538-A269907C9F2F}
start /wait msiexec /qn /norestart /x {48C0866E-57EB-444C-8371-8E4321066BC3}

:: NETGEAR A6100 Genie 1.0.0.12
start /wait msiexec /qn /norestart /x {56C049BE-79E9-4502-BEA7-9754A3E60F9B}

:: New York Times Reader
start /wait msiexec /qn /norestart /x {491ADA37-04EE-2ECE-9F86-DDC0106047AC}

:: Nitro Pro 8
start /wait msiexec /qn /norestart /x {2269F0D5-DE47-4313-9003-BB6357919314}
start /wait msiexec /qn /norestart /x {392C767D-4EE2-49B5-A3B4-A4C3AB6DC145}
start /wait msiexec /qn /norestart /x {6E7DFD3E-2E89-4F35-B4F2-D3301A4AD190}

:: Nitro Pro 9
start /wait msiexec /qn /norestart /x {70B831B7-A8EE-4C5F-8F34-F383D24B3A04}

:: Norton 360 // Internet Security // Online Backup
start /wait msiexec /qn /norestart /x {E4FC1ED9-E20C-4621-B834-03C388278DD8}
start /wait msiexec /qn /norestart /x {63A6E9A9-A190-46D4-9430-2DB28654AFD8}
start /wait msiexec /qn /norestart /x {7B15D70E-9449-4CFB-B9BC-798465B2BD5C}
start /wait msiexec /qn /norestart /x {40A66DF6-22D3-44B5-A7D3-83B118A2C0DC}

:: Nuance Cloud Connector
start /wait msiexec /qn /norestart /x {EEE31B2B-F517-4BD2-8F92-57E4AE938BA3}

:: Nuance PDF Viewer Plus
start /wait msiexec /qn /norestart /x {042A6F10-F770-4886-A502-B795DCF2D3B5}

:: Office 2013 C2R Suite
start /wait msiexec /qn /norestart /x {90150000-0138-0409-0000-0000000FF1CE}
if exist "%ProgramData%\Microsoft\OEMOffice15\OOBE\x86\oemoobe.msi" start /wait msiexec /qn /norestart /x "%ProgramData%\Microsoft\OEMOffice15\OOBE\x86\oemoobe.msi"

:: opensource
start /wait msiexec /qn /norestart /x {3677D4D8-E5E0-49FC-B86E-06541CF00BBE}
start /wait msiexec /qn /norestart /x {E6B87DC4-2B3D-4483-ADFF-E483BF718991}

:: P@H-Protocol (coupon nagware/bloatware)
start /wait msiexec /qn /norestart /x {14F936AB-5D31-410E-A4E2-70AE504712F2}
start /wait msiexec /qn /norestart /x {2D91C34E-12CC-4B1B-90D5-31DAD47B6F48}

:: Panasonic Common Components for Panasonic PC 3.0.1400.100
start /wait msiexec /qn /norestart /x {7804E86D-6DA1-1014-8C88-F05533644796}

:: PaperVision Web Assistant
start /wait msiexec /qn /norestart /x {739843A9-A2D0-4994-8DE0-AF9FF1BB1A27}

:: Perion Networks Photo Notifier and Animation Creator
start /wait msiexec /qn /norestart /x {722CD95C-98C7-4E73-925A-68D2D4F651A6}

:: Pinger
start /wait msiexec /qn /norestart /x {9B56B031-A6C0-4BB7-8F61-938548C1B759}

:: Plantronics MyHeadset Updater
start /wait msiexec /qn /norestart /x {24116AB5-8147-42F6-9A09-6B26DBBCE584}
start /wait msiexec /qn /norestart /x {7D7B61A3-22AC-4141-B88E-5F695128DAD0}
start /wait msiexec /qn /norestart /x {3728D9BC-8267-4546-B359-E7855CA3BEA0}
start /wait msiexec /qn /norestart /x {35806341-97A1-464A-A809-BC5F62E08439}
start /wait msiexec /qn /norestart /x {9F94F9AC-CFFF-477A-AF0A-FF443FEF0261}
start /wait msiexec /qn /norestart /x {15B1D4C6-A245-41CD-96E8-5C63E37DDBFF}
start /wait msiexec /qn /norestart /x {26A67848-1222-4691-B5BA-7E026585886B}

:: Playalot Games
start /wait msiexec /qn /norestart /x {3A3532ED-A121-4297-AA4F-70B60E4BD631}

:: PlayReady PC Runtime amd64 // x86
start /wait msiexec /qn /norestart /x {BCA9334F-B6C9-4F65-9A73-AC5A329A4D04}
start /wait msiexec /qn /norestart /x {20D4A895-748C-4D88-871C-FDB1695B0169}

:: PlayStation(R)Network Downloader (hidden)
start /wait msiexec /qn /norestart /x {B6659DD8-00A7-4A24-BBFB-C1F6982E5D66}

:: PlayStation(R)Store (hidden)
start /wait msiexec /qn /norestart /x {0E532C84-4275-41B3-9D81-D4A1A20D8EE7}

:: PSE10 STI Installer
start /wait msiexec /qn /norestart /x {11D08055-939C-432b-98C3-E072478A0CD7}

:: QualxServ Service Agreement
start /wait msiexec /qn /norestart /x {18401E1E-1E44-461A-A4B2-E48B1A727818}
start /wait msiexec /qn /norestart /x {A84A4FB1-D703-48DB-89E0-68B6499D2801}
start /wait msiexec /qn /norestart /x {903679E8-44C8-4C07-9600-05C92654FC50}

:: Qualcomm Atheros Setup
start /wait msiexec /qn /norestart /x {18373B57-4FC3-4B1A-95B3-A7E5DCA577F7}

:: QuickTime 7
start /wait msiexec /qn /norestart /x {3D2CBC2C-65D4-4463-87AB-BB2C859C1F3E}
start /wait msiexec /qn /norestart /x {AF0CE7C0-A3E4-4D73-988B-B29187EC6E9A}
start /wait msiexec /qn /norestart /x {627FFC10-CE0A-497F-BA2B-208CAC638010}
start /wait msiexec /qn /norestart /x {87CF757E-C1F1-4D22-865C-00C6950B5258}
start /wait msiexec /qn /norestart /x {28BE306E-5DA6-4F9C-BDB0-DBA3C8C6FFFD}
start /wait msiexec /qn /norestart /x {57752979-A1C9-4C02-856B-FBB27AC4E02C}
start /wait msiexec /qn /norestart /x {7BE15435-2D3E-4B58-867F-9C75BED0208C}
start /wait msiexec /qn /norestart /x {80CEEB1E-0A6C-45B9-A312-37A1D25FDEBC}
start /wait msiexec /qn /norestart /x {111EE7DF-FC45-40C7-98A7-753AC46B12FB}
start /wait msiexec /qn /norestart /x {1451DE6B-ABE1-4F62-BE9A-B363A17588A2}
start /wait msiexec /qn /norestart /x {B67BAFBA-4C9F-48FA-9496-933E3B255044}
start /wait msiexec /qn /norestart /x {A429C2AE-EBF1-4F81-A221-1C115CAADDAD}

:: RapidBoot Shield
start /wait msiexec /qn /norestart /x {D446E416-1045-4C70-9341-F73333DCB149}

:: Recovery Manager (HP Reimage Software by Cyberlink) // Disabled by /u/kamakaze_chickn for Tron
::start /wait msiexec /qn /norestart /x {44B2A0AB-412E-4F8C-B058-D1E8AECCDFF5}
::start /wait msiexec /qn /norestart /x {C7231F7C-6530-4E65-ADA6-5B392CF5BEB1}

:: RealDownloader
start /wait msiexec /qn /norestart /x {C8E8D2E3-EF6A-4B1D-A09E-7B27EBE2F3CE}
start /wait msiexec /qn /norestart /x {2259DBC1-EFFB-42B5-BA35-DFC0AAB2B3FB}
start /wait msiexec /qn /norestart /x {B0235718-21E0-4A90-A42F-9C64C1B531CD}
start /wait msiexec /qn /norestart /x {3DC873BB-FFE3-46BF-9701-26B9AE371F9F}
start /wait msiexec /qn /norestart /x {F1D90260-417F-4EB3-9F7B-1D8C86D910A2}
start /wait msiexec /qn /norestart /x {F8D2BE6A-B725-47CD-A931-639A24B8EF10}
start /wait msiexec /qn /norestart /x {6FCD4D5A-20B9-4D79-ABA5-4E7048944025}
start /wait msiexec /qn /norestart /x {EA1FAE0F-2354-4E32-B423-ABAE8E358F91}

:: RealNetworks - Microsoft Visual C++ 2008/2010 runtime 9/10
start /wait msiexec /qn /norestart /x {21E47F47-C9A7-4454-BA48-388327B0EA00}
start /wait msiexec /qn /norestart /x {7770E71B-2D43-4800-9CB3-5B6CAAEBEBEA}
start /wait msiexec /qn /norestart /x {F82B6DA3-73AC-4563-8BF8-4A24551CF64C}
start /wait msiexec /qn /norestart /x {AAECF7BA-E83B-4A10-87EA-DE0B333F8734}

:: Rhapsody Player Engine
start /wait msiexec /qn /norestart /x {2DFF31F9-7893-4922-AF66-C9A1EB4EBB31}

:: Roxio GUIDs; too many to list, Google for individual GUIDs if a Roxio program you want to keep is getting removed
start /wait msiexec /qn /norestart /x {9D6DFAD6-09E5-445E-A4B5-A388FEEBD90D}
start /wait msiexec /qn /norestart /x {11F93B4B-48F0-4A4E-AE77-DFA96A99664B}
start /wait msiexec /qn /norestart /x {098122AB-C605-4853-B441-C0A4EB359B75}
start /wait msiexec /qn /norestart /x {537BF16E-7412-448C-95D8-846E85A1D817}
start /wait msiexec /qn /norestart /x {60B2315F-680F-4EB3-B8DD-CCDC86A7CCAB}
start /wait msiexec /qn /norestart /x {0394CDC8-FABD-4ed8-B104-03393876DFDF}
start /wait msiexec /qn /norestart /x {33FE019D-01E1-4B0F-8D7A-BE2D54B9FA22}
start /wait msiexec /qn /norestart /x {9569E6BC-326A-432F-97AB-35263A327BF1}
start /wait msiexec /qn /norestart /x {CCEAD6DE-A863-497A-A5C0-464AB06B47FD}
start /wait msiexec /qn /norestart /x {48A669A9-76FA-4CA8-BFD5-00C125AC4166}
start /wait msiexec /qn /norestart /x {A121EEDE-C68F-461D-91AA-D48BA226AF1C}
start /wait msiexec /qn /norestart /x {938B1CD7-7C60-491E-AA90-1F1888168240}
start /wait msiexec /qn /norestart /x {74DC8A26-4E05-40B6-AD11-C9428A1AE150}
start /wait msiexec /qn /norestart /x {67CA389E-E759-4181-99FA-CD8B63853FB1}
start /wait msiexec /qn /norestart /x {B05B22B8-72AE-4DC3-8D6F-FBC2233CAF41}
start /wait msiexec /qn /norestart /x {EC877639-07AB-495C-BFD1-D63AF9140810}
start /wait msiexec /qn /norestart /x {07159635-9DFE-4105-BFC0-2817DB540C68}
start /wait msiexec /qn /norestart /x {120262A6-7A4B-4889-AE85-F5E5688D3683}
start /wait msiexec /qn /norestart /x {0D397393-9B50-4c52-84D5-77E344289F87}
start /wait msiexec /qn /norestart /x {C8B0680B-CDAE-4809-9F91-387B6DE00F7C}
start /wait msiexec /qn /norestart /x {7746BFAA-2B5D-4FFD-A0E8-4558F4668105}
start /wait msiexec /qn /norestart /x {BACE8BFA-8F39-421D-BEF1-6E78632BDC90}
start /wait msiexec /qn /norestart /x {83FFCFC7-88C6-41c6-8752-958A45325C82}
start /wait msiexec /qn /norestart /x {A33E7B0C-B99C-4EC9-B702-8A328B161AF9}
start /wait msiexec /qn /norestart /x {08E81ABD-79F7-49C2-881F-FD6CB0975693}
start /wait msiexec /qn /norestart /x {F6377647-81AF-41C0-BC7E-06CF37E204AB}
start /wait msiexec /qn /norestart /x {30465B6C-B53F-49A1-9EBA-A3F187AD502E}
start /wait msiexec /qn /norestart /x {73A4F29F-31AC-4EBD-AA1B-0CC5F18C8F83}
start /wait msiexec /qn /norestart /x {ED439A64-F018-4DD4-8BA5-328D85AB09AB}
start /wait msiexec /qn /norestart /x {EF56258E-0326-48C5-A86C-3BAC26FC15DF}
start /wait msiexec /qn /norestart /x {386C29BB-2CEA-3511-89A0-D78306B139AA}
start /wait msiexec /qn /norestart /x {66D171AA-670F-4309-9C74-5BA7F7DBA0B3}
start /wait msiexec /qn /norestart /x {1F54DAFA-9261-4A62-B59D-6C9F26B48FE4}
start /wait msiexec /qn /norestart /x {F06B5C4C-8D2E-4B24-9D43-7A45EEC6C878}
start /wait msiexec /qn /norestart /x {619CDD8A-14B6-43a1-AB6C-0F4EE48CE048}
start /wait msiexec /qn /norestart /x {5A06423A-210C-49FB-950E-CB0EB8C5CEC7}
start /wait msiexec /qn /norestart /x {6675CA7F-E51B-4F6A-99D4-F8F0124C6EAA}
start /wait msiexec /qn /norestart /x {F4862B43-A087-4826-8C50-D41646EC7728}
start /wait msiexec /qn /norestart /x {8FE60B86-0B99-426D-8DBE-BEC526FDED71}
start /wait msiexec /qn /norestart /x {B6A26DE5-F2B5-4D58-9570-4FC760E00FCD}
start /wait msiexec /qn /norestart /x {880AF49C-34F7-4285-A8AD-8F7A3D1C33DC}
start /wait msiexec /qn /norestart /x {2F4C24E6-CBD4-4AAC-B56F-C9FD44DE5668}
start /wait msiexec /qn /norestart /x {FE51662F-D8F6-43B5-99D9-D4894AF00F83}
start /wait msiexec /qn /norestart /x {6F0BBEFE-BE1C-419B-BA1F-D36C9E7915BC}

:: Samsung MagicTunePremium (monitor selection app)
start /wait msiexec /qn /norestart /x {79E9C7C5-4FCC-4DFF-B79E-17319E9522F3}

:: Samsung RAPID Mode
start /wait msiexec /qn /norestart /x {2806889C-B2E7-4B91-898B-4C3198BD258F}
start /wait msiexec /qn /norestart /x {ED818A3C-3DF5-CDCF-3DB2-A646D7B31A16}

:: Samsung Story Album Viewer
start /wait msiexec /qn /norestart /x {698BBAD8-B116-495D-B879-0F07A533E57F}

:: Samsung SW Update (disables Windows Update; wtf Samsung??)
start /wait msiexec /qn /norestart /x {AAFEFB05-CF98-48FC-985E-F04CD8AD620D}

:: ShufflePlusVLOI
start /wait msiexec /qn /norestart /x {0A80329D-1B59-4F10-8D1D-924C59B2840B}

:: Skins 2007/2008/2009/2010
start /wait msiexec /qn /norestart /x {BECEB1AC-BFFC-443F-9457-359127BD2DE1}
start /wait msiexec /qn /norestart /x {8573BE35-DA4F-D73F-0BC7-01199875F61C}
start /wait msiexec /qn /norestart /x {06F2B3DC-74F4-300D-D41A-B21B46101CA2}
start /wait msiexec /qn /norestart /x {0C7FDF6A-C463-173A-7957-74042481E593}

:: SkyFontsT 4.3.0.0
start /wait msiexec /qn /norestart /x {E11D4FE9-718A-D54C-9C19-A13CA89B9E18}

:: Sky Broadband Browser Branding
start /wait msiexec /qn /norestart /x {5BBD0D3F-E4B2-4EE4-806A-07A95D4E2683}

:: Skype Click 2 Call
start /wait msiexec /qn /norestart /x {981029E0-7FC9-4CF3-AB39-6F133621921A}
start /wait msiexec /qn /norestart /x {5EE47864-CF84-4629-86A6-50BEFF406BE5}
start /wait msiexec /qn /norestart /x {B6CF2967-C81E-40C0-9815-C05774FEF120}

:: SlimCleaner Plus  //  SlimDrivers
start /wait msiexec /qn /norestart /x {0C0F368E-17C4-4F28-9F1B-B1DA1D96CF7A}
start /wait msiexec /qn /norestart /x {7A3C7E05-EE37-47D6-99E1-2EB05A3DA3F7}
start /wait msiexec /qn /norestart /x {F09879E9-7CA4-460F-B14A-6E55FEFB34F7}
start /wait msiexec /qn /norestart /x {5F5EF771-2B0B-401C-969C-38399DF75D35}
start /wait msiexec /qn /norestart /x {746AB259-6474-4111-8966-1C62F9A6E063}
start /wait msiexec /qn /norestart /x {FC7386E4-B71D-42AA-B6B3-0925D0361069}
start /wait msiexec /qn /norestart /x {5AD12E7A-D739-4451-9BD1-3610EC56D8F5}

:: Software Updater (various versions)
start /wait msiexec /qn /norestart /x {B307472F-7BD9-4040-9255-CE6D6A1196A3}
start /wait msiexec /qn /norestart /x {6623AA80-69BE-4D39-852B-329DDE843FB5}

:: Sonic products // Activation Module 1 // CinePlayer Decoder Pack (various versions) // DLA
::                // Icons for Lenovo // myDVD LE // RecordNow variations
start /wait msiexec /qn /norestart /x {8D337F77-BE7F-41A2-A7CB-D5A63FD7049B}
start /wait msiexec /qn /norestart /x {21657574-BD54-48A2-9450-EB03B2C7FC29}
start /wait msiexec /qn /norestart /x {35E1EC43-D4FC-4E4A-AAB3-20DDA27E8BB0}
start /wait msiexec /qn /norestart /x {5B6BE547-21E2-49CA-B2E2-6A5F470593B1}
start /wait msiexec /qn /norestart /x {9541FED0-327F-4DF0-8B96-EF57EF622F19}
start /wait msiexec /qn /norestart /x {075473F5-846A-448B-BCB3-104AA1760205}
start /wait msiexec /qn /norestart /x {B12665F4-4E93-4AB4-B7FC-37053B524629}
start /wait msiexec /qn /norestart /x {1206EF92-2E83-4859-ACCB-2048C3CB7DA6}
start /wait msiexec /qn /norestart /x {9A00EC4E-27E1-42C4-98DD-662F32AC8870}
start /wait msiexec /qn /norestart /x {AB708C9B-97C8-4AC9-899B-DBF226AC9382}

:: Sony Keyboard_Shortcuts
start /wait msiexec /qn /norestart /x {FE8974B4-479C-4DBA-8544-9E5342ABB26A}

:: Sony Media Go
start /wait msiexec /qn /norestart /x {167A1F6A-9BF2-4B24-83DB-C6D659F680EA}

:: Sony Messenger (Oasis2Service)
start /wait msiexec /qn /norestart /x {E50FC5DB-7CBD-407D-A46E-0C13E45BC386}

:: Sony OOBE
start /wait msiexec /qn /norestart /x {18894D16-5448-4BF9-A128-F7E937322F91}
start /wait msiexec /qn /norestart /x {1B500D37-E7CF-480B-8054-8A563594EC4E}

:: Sony PlayMemories Home
start /wait msiexec /qn /norestart /x {E03CD71A-F595-49DF-9ADC-0CFC93B1B211}
start /wait msiexec /qn /norestart /x {886C0C18-F905-49B2-90BA-EFC0FEDF27C6}
start /wait msiexec /qn /norestart /x {1E5C7043-09C5-4974-A69F-A5271FD82BBC}

:: Sony Quick Web Access
start /wait msiexec /qn /norestart /x {13EC74A6-4707-4D26-B9B9-E173403F3B08}

:: Sony Reader for PC (Flagged as malware by some scanners)
start /wait msiexec /qn /norestart /x {CF5B430D-C563-4EE6-803D-A8A133DFCE5E}
start /wait msiexec /qn /norestart /x {11CBB0F5-989E-4B16-AE7E-D569AC4BF241}

:: Sony Remote Play with Playstation(R)3
start /wait msiexec /qn /norestart /x {D56DA747-5FDB-4AD5-9A6A-3481C0ED44BD}
start /wait msiexec /qn /norestart /x {65B138AE-F636-4D4C-BA5D-A06E21E47C53}

:: Sony Setting Utility Series
start /wait msiexec /qn /norestart /x {A7DA438C-2E43-4C20-BFDA-C1F4A6208558}

:: Sony TrackID(TM) with BRAVIA (poor Shazzam clone)
start /wait msiexec /qn /norestart /x {858B32BD-121C-4AC8-BD87-CE37C51C03E2}
start /wait msiexec /qn /norestart /x {2F41EF61-A066-4EBF-84F8-21C1B317A780}

:: Sony VAIO Care Hardware Diagnostics Plugin
start /wait msiexec /qn /norestart /x {EC153498-00E1-4C9C-89BE-81527C6750BE}

:: Sony VAIO Data Restore Tool
start /wait msiexec /qn /norestart /x {5156C9BF-1C27-430B-96D8-7129F11699A8}

:: Sony VAIO DVD Menu Data
start /wait msiexec /qn /norestart /x {596BED91-A1D8-4DF1-8CD1-1C777F7588AC}

:: Sony VAIO Event Service
start /wait msiexec /qn /norestart /x {C7477742-DDB4-43E5-AC8D-0259E1E661B1}

:: Sony VAIO First Logon Setup Tool
start /wait msiexec /qn /norestart /x {82F09B1C-F602-4552-9C40-5BD5F8EAF750}

:: Sony VAIO - Media Gallery
start /wait msiexec /qn /norestart /x {7C7BC722-BB95-4A6E-9373-DA706D83430B}
start /wait msiexec /qn /norestart /x {0EB7792D-EFA2-42AB-9A22-F33D9458E974}
start /wait msiexec /qn /norestart /x {DD88F979-FA58-41AC-980C-A6E1A82B61D9}

:: Sony VAIO - Microsoft Visual C++ 2010 SP1 RUntime 10.0.40219.325
start /wait msiexec /qn /norestart /x {34EB42BE-F4D3-44C1-B28E-9740115DB72C}

:: Sony VAIO - PMB
start /wait msiexec /qn /norestart /x {B6A98E5F-D6A7-46FB-9E9D-1F7BF443491C}

:: Sony VAIO - PMB VAIO Edition Guide (and associated "Plugin" GUIDs)
start /wait msiexec /qn /norestart /x {339F9B4D-00CB-4C1C-BED8-EC86A9AB602A}
start /wait msiexec /qn /norestart /x {133D3F07-D558-46CE-80E8-F4D75DBBAD63}
start /wait msiexec /qn /norestart /x {270380EB-8812-42E1-8289-53700DB840D2}
start /wait msiexec /qn /norestart /x {8356CB97-A48F-44CB-837A-A12838DC4669}

:: Sony VAIO - Remote Keyboard, Remote Keyboard with PlayStation(R)3, Remote Play with Playstation(R)3
start /wait msiexec /qn /norestart /x {7396FB15-9AB4-4B78-BDD8-24A9C15D2C65}
start /wait msiexec /qn /norestart /x {6466EF6E-700E-470F-94CB-D0050302C84E}
start /wait msiexec /qn /norestart /x {E682702C-609C-4017-99E7-3129C163955F}
start /wait msiexec /qn /norestart /x {07441A52-E208-478A-92B7-5C337CA8C131}

:: Sony VAIO Care // VAIO Care Recovery // VAIO Help and Support
start /wait msiexec /qn /norestart /x {D9FFE40D-1A85-4541-992C-5EF505F391A4}
start /wait msiexec /qn /norestart /x {55A60C1D-BEBF-4249-BFB2-F4E5C2E77988}
start /wait msiexec /qn /norestart /x {471F7C0A-CA3A-4F4C-8346-DE36AD5E23D1}
start /wait msiexec /qn /norestart /x {6ED1750E-F44F-4635-8F0D-B76B9262B7FB}
start /wait msiexec /qn /norestart /x {AD3E7141-A22E-40F1-A7A4-55E898AE35E3}
start /wait msiexec /qn /norestart /x {36C5BBF0-E5BF-4DE1-B684-7E90B0C93FB5}

:: Sony VAIO Control Center // CPU Fan Diagnostic // Data Restore Tool // Easy Connect
start /wait msiexec /qn /norestart /x {8E797841-A110-41FD-B17A-3ABC0641187A}
start /wait msiexec /qn /norestart /x {BCE6E3D7-B565-4E1B-AC77-F780666A35FB}
start /wait msiexec /qn /norestart /x {3267B2E9-9DF5-4251-87C8-33412234C77F}
start /wait msiexec /qn /norestart /x {57B955CE-B5D3-495D-AF1B-FAEE0540BFEF}
start /wait msiexec /qn /norestart /x {7C80D30A-AC02-4E3F-B95D-29F0E4FF937B}
start /wait msiexec /qn /norestart /x {72042FA6-5609-489F-A8EA-3C2DD650F667}

:: Sony VAIO Gate // Gate Default // Help and Support // Improvement // Manual // Gesture Control
start /wait msiexec /qn /norestart /x {A7C30414-2382-4086-B0D6-01A88ABA21C3}
start /wait msiexec /qn /norestart /x {AE5F3379-8B81-457E-8E09-7E61D941AFA4}
start /wait msiexec /qn /norestart /x {B7546697-2A80-4256-A24B-1C33163F535B}
start /wait msiexec /qn /norestart /x {0164FA3B-182D-4237-B22A-081C0B55E0D3}
start /wait msiexec /qn /norestart /x {3A26D9BD-0F73-432D-B522-2BA18138F7EF}
start /wait msiexec /qn /norestart /x {C6E893E7-E5EA-4CD5-917C-5443E753FCBD}
start /wait msiexec /qn /norestart /x {C8544A9A-76BE-4F82-811E-979799AE493B}

:: Sony VAIO Gesture Control
start /wait msiexec /qn /norestart /x {692955F2-DE9F-4078-8FAA-858D6F3A1776}

:: Sony VAIO Media plus Opening Movie (seriously Sony...you need an MSI code for this???)
start /wait msiexec /qn /norestart /x {6BF03C88-C06A-48DC-B9A1-FE72B24E5FA9}

:: Sony VAIO Movie Creator
start /wait msiexec /qn /norestart /x {C2CC5822-32E6-4D21-88EA-DE8CED09EE2F}

:: Sony VAIO Movie Story Template Data
start /wait msiexec /qn /norestart /x {6FA8BA2C-052B-4072-B8E2-2302C268BE9E}

:: Sony VAIOCareLearnContents
start /wait msiexec /qn /norestart /x {05959BC8-751E-43B1-A427-233DA743E179}

:: Sony VAIO Media plus
start /wait msiexec /qn /norestart /x {8DE50158-80AA-4FF2-9E9F-0A7C46F71FCD}

:: Sony VAIO Messenger
start /wait msiexec /qn /norestart /x {2BD4D073-FF7E-46C6-B916-02F1AF376300}

:: Sony VAIO OOB (out of box experience)
start /wait msiexec /qn /norestart /x {D9777637-33B7-47A9-800C-F6A2CD4EB0FE}

:: Sony VAIO Sample Contents // Satisfaction Survey // Transfer Support VAIO Update
start /wait msiexec /qn /norestart /x {547C9EB4-4CA6-402F-9D1B-8BD30DC71E44}
start /wait msiexec /qn /norestart /x {5DDAFB4B-C52E-468A-9E23-3B0CEEB671BF}
start /wait msiexec /qn /norestart /x {0899D75A-C2FC-42EA-A702-5B9A5F24EAD5}
start /wait msiexec /qn /norestart /x {9FF95DA2-7DA1-4228-93B7-DED7EC02B6B2}

:: Sony VAIO Startup Setting Tool
start /wait msiexec /qn /norestart /x {855DDD3C-131E-42A8-BCBD-F9581F80CACB}

:: Sony VAIO Survey
start /wait msiexec /qn /norestart /x {34B37A74-125E-4406-87BA-E4BD3D097AE5}

:: Sony VAIO Update
start /wait msiexec /qn /norestart /x {5BEE8F1F-BD32-4553-8107-500439E43BD7}

:: Sony VAIO Window Organizer
start /wait msiexec /qn /norestart /x {6D320CE8-79EB-4D45-8C6D-DEF74D84B49A}

:: Sony VCCx64, VCCx86, VIx64, and VIx86
start /wait msiexec /qn /norestart /x {549AD5FB-F52D-4307-864A-C0008FB35D96}
start /wait msiexec /qn /norestart /x {DF184496-1CA2-4D07-92E7-0BD251D7DEF0}
start /wait msiexec /qn /norestart /x {D55EAC07-7207-44BD-B524-0F063F327743}
start /wait msiexec /qn /norestart /x {D17C2A58-E0EA-4DD7-A2D6-C448FD25B6F6}

:: Sony VMLx86, VPMx64, VSNx64, VSNx86, VSSTx64, VSSTx86, VU5x64, VU5x86, VU5x86, and VWSTx86
start /wait msiexec /qn /norestart /x {02E0F3DE-3FB4-435C-B727-9C9E9EE4ACA4}
start /wait msiexec /qn /norestart /x {DBEAA361-F8A4-4298-B41C-9E9DCB9AAB84}
start /wait msiexec /qn /norestart /x {F2611404-06BF-4E67-A5B7-8DB2FFC1CBF6}
start /wait msiexec /qn /norestart /x {A49A517F-5332-4665-922C-6D9AD31ADD4F}
start /wait msiexec /qn /norestart /x {4F31AC31-0A28-4F5A-8416-513972DA1F79}
start /wait msiexec /qn /norestart /x {B24BB74E-8359-43AA-985A-8E80C9219C70}
start /wait msiexec /qn /norestart /x {6B7DE186-374B-4873-AEC1-7464DA337DD6}
start /wait msiexec /qn /norestart /x {9D12A8B5-9D41-4465-BF11-70719EB0CD02}
start /wait msiexec /qn /norestart /x {D2D23D08-D10E-43D6-883C-78E0B2AC9CC6}
start /wait msiexec /qn /norestart /x {B8991D99-88FD-41F2-8C32-DB70278D5C30}

:: Sony Xperia Link
start /wait msiexec /qn /norestart /x {CEB60C0E-179A-4CE6-8946-8CF48DD1C5F0}
start /wait msiexec /qn /norestart /x {D91558BF-D1F3-411F-AEFE-8774CB406512}

:: swMSM -  Shockwave Player Merge Module (hidden)
start /wait msiexec /qn /norestart /x {612C34C7-5E90-47D8-9B5C-0F717DD82726}
start /wait msiexec /qn /norestart /x {C30E30A6-0AB5-470A-AB67-D322938F5429}

:: Spybot - Search & Destroy. "You either die a hero, or live long enough to see yourself become the villain."
start /wait msiexec /qn /norestart /x {B4092C6D-E886-4CB2-BA68-FE5A88D31DE6}

:: Sql Server Customer Experience Improvement Program (various versions)
start /wait msiexec /qn /norestart /x {2D95D8C0-0DC4-44A6-A729-1E2388D2C03E}
start /wait msiexec /qn /norestart /x {C942A025-A840-4BF2-8987-849C0DD44574}
start /wait msiexec /qn /norestart /x {91C4DE4A-CE48-4F8B-9D73-D2BFB619FB88}
start /wait msiexec /qn /norestart /x {F021CC0C-21C3-4038-AA4A-6E3CBC669CE8}
start /wait msiexec /qn /norestart /x {BD1CD96B-FE4B-4EAE-83D4-6EF55AB5779C}
start /wait msiexec /qn /norestart /x {63B58043-A08C-4379-8929-4233291B743A}

:: SRS Premium Sound for HP Thin Speakers
start /wait msiexec /qn /norestart /x {DEA9F247-F832-4E36-90BF-D8EDA206521A}
start /wait msiexec /qn /norestart /x {94F03B8E-CB73-4653-AFE9-79112C01FED2}

:: Symantec WebReg
start /wait msiexec /qn /norestart /x {CCB9B81A-167F-4832-B305-D2A0430840B3}

:: System Requirements Lab for Intel
start /wait msiexec /qn /norestart /x {04C4B49D-45D9-4A28-9ED1-B45CBD99B8C7}
start /wait msiexec /qn /norestart /x {76CE5B47-F5A4-4E5C-99A0-CEFF6146EA4A}
start /wait msiexec /qn /norestart /x {DB2C58E0-6284-4B48-97F2-22A980B6360B}
start /wait msiexec /qn /norestart /x {63B7AC7E-0178-4F4F-A79B-08D97ADD02D7}

:: timer (appears on a lot of infected systems)
start /wait msiexec /qn /norestart /x {9CC4B8EE-A96B-4800-B674-0CF8B4560F45}

:: Toshiba Audio Enhancement
start /wait msiexec /qn /norestart /x {1515F5E3-29EA-4CD1-A981-032D88880F09}
start /wait msiexec /qn /norestart /x {F2DE0088-CF05-4DAB-AC4D-9D2C4D657456}

:: Toshiba Application Installer
start /wait msiexec /qn /norestart /x {970472D0-F5F9-4158-A6E3-1AE49EFEF2D3}
start /wait msiexec /qn /norestart /x {1E6A96A1-2BAB-43EF-8087-30437593C66C}

:: TOSHIBA Audio Enhancement
start /wait msiexec /qn /norestart /x {11955FE2-CAC6-4C3B-AA68-F787D7405400}

:: Toshiba App Place
start /wait msiexec /qn /norestart /x {ED3CBA78-488F-4E8C-B33F-8E3BF4DDB4D2}
start /wait msiexec /qn /norestart /x {84FA4D2D-4273-4C66-BD3D-ADD3FE48DFA2}

:: TOSHIBA Assist
start /wait msiexec /qn /norestart /x {1B87C40B-A60B-4EF3-9A68-706CF4B69978}

:: Toshiba Bluetooth Statck for Windows by Toshiba
start /wait msiexec /qn /norestart /x {230D1595-57DA-4933-8C4E-375797EBB7E1}
start /wait msiexec /qn /norestart /x {CEBB6BFB-D708-4F99-A633-BC2600E01EF6}

:: TOSHIBA Blu-ray Disc Player
start /wait msiexec /qn /norestart /x {FF07604E-C860-40E9-A230-E37FA41F103A}

:: Toshiba Book Place
start /wait msiexec /qn /norestart /x {92C7DC44-DAD3-49FE-B89B-F92C6BA9A331}
start /wait msiexec /qn /norestart /x {39187A4B-7538-4BE7-8BAD-9E83303793AA}
start /wait msiexec /qn /norestart /x {05A55927-DB9B-4E26-BA44-828EBFF829F0}

:: TOSHIBA Bulletin Board
start /wait msiexec /qn /norestart /x {C14518AF-1A0F-4D39-8011-69BAA01CD380}
start /wait msiexec /qn /norestart /x {229C190B-7690-40B7-8680-42530179F3E9}
start /wait msiexec /qn /norestart /x {1C8C049A-145F-4A6E-8290-B5C245EBE39D}

:: TOSHIBA ConfigFree
start /wait msiexec /qn /norestart /x {716C8275-A4A9-48CB-88C0-9829334CA3C5}
start /wait msiexec /qn /norestart /x {EAF55C99-A493-4373-A8C5-09ACC5DCD7EF}

:: Toshiba Desktop Assist
start /wait msiexec /qn /norestart /x {95CCACF0-010D-45F0-82BF-858643D8BC02}

:: TOSHIBA Disc Creator
start /wait msiexec /qn /norestart /x {5944B9D4-3C2A-48DE-931E-26B31714A2F7}

:: Toshiba Display Utility
start /wait msiexec /qn /norestart /x {0B39C39A-3ECE-4582-9C91-842D22819A24}
start /wait msiexec /qn /norestart /x {78C6A78A-8B03-48C8-A47C-78BA1FCA2307}
start /wait msiexec /qn /norestart /x {11244D6B-9842-440F-8579-6A4D771A0D9B}

:: TOSHIBA Eco Utility
start /wait msiexec /qn /norestart /x {72EFCFA8-3923-451D-AF52-7CE9D87BC2A1}
start /wait msiexec /qn /norestart /x {59358FD4-252B-4B38-AB81-955C491A494F}
start /wait msiexec /qn /norestart /x {2C486987-D447-4E36-8D61-86E48E24199C}

:: TOSHIBA Extended Tiles for Windows Mobility Center // GUID shared with TOSHIBA Disc Creator
start /wait msiexec /qn /norestart /x {5DA0E02F-970B-424B-BF41-513A5018E4C0}

:: TOSHIBA Face Recognition
start /wait msiexec /qn /norestart /x {F67FA545-D8E5-4209-86B1-AEE045D1003F}

:: TOSHIBA Flash Cards Support Utility
start /wait msiexec /qn /norestart /x {617C36FD-0CBE-4600-84B2-441CEB12FADF}

:: TOSHIBA HDD/SDD Alert 3.1.64.x
start /wait msiexec /qn /norestart /x {D4322448-B6AF-4316-B859-D8A0E84DCB38}

:: TOSHIBA Media Controller and TOSHIBA Media Controller Plug-in 1.0.5.11
start /wait msiexec /qn /norestart /x {983CD6FE-8320-4B80-A8F6-0D0366E0AA22}
start /wait msiexec /qn /norestart /x {F26FDF57-483E-42C8-A9C9-EEE1EDB256E0}

:: Toshiba Password Utility
start /wait msiexec /qn /norestart /x {26BB68BB-CF93-4A12-BC6D-A3B6F53AC8D9}
start /wait msiexec /qn /norestart /x {21A63CA3-75C0-4E56-B602-B7CD2EF6B621}
start /wait msiexec /qn /norestart /x {6D35FF17-A8B3-43D3-917E-5A1F2C3FB628}
start /wait msiexec /qn /norestart /x {B1786E63-2127-42C9-95A3-146E5F727BF1}

:: TOSHIBA PC Health Monitor
start /wait msiexec /qn /norestart /x {9DECD0F9-D3E8-48B0-A390-1CF09F54E3A4}

:: TOSHIBA Peak Shift Control
start /wait msiexec /qn /norestart /x {73F1BDB6-11E1-11D5-9DC6-00C04F2FC33B}

:: Toshiba Places Icon Utility
start /wait msiexec /qn /norestart /x {C991A8C4-307C-4FDD-8AAE-A1BF44881E95}

:: TOSHIBA Quality Application
start /wait msiexec /qn /norestart /x {E69992ED-A7F6-406C-9280-1C156417BC49}
start /wait msiexec /qn /norestart /x {620BBA5E-F848-4D56-8BDA-584E44584C5E}

:: TOSHIBARegistration
start /wait msiexec /qn /norestart /x {5AF550B4-BB67-4E7E-82F1-2C4300279050}

:: TOSHIBA Recovery Media Creator // Disabled by /u/kamakaze_chickn for Tron
::start /wait msiexec /qn /norestart /x {B65BBB06-1F8E-48F5-8A54-B024A9E15FDF}

:: Toshiba ReelTime
start /wait msiexec /qn /norestart /x {24811C12-F4A9-4D0F-8494-A7B8FE46123C}

:: Toshiba Service Station
start /wait msiexec /qn /norestart /x {0DFA8761-7735-4DE8-A0EB-2286578DCFC6}
start /wait msiexec /qn /norestart /x {6499E894-43F8-458B-AE35-724F4732BCDE}
start /wait msiexec /qn /norestart /x {F64E9295-E1B3-4EEA-86D3-AF44A0087B06}
start /wait msiexec /qn /norestart /x {B8C8422F-01F1-4791-B084-047AAFF9BFCC}

:: TOSHIBA Speech System Appplications, SR Engine(U.S.), TTS Engine(U.S.)
start /wait msiexec /qn /norestart /x {EE033C1F-443E-41EC-A0E2-559B539A4E4D}
start /wait msiexec /qn /norestart /x {008D69EB-70FF-46AB-9C75-924620DF191A}
start /wait msiexec /qn /norestart /x {3FBF6F99-8EC6-41B4-8527-0A32241B5496}

:: Toshiba System Driver // Disabled by /u/kamakaze_chickn for Tron
::start /wait msiexec /qn /norestart /x {16562A90-71BC-41A0-B890-D91B0C267120}

:: Toshiba System Settings
start /wait msiexec /qn /norestart /x {B040D5C9-C9AA-430A-A44E-696656012E61}
start /wait msiexec /qn /norestart /x {EFCCEE68-1317-40A5-B785-C07AD2769338}

:: Toshiba TEMPRO
start /wait msiexec /qn /norestart /x {F76F5214-83A8-4030-80C9-1EF57391D72A}

:: Toshiba Utility Common Driver (hidden)
start /wait msiexec /qn /norestart /x {12688FD7-CB92-4A5B-BEE4-5C8E0574434F}

:: Toshiba User's Guide
start /wait msiexec /qn /norestart /x {3384E1D9-3F18-4A98-8655-180FEF0DFC02}

:: Toshiba Value Added Package
start /wait msiexec /qn /norestart /x {066CFFF8-12BF-4390-A673-75F95EFF188E}
start /wait msiexec /qn /norestart /x {FBFCEEA5-96EA-4C8E-9262-43CBBEBAE413}

:: TOSHIBA Web Camera Application
start /wait msiexec /qn /norestart /x {5E6F6CF3-BACC-4144-868C-E14622C658F3}
start /wait msiexec /qn /norestart /x {6F3C8901-EBD3-470D-87F8-AC210F6E5E02}

:: Toshiba Wireless LAN Indicator
start /wait msiexec /qn /norestart /x {CDADE9BC-612C-42B8-B929-5C6A823E7FF9}
start /wait msiexec /qn /norestart /x {5B01BCB7-A5D3-476F-AF11-E515BA206591}

:: Trend Micro Trial
start /wait msiexec /qn /norestart /x {BED0B8A2-2986-49F8-90D6-FA008D37A3D2}

:: Trend Micro Worry-Free Business Security Trial
start /wait msiexec /qn /norestart /x {0A07E717-BB5D-4B99-840B-6C5DED52B277}

:: TuneUp Utilities 2014 (PUP)
start /wait msiexec /qn /norestart /x {14C8CE46-C68C-461B-BCA9-E276A85851C6}
start /wait msiexec /qn /norestart /x {FE8D473A-6F06-4F99-B5F4-BED72B2A038C}

:: uLead Burn.Now 4.5 4.5.0
start /wait msiexec /qn /norestart /x {FB3A15FD-FC67-3A2F-892B-6890B0C56EA9}

:: VIP Access (Lenovo-installed OEM bloatware for Verisign)
start /wait msiexec /qn /norestart /x {E8D46836-CD55-453C-A107-A59EC51CB8DC}

:: Real Networks Video Downloader, VideoManager, VideoToolkit
start /wait msiexec /qn /norestart /x {62796191-6F12-4ABE-BA8B-B4D4A266C997}
start /wait msiexec /qn /norestart /x {E60AFF01-6087-47BD-8272-61FA3CFC309D}
start /wait msiexec /qn /norestart /x {6F0FA48E-DAEE-4CCE-BA6A-68C25E27BC85}
start /wait msiexec /qn /norestart /x {9C618A4D-5428-41B7-8A25-36B311FF8C77}

:: WD Quick View, SmartWare
start /wait msiexec /qn /norestart /x {7AE43D6C-B3F1-448D-AD84-1CDC7AC6EBC7}
start /wait msiexec /qn /norestart /x {79966948-BECF-4CB1-A79F-E76C830A17D2}

:: WeatherBug Gadget
start /wait msiexec /qn /norestart /x {209CDA54-D390-46A2-A97C-7BF61734418D}

:: WildTangent GUIDs. Thanks to /u/mnbitcoin
start /wait msiexec /qn /norestart /x {2FA94A64-C84E-49d1-97DD-7BF06C7BBFB2}
start /wait msiexec /qn /norestart /x {EE691BD9-2B2C-6BFB-6389-ABAF5AD2A4A1}
start /wait msiexec /qn /norestart /x {9E9EF3EC-22BC-445C-A883-D8DB2908698D}
start /wait msiexec /qn /norestart /x {DD7C5FC1-DCA5-487A-AF23-658B1C00243F}
start /wait msiexec /qn /norestart /x {0F929651-F516-4956-90F2-FFBD2CD5D30E}
start /wait msiexec /qn /norestart /x {89C7E0A7-4D9D-4DCC-8834-A9A2B92D7EBB}
start /wait msiexec /qn /norestart /x {36AC0D1D-9715-4F13-B6A4-86F1D35FB4DF}
start /wait msiexec /qn /norestart /x {70B446D1-E03B-4ab0-9B3C-0832142C9AA8}
start /wait msiexec /qn /norestart /x {182d7111-a24a-4fdf-8f04-063b2496bd3c}
start /wait msiexec /qn /norestart /x {1a64c8aa-b65a-4ba4-ac23-74a9a923066c}
start /wait msiexec /qn /norestart /x {1bbc95c1-9590-4e33-84dd-1847eb023d47}
start /wait msiexec /qn /norestart /x {3405dccb-a52b-4fe5-a989-8b1cd3120ed9}
start /wait msiexec /qn /norestart /x {34aee1f7-ebf9-44d9-a5cd-03ea1492159b}
start /wait msiexec /qn /norestart /x {3fb318f0-8769-487e-ba1e-37e23c0ab7cf}
start /wait msiexec /qn /norestart /x {4dade5b5-20b8-4daf-8ec1-42b359c222ad}
start /wait msiexec /qn /norestart /x {64f99079-7030-435f-8ffb-e3688f68fb56}
start /wait msiexec /qn /norestart /x {77d72443-68e9-4dfa-97e8-eceaff0066b2}
start /wait msiexec /qn /norestart /x {80317707-210a-4c0a-8a95-c73327422c9c}
start /wait msiexec /qn /norestart /x {d54b04b0-458e-4fb3-b570-8f386efd3d02}
start /wait msiexec /qn /norestart /x {d9662777-5f30-4b0a-8bf9-d051ae8d4276}
start /wait msiexec /qn /norestart /x {e12e20f3-0206-463b-9ebe-ef1a23768e00}
start /wait msiexec /qn /norestart /x {e6b22ecf-c476-4fb0-899f-edb6b6da269d}

:: Windows 7 Upgrade Advisor
start /wait msiexec /qn /norestart /x {AAF91344-2808-4D6B-9242-FBE5AF79D60A}

:: Windows Demo Experience
start /wait msiexec /qn /norestart /x {2B30D5CA-7A2D-4BAE-9654-8015995960C1}

:: Windows Live Family Safety // Disabled by Vocatus for Tron (some family systems may be using this)
::start /wait msiexec /qn /norestart /x {5F611ADA-B98C-4DBB-ADDE-414F08457ECF}

:: Windows Live Language Selector
start /wait msiexec /qn /norestart /x {180C8888-50F1-426B-A9DC-AB83A1989C65}
start /wait msiexec /qn /norestart /x {D07A61E5-A59C-433C-BCBD-22025FA2287B}

:: Windows Live Mesh (deprecated MS product)
start /wait msiexec /qn /norestart /x {841F1FB4-FDF8-461C-A496-3E1CFD84C0B5}
start /wait msiexec /qn /norestart /x {A0C91188-C88F-4E86-93E6-CD7C9A266649}
start /wait msiexec /qn /norestart /x {2902F983-B4C1-44BA-B85D-5C6D52E2C441}
start /wait msiexec /qn /norestart /x {DECDCB7C-58CC-4865-91AF-627F9798FE48}

:: Windows Live MIME IFilter
start /wait msiexec /qn /norestart /x {DA54F80E-261C-41A2-A855-549A144F2F59}

:: Windows Live Remote Client
start /wait msiexec /qn /norestart /x {847B0532-55E3-4AAF-8D7B-E3A1A7CD17E5}
start /wait msiexec /qn /norestart /x {B750FA38-7AB0-42CB-ACBB-E7DBE9FF603F}
start /wait msiexec /qn /norestart /x {DF6D988A-EEA0-4277-AAB8-158E086E439B}

:: Windows Live Remote Service
start /wait msiexec /qn /norestart /x {5E2CD4FB-4538-4831-8176-05D653C3E6D4}
start /wait msiexec /qn /norestart /x {656DEEDE-F6AC-47CA-A568-A1B4E34B5760}
start /wait msiexec /qn /norestart /x {E02A6548-6FDE-40E2-8ED9-119D7D7E641F}

:: Windows Live Sign-in Assistant
start /wait msiexec /qn /norestart /x {CE52672C-A0E9-4450-8875-88A221D5CD50}
start /wait msiexec /qn /norestart /x {1B8ABA62-74F0-47ED-B18C-A43128E591B8}
start /wait msiexec /qn /norestart /x {9B48B0AC-C813-4174-9042-476A887592C7}
start /wait msiexec /qn /norestart /x {0610DFB0-CCEA-6EC0-E3C3-A0160AD7FD98}
start /wait msiexec /qn /norestart /x {993F6DDC-63F8-4BCD-9B28-D941971A9CAC}
start /wait msiexec /qn /norestart /x {1ACC8FFB-9D84-4C05-A4DE-D28A9BC91698}
start /wait msiexec /qn /norestart /x {6152DEA9-EA0C-4013-9DBF-4A8881A7F722}
start /wait msiexec /qn /norestart /x {19BA08F7-C728-469C-8A35-BFBD3633BE08}
start /wait msiexec /qn /norestart /x {C424CD5E-EA05-4D3E-B5DA-F9F149E1D3AC}
start /wait msiexec /qn /norestart /x {81128EE8-8EAD-4DB0-85C6-17C2CE50FF71}
start /wait msiexec /qn /norestart /x {CDC1AB00-01FF-4FC7-816A-16C67F0923C0}
start /wait msiexec /qn /norestart /x {45338B07-A236-4270-9A77-EBB4115517B5}

:: Windows Live Toolbar
start /wait msiexec /qn /norestart /x {995F1E2E-F542-4310-8E1D-9926F5A279B3}

:: WinZip (various versions) // WinZip Courier // Disabled by Vocatus for Tron
:: start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240ED}
:: start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240CD}
:: start /wait msiexec /qn /norestart /x {CD95F661-A5C4-11AF-B2CC-ABCD21A325B8}
:: start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240C3}
:: start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240CF}
:: start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240E3}
:: start /wait msiexec /qn /norestart /x {8A6EAACB-E2D6-D6BF-0338-F4AC9641B423}

:: WOT for Internet Explorer plugin
start /wait msiexec /qn /norestart /x {373B90E1-A28C-434C-92B6-7281AFA6115A}

:: Xmarks for IE
start /wait msiexec /qn /norestart /x {ABFA6EAE-C9C0-4B39-B722-02094EF6B889}

:: Xnet Local Print Extension
start /wait msiexec /qn /norestart /x {FD8D8382-4058-4F74-8EF1-FE61091F854A}

:: YouTube Downloader 2.7.2
start /wait msiexec /qn /norestart /x {1a413f37-ed88-4fec-9666-5c48dc4b7bb7}

:: Zinio Alert Messenger
start /wait msiexec /qn /norestart /x {D2E707E8-090E-EC5B-4833-1CA694FB7460}

:: Zinio Reader 4
start /wait msiexec /qn /norestart /x {7FB00B6B-6843-97EC-EED6-78BD6D35370A}

:: ZoneAlarm Antivirus, Firewall, and Security // Disabled for Tron by /u/vocatus
::start /wait msiexec /qn /norestart /x {043A5C25-EC0E-4152-A53B-73065A4315DF}
::start /wait msiexec /qn /norestart /x {537317B1-FB59-4578-953F-544914A8F25F}
::start /wait msiexec /qn /norestart /x {9A121E1B-1E87-4F37-BC9C-F8D073047942}

:: Zune Desktop Theme
start /wait msiexec /qn /norestart /x {76BA306B-2AA0-47C0-AB6B-F313AB56C136}

:: Zune Language Pack (various versions)
start /wait msiexec /qn /norestart /x {07EEE598-5F21-4B57-B40B-46592625B3D9}
start /wait msiexec /qn /norestart /x {9B75648B-6C30-4A0D-9DE6-0D09D20AF5A5}
start /wait msiexec /qn /norestart /x {A5A53EA8-A11E-49F0-BDF5-AE536426A31A}
start /wait msiexec /qn /norestart /x {8960A0A1-BB5A-479E-92CF-65AB9D684B43}
start /wait msiexec /qn /norestart /x {B4870774-5F3A-46D9-9DFE-06FB5599E26B}
start /wait msiexec /qn /norestart /x {2A9DFFD8-4E09-4B91-B957-454805B0D7C4}
start /wait msiexec /qn /norestart /x {6740BCB0-5863-47F4-80F4-44F394DE4FE2}
start /wait msiexec /qn /norestart /x {A8F2E50B-86E2-4D96-9BD2-9758BCC6F9B3}
start /wait msiexec /qn /norestart /x {C5D37FFA-7483-410B-982B-91E93FD3B7DA}
start /wait msiexec /qn /norestart /x {C68D33B1-0204-4EBE-BC45-A6E432B1D13A}
start /wait msiexec /qn /norestart /x {8B112338-2B08-4851-AF84-E7CAD74CEB32}
start /wait msiexec /qn /norestart /x {BE236D9A-52EC-4A17-82DA-84B5EAD31E3E}
start /wait msiexec /qn /norestart /x {C6BE19C6-B102-4038-B2A6-1C313872DBB4}
start /wait msiexec /qn /norestart /x {3589A659-F732-4E65-A89A-5438C332E59D}
start /wait msiexec /qn /norestart /x {6EB931CD-A7DA-4A44-B74A-89C8EB50086F}
start /wait msiexec /qn /norestart /x {5DEFD397-4012-46C3-B6DA-E8013E660772}
start /wait msiexec /qn /norestart /x {5C93E291-A1CC-4E51-85C6-E194209FCDB4}
start /wait msiexec /qn /norestart /x {7E20EFE6-E604-48C6-8B39-BA4742F2CDB4}
start /wait msiexec /qn /norestart /x {98BED31B-B364-4D74-BFBD-5C070E5DA77D}
start /wait msiexec /qn /norestart /x {57C51D56-B287-4C11-9192-EC3C46EF76A4}
start /wait msiexec /qn /norestart /x {51C839E1-2BE4-4E77-A1BA-CCEA5DAFA741}
start /wait msiexec /qn /norestart /x {6B33492E-FBBC-4EC3-8738-09E16E395A10}

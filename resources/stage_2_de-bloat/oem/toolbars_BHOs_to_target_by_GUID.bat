:: Batch file to uninstall a specific list of toolbars, BHO, Trojans by GUID
:: Called by Tron in Stage 2: De-bloat
:: Initial list by reddit.com/user/Chimaera12, modifications for use in Tron by reddit.com/user/vocatus
:: This list is for Browser Hijack Objects, Toolbars and Trojans not bloat.
@echo off


:::::::::::::::
:: GUID LIST ::
:::::::::::::::

:: 01NET.com Toolbar
start /wait msiexec /qn /norestart /x {8e5025c2-8ea3-430d-80b8-a14151068a6d}

:: 1Club.FM Toolbar
start /wait msiexec /qn /norestart /x {3a9262ef-45b5-46fc-b460-7053539c9176}

:: 24x7 Help
start /wait msiexec /qn /norestart /x {A957F04C-49F4-4375-8C8A-D04B769EFE47}

:: 2algeria Toolbar
start /wait msiexec /qn /norestart /x {1bc82e67-afbc-434a-aae9-eb0776452f05}

:: 2shared Toolbar
start /wait msiexec /qn /norestart /x {4D84CC03-383C-4BB1-A485-B263A03E9FF1}
start /wait msiexec /qn /norestart /x {ef468e5b-5b30-4136-a833-7f2e3a31afdf}

:: 4shared.com Toolbar
start /wait msiexec /qn /norestart /x {09ec805c-cb2e-4d53-b0d3-a75a428b81c7}

:: 4shared Toolbar
start /wait msiexec /qn /norestart /x {95080B13-AA71-4EE8-B951-7E98221E1ED5}

:: Absolutist Games Toolbar
start /wait msiexec /qn /norestart /x {631ac2d4-57b3-42b0-a148-da33b462c1a3}

:: Acer eDataSecurity Management Toolbar
start /wait msiexec /qn /norestart /x {5CBE3B7C-1E47-477e-A7DD-396DB0476E29}

:: Activeris AntiMalware
start /wait msiexec /qn /norestart /x 94EAE98D-444B-4817-858C-13DB943DF4F1_Activeris_A~741EE3A2_is1

:: ActiveCollectorPluginBHO Class
start /wait msiexec /qn /norestart /x {07202B0D-149C-4568-90DF-ACC2B4057809}

:: Act.UI.InternetExplorer.Plugins.AttachFile.CAttachFile
start /wait msiexec /qn /norestart /x {D5233FCD-D258-4903-89B8-FB1568E7413D}

:: AccuWeather Toolbar
start /wait msiexec /qn /norestart /x {600242f9-c267-4e64-b6d1-3e3d8e75a8b6}
start /wait msiexec /qn /norestart /x {b9b27172-7b82-4de1-9249-b93666370498}

:: Ad-Aware Security Toolbar
start /wait msiexec /qn /norestart /x {6c97a91e-4524-4019-86af-2aa2d567bf5c}

:: AdC4USelfUpdater
start /wait msiexec /qn /norestart /x {136BB0FD-7E70-40F5-B17E-5FB91F229463}

:: ADDICT-THING Class (Buzzdock Ads)
start /wait msiexec /qn /norestart /x {AFF12765-BBB3-497E-9FB4-EED609A3E9F7}
start /wait msiexec /qn /norestart /x {CCA58AA3-63B0-4CCA-B84A-B739AB91F9AE}
start /wait msiexec /qn /norestart /x {35174834-3496-4325-83D5-390C0821EC54}
start /wait msiexec /qn /norestart /x {645F1B92-D710-4BCB-BA38-3A524EB9A6E9}
start /wait msiexec /qn /norestart /x {DE6EEA75-5DCE-45B4-A307-2A3400447F28}
start /wait msiexec /qn /norestart /x {CA285E00-A35D-4DF5-861D-A819D66766BE}
start /wait msiexec /qn /norestart /x {80C4FEB0-479F-4FC9-A915-2A85C23FB9D4}
start /wait msiexec /qn /norestart /x {CCBFD0AE-D5B9-4F14-8770-D6F1051A97B8}
start /wait msiexec /qn /norestart /x {65B15196-EDFE-40D2-9ACE-A6C6ECB9C814}
start /wait msiexec /qn /norestart /x {4889F191-B666-47C4-A7A2-E4FDD63345B5}
start /wait msiexec /qn /norestart /x {4799EEDF-8EFC-476D-BDB8-50DCD7DEF937}
start /wait msiexec /qn /norestart /x {039CF685-198F-38D7-B22D-D7C9F69DD663}
start /wait msiexec /qn /norestart /x {6B0E8691-BD28-8DB7-C28D-D67A087D6F15}
start /wait msiexec /qn /norestart /x {C9087A39-E63C-4398-AAD5-B44C3824CC8F}
start /wait msiexec /qn /norestart /x {32CAEEED-77BB-EE3E-D089-2C9E38A01DF4}
start /wait msiexec /qn /norestart /x {891EB31D-F75E-3966-9A10-AE7106D37B34}
start /wait msiexec /qn /norestart /x {591D626A-7BA4-3BEB-D0BE-0786BBA0A636}
start /wait msiexec /qn /norestart /x {5000B39A-446B-CCAC-9F11-A568496B8C2C}
start /wait msiexec /qn /norestart /x {A19740B3-2D1E-F0F2-4944-2056F9DF1451}
start /wait msiexec /qn /norestart /x {D8AF9DCA-8169-416D-4DEF-95B0CC09E266}
start /wait msiexec /qn /norestart /x {CC2CB5EA-37E5-53D7-277D-D6126AE8E97E}
start /wait msiexec /qn /norestart /x {651EB2DD-2A46-D23F-C9F6-ADE7A7308514}
start /wait msiexec /qn /norestart /x {246A4640-7B12-D270-EC2B-51417785C961}
start /wait msiexec /qn /norestart /x {475DEEE0-9CEB-A7EF-664A-51ED6B34930C}
start /wait msiexec /qn /norestart /x {F23756EE-B36F-03BF-7067-F76B1FD06171}
start /wait msiexec /qn /norestart /x {C580E15B-F2CA-B3B0-88EF-A85EF7A662B5}
start /wait msiexec /qn /norestart /x {94F1CA45-5D25-4014-7D34-B1EEB5DA6D44}
start /wait msiexec /qn /norestart /x {B67EAE38-84B8-D17A-19ED-723676B831D6}
start /wait msiexec /qn /norestart /x {1224AB36-2320-129D-375F-7702BB4DCE01}
start /wait msiexec /qn /norestart /x {B1875148-2557-5A29-0DF2-BE1DA9BAD584}
start /wait msiexec /qn /norestart /x {824194D0-03FF-74B4-F988-28E9CE777221}
start /wait msiexec /qn /norestart /x {F489924A-16AE-9857-B120-DEAFF2416303}
start /wait msiexec /qn /norestart /x {075509E4-7B92-F485-3535-6C498A94F50B}
start /wait msiexec /qn /norestart /x {0A2F1166-497B-CAFD-C565-27A889C8452A}

:: Adobe Acrobat Create PDF Toolbar
start /wait msiexec /qn /norestart /x {47833539-D0C5-4125-9FA8-0819E2EAAC93}

:: AddThis Toolbar
start /wait msiexec /qn /norestart /x {B43176CC-4D9E-493B-A636-D9CBFE39C6DA}

:: AdventureQuest Worlds Toolbar
start /wait msiexec /qn /norestart /x {3385E2D6-567B-4FC6-8F0F-D7A8C6E6118C}

:: Advanced System Protector / Advanced Uninstaller Pro
start /wait msiexec /qn /norestart /x 00212D92-C5D8-4ff4-AE50-B20F0F85C40A_Systweak_Ad~B9F029BF_is1
start /wait msiexec /qn /norestart /x 00212D92-C5D8-4ff4-AE50-B20F0F85C40A_Systweak_Ad~4A5BE654_is1
start /wait msiexec /qn /norestart /x 00212D92-C5D8-4ff4-AE50-B20F0F85C40A_Systweak_Ad~B9F029BF_is1
start /wait msiexec /qn /norestart /x 00212D92-C5D8-4ff4-AE50-B20F0F85C40A_Systweak_Ad~9338DF9D_is1

:: Advertising Center by Nero AG
start /wait msiexec /qn /norestart /x {b2ec4a38-b545-4a00-8214-13fe0e915e6d}

:: Advertising Cookie Opt-out
start /wait msiexec /qn /norestart /x {8E425EB4-ADBD-4816-B1E8-49BB9DECF034}

:: AF-HSS Toolbar
start /wait msiexec /qn /norestart /x {f0381dbd-e018-4e07-ae40-d96ab15083f0}

:: af0.Adblock.BHO
start /wait msiexec /qn /norestart /x {90EFF544-3981-4d46-85C9-C0361D0931D6}

:: AGForms Toolbar
start /wait msiexec /qn /norestart /x {ed2e7de7-07db-4941-a06d-f780b93ba730}

:: AGFormHelperObj Class
start /wait msiexec /qn /norestart /x {6620E618-1AB9-4EB2-ACA4-CBBE9066DBE6}

:: agihelper.AGUtils
start /wait msiexec /qn /norestart /x {0bc6e3fa-78ef-4886-842c-5a1258c4455a}

:: AhIeBho Class
start /wait msiexec /qn /norestart /x {10384d0e-2bc1-48b6-844b-ad0e9e6d2511}

:: AIM Toolbar
start /wait msiexec /qn /norestart /x {DE9C389F-3316-41A7-809B-AA305ED9D922}
start /wait msiexec /qn /norestart /x {61539ecd-cc67-4437-a03c-9aaccbd14326}

:: Alawar Ask Toolbar
start /wait msiexec /qn /norestart /x {D4027C7F-154A-4066-A1AD-4243D8127440}

:: Alcohol Toolbar
start /wait msiexec /qn /norestart /x {ED4BD629-C1B6-4399-8A34-02CCAA921DC9}
start /wait msiexec /qn /norestart /x {4C4E7CDB-5BFC-4D74-83E2-8AE659B7EDA2}

:: Alexa Toolbar
start /wait msiexec /qn /norestart /x {EA582743-9076-4178-9AA6-7393FDF4D5CE}

:: allday savings
start /wait msiexec /qn /norestart /x {C13DB9D9-D8B8-4E8F-B4ED-BCFCC8C284E7}

:: AlxHelper Class
start /wait msiexec /qn /norestart /x {F443A627-5009-4323-9C1D-7FD598D0D712}

:: almeethaq-GR Toolbar
start /wait msiexec /qn /norestart /x {9fdddcc5-7bda-43a8-9e8b-c6e968b1294f}

:: ALOT Appbar Toolbar / Helper
start /wait msiexec /qn /norestart /x {A531D99C-5A22-449b-83DA-872725C6D0ED}
start /wait msiexec /qn /norestart /x {85F5CF95-EC8F-49fc-BB3F-38C79455CBA2}

:: Amazon Browser App
start /wait msiexec /qn /norestart /x {0A7D6F3C-F2AB-48ED-BE23-99791BFF87D6}

:: Amazon Browser Bar Toolbar
start /wait msiexec /qn /norestart /x {EA582743-9076-4178-9AA6-7393FDF4D5CE}

:: Amazon Music Importer 
start /wait msiexec /qn /norestart /x {EE54B7D5-57E0-A190-5D10-0982B52DF050}

:: AliBar BHO / B1 Toolbar
start /wait msiexec /qn /norestart /x {E4E012DC-1925-48E9-8010-2D195574642A}

:: Alnaddy.com Toolbar
start /wait msiexec /qn /norestart /x {CD3AED25-23AB-4543-B915-159449C37197}

:: Ant.com browser helper (video detector)
start /wait msiexec /qn /norestart /x {346FDE31-DFF9-418A-90C8-BA31DC9FF2EF}

:: Ant.com Video Downloader Toolbar
start /wait msiexec /qn /norestart /x {2E924F4F-67F0-4BD8-9560-49F468E843D2}

:: AOL Toolbar Loader
start /wait msiexec /qn /norestart /x {3ef64538-8b54-4573-b48f-4d34b0238ab2}
start /wait msiexec /qn /norestart /x {7C554162-8CB7-45A4-B8F4-8EA1C75885F9}

:: AOL Deutschland Toolbar
start /wait msiexec /qn /norestart /x {567d4d94-8077-4682-b887-945f3d644116}

:: AOL Toolbar
start /wait msiexec /qn /norestart /x {ba00b7b1-0351-477a-b948-23e3ee5a73d4}
start /wait msiexec /qn /norestart /x {4982D40A-C53B-4615-B15B-B5B5E98D167C}
start /wait msiexec /qn /norestart /x {A2A31FE0-CB70-409D-B4CC-40DCDF880732}

:: AOL Broadband Toolbar
start /wait msiexec /qn /norestart /x {e6ed7f95-e571-4f81-8757-5eb11252703d}
start /wait msiexec /qn /norestart /x {DE9C389F-3316-41A7-809B-AA305ED9D922}

:: AppGraffiti
start /wait msiexec /qn /norestart /x {6F6A5334-78E9-4D9B-8182-8B41EA8C39EF}_is1
start /wait msiexec /qn /norestart /x {6F6A5334-78E9-4D9B-8182-8B41EA8C39EF}

:: AP Suggestor
start /wait msiexec /qn /norestart /x {D0984FD4-FA9A-46ee-9072-70B0735FF852}

:: Aqori.com
start /wait msiexec /qn /norestart /x {11111111-1111-1111-1111-110011461173}

:: ArcadeGiant
start /wait msiexec /qn /norestart /x {BEC0B5A9-4CE8-4873-90E5-345E66A944DB}

:: ARPCache (Conduit related)
start /wait msiexec /qn /norestart /x {CD95D125-2992-4858-B3EF-5F6FB52FBAD6}

:: AskBar BHO
start /wait msiexec /qn /norestart /x {201f27d4-3704-41d6-89c1-aa35e39143ed}

:: Ask Toolbar / Search App / Installer / Ask.com Updater / Shopping App
start /wait msiexec /qn /norestart /x {3cb073f3-be3c-4e8f-942d-8a747b54486f}
start /wait msiexec /qn /norestart /x {41524553-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {41524553-342D-5350-00A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {41524553-3434-2D53-5000-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4152532D-5350-4D45-4400-7A786E7484D7}
start /wait msiexec /qn /norestart /x {41525353-502D-4D45-4400-7A786E7484D7}
start /wait msiexec /qn /norestart /x {41525353-5031-2D4D-4544-7A786E7484D7}
start /wait msiexec /qn /norestart /x {41525353-5032-2D4D-4544-7A786E7484D7}
start /wait msiexec /qn /norestart /x {41525353-5033-2D4D-4544-7A786E7484D7}
start /wait msiexec /qn /norestart /x {41545534-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {41564952-412D-5350-00A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4156522D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-3153-502D-5637-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-3200-A76A-76A7-A758B70C0A02}
start /wait msiexec /qn /norestart /x {42435041-3253-502D-5637-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-332D-5350-00A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-342D-5350-00A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-342D-5637-00A7-A758B70C0A00}
start /wait msiexec /qn /norestart /x {42435041-3431-2D53-5000-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-3432-2D53-5000-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-3433-2D53-5000-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-3434-2D53-5000-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-352D-5350-00A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {424C542D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {434C4D2D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {434D472D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {434D472D-5350-006A-76A7-A758B70C1200}
start /wait msiexec /qn /norestart /x {434D472D-5350-3100-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {434D472D-5350-3200-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4646332D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {46575637-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4B4D5056-372D-5350-00A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4D503352-5637-432D-5350-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4E44562D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4F524A00-6A76-A76A-76A7-A758B70C1300}
start /wait msiexec /qn /norestart /x {4F524A00-6A76-A76A-76A7-A758B70C1500}
start /wait msiexec /qn /norestart /x {4F524A00-6A76-A76A-76A7-A758B70C1D00}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-A758B70C1101}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-A758B70C1200}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-A758B70C1500}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-A758B70C1801}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-A758B70C1902}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-A758B70C1C01}
start /wait msiexec /qn /norestart /x {4F524A2D-5350-4500-76A7-A758B70C1D00}
start /wait msiexec /qn /norestart /x {4F524A2D-5354-2D53-5045-A758B70C0F05}
start /wait msiexec /qn /norestart /x {4F524A2D-5354-2D53-5045-A758B70C1200}
start /wait msiexec /qn /norestart /x {4F524A2D-5354-2D53-5045-A758B70C1C01}
start /wait msiexec /qn /norestart /x {4F524A2D-5354-2D53-5045-A758B70C1D00}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-006A-76A7-A758B70C0300}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-006A-76A7-A758B70C0F01}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-006A-76A7-A758B70C1C01}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-2D53-4154-A758B70C0A06}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-2D53-4154-A758B70C1300}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-4300-76A7-A758B70C0A00}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-4300-76A7-A758B70C0A06}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-4300-76A7-A758B70C0F01}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-4300-76A7-A758B70C2201}
start /wait msiexec /qn /norestart /x {4F564F32-5637-2D53-4154-A758B70C0300}
start /wait msiexec /qn /norestart /x {5043442D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {504C542D-5350-3200-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {504C5453-4F43-2D53-5000-7A786E7484D7}
start /wait msiexec /qn /norestart /x {5245414C-312D-5350-00A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {5245414C-312D-5350-00A7-A758B70C1D00}
start /wait msiexec /qn /norestart /x {5245414C-322D-5350-00A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {5245414C-392D-5350-00A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {52454C33-5350-2D53-4154-A758B70C1C01}
start /wait msiexec /qn /norestart /x {5347542D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {53475431-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {53475432-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {53475437-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {5348442D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {53484431-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {53484432-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {53484433-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {5350432D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {54422D54-4553-5400-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {54425F44-454D-4F5F-5350-7A786E7484D7}
start /wait msiexec /qn /norestart /x {56444A2D-5350-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {57425637-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {57434C32-2D53-5000-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {79A765E1-C399-405B-85AF-466F52E918B0}
start /wait msiexec /qn /norestart /x {86D4B82A-ABED-442A-BE86-96357B70F4FE}
start /wait msiexec /qn /norestart /x {9149AE79-3421-4A3A-834E-543948B045A2}
start /wait msiexec /qn /norestart /x {F084395C-40FB-4DB3-981C-B51E74E1E83D}

:: Astrology.com Toolbar
start /wait msiexec /qn /norestart /x {ea184a40-b71a-4aa7-b3be-596349038fa0}

:: aTube Toolbar
start /wait msiexec /qn /norestart /x {bfc39e47-d643-4dc2-aa1d-61377501c844}

:: Avanquest EN Toolbar / Avanquest ES Toolbar / Avanquest FR Toolbar
start /wait msiexec /qn /norestart /x {d7521926-ede3-4a77-9073-e9374fc439a3}
start /wait msiexec /qn /norestart /x {5ba84a9a-82f3-44a8-83c2-5ab15677491c}
start /wait msiexec /qn /norestart /x {6ec85fcf-87ad-41d7-ae1f-f116f8ad4848}

:: avast! WebRep Toolbar
start /wait msiexec /qn /norestart /x {8E5E2654-AD2D-48bf-AC2D-D17F00898D06}

:: Avery Toolbar
start /wait msiexec /qn /norestart /x {41565256-3700-A76A-76A7-7A786E7484D7}

:: AVG Web TuneUp Toolbar
start /wait msiexec /qn /norestart /x {95B7759C-8C7F-4BF1-B163-73684A933233}

:: AVG PC Tuneup 2011 / 2014 / AVG Driver Updater / AVG Security Toolbar
start /wait msiexec /qn /norestart /x {50316C0A-CC2A-460A-9EA5-F486E54AC17D}_is1 
start /wait msiexec /qn /norestart /x {8CD86D42-C4DD-4E40-9211-164DFFBCA4DB}
start /wait msiexec /qn /norestart /x {01BD4FC9-2F86-4706-A62E-774BB7E9D308}
start /wait msiexec /qn /norestart /x {E5D31C47-7177-443A-B65D-333F5ED6CCD0}
start /wait msiexec /qn /norestart /x {1AE46C09-2AB8-4EE5-88FB-08CD0FF7F2DF}

:: Avira SearchFree Toolbar
start /wait msiexec /qn /norestart /x {41564952-412D-5637-4300-A758B70C0A03}
start /wait msiexec /qn /norestart /x {41564952-412D-5637-4300-7A786E7484D7}

:: A VIO Bar Toolbar
start /wait msiexec /qn /norestart /x {4ba58ed5-2614-4e24-9fe9-7938ebfd00c5}

:: Axeso5 Toolbar
start /wait msiexec /qn /norestart /x {08EB9EF9-D1D5-428B-BECA-87E23F35A331}

:: AZESearch Toolbar / ZToolbar
start /wait msiexec /qn /norestart /x {D01B1F7D-9D7F-46C3-8DB9-5A55819E2A7F}
start /wait msiexec /qn /norestart /x {A6790AA5-C6C7-4BCF-A46D-0FDAC4EA90EB}

:: Babylon Toolbar
start /wait msiexec /qn /norestart /x {E55E7026-EF2A-4A17-AAA7-DB98EA3FD1B1}

:: BabylonObjectInstaller
start /wait msiexec /qn /norestart /x {83AA2913-C123-4146-85BD-AD8F93971D39}

:: Baidu Toolbar
start /wait msiexec /qn /norestart /x {B580CF65-E151-49C3-B73F-70B13FCA8E86}

:: BBuYNsave
start /wait msiexec /qn /norestart /x {842C4394-47F7-60DE-480B-C09116B63559}

:: Bestgame Toolbar
start /wait msiexec /qn /norestart /x {899cac9d-533d-45c2-8a07-afb42425b544}

:: BetterCareerSearch Toolbar 
start /wait msiexec /qn /norestart /x {7ff70c81-f37a-4d7b-9d30-ba8ee8c80d5f}

:: BEtteerPPriceoCChec 
start /wait msiexec /qn /norestart /x {4E5FE462-1A84-47B4-3411-C72434AAD86C}

:: Bekko Search Bar 1.0 Toolbar
start /wait msiexec /qn /norestart /x {D8E6FAB1-CCB0-9174-716B-7C4727C14BC8}

:: BFlix Toolbar
start /wait msiexec /qn /norestart /x {a6bf16ab-42a1-4bc5-965d-5e407e449aaa}

:: BHO for iE
start /wait msiexec /qn /norestart /x {67B630C5-D6CF-CDE0-1B2D-853A5A74C3F5}

:: BigSeekPro Toolbar
start /wait msiexec /qn /norestart /x {338B4DFE-2E2C-4338-9E41-E176D497299E}

:: Bing Bar / Bing Bar Helper
start /wait msiexec /qn /norestart /x {FF6DD716-7B10-4269-9F19-FFB07AC4CD95}
start /wait msiexec /qn /norestart /x {3365E735-48A6-4194-9988-CE59AC5AE503}
start /wait msiexec /qn /norestart /x {3611CA6C-5FCA-4900-A329-6A118123CCFC}
start /wait msiexec /qn /norestart /x {1E03DB52-D5CB-4338-A338-E526DD4D4DB1}
start /wait msiexec /qn /norestart /x {77F8A71E-3515-4832-B8B2-2F1EDBD2E0F1}
start /wait msiexec /qn /norestart /x {C28D96C0-6A90-459E-A077-A6706F4EC0FC}
start /wait msiexec /qn /norestart /x {B4089055-D468-45A4-A6BA-5A138DD715FC}
start /wait msiexec /qn /norestart /x {D6C3C9E7-D334-4918-BD57-5B1EF14C207D}
start /wait msiexec /qn /norestart /x {449CE12D-E2C7-4B97-B19E-55D163EA9435}
start /wait msiexec /qn /norestart /x {77C4850C-3592-4A2F-B652-ACB77A1EF77C}
start /wait msiexec /qn /norestart /x {08234a0d-cf39-4dca-99f0-0c5cb496da81}
start /wait msiexec /qn /norestart /x {65C0025A-2CDE-43C5-82D0-C7A56EF0DB39}
start /wait msiexec /qn /norestart /x {16D0F2D2-242C-4885-BEF1-4B1655C141AE}
start /wait msiexec /qn /norestart /x {16793295-2366-40F7-A045-A3E42A81365E}
start /wait msiexec /qn /norestart /x {623B8278-8CAD-45C1-B844-58B687C07805}
start /wait msiexec /qn /norestart /x {6F6D8BC6-CE36-493B-996F-04CD8CCC35A8}

:: Bing Rewards Client Installer
start /wait msiexec /qn /norestart /x {61EDBE71-5D3E-4AB7-AD95-E53FEAF68C17}

:: BitSaverr
start /wait msiexec /qn /norestart /x {A3FC46A0-9B62-0EF3-B475-743B3A2762B1}

:: Bitlord Toolbar
start /wait msiexec /qn /norestart /x {63ee0f5c-b56a-4ecf-b209-45fdcbfcaf45}
start /wait msiexec /qn /norestart /x {7c5c0f58-e061-457d-9033-77307f5ed00c}

:: BitTorrentBar Toolbar
start /wait msiexec /qn /norestart /x {88c7f2aa-f93f-432c-8f0e-b7d85967a527}

:: BittorrentBar_NL Toolbar
start /wait msiexec /qn /norestart /x {2d8d9acc-f6d7-4362-8876-a275ca929591}

:: Blingee Toolbar
start /wait msiexec /qn /norestart /x {D1121FE0-0145-44C9-AA35-72071AC20A9B}

:: Blipshot One Click Screenshots 
start /wait msiexec /qn /norestart /x {0B750649-0E5A-78CB-A6AE-E2D6E2AD8882}

:: BlockAndSurf
start /wait msiexec /qn /norestart /x {9A08C510-8505-2B66-CAC9-1B6A5774EBB0}

:: BlockAndSurf Toolbar
start /wait msiexec /qn /norestart /x {5176EA87-B7D4-4E04-A5D7-CF3FC0AAF7EC}

:: Booksbario Toolbar
start /wait msiexec /qn /norestart /x {d27e2b5a-2344-4a09-a60a-8b90cd474deb}

:: bProtector pup
start /wait msiexec /qn /norestart /x {15D2D75C-9CB2-4efd-BAD7-B9B4CB4BC693}

:: BringMeSports Toolbar
start /wait msiexec /qn /norestart /x {cc53bd19-7b23-43b0-ab7c-0e06c708cced}

:: BrotherSoft Extreme Toolbar
start /wait msiexec /qn /norestart /x {51a86bb3-6602-4c85-92a5-130ee4864f13}

:: Browsing Protection Toolbar
start /wait msiexec /qn /norestart /x {265EEE8E-3228-44D3-AEA5-F7FDF5860049}

:: Browser Features
start /wait msiexec /qn /norestart /x {27699FD3-AB4E-46BE-8DD2-7B2D5839BDF1}_is1

:: Browse and SHop
start /wait msiexec /qn /norestart /x {B54A674B-5B6E-A4E6-4E71-FB7182E9D18F}

:: Browser System Enhancer
start /wait msiexec /qn /norestart /x {5F189DF5-2D05-472B-9091-84D9848AE48B}{671c50b0}

:: BS Player Toolbar
start /wait msiexec /qn /norestart /x {fed66dc5-1b74-4a04-8f5c-15c5ace2b9a5}
start /wait msiexec /qn /norestart /x {b2e293ee-fd7e-4c71-a714-5f4750d8d7b7}

:: BT Yahoo! Toolbar
start /wait msiexec /qn /norestart /x {EF99BD32-C1FB-11D2-892F-0090271D4F88}

:: Burn4Free DB Toolbar / BigSeekPro Toolbar
start /wait msiexec /qn /norestart /x {338B4DFE-2E2C-4338-9E41-E176D497299E}

:: Butterscotch Toolbar
start /wait msiexec /qn /norestart /x {AF3D7884-B142-414E-943D-75D8D54E1FFF}

:: BuzzDock Adware
start /wait msiexec /qn /norestart /x {ac225167-00fc-452d-94c5-bb93600e7d9a}
start /wait msiexec /qn /norestart /x {220EB34E-DC2B-4B04-AD40-A1C7C31731F2}
start /wait msiexec /qn /norestart /x {cfd32d46-7d3f-483f-bace-7172aec5592d}

:: bUyandBrowseu
start /wait msiexec /qn /norestart /x {E2D23061-C457-77CB-7789-7139D13F4910}

:: BVD ToolKit Toolbar
start /wait msiexec /qn /norestart /x {e49d8d56-543d-4b71-ba78-150d6dd38374}

:: CA Anti-Phishing Toolbar
start /wait msiexec /qn /norestart /x {0123B506-0AD9-43AA-B0CF-916C122AD4C5}

:: CashSurfers Toolbar
start /wait msiexec /qn /norestart /x {710E56CE-0C2F-474B-8A40-554A11A7E56F}

:: CallingID LinkAdvisor 2.0 Toolbar
start /wait msiexec /qn /norestart /x {10134636-E7AF-4AC5-A1DC-C7C44BB97D81}

:: Celebrity Toolbar
start /wait msiexec /qn /norestart /x {FD2FD708-1F6F-4B68-B141-C5778F0C19BB}

:: Cell Phone Unlock Toolbar
start /wait msiexec /qn /norestart /x {a786e841-0541-427e-a26a-a5e078bfcd86}

:: CenturyLink Toolbar
start /wait msiexec /qn /norestart /x {A317CB83-299C-4FC8-9ED7-2D64117D98EE}

:: ChatSend Toolbar
start /wait msiexec /qn /norestart /x {1BB22D38-A411-4B13-A746-C2A4F4EC7344}
start /wait msiexec /qn /norestart /x {37D48D9C-3F7E-412F-B5BF-611BE7CCFCA1}

:: ChatVibes Toolbar
start /wait msiexec /qn /norestart /x {01193D00-C7F9-4C26-92A2-1CA91F170068}
start /wait msiexec /qn /norestart /x {10000000-1000-1000-1000-100000000003}

:: CHeaupMe
start /wait msiexec /qn /norestart /x {F6C44C71-2CFE-8176-3A4D-CBD0DCE5AEFA}

:: CieoNet Utilities Toolbar
start /wait msiexec /qn /norestart /x {8175e372-1ff1-4288-8e6e-addebd415d47}

:: Classic Explorer Bar Toolbar
start /wait msiexec /qn /norestart /x {553891B7-A0D5-4526-BE18-D3CE461D6310}

:: cleanlab Toolbar
start /wait msiexec /qn /norestart /x {0b1be383-efa8-44d5-a7c2-9a39594575a1}

:: Cleaner Pro v2.6.2
start /wait msiexec /qn /norestart /x {25FBF79F-83C6-4243-B149-C6050AB71B72}

:: Cocoon Toolbar
start /wait msiexec /qn /norestart /x {58435E33-B5C7-4871-9D03-1A5FEB408074}

:: Cole2k Media Toolbar
start /wait msiexec /qn /norestart /x {8AE33802-00D3-4F1B-B5C7-6FEE34E402CE}
start /wait msiexec /qn /norestart /x {015407A9-D183-4379-8452-DFD7C2297902}
start /wait msiexec /qn /norestart /x {2D2DE234-AB9F-4345-9D17-94FA78BA37E3}
start /wait msiexec /qn /norestart /x {CE899E3C-524B-47ee-9EDA-29140AC0FCCE}

:: compliance 54328 / 0615 Toolbar
start /wait msiexec /qn /norestart /x {4724c5d8-dfa7-417a-a2f5-1eabfee9b4ac}
start /wait msiexec /qn /norestart /x {31c7d459-9cc3-44f2-9dca-fc11795309b4}

:: Coolstreaming Tool-Bar v1.0 Toolbar
start /wait msiexec /qn /norestart /x {bd0e4d83-654e-4213-965b-fcbe887061f4}

:: CoolSoft Toolbar
start /wait msiexec /qn /norestart /x {8cc79aa8-290c-41c4-953c-678bdee602bb}

:: Coupoon v1.0
start /wait msiexec /qn /norestart /x {49F8B4F8-0CD4-4BE4-A9E8-B13A071F7C90}_is1

:: Coupon Alert Toolbar
start /wait msiexec /qn /norestart /x {3462c343-be19-4143-af70-cefb56f46fc6}

:: CouponAmazing
start /wait msiexec /qn /norestart /x {60DFCCEC-70F7-413B-8AA4-F82B76E1EB9F}

:: ConVertsPDF
start /wait msiexec /qn /norestart /x {734E01CA-17DF-C45B-9082-D4D09732D089}

:: CCoupSCanneR
start /wait msiexec /qn /norestart /x {80E8B0A0-117D-1402-7CDE-688156237115}

:: Common Desktop Agent
start /wait msiexec /qn /norestart /x {031A0E14-0413-4C97-9772-2639B782F46F}

:: conTiinuetoSavee
start /wait msiexec /qn /norestart /x {C1C6816E-CBB3-A748-85F9-A8B47B68985B}

:: Contribute Toolbar
start /wait msiexec /qn /norestart /x {517BDDE4-E3A7-4570-B21E-2B52B6139FC7}

:: Corsair Add-on Toolbar
start /wait msiexec /qn /norestart /x {B4FBA8C3-2083-4ED8-A35B-148478739826}

:: CoouupExteonnsioen
start /wait msiexec /qn /norestart /x {6933C2BA-C67D-42C7-8C77-1FF4B364AF54}

:: Coupons.com CouponBar
start /wait msiexec /qn /norestart /x {8660E5B3-6C41-44DE-8503-98D99BBECD41}

:: Crawler.com / Crawler / Crawler Helper Toolbar
start /wait msiexec /qn /norestart /x {11BF46C6-B3DE-48BD-BF70-3AD85CAB80B5}_is1
start /wait msiexec /qn /norestart /x {1CB20BF0-BBAE-40A7-93F4-6435FF3D0411}
start /wait msiexec /qn /norestart /x {4B3803EA-5230-4DC3-A7FC-33638F3D3542}
start /wait msiexec /qn /norestart /x {C4D78C72-08DB-4A3F-9175-B265157283F3}

:: CrazyForCricket Toolbar
start /wait msiexec /qn /norestart /x {9ddabb0a-cdcc-4cc6-ab2d-356099308433}

:: Cupid Toolbar
start /wait msiexec /qn /norestart /x {618413C5-0C8D-4D0F-9600-7CED876FA3DF}

:: CyberDefender Link Patrol Toolbar
start /wait msiexec /qn /norestart /x {DD662A0C-12FE-4b38-BA53-247F7EC82F46}

:: D-Link Toolbar
start /wait msiexec /qn /norestart /x {61874dfa-9adf-44e5-8e61-f3913707e7d7}

:: DAEMON Tools Toolbar
start /wait msiexec /qn /norestart /x {32099AAC-C132-4136-9E9A-4E364A424E17}

:: DailyBibleGuide Toolbar
start /wait msiexec /qn /norestart /x {2a942ab7-2073-49bc-a7e1-77e93835889a}
start /wait msiexec /qn /norestart /x {1399078b-7eb7-477a-893f-93d4ace22fda}

:: dAilyypRize
start /wait msiexec /qn /norestart /x {144AC25F-D7A7-B233-BFB8-433771ECB92D}

:: ddeal44rEAl
start /wait msiexec /qn /norestart /x {2FA77785-00C3-A920-6452-D4FE5C9C129F}

:: DDealEXpreuss
start /wait msiexec /qn /norestart /x {25F259ED-12F6-429F-5783-527C3E2F8586}

:: DealNoDeal
start /wait msiexec /qn /norestart /x {37476589-E48E-439E-A706-56189E2ED4C4}

:: dealsteeR
start /wait msiexec /qn /norestart /x {5E03DFA7-51FC-7C12-CEE5-4D75FBB01E8F}

:: DeGoTB Toolbar
start /wait msiexec /qn /norestart /x {b5fb4c8d-8220-4a63-8e0f-708cdd0f4c3d}

:: Delta Chrome Toolbar
start /wait msiexec /qn /norestart /x {177586E7-E42E-4F38-83D1-D15B4AF5B714}

:: DebugBar (Toolbar)
start /wait msiexec /qn /norestart /x {3E1201F4-1707-409F-BB45-A5F192381DA0}

:: Dell Toolbar
start /wait msiexec /qn /norestart /x {09B71986-2AC5-482d-B6CB-42EA34F4F85B}

:: dgfr Toolba Toolbar
start /wait msiexec /qn /norestart /x {5e1e5b07-85fa-4930-b100-66efa0562444}

:: Diary.ru v1 Toolbar
start /wait msiexec /qn /norestart /x {44D23804-F368-489f-9218-CD2D6C070F3E}

:: DigitalPowered Toolbar
start /wait msiexec /qn /norestart /x {b317125e-2f10-4388-bf1f-2c31c6cd89ed}

:: Diigo Toolbar
start /wait msiexec /qn /norestart /x {09197FFB-C236-4153-B268-31051E4F3B6C}

:: Dictionary.com Toolbar
start /wait msiexec /qn /norestart /x {44494333-5637-006A-76A7-7A786E7484D7}

:: DictionaryBoss Toolbar
start /wait msiexec /qn /norestart /x {3042df7a-e900-4389-9b94-923df0daa57e}

:: Discover USA Toolbar
start /wait msiexec /qn /norestart /x {48405d3d-2674-4cd8-b1ef-9a719443bd3f}

:: DiSecOUnntLLocator 
start /wait msiexec /qn /norestart /x {194FED75-9C74-BDB7-53F8-8CFFEF1AFEC9}

:: DocuCom PDF Toolbar
start /wait msiexec /qn /norestart /x {E3286BF1-E654-42FF-B4A6-5E111731DF6B}

:: Dogpile Bundle Toolbar
start /wait msiexec /qn /norestart /x {C80BDEB2-8735-44C6-BD55-A1CCD555667A}

:: Download Energy Toolbar
start /wait msiexec /qn /norestart /x {ad708c09-d51b-45b3-9d28-4eba2681febf}
start /wait msiexec /qn /norestart /x {2bae58c2-79f9-45d1-a286-81f911301c3a}

:: doownloAditkeeP.
start /wait msiexec /qn /norestart /x {1C52B8B6-FFA2-12F6-0A5A-E8301F96A568}

:: doleluaRsAover
start /wait msiexec /qn /norestart /x {6E3B2E00-8ADC-98BD-428C-13CEC2925F29}

:: Driver Detective
start /wait msiexec /qn /norestart /x {3839C2FF-2CD0-4601-91A8-B1E40A9BE8A8}

:: DriverUpdate
start /wait msiexec /qn /norestart /x {65C92136-6AF0-4E70-88D2-D19E739CE285}
start /wait msiexec /qn /norestart /x {97C97FAC-9153-409E-A9C8-A19AFABE7547}
start /wait msiexec /qn /norestart /x {069A06F9-10B2-444A-8455-DC6131666772}
start /wait msiexec /qn /norestart /x {1EC642B2-436B-43ED-AF56-D85A48E6E6AB}
start /wait msiexec /qn /norestart /x {2B353DA2-A8FD-4238-B207-62A1921158D7}
start /wait msiexec /qn /norestart /x {554D1038-9882-4CC8-9CC5-F8AB6C556469}
start /wait msiexec /qn /norestart /x {40DEF4E7-EECA-415D-9E40-6E0C6E4E80E3}
start /wait msiexec /qn /norestart /x {C67F5282-3EB4-4FE2-A5C7-ABEE4BE42F6D}
start /wait msiexec /qn /norestart /x {E5552EF3-E76E-4065-AD34-74FC6032D3D7}
start /wait msiexec /qn /norestart /x {850A14FC-F410-47F7-94E4-38F4D3F270D4}
start /wait msiexec /qn /norestart /x {A52E7121-E333-4676-8767-9FD412531B53}
start /wait msiexec /qn /norestart /x {CF516344-84E1-4420-BDAD-52E13F32D07E}
start /wait msiexec /qn /norestart /x {C85A8187-7E95-429D-9C9C-57C10268B3CF}

:: Driver Whiz
start /wait msiexec /qn /norestart /x {97BBECCF-B1FD-4010-8D4B-EFC9E3CCEECF}

:: Driver Support 
start /wait msiexec /qn /norestart /x {597FB4A5-DD86-4316-A410-7E8074CC2CCE}

:: Driver Manager
start /wait msiexec /qn /norestart /x {177CD779-4EEC-43C5-8DEA-4E0EC103624B}

:: DriverTuner
start /wait msiexec /qn /norestart /x {520C1D80-935C-42B9-9340-E883849D804F}_is1

:: DVD Video Soft Toolbar
start /wait msiexec /qn /norestart /x {cd8812d4-e5b8-41c6-94d4-59872a484bf1}

:: dynaTrace AJAX Edition Toolbar
start /wait msiexec /qn /norestart /x {42EC68EF-4494-4041-9993-A5789BF7750B}

:: EarthLink Toolbar
start /wait msiexec /qn /norestart /x {C7768536-96F8-4001-B1A2-90EE21279187}

:: Easy Photo Print Toolbar
start /wait msiexec /qn /norestart /x {9421DD08-935F-4701-A9CA-22DF90AC4EA6}

:: Easy-SpeedUp-Manager
start /wait msiexec /qn /norestart /x {EF367AA4-070B-493C-9575-85BE59D789C9}

:: Easy-WebPrint Toolbar
start /wait msiexec /qn /norestart /x {327C2873-E90D-4c37-AA9D-10AC9BABA46C}

:: Eazel-FR Toolbar
start /wait msiexec /qn /norestart /x {a8f9752d-e2b8-4e7a-86b5-499f4330e2fe}

:: EarthLink Toolbar
start /wait msiexec /qn /norestart /x {C7768536-96F8-4001-B1A2-90EE21279187}

:: eBay Toolbar
start /wait msiexec /qn /norestart /x {92085AD4-F48A-450D-BD93-B28CC7DF67CE}

:: eFix Pro
start /wait msiexec /qn /norestart /x {309B04C3-FEFD-0FD5-BB61-C08E8227F5F6}

:: Egisca Toolbar
start /wait msiexec /qn /norestart /x {C1E68079-1B2C-41D7-A3C2-BE82E570251E}

:: EixTrraShoppperr
start /wait msiexec /qn /norestart /x {7BCAC0EB-3993-2416-0531-848C39DF8B65}

:: Elf 1 / 1.11 / 1.12 / 1.13 / 1.15 Toolbar
start /wait msiexec /qn /norestart /x {22e03916-85c5-44b0-8dc9-1830c11238d9}
start /wait msiexec /qn /norestart /x {313a832a-aaf3-4880-a8d0-c42bee319c02}
start /wait msiexec /qn /norestart /x {38542454-dfb6-44f5-b052-d4e071a3d073}
start /wait msiexec /qn /norestart /x {b80f591e-fe9a-46cf-a13e-180377240586}
start /wait msiexec /qn /norestart /x {b9d63c58-90cc-428b-8d3b-cbb88eb07e7e}

:: EndNote Web Toolbar
start /wait msiexec /qn /norestart /x {945C8270-A848-11D5-A805-00B0D092F45B}

:: EnjoyCoupon
start /wait msiexec /qn /norestart /x {2DF3E224-05CD-4113-AA7A-86F2F6607B46}

:: eToolKit Toolbar
start /wait msiexec /qn /norestart /x {D3B22A92-87A2-47b6-B3E6-A64877B5C242}

:: eType Toolbar
start /wait msiexec /qn /norestart /x {d0230100-3044-43b1-a44e-70dc12fd418c}
start /wait msiexec /qn /norestart /x {BDE58274-7A2A-4682-8C47-A379DD9E36CB}

:: eTvOnline.ro Toolbar
start /wait msiexec /qn /norestart /x {7272be4d-474f-43c8-9c65-7e8824ef39b8}

:: E-Web Print Toolbar
start /wait msiexec /qn /norestart /x {201CF130-E29C-4E5C-A73F-CD197DEFA6AE}

:: express-files Toolbar
start /wait msiexec /qn /norestart /x {88ac3cb6-596b-4217-964c-b6757ef9602d}

:: ExsatraSavinngs
start /wait msiexec /qn /norestart /x {C637A71C-A4B2-4B47-1B2A-1042A8D525A3}

:: ExSetraCooupon
start /wait msiexec /qn /norestart /x {98449C67-C7AF-BB53-112D-26C916814611}

:: Extreme Blocker 
start /wait msiexec /qn /norestart /x {37476589-E48E-439E-A706-56189E2ED4C4}_is1

:: EZDownloader
start /wait msiexec /qn /norestart /x {0F44DC3A-6E62-4961-A14B-95323C512F9B}_is1

:: ExplorerWnd Helper Toolbar
start /wait msiexec /qn /norestart /x {10921475-03CE-4E04-90CE-E2E7EF20C814}

:: E-Zsoft VideoDownloaderToolbar
start /wait msiexec /qn /norestart /x {4322A444-92F8-4C3E-BD4C-013BA51E2871}

:: FastClean PRO
start /wait msiexec /qn /norestart /x {47BAE98C-1DE7-4415-9EA7-D783AEA04F54}
start /wait msiexec /qn /norestart /x {01B0D3C2-DCD1-4F5C-92B7-D82988610623}

:: F-Secure Search Toolbar
start /wait msiexec /qn /norestart /x {B242FC32-2B60-48EA-A8E3-2E280EDBC48F}

:: FaceSmooch Toolbar
start /wait msiexec /qn /norestart /x {3c490bf5-4244-4310-b4a7-3361f288dac5}
start /wait msiexec /qn /norestart /x {7bf3213c-29b9-4150-935c-5d861c4ec978}

:: Fast And Safe (Adware)
start /wait msiexec /qn /norestart /x {5F189DF5-2D05-472B-9091-84D9848AE48B}{64af91bf}

:: fastsaLer
start /wait msiexec /qn /norestart /x {6AEC2288-82D5-C6CE-CC6F-213FE715E4E5}

:: FestiveBar Toolbar
start /wait msiexec /qn /norestart /x {9ae277e9-32f4-46d5-94f4-20201609d1d0}

:: ffreie2you
start /wait msiexec /qn /norestart /x {074887BF-06BC-9065-9562-3C1A861F7111}

:: FiinndBestDeaal Software
start /wait msiexec /qn /norestart /x {B5DB572D-EA87-D3B0-08F6-4D153EA6A783}

:: File2LinkIB Toolbar
start /wait msiexec /qn /norestart /x {c23b756a-bd9f-4ca6-aded-17ab8ccf3e8b}

:: FilmFanatic Toolbar
start /wait msiexec /qn /norestart /x {0b84b4b4-8af8-4f1f-91fe-074a666f6425}

:: FlashGet Bar Toolbar
start /wait msiexec /qn /norestart /x {E0E899AB-F487-11D5-8D29-0050BA6940E3}

:: Flexera Software
start /wait msiexec /qn /norestart /x {A7296D52-26ED-42F5-95C1-DD595ED66391}

:: Fliptoast by W3i
start /wait msiexec /qn /norestart /x {B25D67C4-E885-43F8-8085-B532F6261529}

:: Flip - Connect with Friends Toolbar
start /wait msiexec /qn /norestart /x {4DA729A4-684A-4034-A45B-6D56CEAAE92B}

:: FlvTube Toolbar
start /wait msiexec /qn /norestart /x {851552F5-B878-4b03-904F-2AD6A4CC8994}

:: Free Lunch Design Toolbar
start /wait msiexec /qn /norestart /x {57cc715d-37ca-44e4-9ec2-8c2cbddb25ec}

:: Free Ride Games Player
start /wait msiexec /qn /norestart /x {2B7BDADB-EC8C-4C54-B5DD-CE45A016D3A7}

:: Freecorder Toolbar
start /wait msiexec /qn /norestart /x {1392b8d2-5c05-419f-a8f6-b9f15a596612}
start /wait msiexec /qn /norestart /x {70dd86e8-b5bc-4e4a-9d5c-b6234c24323c}

:: FreeRIP Toolbar
start /wait msiexec /qn /norestart /x {E634228A-03CF-4BC8-B0AB-668257F1FD8C}

:: free-downloads.net Toolbar
start /wait msiexec /qn /norestart /x {ecdee021-0d17-467f-a1ff-c7a115230949}

:: FreeOnlineRadioPlayerRecorder Toolbar
start /wait msiexec /qn /norestart /x {f999a48b-1950-4d81-9971-79018f807b4b}

:: FrostWire Toolbar
start /wait msiexec /qn /norestart /x {46575637-0076-A76A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {67f50cea-7b7a-4e4d-bbf6-89686df28fa2}
start /wait msiexec /qn /norestart /x {46575636-0076-A76A-76A7-7A786E7484D7}

:: Free SystemUtilities
start /wait msiexec /qn /norestart /x {F321FD31-FE5B-40A8-98A6-AC3F06D73A64}

:: FULL-DISKfighter
start /wait msiexec /qn /norestart /x {66986E4B-E9FB-47C2-83FB-59AD8E40386A}

:: FuonDeealls Software
start /wait msiexec /qn /norestart /x {478472F9-9E09-492A-BDAB-42EE595EF1AD}

:: FVD Suite Toolbar
start /wait msiexec /qn /norestart /x {2B171655-A69C-5c18-B693-6CB5DC269D41}

:: GagetBox Toolbar
start /wait msiexec /qn /norestart /x {3B81079D-2AC9-425f-A494-A1C7D93AFA3C}

:: GameBox Toolbar
start /wait msiexec /qn /norestart /x {0FEF2D2C-CDA6-45E4-B2ED-9DF7C50C95FF}

:: Gamers Unite! Snag Bar Toolbar
start /wait msiexec /qn /norestart /x {25515A79-C1C7-4B97-97F8-31A711694487}

:: GamesBar Toolbar
start /wait msiexec /qn /norestart /x {6F282B65-56BF-4BD1-A8B2-A4449A05863D}
start /wait msiexec /qn /norestart /x {7ffa5f54-1c4f-46de-8576-c271a0dd482f}
start /wait msiexec /qn /norestart /x {a813911c-202d-4343-a0f2-5906d512fec5}

:: GamingWonderland Toolbar
start /wait msiexec /qn /norestart /x {a899079d-206f-43a6-be6a-07e0fa648ea0}

:: Game Master 2.1 Toolbar
start /wait msiexec /qn /norestart /x {22dfbf5b-a7cd-4b25-9471-3dc68c71855f}

:: GameVance
start /wait msiexec /qn /norestart /x {C1C3E833-420E-4D78-9BA7-86AEBB272384}

:: Games.com Toolbar
start /wait msiexec /qn /norestart /x {9da1bcf1-77f5-41c5-b7c3-c597dc20752c}

:: Get-Styles Toolbar v3
start /wait msiexec /qn /norestart /x {5BCDC9E9-A980-4B53-B2E8-60CFF484DA61}

:: GeekBuddy
start /wait msiexec /qn /norestart /x {39AB4A9F-97DB-4BCA-981F-B85189115037}

:: Glarysoft Toolbar
start /wait msiexec /qn /norestart /x {e9d9d92d-7918-49d4-a93a-afc809e21eb7}

:: Global English Productivity Toolbar
start /wait msiexec /qn /norestart /x {D2EC0085-C9B2-4860-BC38-8A5FB2DA836C}

:: GlobalSpec Engineering Toolbar
start /wait msiexec /qn /norestart /x {4E7BD74F-2B8D-469E-D1FB-EF7FB3D5FA7D}

:: GMX Toolbar
start /wait msiexec /qn /norestart /x {C424171E-592A-415a-9EB1-DFD6D95D3530}
start /wait msiexec /qn /norestart /x {2D1DDD38-CE4D-459b-A01C-F11BC92D5B69}

:: Google Toolbar / Google Update Helper / Google Web Accelerator 
start /wait msiexec /qn /norestart /x {18455581-E099-4BA8-BC6B-F34B2F06600C}
start /wait msiexec /qn /norestart /x {2318C2B1-4965-11d4-9B18-009027A5CD4F}
start /wait msiexec /qn /norestart /x {DBEA1034-5882-4A88-8033-81C4EF0CFA29}
start /wait msiexec /qn /norestart /x {2CCBABCB-6427-4A55-B091-49864623C43F}
start /wait msiexec /qn /norestart /x {A92DAB39-4E2C-4304-9AB6-BC44E68B55E2}
start /wait msiexec /qn /norestart /x {DB87BFA2-A2E3-451E-8E5A-C89982D87CBF}

:: GoSave extension
start /wait msiexec /qn /norestart /x {64A4ABCA-CF3D-C548-2DC4-72A55DC5882A}

:: Grab Pro / Orbit Downloader Toolbar
start /wait msiexec /qn /norestart /x {C55BBCD6-41AD-48AD-9953-3609C48EACC7}

:: GreatSaver
start /wait msiexec /qn /norestart /x {CA41BB14-E67B-1653-C57B-5CA99418A866}

:: grreatSaving
start /wait msiexec /qn /norestart /x {439763FF-59EC-FF1D-B0B5-CB9E213A7A5C}

:: Gossiper Toolbar
start /wait msiexec /qn /norestart /x {0a452a47-c5a8-4854-a237-4b9b06b376f0}

:: Gotovim-Doma.ru Toolbar
start /wait msiexec /qn /norestart /x {788400C4-31F6-4d9f-BAFF-D289627600A8}

:: Guffins Toolbar
start /wait msiexec /qn /norestart /x {de2fdf7c-2637-4ba3-b427-3fce2d331db5}

:: Gutscheinmieze Toolbar
start /wait msiexec /qn /norestart /x {DFEFCDEE-CF1A-4FC8-88AD-48514E463B27}

:: Harmony Hollow Software Toolbar
start /wait msiexec /qn /norestart /x {3806b089-6759-411d-b2c3-b7995a9f34d7}

:: HeadlineAlley Toolbar
start /wait msiexec /qn /norestart /x {8f61e414-ea79-4559-8bb6-61d956f70306}

:: Hero Fighter Toolbar
start /wait msiexec /qn /norestart /x {b12785f5-d8d0-4530-a3ea-5c4263b85bef}

:: HHappy2SaiVe BHO
start /wait msiexec /qn /norestart /x {E957849A-94AC-6F46-4623-C31474E3C170}

:: HopSurf Toolbar
start /wait msiexec /qn /norestart /x {E9FAB13D-4600-49E1-90D1-EE961C859D39}

:: Horoscopes Daily Toolbar
start /wait msiexec /qn /norestart /x {acfbb02a-e32d-4223-9d4e-4926c02ff981}

:: Hot MP3 Toolbar
start /wait msiexec /qn /norestart /x {9384bd4c-dd14-4be9-80f7-f6277511e4f5}

:: HottieStar / HotVideoBar Toolbar
start /wait msiexec /qn /norestart /x {D45817B8-3EAD-4d1d-8FCA-EC63A8E35DE2}

:: HomeTab 6.4 
start /wait msiexec /qn /norestart /x {764f9059-6965-4561-95b6-916ca8d5f8f7}_is1

:: HP SimplePass Toolbar
start /wait msiexec /qn /norestart /x {C98EE38D-21E4-4A50-907D-2B56FEC7013E}

:: Hummingbird DM Toolbar
start /wait msiexec /qn /norestart /x {83E8BF99-F3C0-4475-B453-9F9E8E4548C3}

:: Hunt TB Toolbar
start /wait msiexec /qn /norestart /x {d3f4b70a-92e0-4393-a0f3-976d03b1ebf5}

:: Iadah Toolbar
start /wait msiexec /qn /norestart /x {3EA8D036-C9E7-4721-BCDF-C13D00C4CC39}

:: i-beta.com extension
start /wait msiexec /qn /norestart /x {37BE563C-6020-43A7-BB6C-3BEDE8BFA1BD}

:: iCafe Manager Toolbar
start /wait msiexec /qn /norestart /x {283E1154-49DB-4B7A-9A94-6B54A1087B42}

:: IDA Bar Toolbar
start /wait msiexec /qn /norestart /x {C70E30C7-140A-4166-A2E8-43557E62B41A}
start /wait msiexec /qn /norestart /x {0E1230F8-EA50-42A9-983C-D22ABC2EED3B}
start /wait msiexec /qn /norestart /x {977AE9CC-AF83-45E8-9E03-E2798216E2D5}
start /wait msiexec /qn /norestart /x {1FAFD711-ABF9-4F6A-8130-5166C7371427}

:: IE SweetPacks Toolbar 
start /wait msiexec /qn /norestart /x {F4E33CE5-A7AB-4F68-A7E7-F0AA84EF2D9E}
start /wait msiexec /qn /norestart /x {C3E85EE9-5892-4142-B537-BCEB3DAC4C3D}

:: IIsaaver Software
start /wait msiexec /qn /norestart /x {F1422DAA-0829-09A1-7536-73936CAB8FFA}

:: iLivid Download Manager
start /wait msiexec /qn /norestart /x {8D15E1B2-D2B7-4A17-B44B-D2DDE5981406}

:: ImageToPng BHO
start /wait msiexec /qn /norestart /x {96CA71FF-122E-97A7-1D4F-F986889CA854}

:: Imbooster
start /wait msiexec /qn /norestart /x {7F1E694F-1880-4D5F-BD27-A0D0A5379864}

:: Iminent Toolbar
start /wait msiexec /qn /norestart /x {5CDCDBCD-119A-4AE1-9C55-B816DBBE4245}
start /wait msiexec /qn /norestart /x {A76AA284-E52D-47E6-9E4F-B85DBF8E35C3}
start /wait msiexec /qn /norestart /x {118D6CE9-5F18-42F9-958A-14676A629FDE}
start /wait msiexec /qn /norestart /x {89B5DFCA-81E0-4EA4-8A0A-4F4087A1DD00}
start /wait msiexec /qn /norestart /x {F7CF0E9A-D48B-4942-9537-259ED0568DF4}
start /wait msiexec /qn /norestart /x {29C7E8BE-FBD9-4D91-BC4F-B470C718D554}

:: IMVU Inc Toolbar
start /wait msiexec /qn /norestart /x {90b49673-5506-483e-b92b-ca0265bd9ca8}

:: InboxAce Toolbar
start /wait msiexec /qn /norestart /x {3775afd7-5921-4571-968f-85a631203d1c}

:: InboxDollars Toolbar
start /wait msiexec /qn /norestart /x {47980628-3844-42AA-A0DD-E2D86BBA9600}
start /wait msiexec /qn /norestart /x {3FABEEE8-9237-CDE4-D1F2-6648F4D1C386}

:: Inbox Toolbar
start /wait msiexec /qn /norestart /x {D7E97865-918F-41E4-9CD0-25AB1C574CE8}

:: IncrediMail MediaBar 2 / 4 Toolbar
start /wait msiexec /qn /norestart /x {d40b90b4-d3b1-4d6b-a5d7-dc041c1b76c0}
start /wait msiexec /qn /norestart /x {90eee664-34b1-422a-a782-779af65cdf6d}

:: InternetDownload Toolbar
start /wait msiexec /qn /norestart /x {376CA00C-3F95-46F7-8F04-E69906E52A1F}

:: iNTERNET TURBO Toolbar
start /wait msiexec /qn /norestart /x {09152f0b-739c-4dec-a245-1aa8a37594f1}
start /wait msiexec /qn /norestart /x {B69EF583-75E4-4C52-B912-C711D937D648}

:: InboxToolbar
start /wait msiexec /qn /norestart /x {612AD33D-9824-4E87-8396-92374E91C4BB}_is1

:: Incredibar
start /wait msiexec /qn /norestart /x {336D0C35-8A85-403a-B9D2-65C292C39087}_is1

:: InstallIQ Updater
start /wait msiexec /qn /norestart /x {8E5E3330-6746-4A1D-A6BA-043E4D437A59}
start /wait msiexec /qn /norestart /x {8E1CB0F1-67BF-4052-AA23-FA22E94804C1}

:: Interenet Optimizer
start /wait msiexec /qn /norestart /x {5F189DF5-2D05-472B-9091-84D9848AE48B}{c632643}

:: Instant Share Alert
start /wait msiexec /qn /norestart /x {069730C2-755A-485B-A205-27A1AAFA836A}
start /wait msiexec /qn /norestart /x {069730C2-755A-485B-A205-27A1AAFA836A}

:: IObit Toolbar (various versions)
start /wait msiexec /qn /norestart /x {4F5E5430-1DA8-4B2B-BB26-B29C0E7DBFDB}
start /wait msiexec /qn /norestart /x {BAADB485-50A5-4E37-AE32-04F35DCEC14B}
start /wait msiexec /qn /norestart /x {B2A36391-A3A9-4293-88B2-A8263EC7F865}
start /wait msiexec /qn /norestart /x {69121ED8-5025-4607-8604-EB1EB0C7498A}
start /wait msiexec /qn /norestart /x {70D6C4BA-DCBE-41C9-BDFA-DA9819E3501C}
start /wait msiexec /qn /norestart /x {0194C594-CB88-42E9-B871-A574FAA47891}

:: Iolo System Mechanic
start /wait msiexec /qn /norestart /x {55FD1D5A-7AEF-4DA3-8FAF-A71B2A52FFC7}_is1

:: iPlugin / IWantSearch Toolbar
start /wait msiexec /qn /norestart /x {0E1230F8-EA50-42A9-983C-D22ABC2EED3B}

:: Iridium Direct Internet 3 Web Accelerator Toolbar
start /wait msiexec /qn /norestart /x {8B79EE88-E62D-4AA8-B530-CC357BA112B7}

:: I.R.I.S. Desktop Search Toolbar
start /wait msiexec /qn /norestart /x {577EBCA9-8ED3-45FC-A514-55B3817D4BCF}

:: IsoBuster Toolbar
start /wait msiexec /qn /norestart /x {266fcdca-7bb3-4da7-b3bf-f845dea2ebd6}
start /wait msiexec /qn /norestart /x {D4027C7F-154A-4066-A1AD-4243D8127440}

:: IspAssistant-FileServe Toolbar
start /wait msiexec /qn /norestart /x {0E91EFA2-AF48-4333-9965-5DD29DE31B56}

:: istart.webssearches.com
start /wait msiexec /qn /norestart /x {2D471A31-4FA7-95BA-1880-D441113ED736}

:: iWon Toolbar
start /wait msiexec /qn /norestart /x {94b03f0f-4130-49fc-98ac-a8a1b3a69c59}
start /wait msiexec /qn /norestart /x {43a3055a-6ff3-4aa5-90e6-18a10297cb53}

:: Jaybob's Movies Toolbar
start /wait msiexec /qn /norestart /x {33a329ee-7f7d-471e-ac67-15c54d970678}

:: Jaytown Toolbar
start /wait msiexec /qn /norestart /x {3BE093E7-4650-438B-AC6F-C944C30F81AD}

:: Jhoos Toolbar
start /wait msiexec /qn /norestart /x {9c25d2ef-c545-49ee-bd1a-f264b273ec10}

:: JooniCoupoaN Software
start /wait msiexec /qn /norestart /x {51417852-174C-88D4-34A0-D0FE7858BE47}

:: jZip Toolbar
start /wait msiexec /qn /norestart /x {1e48c56f-08cd-43aa-a6ef-c1ec891551ab}

:: K9-PC Protector
start /wait msiexec /qn /norestart /x 9E2253C2-A799-47B0-9864-90CF612BCC61_K9Tools_K9-~6898A8B4_is1

:: Kantar Media Virtual meter Toolbar
start /wait msiexec /qn /norestart /x {D35FC7EF-48C9-4BBC-9B0A-C058750E9673}

:: Kaspersky Protection Toolbar
start /wait msiexec /qn /norestart /x {3507FA00-ADA2-4A02-99B9-51AD26CA9120}

:: KinGCoupon
start /wait msiexec /qn /norestart /x {5C28578D-D0F1-699F-01B0-CC0653A28C11}

:: Kino-Filmov.Net Toolbar
start /wait msiexec /qn /norestart /x {1a894269-562d-459e-b17e-efd8de428e41}

:: KMP Media Toolbar
start /wait msiexec /qn /norestart /x {daf5b34c-1aa3-4c33-ae24-766a370635d2}
start /wait msiexec /qn /norestart /x {4B4D5056-3700-A76A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4B4D5056-3763-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4B4D5056-3600-A76A-76A7-7A786E7484D7}

:: Koyote Soft Toolbar
start /wait msiexec /qn /norestart /x {1E864EAC-892F-4A60-8C17-63123FD5731C}

:: Kurulum Toolbar
start /wait msiexec /qn /norestart /x {a2d8f477-f908-478d-a77a-5d934a922bc0}

:: LazyTruth
start /wait msiexec /qn /norestart /x {35E0D123-1F22-9AE6-F973-B7ECA46E8BFE}

:: Lenovo ThinkVantage Toolbox Toolbar
start /wait msiexec /qn /norestart /x {86B9B5DD-FB75-4035-BD52-3C94F7849CAF}
start /wait msiexec /qn /norestart /x {D5F11930-C4B8-4248-88C3-43621271B3FA}

:: Lexmark Toolbar
start /wait msiexec /qn /norestart /x {1017A80C-6F09-4548-A84D-EDD6AC9525F0}

:: Little Fighter 2 Toolbar
start /wait msiexec /qn /norestart /x {C11483F7-D7D8-4804-98D8-6055470BB989}
start /wait msiexec /qn /norestart /x {C3CD744D-2FAE-4640-8297-16B5DA423104}

:: LucckYCoupon
start /wait msiexec /qn /norestart /x {BA5D43C9-D633-D0EC-CFEA-2ABA974B333D}

:: LPT System Updater (Linkury)
start /wait msiexec /qn /norestart /x {BC0BF363-63AB-4FF7-8EF1-AE0D7F711B24}

:: Launch Toolbar
start /wait msiexec /qn /norestart /x {4A65DAD2-E914-4923-9C2A-81B968A68CE2}

:: loadtbs Toolbar
start /wait msiexec /qn /norestart /x {DFEFCDEE-CF1A-4FC8-88AD-129872198372}

:: loewrate BHO
start /wait msiexec /qn /norestart /x {5A1EDE4C-67FF-6CB4-C08E-A23CAB1557D4}

:: Longdo Toolbar
start /wait msiexec /qn /norestart /x {8BF27F8B-236F-4b81-AC69-8EB7690E5845}

:: Lookineo Toolbar
start /wait msiexec /qn /norestart /x {C656B705-5293-4a09-8908-3E0B6406999F}

:: LowPrices
start /wait msiexec /qn /norestart /x {F8ED2666-3D38-8820-ECF6-296D74B8C9D1}

:: Live! Cam Avatar Creator
start /wait msiexec /qn /norestart /x {65D0C510-D7B6-4438-9FC8-E6B91115AB0D}
start /wait msiexec /qn /norestart /x {65D0C510-D7B6-4438-9FC8-E6B91115AB0D}

:: Linkury Community Smartbar
start /wait msiexec /qn /norestart /x {23538B53-1A87-4728-AC4B-869345AA067D}
start /wait msiexec /qn /norestart /x {D96EBFC0-C680-4463-B4F0-299E48771819}

:: Lwgame RuBar Toolbar
start /wait msiexec /qn /norestart /x {23DD83B5-BDDC-49CE-B77B-514819C6D551}

:: MadLen.uCoz.coM Toolbar
start /wait msiexec /qn /norestart /x {8dec4b69-27c4-405d-a37d-8d45c83f66ab}

:: MakeMeBabies 2.0 Toolbar
start /wait msiexec /qn /norestart /x {d4330680-c0ae-4226-8a21-0afe2fd1ac24}

:: Maps4PC Toolbar
start /wait msiexec /qn /norestart /x {32bfba07-b1fc-4764-bc21-4af8c6188ca5}

:: MapQuest Toolbar
start /wait msiexec /qn /norestart /x {9302e698-7e00-43ab-b867-c6e759bc2ada}

:: MapsGalaxy Toolbar
start /wait msiexec /qn /norestart /x {364ea597-e728-4ce4-bb4a-ed846ef47970}

:: Mapit Toolbar
start /wait msiexec /qn /norestart /x {46a21652-3f93-437d-aac0-caa1f6713da0}

:: Map Button Toolbar
start /wait msiexec /qn /norestart /x {7745B7A9-F323-4BB9-9811-01BF57A028DA}

:: MarketResearch Toolbar
start /wait msiexec /qn /norestart /x {175F0111-2968-4935-8F70-33108C6A4DE3}
start /wait msiexec /qn /norestart /x {D360FA88-17C8-4F14-B67F-13AAF9607B12}

:: Magentic Toolbar
start /wait msiexec /qn /norestart /x {07C92F45-3193-4FD9-AF54-B1925707C872}

:: MakeItLive Plugin Toolbar
start /wait msiexec /qn /norestart /x {56361A71-4E9F-401D-9E12-8AEAA3D7A672}

:: Malicea Toolbar
start /wait msiexec /qn /norestart /x {16A644CA-74F9-46BE-BC6E-1FE21876D902}

:: Marine Aquarium Lite Toolbar
start /wait msiexec /qn /norestart /x {07189b84-b33b-4a1e-9b32-ad203c983c20}

:: Mario Forever Toolbar
start /wait msiexec /qn /norestart /x {463DF6D5-BEC1-4d67-B217-59DB692DFC53}
start /wait msiexec /qn /norestart /x {707db484-2428-402d-afb5-d85b387544c7}
start /wait msiexec /qn /norestart /x {71B6ACF7-4F0F-4FD8-BB69-6D1A4D271CB7}

:: Max EN / P2P Max /  ES Atube Toolbar
start /wait msiexec /qn /norestart /x {867dd841-5bf7-44ca-8426-c5a6eda00735}
start /wait msiexec /qn /norestart /x {72ae8426-3b8d-4ead-b191-8d0ad1c62158}
start /wait msiexec /qn /norestart /x {58ba374f-d9ea-4f27-bb8f-519b84820cc1}
start /wait msiexec /qn /norestart /x {a2f4b1e3-7c07-4603-8b10-512ead9611d3}

:: MB2 Toolbar
start /wait msiexec /qn /norestart /x {013a635f-e3aa-4371-b682-ece95ca974b0}

:: McAfee SafeKey Toolbar
start /wait msiexec /qn /norestart /x {61D700C1-7D8D-43c5-9C13-4FF85157CFE6}

:: McAfee SiteAdvisor / Web Control Toolbar
start /wait msiexec /qn /norestart /x {0BF43445-2F28-4351-9252-17FE6E806AA0}
start /wait msiexec /qn /norestart /x {0EBBBE48-BAD4-4B4C-8E5A-516ABECAE064}

:: MediaBar Toolbar
start /wait msiexec /qn /norestart /x {0974BA1E-64EC-11DE-B2A5-E43756D89593}
start /wait msiexec /qn /norestart /x {c2d64ff7-0ab8-4263-89c9-ea3b0f8f050c}
start /wait msiexec /qn /norestart /x {28387537-e3f9-4ed7-860c-11e69af4a8a0}
start /wait msiexec /qn /norestart /x {23DD83B5-BDDC-49CE-B77B-514819C6D551}
start /wait msiexec /qn /norestart /x {ABB49B3B-AB7D-4ED0-9135-93FD5AA4F69F}
start /wait msiexec /qn /norestart /x {d48c9ead-f59f-4dea-ac97-7065fea79f42}
start /wait msiexec /qn /norestart /x {7B840956-64ED-11DE-B890-694956D89593}
start /wait msiexec /qn /norestart /x {9a95b751-bf3e-4ea8-a938-2d4d84cd4964}
start /wait msiexec /qn /norestart /x {EE9A4208-64EC-11DE-8440-204256D89593}

:: Media Pimp Toolbar
start /wait msiexec /qn /norestart /x {283B4AA3-1B7A-46E6-B56D-90EF4743FB2C}

:: Media Search App (Ask)
start /wait msiexec /qn /norestart /x {41545534-5350-2D4D-4544-7A786E7484D7}
start /wait msiexec /qn /norestart /x {424C5453-502D-4D45-4400-7A786E7484D7}
start /wait msiexec /qn /norestart /x {53475453-5031-2D4D-4544-7A786E7484D7}
start /wait msiexec /qn /norestart /x {42435041-5350-2D4D-4544-7A786E7484D7}
start /wait msiexec /qn /norestart /x {53475453-502D-4D45-4400-7A786E7484D7}
start /wait msiexec /qn /norestart /x {53484453-502D-4D45-4400-7A786E7484D7}

:: mefeediaTest Toolbar
start /wait msiexec /qn /norestart /x {154d932f-dc51-4a4f-9d52-b78b1419d3b4}

:: mercan / Logic X Toolbar
start /wait msiexec /qn /norestart /x {b475cfd8-45d8-4905-b319-ad995327abeb}
start /wait msiexec /qn /norestart /x {96433b69-498c-400b-a296-1a4ed8098817}

:: Messenger Plus! Community Smartbar Toolbar
start /wait msiexec /qn /norestart /x {ae07101b-46d4-4a98-af68-0333ea26e113}

:: Messenger Plus Live Latin America Toolbar
start /wait msiexec /qn /norestart /x {3612084b-0d56-49c2-8978-194f391919cd}

:: MinimumPrice Software
start /wait msiexec /qn /norestart /x {CA1838EF-A497-194E-3850-37A62CEE398B}

:: Microcomp Toolbar
start /wait msiexec /qn /norestart /x {10000000-1000-1000-1000-100000000000}

:: Microsoft Live Search Toolbar
start /wait msiexec /qn /norestart /x {1E61ED7C-7CB8-49d6-B9E9-AB4C880C8414}

:: midicair Toolbar
start /wait msiexec /qn /norestart /x {77f8c945-4b74-4bd6-a073-e0d1997edce8}

:: midicairus Toolbar
start /wait msiexec /qn /norestart /x {efb1e45a-148d-40f9-a3f0-09d5577f9970}

:: MSN Toolbar
start /wait msiexec /qn /norestart /x {C994D98C-293D-4825-958E-EB684B4D413F}
start /wait msiexec /qn /norestart /x {8dcb7100-df86-4384-8842-8fa844297b3f}
start /wait msiexec /qn /norestart /x {1E61ED7C-7CB8-49d6-B9E9-AB4C880C8414}
start /wait msiexec /qn /norestart /x {BDAD1DAD-C946-4A17-ADC1-64B5B4FF55D0}

:: movies Toolbar
start /wait msiexec /qn /norestart /x {88E96402-3BBD-02D9-0A36-6FB806AEE04E}

:: mobilewitch Toolbar
start /wait msiexec /qn /norestart /x {fcbf663e-8530-46f8-a880-ac5abe9d2b23}

:: Mon Achat Malin MAE Toolbar
start /wait msiexec /qn /norestart /x {17742D34-6B6A-4527-B7E5-F628B0232DEC}

:: MP3 Rocket Toolbar
start /wait msiexec /qn /norestart /x {4D503352-5636-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {4C350B19-6CA1-4569-B14C-296D8D65300B}
start /wait msiexec /qn /norestart /x {4D503352-5637-006A-76A7-7A786E7484D7}

:: MTV Direct Toolbar
start /wait msiexec /qn /norestart /x {4215af89-e516-4ba5-bbfa-a85490a73c21}

:: Music Oasis by W3i
start /wait msiexec /qn /norestart /x {c6c214df-2922-4809-94aa-f4d67d4451ec}

:: Muvic Smartbar 
start /wait msiexec /qn /norestart /x {C8428739-5207-4817-9F19-69FA77018633}

:: MyAshampoo Toolbar
start /wait msiexec /qn /norestart /x {a1e75a0e-4397-4ba8-bb50-e19fb66890f4}

:: myBabylon English Toolbar
start /wait msiexec /qn /norestart /x {b2e293ee-fd7e-4c71-a714-5f4750d8d7b7}

:: My.Freeze.com Toolbar
start /wait msiexec /qn /norestart /x {0bd6f992-62ad-47f7-aca6-299729be4e2b}
start /wait msiexec /qn /norestart /x {D0523BB4-21E7-11DD-9AB7-415B56D89593}

:: My Global Search Bar Toolbar
start /wait msiexec /qn /norestart /x {37B85A29-692B-4205-9CAD-2626E4993404}

:: My Poco Toolba Toolbar
start /wait msiexec /qn /norestart /x {d44c9227-30bd-47d4-8137-95d32189d02a}

:: My Scrap Nook Toolbar
start /wait msiexec /qn /norestart /x {fe6f06fb-0fc0-4499-828f-ee48088f504f}

:: MyWebFace Toolbar
start /wait msiexec /qn /norestart /x {af94b35c-3ac5-4030-9f9c-15fb4e3dc339}

:: mywebsites.pro-ES / pro-FR Toolbar
start /wait msiexec /qn /norestart /x {8a2e8c25-42b7-45d8-ba32-3d323fc8d743}
start /wait msiexec /qn /norestart /x {33727f97-486d-4d19-97c3-23f432ef93fc}

:: NCH DE / NCH / NCH EN Toolbar
start /wait msiexec /qn /norestart /x {b106b661-3e1b-4015-af5c-195e909f35c6}
start /wait msiexec /qn /norestart /x {c2db4fe6-8409-45ce-8010-189a7b5cce86}
start /wait msiexec /qn /norestart /x {37483b40-c254-4a72-bda4-22ee90182c1e}

:: Nectar Search Toolbar
start /wait msiexec /qn /norestart /x {8020143D-5926-4394-A04D-DD0B649DA121}

:: NeetoCOOupon Software
start /wait msiexec /qn /norestart /x {317D8BB4-16C3-CFBD-3777-AED69667DA46}

:: NeewSaver Software
start /wait msiexec /qn /norestart /x {6A08B379-76FB-B4CF-0C70-CAFCD3635A77}

:: nicenefree
start /wait msiexec /qn /norestart /x {DCFB940E-C3BD-023F-4884-7FD36006422F}

:: NetAssistant
start /wait msiexec /qn /norestart /x {C792A75A-2A1F-4991-9B85-291745478A79}

:: NetWorx Desk Band Toolbar
start /wait msiexec /qn /norestart /x {FEEA54B4-D80F-41C7-87B9-DC08E6D3255F}

:: NetXfer Toolbar
start /wait msiexec /qn /norestart /x {C16CBAAC-A75C-4DB5-A0DD-CDF5CAFCDD3A}

:: Norton Safe Web Lite Toolbar
start /wait msiexec /qn /norestart /x {30CEEEA2-3742-40e4-85DD-812BF1CBB83D}

:: Norton Identity Safe Toolbar
start /wait msiexec /qn /norestart /x {A13C2648-91D4-4bf3-BC6D-0079707C4389}

:: Nuance PDF Toolbar
start /wait msiexec /qn /norestart /x {BCCE15AE-AC7E-4bc9-94AF-2A714A412BCB}
start /wait msiexec /qn /norestart /x {BED78D9C-A025-4FE9-B3BA-27E6D376A3D5}

:: NuSphere Debugger Toolbar
start /wait msiexec /qn /norestart /x {0F62D223-9206-4EA3-9EA8-D0F3C7C82ACA}

:: Okta Toolbar
start /wait msiexec /qn /norestart /x {8C938A58-9A96-4A95-929D-C8C28C639C32}

:: offerSOftu
start /wait msiexec /qn /norestart /x {B43ADAE2-EB7C-9E3F-2EE9-6D55C686D263}

:: offerApp
start /wait msiexec /qn /norestart /x {BDA14B0B-4672-3ABF-B189-A5958FE3A42F}

:: Online Sharing Toolbar
start /wait msiexec /qn /norestart /x {8567a644-e36c-470c-86cf-9c5b4f37db81}
start /wait msiexec /qn /norestart /x {bc4be15d-6a34-4356-9e97-79e43da32b1d}

:: Online Vault Crawler
start /wait msiexec /qn /norestart /x {FE60B87C-63A2-4A45-AC06-FFEFD5DB7846}_is1

:: OnRPG Toolbar
start /wait msiexec /qn /norestart /x {d22f6f66-2f47-4184-8625-fbfa4cbdb7ce}

:: Orange Toolbar
start /wait msiexec /qn /norestart /x {E97B5F2E-CA8E-4D34-BDA3-44EEC4ED2B12}

:: OurBabymaker Toolbar
start /wait msiexec /qn /norestart /x {e0b0df9f-34a3-4db1-becc-621697348607}

:: OTS Software Toolbar
start /wait msiexec /qn /norestart /x {e41b29e5-88b5-40b1-903e-080e0f2c4b65}

:: Outspark Toolbar 
start /wait msiexec /qn /norestart /x {94709E6D-4459-4223-9730-18F5763CA1E6}
start /wait msiexec /qn /norestart /x {efa37648-2754-4e3b-ad97-dc088c8805cd}

:: ooVoo version 2.2.4.25
start /wait msiexec /qn /norestart /x {FAA7F8FF-3C05-4A61-8F14-D8A6E9ED6623}

:: P2P Max France Toolbar
start /wait msiexec /qn /norestart /x {fe37be35-b028-49f9-bb0c-6a38c4e55b97}

:: P2P Max IT Toolbar
start /wait msiexec /qn /norestart /x {d22b76bb-abbd-4eb6-9bbb-f387bf27f76b}

:: Pando-Media-Booster
start /wait msiexec /qn /norestart /x {980A182F-E0A2-4A40-94C1-AE0C1235902E}

:: ParetoLogic FileCure
start /wait msiexec /qn /norestart /x {C1C441C4-57FA-4950-BDBA-BABFBAA2AA39}

:: PageRage Toolbar
start /wait msiexec /qn /norestart /x {9565115d-c7d6-46d3-bd63-b67b481a4368}

:: Panda Security Toolbar
start /wait msiexec /qn /norestart /x {B821BF60-5C2D-41EB-92DC-3E4CCD3A22E4}

:: Pazera Toolbar
start /wait msiexec /qn /norestart /x {093B3D46-0F87-44CF-B44B-79537F1597E5}

:: PC Tools Browser Guard Toolbar
start /wait msiexec /qn /norestart /x {472734EA-242A-422B-ADF8-83D1E48CC825}

:: PC Unleashed Online Inc
start /wait msiexec /qn /norestart /x {A8A98F85-9CC8-418D-B65B-FDE1EC737C47}

:: PC Power Speed 2.1.0.107
start /wait msiexec /qn /norestart /x {B0C56FD7-493D-44DD-B007-BBB5117D6E6F}_is1
start /wait msiexec /qn /norestart /x {B0C56FD7-493D-44DD-B007-BBB5117D6E6F}_is1
start /wait msiexec /qn /norestart /x {B0C56FD7-493D-44DD-B007-BBB5117D6E6F}_is1

:: PCTechHotline
start /wait msiexec /qn /norestart /x {A0B0DA25-DD15-4739-92A3-62D3424F043A}_is1

:: PC Unleashed Online
start /wait msiexec /qn /norestart /x {A8A98F85-9CC8-418D-B65B-FDE1EC737C47}

:: PC Fix Speed 2.2.0.103
start /wait msiexec /qn /norestart /x {F7B34B38-02A6-44D5-B8CC-06EB3B8ACFC9}_is1

:: PC Helper 360
start /wait msiexec /qn /norestart /x {CED0FE94-7795-42b5-978C-B247EB3EDE66}

:: PC-Mechanic
start /wait msiexec /qn /norestart /x {1F88FC5D-4D46-448A-AF59-7061FFC6ABBF}_is1

:: pc gear it Toolbar
start /wait msiexec /qn /norestart /x {fde1c224-0b9c-46b2-8fca-8945bcf8d4cb}

:: Pconverter Toolbar
start /wait msiexec /qn /norestart /x {36842df0-5a41-4afc-9625-5f0fb7b54786}

:: PC Tools Browser Defender Toolbar
start /wait msiexec /qn /norestart /x {472734EA-242A-422B-ADF8-83D1E48CC825}

:: PDFCreator Toolbar
start /wait msiexec /qn /norestart /x {31CF9EBE-5755-4A1D-AC25-2834D952D9B4}

:: PDF de Adobe Toolbar
start /wait msiexec /qn /norestart /x {47833539-D0C5-4125-9FA8-0819E2EAAC93}

:: pdfforge Toolbar v6.5 / v7.0
start /wait msiexec /qn /norestart /x {169917C4-4A77-45F4-B20E-860703FD5E6F}
start /wait msiexec /qn /norestart /x {BE7785D6-045F-44FB-A1E4-3FA555874415}
start /wait msiexec /qn /norestart /x {B922D405-6D13-4A2B-AE89-08A030DA4402}

:: PDF Suite Toolbar
start /wait msiexec /qn /norestart /x {261F6A8B-7AAF-4BF5-8552-6610F4D67819}

:: PDFXChange 4.0 IE Plugin / 2012 Toolbar
start /wait msiexec /qn /norestart /x {42DFA04F-0F16-418e-B80C-AB97A5AFAD39}
start /wait msiexec /qn /norestart /x {42DFA04F-0F16-418e-B80C-AB97A5AFAD3A}

:: PHPNukeDU / EN / IT Toolbar
start /wait msiexec /qn /norestart /x {46735dee-f862-49d1-876d-6382794dc625}
start /wait msiexec /qn /norestart /x {dd02a4eb-4afd-4d60-99d8-e67f964ca813}
start /wait msiexec /qn /norestart /x {2c965f3f-8efd-4bfc-a2c5-1672845fdbbf}

:: Picjoke informer Toolbar
start /wait msiexec /qn /norestart /x {60B9CB00-2331-4540-B94C-CA83CB40154D}

:: Planet Surf Toolbar
start /wait msiexec /qn /norestart /x {CB14350D-B064-4283-9145-B63F96772108}

:: Playfin Toolbar
start /wait msiexec /qn /norestart /x {d30bc29f-19f6-40b3-a91f-d4707048ade6}

:: Plusmedia uk Toolbar
start /wait msiexec /qn /norestart /x {193d7001-bd9f-48c2-b5c7-69775aa2201d}

:: Power Karaoke Toolbar
start /wait msiexec /qn /norestart /x {3303e956-2a3a-48e0-be39-2e0ef11a2f44}

:: Productivity 1.13 / 2 / 2.1 / 2.2 / 3.1 Toolbar
start /wait msiexec /qn /norestart /x {0f3385fe-265e-4f39-b1fd-e597e64b289e}
start /wait msiexec /qn /norestart /x {795828a9-f271-43a8-8536-4484bb991d3d}
start /wait msiexec /qn /norestart /x {c44f9e21-d93f-490c-b41c-b3548bdd19fc}
start /wait msiexec /qn /norestart /x {e84cc2c1-b722-48fc-a39c-edb8b525c777}
start /wait msiexec /qn /norestart /x {9427041a-a8dc-4d06-9a68-93873486e957}

:: Produtools Maps Toolbar
start /wait msiexec /qn /norestart /x {575bddf5-790a-4d01-a37d-2863dec1c085}

:: Produtools Manuals 2.1 Toolbar
start /wait msiexec /qn /norestart /x {b2bf7b3f-bf0b-4c48-aec6-f92c51be63e1}

:: Programas-GRATIS.net Toolbar
start /wait msiexec /qn /norestart /x {ac6fad42-419e-4f3a-abde-1bc6ce916b7d}

:: PriceSparrow by Ciuvo
start /wait msiexec /qn /norestart /x {3F2DC1E7-A56F-49D8-B0CF-DB2300594497}

:: Performance Optimizer 
start /wait msiexec /qn /norestart /x {5F189DF5-2D05-472B-9091-84D9848AE48B}{892cc6a3}

:: Pro PC Cleaner
start /wait msiexec /qn /norestart /x {23497AFC-382C-417E-AC1F-42D98A5A8ADA}
start /wait msiexec /qn /norestart /x {C3060724-6AC7-4BEF-B516-4F6B1D90887D}
start /wait msiexec /qn /norestart /x {BED67F4B-AD6C-4DE8-98F2-EFB5BE5AFE5A}
start /wait msiexec /qn /norestart /x {DDEC0D2E-F92A-4D5E-8FE7-DA19703F674A}
start /wait msiexec /qn /norestart /x {F34459D4-E2F9-430C-BB3C-05DE802462E4}
start /wait msiexec /qn /norestart /x {B2B04F8B-6444-4364-89C8-F3088D4E8D02}

:: Prowebi
start /wait msiexec /qn /norestart /x {5F189DF5-2D05-472B-9091-84D9848AE48B}{b8e33daf}

:: PriceLess!
start /wait msiexec /qn /norestart /x {75F9BF4A-AF67-A478-A37B-31D73186D3F3}
:: PremierOpinion
start /wait msiexec /qn /norestart /x {eeb86aef-4a5d-4b75-9d74-f16d438fc286}

:: Popcornew
start /wait msiexec /qn /norestart /x {F67C6875-6414-40FA-886F-AE87A99AFED8}

:: PointerBooster
start /wait msiexec /qn /norestart /x {12DA0E6F-5543-440C-BAA2-28BF01070AFA}{fc67e7a0}

:: Power Search Tool Toolbar
start /wait msiexec /qn /norestart /x {A08C6464-8102-465D-BB4B-3C1458E7F57F}

:: PriceMinus
start /wait msiexec /qn /norestart /x {06B99631-BFA2-3B7A-F58B-D067C2BA59B7}

:: Publishers Clearing House Prize Bar Toolbar
start /wait msiexec /qn /norestart /x {0FB24E1F-D247-4F4E-8DDD-9E18EA10829F}

:: Pup software
start /wait msiexec /qn /norestart /x {1E38F0E0-5499-CDAF-F946-BA3D053AABC2}

:: PUP.Axtloowpkjv64
start /wait msiexec /qn /norestart /x 740E97DF-6426-4A2A-ABEF-5C33040EFEE1

:: PUP Optional Multiplug
start /wait msiexec /qn /norestart /x {F6423EE4-93D8-FA04-D09D-A8598F6EFDFD}

:: PUP.DownLoadAndSA
start /wait msiexec /qn /norestart /x {78B72F2B-0468-A7AC-ECEE-02C79EC3EF0B}
start /wait msiexec /qn /norestart /x {20E7BC40-33F6-4A81-9D52-B58349326206}

:: QTTabBar Toolbar
start /wait msiexec /qn /norestart /x {d2bf470e-ed1c-487f-a333-2bd8835eb6ce}

:: QT Breadcrumbs Address Bar Toolbar
start /wait msiexec /qn /norestart /x {af83e43c-dd2b-4787-826b-31b17dee52ed}

:: QT Button Bar Toolbar
start /wait msiexec /qn /norestart /x {d2bf470e-ed1c-487f-a666-2bd8835eb6ce}

:: QuickStores- Toolbar
start /wait msiexec /qn /norestart /x {10EDB994-47F8-43F7-AE96-F2EA63E9F90F}

:: QuotationCafe Toolbar
start /wait msiexec /qn /norestart /x {99bced2f-1db3-4ecd-8e35-8906428a6cfe}

:: Radio Toolbar
start /wait msiexec /qn /norestart /x {8E718888-423F-11D2-876E-00A0C9082467}

:: RadioBar Toolbar
start /wait msiexec /qn /norestart /x {5B291E6C-9A74-4034-971B-A4B007A0B315}

:: RadioRage Toolbar
start /wait msiexec /qn /norestart /x {78ba36c9-6036-482b-b48d-ecca6f964b84}

:: Radio TV 1.1 / 2.1 / 1.3 Toolbar
start /wait msiexec /qn /norestart /x {060a0a36-13dc-407d-b055-5a9accd8e083}
start /wait msiexec /qn /norestart /x {ac417ce4-146b-4c18-a1ca-a2f609af2f9e}
start /wait msiexec /qn /norestart /x {4adc4b13-b4c2-4946-835e-c5f61fa9d8bf}

:: Radio W Toolbar
start /wait msiexec /qn /norestart /x {b4efb02b-cd4a-44b9-b5d9-aa486cdffab6}

:: RanddomPrIce
start /wait msiexec /qn /norestart /x {8E8C2E2D-7F21-2CF5-0ADB-64935121ECF0}

:: Rambler Toolbar
start /wait msiexec /qn /norestart /x {468CD8A9-7C25-45FA-969E-3D925C689DC4}

:: Reasonable Toolbar
start /wait msiexec /qn /norestart /x {c9a6357b-25cc-4bcf-96c1-78736985d413}

:: RecFree Toolbar
start /wait msiexec /qn /norestart /x {0508F8F1-08E3-43EE-AAA8-09AD09803084}

:: Rediff Toolbar
start /wait msiexec /qn /norestart /x {12F02779-6D88-4958-8AD3-83C12D86ADC7}

:: RefresherBand Class Toolbar
start /wait msiexec /qn /norestart /x {B24BA06E-FB7B-4757-95C2-DC01125F750E}

:: Re-markit Software
start /wait msiexec /qn /norestart /x {9aea10e8-c641-4bb5-b5f2-41d321e5216a}

:: RebateInformer
start /wait msiexec /qn /norestart /x {4EF645BD-65B0-4F98-AD56-D0437B7045F6}_is1

:: RegCure Pro
start /wait msiexec /qn /norestart /x {C547F361-5750-4CD1-9FB6-BC93827CB6C1}

:: ReferenceBoss Toolbar
start /wait msiexec /qn /norestart /x {c4676d53-fce5-4a19-be4d-97e6eaf7e19a}

:: Reganam Toolbar
start /wait msiexec /qn /norestart /x {db9d7a78-a76c-4bf2-97c6-258925ee1542}

:: Registry Booster
start /wait msiexec /qn /norestart /x {E55B3271-7CA8-4D0C-AE06-69A24856E997}_is1

:: RegulArDeAls Software
start /wait msiexec /qn /norestart /x {76DEE3DC-2B8B-E212-2126-D31D9E73DFE4}

:: Relevant Knowledge (Virus)
start /wait msiexec /qn /norestart /x {d08d9f98-1c78-4704-87e6-368b0023d831}

:: Retrogamer Toolbar
start /wait msiexec /qn /norestart /x {3392cfec-56f8-41ee-bdb4-4e301efd2c93}
start /wait msiexec /qn /norestart /x {54ba686e-738f-42fe-badd-d8cb7cfbc07e}

:: Rid Spyware
start /wait msiexec /qn /norestart /x {55801C3F-5581-477B-A21B-2BF3B996BEA6}_is1

:: Right-Backup
start /wait msiexec /qn /norestart /x 980124D4-3D52-4c2d-AD41-9E90BDF4C031_Systweak_Ri~01F2B2E8_is1

:: RoboSaver Software
start /wait msiexec /qn /norestart /x {BE360B8B-0F10-CA89-FC84-A5EAB71A6AF8}

:: rocckettsalee
start /wait msiexec /qn /norestart /x {D790D3FB-670B-6EF4-3686-4CB69E4ADE96}

:: RSA Toolbar
start /wait msiexec /qn /norestart /x {749F8452-7D28-4658-A903-9B047E5A2CE8}

:: RuoyaulCoupaonn 
start /wait msiexec /qn /norestart /x {40DC4B27-4588-C56F-7737-D03A0ACE4383}

:: Safefinder Smartbar
start /wait msiexec /qn /norestart /x {FA6289D6-676C-4497-88CC-9E2E15488944}

:: Safety Optimizer 
start /wait msiexec /qn /norestart /x {3A7C5D21-A152-4242-9353-E03089932A81}_is1

:: Safer-Surf 
start /wait msiexec /qn /norestart /x {9c069507-b3c8-491f-8c69-e5a2aae87bb0}

:: saferwweb
start /wait msiexec /qn /norestart /x {5F488658-35A7-2AB8-A756-560BA8F103C3}

:: SafeFinder Smartbar
start /wait msiexec /qn /norestart /x {AF37B709-2A7A-467D-8139-C1DE4B2C8924}

:: saevvErOOn
start /wait msiexec /qn /norestart /x {66951628-3E5A-9C96-37EA-490E187974D5}

:: SalePlus / SfKpCouponApp
start /wait msiexec /qn /norestart /x {44E4311D-BA06-FD43-505E-17DC53F4C22F}

:: SaleesMAgnaet
start /wait msiexec /qn /norestart /x {3119AFD3-545C-0955-573A-494F62E61990}

:: SalesiChueCker
start /wait msiexec /qn /norestart /x {CC17A332-9555-AD95-3985-0BDD9BF0EC71}

:: sAvverebox
start /wait msiexec /qn /norestart /x {CA8C94BE-9F47-1B2E-90F8-D8C07119BD96}

:: SaverPro
start /wait msiexec /qn /norestart /x {94851E46-5E5B-DD67-2593-709E8D27DC4C}

:: Sammsoft Toolbar
start /wait msiexec /qn /norestart /x {424C502D-5637-006A-76A7-7A786E7484D7}
start /wait msiexec /qn /norestart /x {5853442D-5637-006A-76A7-7A786E7484D7}

:: SaveerAddon
start /wait msiexec /qn /norestart /x {10A0E600-D246-BD63-F465-4C849C688998}

:: Save Tube Video Toolbar
start /wait msiexec /qn /norestart /x {F334C7B0-8774-4d5b-BD7A-4F448D03A1AE}

:: Savevid Toolbar
start /wait msiexec /qn /norestart /x {23cd218f-af09-443f-bbb1-adb89fd5986d}

:: savinshopo
start /wait msiexec /qn /norestart /x {70BD2558-27DA-8B02-02D0-D8704ECD2EDF}

:: SaverExtenSIOin
start /wait msiexec /qn /norestart /x {274E3C5C-178E-EAE2-A52F-2863C0EECD46}

:: SaveOn
start /wait msiexec /qn /norestart /x {993EA8F6-6E55-7E4E-39DE-5796E3226DB9}

:: Savings Bull / SavingsBullFilter
start /wait msiexec /qn /norestart /x {6DDE8071-E4BA-461B-8A96-990DFAA0EBD1}
start /wait msiexec /qn /norestart /x {813BA625-B0FA-48D8-9B75-59759C88C219}

:: ScenicReflections Toolbar
start /wait msiexec /qn /norestart /x {3a47260c-5db6-4371-91ce-f3c30748704f}

:: Search Toolbar
start /wait msiexec /qn /norestart /x {9D425283-D487-4337-BAB6-AB8354A81457}
start /wait msiexec /qn /norestart /x {0C8413C1-FAD1-446C-8584-BE50576F863E}

:: Search.com Bar Toolbar
start /wait msiexec /qn /norestart /x {80987362-6216-49bc-98e4-77e6cf71a5d7}
start /wait msiexec /qn /norestart /x {9f85f783-362b-4373-afb4-4999ef33aa35}

:: SearchElf 1.2 Toolbar
start /wait msiexec /qn /norestart /x {f4e6547e-325b-403c-a3bb-ad29ed37a92f}

:: Searchme Toolbar
start /wait msiexec /qn /norestart /x {B9C767DD-F66A-40B4-8F12-4199A9A4393C}

:: Search Results Toolbar
start /wait msiexec /qn /norestart /x {e5593220-bcaf-4b30-89fe-af988d0eacaa}
start /wait msiexec /qn /norestart /x {94366e2c-9923-431c-b0d6-747447dd0f2b}
start /wait msiexec /qn /norestart /x {fa63398e-322b-4833-9af3-15837ad12138}
start /wait msiexec /qn /norestart /x {348bd83c-b2cd-4319-a605-c96bb458dd80}
start /wait msiexec /qn /norestart /x {6f895323-a0d1-4844-b5d1-89e3962fa2b2}
start /wait msiexec /qn /norestart /x {ad146b57-67a2-4c82-8b1c-51f6316b20d2}
start /wait msiexec /qn /norestart /x {d8e45e11-8175-485c-a823-c480fd38b674}

:: Searchgo Toolba Toolbar
start /wait msiexec /qn /norestart /x {338c5d66-6b92-40a7-a216-9830d2e54103}

:: Searchdwebs
start /wait msiexec /qn /norestart /x {C670DCAE-E392-AA32-6F42-143C7FC4BDFD}

:: Security Wizards
start /wait msiexec /qn /norestart /x {EC84E3E6-C2D6-4DFB-81E0-448324C8FDF4}

:: Serif DrawPlus Toolbar
start /wait msiexec /qn /norestart /x {b97ed18c-1a8a-4acc-884f-b4fe7415adf2}

:: Serif WebPlus Toolbar
start /wait msiexec /qn /norestart /x {07364a98-eb02-4736-bc54-ebe437fccb87}

:: Sendspace Bar Toolbar
start /wait msiexec /qn /norestart /x {5570f0a0-580c-4c69-808f-8b2aaa2aa93c}

:: Setuprog Toolbar
start /wait msiexec /qn /norestart /x {f4ef4468-9bbb-45a1-a2ce-f0c430a9a7e5}

:: SFT_IT Toolbar
start /wait msiexec /qn /norestart /x {e29dfa44-501b-45be-be17-393b9e5e058a}

:: SfKpCouponApp
start /wait msiexec /qn /norestart /x {44E4311D-BA06-FD43-505E-17DC53F4C22F}

:: SFT_eng7 Toolbar
start /wait msiexec /qn /norestart /x {08d6b0b4-c132-470d-a8e2-aa2e9c3851c9}

:: SFT English FF Toolbar
start /wait msiexec /qn /norestart /x {ffa0793e-3980-4be4-8234-048fa665f700}

:: SharkManCoupon / GetTheDiscount
start /wait msiexec /qn /norestart /x {37476589-E48E-439E-A706-56189E2ED4C4}_is1

:: Shareware.Pro-EN / PR Toolbar
start /wait msiexec /qn /norestart /x {bc3abe80-8ccd-4093-955d-a087dda18266}
start /wait msiexec /qn /norestart /x {c8bf7b9e-8545-4738-bbaf-3f4ae7b0ec9f}

:: Show Norton Toolbar
start /wait msiexec /qn /norestart /x {7FEBEFE3-6B19-4349-98D2-FFB09D4B49CA}
start /wait msiexec /qn /norestart /x {90222687-F593-4738-B738-FBEE9C7B26DF}

:: Shopping Helper Smartbar
start /wait msiexec /qn /norestart /x {9726F9E3-EE13-4601-B2AF-81B1413BD8AF}
start /wait msiexec /qn /norestart /x {C64BEB42-B25D-4674-BB55-4099CB720110}
start /wait msiexec /qn /norestart /x {B2A302E7-8FA4-4585-AB7F-12C4DEBC0D32}
start /wait msiexec /qn /norestart /x {AB3837C5-AA2E-454F-88E0-A169B2110DDC}

:: Shopandscan
start /wait msiexec /qn /norestart /x {0AE44DE7-5B32-4151-8272-0FA6DAF800E8}

:: sHoppingchhiP
start /wait msiexec /qn /norestart /x {1D2ABF6A-2B19-3E94-0991-5B5BDB7134DA}

:: ShopaDrop
start /wait msiexec /qn /norestart /x {B6D700D3-3D0D-FEEB-D675-2CE78F9EC5D6}

:: ShopAtHome.com Toolbar
start /wait msiexec /qn /norestart /x {311B58DC-A4DC-4B04-B1B5-60299AD3D803}
start /wait msiexec /qn /norestart /x {98279C38-DE4B-4bcf-93C9-8EC26069D6F4}

:: SimilarSites Toolbar
start /wait msiexec /qn /norestart /x {FE69C007-C452-4d3e-86D2-1730DF8BC871}

:: siaLeofferr
start /wait msiexec /qn /norestart /x {6C9B756D-B313-0B9A-29C4-0D41CFAFE000}

:: Skype Toolbars
start /wait msiexec /qn /norestart /x {981029E0-7FC9-4CF3-AB39-6F133621921A}

:: SlimCleaner Plus
start /wait msiexec /qn /norestart /x {BA219F82-20BF-49AD-A279-E2D69D3B9D3F}
start /wait msiexec /qn /norestart /x {367ADFA6-09FD-43D8-94D7-C205EC9383DD}
start /wait msiexec /qn /norestart /x {1451E1D4-6AFA-44C9-B43D-B25247321205}
start /wait msiexec /qn /norestart /x {0C0F368E-17C4-4F28-9F1B-B1DA1D96CF7A}
start /wait msiexec /qn /norestart /x {63144FD7-52F5-413A-8060-5A70D5B913DD}
start /wait msiexec /qn /norestart /x {4ACA2953-3836-4049-A013-839F1CAFD0CE}
start /wait msiexec /qn /norestart /x {FC7386E4-B71D-42AA-B6B3-0925D0361069}

:: SLOW PCfighter
start /wait msiexec /qn /norestart /x {7648D847-AEBC-4DEF-ADA2-F93314A5F4F2}

:: SmartPCFixer 4.2
start /wait msiexec /qn /norestart /x {2C5927BD-3F65-4207-8FB5-8EDF638A3511}_is1

:: Smart Recovery 2 Toolbar
start /wait msiexec /qn /norestart /x {a011d643-4a67-4934-a775-46139847d7f2}

:: SmileBox EN Toolbar
start /wait msiexec /qn /norestart /x {f897eb0e-a3a4-46c3-80eb-2729699d8892}

:: Smileys We Love Toolbar
start /wait msiexec /qn /norestart /x {A82BD48E-3547-4B94-BC0C-42EFED86B0EB}

:: Snap.Do
start /wait msiexec /qn /norestart /x {D5E50D52-C658-4C16-9722-9F9B057B5F0F}

:: SoccerInferno Toolbar 
start /wait msiexec /qn /norestart /x {c5a318c1-d1d9-41f0-85fe-41cc9fb25e75}

:: Soda PDF / PDF 7 Toolbar
start /wait msiexec /qn /norestart /x {980EB9EC-6EB5-4258-BDDB-EFE25C5F99EF}
start /wait msiexec /qn /norestart /x {7C68E87F-4487-4AE5-BBC2-C398C530DE9A}

:: softonic.com4 Toolbar
start /wait msiexec /qn /norestart /x {0974848a-b5bc-49f2-9778-307742b4a55d}

:: Somoto Toolbar
start /wait msiexec /qn /norestart /x {bb45ef8e-1e36-4535-a017-ec908fb1e335}
start /wait msiexec /qn /norestart /x {c3721e85-f0ac-4b7e-ae4c-3e738011dc9d}
start /wait msiexec /qn /norestart /x {652853ad-5592-4231-88c6-706613a52e61}

:: SOSO Toolbar
start /wait msiexec /qn /norestart /x {29CF293A-1E7D-4069-9E11-E39698D0AF95}

:: Soft32 Toolbar
start /wait msiexec /qn /norestart /x {d1fce654-5fd1-48ad-b13c-5064736120b7}

:: softonic-de3 Toolbar
start /wait msiexec /qn /norestart /x {cc05a3e3-64c3-4af2-bfc1-af0d66b69065}

:: Softonic VLC EN Toolbar
start /wait msiexec /qn /norestart /x {e6570cd8-9978-4621-b1f9-6a62436f0466}

:: SoundDabble Toolbar
start /wait msiexec /qn /norestart /x {7748e11f-41eb-4ebd-9ae8-3f7dc602da73}

:: Spam Free Search Bar Toolbar
start /wait msiexec /qn /norestart /x {26c9e18c-3717-4be1-a225-04e4471f5b6e}

:: SparkTrust PC Cleaner
start /wait msiexec /qn /norestart /x {35827710-D042-428B-A1E5-E20E12D2FEB9}

:: Spb Wallet Toolbar
start /wait msiexec /qn /norestart /x {2913D3DD-9363-4C21-B205-C19A584A0674}

:: SpeedUp Toolbar
start /wait msiexec /qn /norestart /x {005B8FC3-0F7E-45DD-8A2F-E352D67EDBFC}

:: Spesoft Toolba Toolbar
start /wait msiexec /qn /norestart /x {94817c02-feac-4aa8-99d8-1cb47bf4d4c0}

:: SpecialSavings
start /wait msiexec /qn /norestart /x {09C14BAE-2D45-4133-B0FA-5EA4FE5CF978}

:: SpeedMaxPC
start /wait msiexec /qn /norestart /x {EF4F8650-7710-4CA0-831D-4AA9C1CF6D87}

:: SpeedUpMyPc
start /wait msiexec /qn /norestart /x {E55B3271-7CA8-4D0C-AE06-69A24856E996}_is1

:: SpyHunter
start /wait msiexec /qn /norestart /x {DDABC667-56B3-4122-82B0-2F5782EA2F9A}

:: Spyware Clear (PC Tech Hotline)
start /wait msiexec /qn /norestart /x {5FB600FF-BC65-471F-A3F8-C2666863BA75}_is1

:: ssaveitkeEEP
start /wait msiexec /qn /norestart /x {B10BC31B-DBC6-56FE-DD3D-DD4E49A3E6CE}

:: StartNow Toolbar
start /wait msiexec /qn /norestart /x {5911488E-9D1E-40ec-8CBB-06B231CC153F}

:: Steganos Password Manager Toolbar
start /wait msiexec /qn /norestart /x {9C65D12D-CF9D-454D-8049-61965D8C6FFF}

:: Streaming Search MP3 Toolbar
start /wait msiexec /qn /norestart /x {C86FF9FA-AEED-451B-A9CC-39A53173AE2E}

:: Starware Casual Games Toolbar 
start /wait msiexec /qn /norestart /x {45a2e207-6bba-49e0-bce2-e2542f0ad7b7}

:: Sticky Password Toolbar
start /wait msiexec /qn /norestart /x {AC02E217-6E13-4F14-9BAC-D7BA27C1E912}

:: ST-Eng7 Toolbar
start /wait msiexec /qn /norestart /x {414b6d9d-4a95-4e8d-b5b1-149dd2d93bb3}

:: ST France Toolbar
start /wait msiexec /qn /norestart /x {364d4e0c-543f-4b85-abe3-19551139da4f}

:: Strongvault Online Backup
start /wait msiexec /qn /norestart /x {692EF506-1E15-4473-A829-ED951D6C49DB}

:: StormWatchPUP
start /wait msiexec /qn /norestart /x {BC799F5F-37C9-ACBB-BE51-805992C10610}

:: Soda PDF 3D Reader Toolbar
start /wait msiexec /qn /norestart /x {64C9D46E-8F8B-4158-9780-A6581C7439B1}
start /wait msiexec /qn /norestart /x {4DB8FC50-B206-44B3-9B28-442F326056B9}

:: Softonic English FF Toolba Toolbar
start /wait msiexec /qn /norestart /x {ffa0793e-3980-4be4-8234-048fa665f700}

:: Supra Savings
start /wait msiexec /qn /norestart /x {E6B105B8-1F65-4428-9397-1DFD8A03B94D}

:: Supprimer PUP
start /wait msiexec /qn /norestart /x {99C91FC5-DB5B-4AA0-BB70-5D89C5A4DF96}

:: SuggestMeYesBHO
start /wait msiexec /qn /norestart /x {4FFBB818-B13C-11E0-931D-B2664824019B}_is1

:: SuperOptimizer
start /wait msiexec /qn /norestart /x {1146AC44-2F03-4431-B4FD-889BC837521F}


:: SweetIM for Messenger 3.6 / SweetIM Toolbar
start /wait msiexec /qn /norestart /x {A81A974F-8A22-43E6-9243-5198FF758DA1}
start /wait msiexec /qn /norestart /x {A0C9DF2B-89B5-4483-8983-18A68200F1B4}
start /wait msiexec /qn /norestart /x {A7BC02AF-1128-4A31-BCF8-1A3EE803D3B3}
start /wait msiexec /qn /norestart /x {08ED8855-4C2E-429B-A878-F129E1F624FA}
start /wait msiexec /qn /norestart /x {EA8FA6BE-29BE-4AF2-9352-841F83215EB0}
start /wait msiexec /qn /norestart /x {A1194237-547A-461d-BD44-B97B1574A7DA}
start /wait msiexec /qn /norestart /x {953AA732-9AFB-49C9-84A4-7F96CA0A08DA}
start /wait msiexec /qn /norestart /x {DEDAF650-12B8-48f5-A843-BBA100716106}_is1

:: System Checkup 3.5
start /wait msiexec /qn /norestart /x {4AC7B4E7-59B7-4E48-A60D-263C486FC33A}_is1

:: SystemMuscle
start /wait msiexec /qn /norestart /x {12DA0E6F-5543-440C-BAA2-28BF01070AFA}{763bdca1}

:: SystemAssister
start /wait msiexec /qn /norestart /x {12DA0E6F-5543-440C-BAA2-28BF01070AFA}{5c8a92f4}

:: Show Xmlbar Toolbar
start /wait msiexec /qn /norestart /x {6B896ADB-4A82-46e2-858C-13134782CE34}

:: TAkeTheCOupoN
start /wait msiexec /qn /norestart /x {53B21E29-3967-C332-57EB-C02631658584}

:: Telbar Toolbar
start /wait msiexec /qn /norestart /x {3D52425B-A0FE-4288-B1CB-24B3576E01CD}

:: TenchisTV Toolbar
start /wait msiexec /qn /norestart /x {ece24dcf-8548-4655-b392-47a388721482}

:: TelevisionFanatic Toolbar
start /wait msiexec /qn /norestart /x {c98d5b61-b0ea-4d48-9839-1079d352d880}

:: TerraGame Toolbar
start /wait msiexec /qn /norestart /x {95247e39-4a41-47e5-8651-3056bf0a3034}

:: TextAloud Toolbar
start /wait msiexec /qn /norestart /x {F053C368-5458-45B2-9B4D-D8914BDDDBFF}

:: The Weather Channel Toolbar
start /wait msiexec /qn /norestart /x {2E5E800E-6AC0-411E-940A-369530A35E43}

:: Thoosje Toolbar
start /wait msiexec /qn /norestart /x {3ba34663-845a-4931-a6f3-1e033ec342a7}

:: TicaTaCouppon
start /wait msiexec /qn /norestart /x {E370F69F-ED3F-925F-31FC-14D1329A713B}

:: TMBGBAR Toolbar
start /wait msiexec /qn /norestart /x {C8137A8D-415D-450C-A1B1-D0C519D45296}

:: ToggleEN Toolbar
start /wait msiexec /qn /norestart /x {038cb5c7-48ea-4af9-94e0-a1646542e62b}

:: ToggleFI Toolbar
start /wait msiexec /qn /norestart /x {a95df5b3-97ae-4a89-8e8d-c65ec85f607e}

:: Toolbar Fairy
start /wait msiexec /qn /norestart /x {7F8F0070-9003-4D3F-8340-1605BBDEE54F}

:: Tom's Guide Toolbar
start /wait msiexec /qn /norestart /x {a65e491f-a436-4952-b49a-b24ed99a0f67}

:: TorrentMan Toolbar
start /wait msiexec /qn /norestart /x {7c5c0f58-e061-457d-9033-77307f5ed00c}

:: TotalRecipeSearch Toolbar
start /wait msiexec /qn /norestart /x {a0154e07-2b48-475c-a82a-80efd84ea33e}

:: topbuyer 
start /wait msiexec /qn /norestart /x {FE139F4C-CE5B-121A-8A2D-191FA2226094}

:: tPerfectCoupon
start /wait msiexec /qn /norestart /x {23B82977-C816-92D2-66E7-BE67DD1E7786}

:: TranslatorBar 1.2 / 3.1 / 5 Toolbar
start /wait msiexec /qn /norestart /x {548f6736-8fe4-4680-82f2-170d6c07e1d2}
start /wait msiexec /qn /norestart /x {3eec3c07-13c6-4b41-87c6-40b425a0b0a2}
start /wait msiexec /qn /norestart /x {b9b97401-98e1-4942-930d-c36652dab7f2}

:: Trend Micro Toolbar
start /wait msiexec /qn /norestart /x {CCAC5586-44D7-4c43-B64A-F042461A97D2}

:: tricomfi (estdemin)
start /wait msiexec /qn /norestart /x {74f1e872-8d6f-4cc7-58d6-c60d8dfe43ed}

:: TSULoader
start /wait msiexec /qn /norestart /x {8B1881C3-A40C-4DF3-BFD2-CCD2FEDD7D83}

:: TuneUp Utilities 2009 / 2012 / 2014 / TuneUp Utilities Language Pack
start /wait msiexec /qn /norestart /x {504F08E9-C70E-4B70-917E-382141CAC326}
start /wait msiexec /qn /norestart /x {FE8D473A-6F06-4F99-B5F4-BED72B2A038C}
start /wait msiexec /qn /norestart /x {55A29068-F2CE-456C-9148-C869879E2357}
start /wait msiexec /qn /norestart /x {32364CEA-7855-4A3C-B674-53D8E9B97936}
start /wait msiexec /qn /norestart /x {A95A76C9-6F65-477E-83A0-9F884B6DC21B}

:: Turbo Diagnosis
start /wait msiexec /qn /norestart /x {59680D1A-6A49-4E85-BB42-6886773DF589}_is1
start /wait msiexec /qn /norestart /x {BD3C020E-CA6D-44E8-9FA4-93D410D18D70}_is1

:: TV Center Toolbar
start /wait msiexec /qn /norestart /x {a7347e8c-1ca6-469b-951e-4a23c4437935}
start /wait msiexec /qn /norestart /x {350e72a9-e6db-4967-9572-dd8e27d3e1be}

:: TvOnline by Webdessign Toolbar
start /wait msiexec /qn /norestart /x {77d0b2ea-9fb1-491c-bd40-04e2232bdd22}
start /wait msiexec /qn /norestart /x {414b6d9d-4a95-4e8d-b5b1-149dd2d93bb3}

:: Uniblue DriverScanner / Uniblue RegistryBooster / Uniblue SystemTweaker
start /wait msiexec /qn /norestart /x {C2F8CA82-2BD9-4513-B2D1-08A47914C1DA}_is1
start /wait msiexec /qn /norestart /x {09FF4DB8-7DE9-4D47-B7DB-915DB7D9A8CA}
start /wait msiexec /qn /norestart /x {DBB1F4ED-3212-4F58-A427-9C01DE4A24A5}_is1

:: uNisaales
start /wait msiexec /qn /norestart /x {4CEE92A3-9F0C-51AB-ADC0-34EC24AD7B7E}

:: Utility Chest Toolbar
start /wait msiexec /qn /norestart /x {cf67755f-9265-449c-87cf-b945519e073b}

:: Upromise TurboSaver Toolbar
start /wait msiexec /qn /norestart /x {06E58E5E-F8CB-4049-991E-A41C03BD419E}

:: Uptodown Toolbar
start /wait msiexec /qn /norestart /x {ba5844d2-b2c5-49eb-86f5-248d776a6f08}

:: uTorrentBar_ES / DE / IT / NL / PT Toolbar
start /wait msiexec /qn /norestart /x {db131c55-60c8-4adc-84dc-9e76ab06e2dc}
start /wait msiexec /qn /norestart /x {c840e246-6b95-475e-9bd7-caa1c7eca9f2}
start /wait msiexec /qn /norestart /x {4ae0c3d6-f713-4eed-bc65-25dc3ffdaac1}
start /wait msiexec /qn /norestart /x {87775fdb-6972-41f9-ae51-8326e38cb206}
start /wait msiexec /qn /norestart /x {e0301295-ab3e-4af3-979f-3d453c5f9f48}
start /wait msiexec /qn /norestart /x {bf7380fa-e3b4-4db2-af3e-9d8783a45bfc}

:: uTorrentControl2 Toolbar
start /wait msiexec /qn /norestart /x {687578b9-7132-4a7a-80e4-30ee31099e03}

:: uTorrentControl3 Toolbar
start /wait msiexec /qn /norestart /x {46a3135d-3683-48cf-b94c-82655cbc0e8a}

:: Utubebario Toolba Toolbar
start /wait msiexec /qn /norestart /x {58beca16-cae6-4b7a-a0e8-153d0cbba63a}

:: UViOo Toolbar
start /wait msiexec /qn /norestart /x {2ee842eb-8b82-44f0-9511-e4b67de54e44}

:: V9-Toolbar
start /wait msiexec /qn /norestart /x {742E70CF-7770-412d-86CB-230B322E807C}

:: VAFPlayer
start /wait msiexec /qn /norestart /x {EBE677C0-CBCB-4EBF-8098-E27E1B5271CF}

:: Vaudix
start /wait msiexec /qn /norestart /x {681002C6-5019-81A2-7871-A43754F71E56}

:: Video Clip Grab Toolbar
start /wait msiexec /qn /norestart /x {9b53772a-8259-495d-a6b2-fa5966fe52e1}

:: VideoDownloadConverter Toolbar
start /wait msiexec /qn /norestart /x {48586425-6bb7-4f51-8dc6-38c88e3ebb58}

:: Video Download Toolbar
start /wait msiexec /qn /norestart /x {E52BE12D-A44A-4F51-9DC1-34F37A488CC7}

:: VideoScavenger Toolbar
start /wait msiexec /qn /norestart /x {acf7da4c-eeb2-484a-a3a1-303d4054d50c}

:: Viral Tube Toolbar
start /wait msiexec /qn /norestart /x {93c338de-5fb5-4fb5-ab4e-0eedc0bd9f3a}

:: Virgilio Toolbar
start /wait msiexec /qn /norestart /x {D3403F28-7D39-435F-A8CB-45016C29E48E}

:: Virgin Media Toolbar
start /wait msiexec /qn /norestart /x {A057A204-BACC-4D26-CFC3-3CECC9AB2EDA}

:: Visicom Toolbar
start /wait msiexec /qn /norestart /x {51dd3535-abea-484a-b1cf-06ab7b092c0c}

:: VIO Player
start /wait msiexec /qn /norestart /x {BD85D232-E96C-4E66-AA73-37B85925CB23}_is1
start /wait msiexec /qn /norestart /x {C8A17598-7F89-41EA-9876-0F89DA0B24F1}_is1

:: VMN Toolbar Astro Gemini Toolbar
start /wait msiexec /qn /norestart /x {A057A204-BACC-4D26-8287-79A187E26987}

:: VShareToolbar / vshare.tv Bar Toolbar
start /wait msiexec /qn /norestart /x {7AC3E13B-3BCA-4158-B330-F66DBB03C1B5}
start /wait msiexec /qn /norestart /x {043C5167-00BB-4324-AF7E-62013FAEDACF}
start /wait msiexec /qn /norestart /x {7aeb3efd-e564-43f1-b658-5058a7c5743b}

:: Vuze Remote Toolbar v9.8
start /wait msiexec /qn /norestart /x {D41A0173-FFD4-4422-9E52-467EA116C14B}
start /wait msiexec /qn /norestart /x {ba14329e-9550-4989-b3f2-9732e92d17cc}
start /wait msiexec /qn /norestart /x {05478A66-EDB6-4A22-A870-A5987F80A7DA}

:: Walla Toolbar
start /wait msiexec /qn /norestart /x {bebc2a28-82ab-4cc7-810e-9a3df7a1970f}
start /wait msiexec /qn /norestart /x {f228c6a4-a593-4017-944c-4e7958fb3177}

:: Wanadoo Toolbar
start /wait msiexec /qn /norestart /x {8B68564D-53FD-4293-B80C-993A9F3988EE}

:: Web assistant Toolbar
start /wait msiexec /qn /norestart /x {0B53EAC3-8D69-4b9e-9B19-A37C9A5676A7}

:: WebEx Productivity Tools Toolbar
start /wait msiexec /qn /norestart /x {90E2BA2E-DD1B-4cde-9134-7A8B86D33CA7}

:: Webplayer (Kreapixel)
start /wait msiexec /qn /norestart /x {071FD108-9B60-4F17-BBF8-BC921F353669}_is1

:: Web Bar 2.0.5659
start /wait msiexec /qn /norestart /x {0BCE8B0A-1E76-44E5-9909-3CF804D92E4D}_is1

:: websaver
start /wait msiexec /qn /norestart /x {5CDF2354-26AF-2DBC-1012-44FEDFCC75BB}

:: Webbsaveers
start /wait msiexec /qn /norestart /x {9DB19ABE-679C-FFBF-ECA3-159A4E15CB61}

:: Webfetti Toolbar
start /wait msiexec /qn /norestart /x {d499ff20-fc53-4ef0-a2a8-b30d8276cbcc}
start /wait msiexec /qn /norestart /x {94fc3fb2-3e5c-4b8f-aaee-17090ce800bc}

:: Web-Recherche-Symbolleiste Toolbar
start /wait msiexec /qn /norestart /x {8F0F47B1-7D4B-4834-A981-91E2A3DCE069}

:: Webroot Toolbar
start /wait msiexec /qn /norestart /x {97ab88ef-346b-4179-a0b1-7445896547a5}
start /wait msiexec /qn /norestart /x {d84a64a0-f2b2-4975-b264-3a3bce8d57d6}

:: Webshots Toolbar
start /wait msiexec /qn /norestart /x {C17590D2-ECB4-4b15-8820-F58798DCC118}

:: WeatherBug Alert
start /wait msiexec /qn /norestart /x {7426428E-71D4-452C-BA13-B14E5EB52859}

:: Websteroids
start /wait msiexec /qn /norestart /x {D54E3D9F-FEB8-4D2D-A138-B69A5C80080B}

:: WebCake.BHO
start /wait msiexec /qn /norestart /x {C4ED781C-7394-4906-AAFF-D6AB64FF7C38}

:: WebReg
start /wait msiexec /qn /norestart /x {8EE94FD8-5F52-4463-A340-185D16328158}
start /wait msiexec /qn /norestart /x {43CDF946-F5D9-4292-B006-BA0D92013021}
start /wait msiexec /qn /norestart /x {CCB9B81A-167F-4832-B305-D2A0430840B3}

:: Winload Toolbar
start /wait msiexec /qn /norestart /x {40c3cc16-7269-4b32-9531-17f2950fb06f}

:: WinZipBar Toolbar
start /wait msiexec /qn /norestart /x {50fafaf0-70a9-419d-a109-fa4b4ffd4e37}

:: Windows Live Toolbar
start /wait msiexec /qn /norestart /x {BDAD1DAD-C946-4A17-ADC1-64B5B4FF55D0}

:: Windows Live Toolbar Beta Toolbar 
start /wait msiexec /qn /norestart /x {21FA44EF-376D-4D53-9B0F-8A89D3229068}

:: Window Resizer / cheuApp4all
start /wait msiexec /qn /norestart /x {26453017-2C54-574B-7597-9EA6652686A6}

:: WinZip Driver Updater
start /wait msiexec /qn /norestart /x {9854A5C4-5BE5-46E2-A989-352DD8B37E20}_is1

:: WiseConvert 2.1 Toolbar
start /wait msiexec /qn /norestart /x {ecce0073-a837-45a2-95b9-600420505f7e}

:: Wisdom-soft Toolbar 
start /wait msiexec /qn /norestart /x {6dfc55bb-bfff-485a-9709-90c3fdf6db58}

:: WiseConvert / 2.2 / G2 / G3 Toolbar 
start /wait msiexec /qn /norestart /x {ebd898f8-fcf6-4694-bc3b-eabc7271eeb1}
start /wait msiexec /qn /norestart /x {b81767e1-672d-4da1-b5cc-d277185815a6}
start /wait msiexec /qn /norestart /x {ac955a4e-5a9c-4d20-8751-a7eac17ac342}
start /wait msiexec /qn /norestart /x {3ca0fc59-46f8-47b1-81a7-a112813fa785}

::WiseFixer 3.5
start /wait msiexec /qn /norestart /x {900C2AB5-3F37-4F84-B58C-893FA5F42D7D}_is1

:: Wunderlist Panel
start /wait msiexec /qn /norestart /x {D86C82B0-1F02-816A-5F3D-6466F6A67566}

:: Wondershare PC Care Toolbar
start /wait msiexec /qn /norestart /x {bee9ae08-b4e5-4021-ae8b-0befc64d537b}

:: WOT Toolbar
start /wait msiexec /qn /norestart /x {71576546-354D-41c9-AAE8-31F2EC22BF0D}

:: WS Yahoo Toolbar
start /wait msiexec /qn /norestart /x {e9304219-15a8-464f-b6a1-97559bdc9a98}

:: XFINITY Toolbar
start /wait msiexec /qn /norestart /x {4b9bcce8-a70b-402a-a7e1-db96831ee26f}

:: XfireXO Toolbar
start /wait msiexec /qn /norestart /x {5e5ab302-7f65-44cd-8211-c1d4caaccea3}

:: Yahoo!Companion
start /wait msiexec /qn /norestart /x {EF99BD32-C1FB-11D2-892F-0090271D4F88}

:: Yepi Toolbar
start /wait msiexec /qn /norestart /x {5FC86FB3-A8B1-400B-8BE7-0EAF0D857F5D}

:: YourFileDownloader
start /wait msiexec /qn /norestart /x {7223EDAC-E091-B3C1-BD91-B66CE557800F}

:: YoutubeAdBlocker
start /wait msiexec /qn /norestart /x {4820778D-AB0D-6D18-C316-52A6A0E1D507}

:: YouTube Downloader Toolbar
start /wait msiexec /qn /norestart /x {9B596622-FDDA-4e28-97F8-998C522FA58E}
start /wait msiexec /qn /norestart /x {F3FEE66E-E034-436a-86E4-9690573BEE8A}

:: YoudaGames Toolbar
start /wait msiexec /qn /norestart /x {53A871EB-8545-4244-A2CE-BFC401587CE4}

:: Yahoo Community Smartbar
start /wait msiexec /qn /norestart /x {8188AEF6-2A51-421C-BA75-5EB53AAF4271}

:: YTAdRemovaL
start /wait msiexec /qn /norestart /x {7BE66183-98C0-B71F-FF97-9E1CAABBF113}

:: Yontoo.Pagerage
start /wait msiexec /qn /norestart /x {889DF117-14D1-44EE-9F31-C5FB5D47F68B}

:: Yahoo Community Smartbar / Yahoo Community Smartbar Engine
start /wait msiexec /qn /norestart /x {3BC7022B-CDE0-4664-9AB6-E3EC25CE644A}
start /wait msiexec /qn /norestart /x {4E732E5D-E577-451A-9BB1-CBE64A2CBC2F}
start /wait msiexec /qn /norestart /x {6818F6FB-6270-4DE8-9827-40E852111F2A}
start /wait msiexec /qn /norestart /x {44cd9a5d-138e-4764-b6f4-1bed50a72405}
start /wait msiexec /qn /norestart /x {D62304BE-D5D3-4CCF-8973-123909491ADB}
start /wait msiexec /qn /norestart /x {3f0a76b2-932c-4f0e-914b-480f3d689529}

:: YTD Toolbar v7.2 / v8.6 / v8.9
start /wait msiexec /qn /norestart /x {DA36FB9E-9020-47E6-9BDE-B33A6E36F0F4}
start /wait msiexec /qn /norestart /x {4BBD417F-13B6-4477-B7C2-AE705864058D}
start /wait msiexec /qn /norestart /x {5CDFBF03-D1B2-466B-AA19-B10FDA43E2BB}

:: YTD Video Downloader 4.9 
start /wait msiexec /qn /norestart /x {1a413f37-ed88-4fec-9666-5c48dc4b7bb7}

:: Zend Studio Toolbar
start /wait msiexec /qn /norestart /x {95188727-288F-4581-A48D-EAB3BD027314}

:: ZoneAlarm Security Engine Toolbar
start /wait msiexec /qn /norestart /x {EE2AC4E5-B0B0-4EC6-88A9-BCA1A32AB107}

:: ZoneAlarm Security Toolbar
start /wait msiexec /qn /norestart /x {438FAE3E-BDEF-44D3-AB8B-0C7C8350DF59}
start /wait msiexec /qn /norestart /x {91da5e8a-3318-4f8c-b67e-5964de3ab546}

:: Zone Alarm Toolbar
start /wait msiexec /qn /norestart /x {98889811-442D-49dd-99D7-DC866BE87DBC}

:: Zwinky Toolbar
start /wait msiexec /qn /norestart /x {3033124f-06bf-4829-873a-310a125b4d4c}

:: Zynga Toolbar
start /wait msiexec /qn /norestart /x {7b13ec3e-999a-4b70-b9cb-2617b8323822}

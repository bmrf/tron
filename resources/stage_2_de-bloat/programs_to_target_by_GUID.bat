:: Batch file to uninstall a specific list of programs by GUID
:: Called by Tron in Stage 2: De-bloat
:: Initial list by reddit.com/user/tuxedo_jack, modifications for use in Tron by reddit.com/user/vocatus
:: Add any GUID uninstall commands to this list to target them for removal
@echo off


:::::::::::::::
:: GUID LIST ::
:::::::::::::::

:: Absolute Notifier // Absolute Reminder
start /wait msiexec /qn /norestart /x {40F4FF7A-B214-4453-B973-080B09CED019}
start /wait msiexec /qn /norestart /x {FB500000-0010-0000-0000-074957833700}

:: Accidental Damage Services Agreement
start /wait msiexec /qn /norestart /x {EBE939ED-4612-45FD-A39E-77AC199C4273}

:: Acrobat.com (various versions)
start /wait msiexec /qn /norestart /x {6D8D64BE-F500-55B6-705D-DFD08AFE0624}
start /wait msiexec /qn /norestart /x {6978914A-A5AC-4F14-8158-DB66EE41E72B}
start /wait msiexec /qn /norestart /x {287ECFA4-719A-2143-A09B-D6A12DE54E40}
start /wait msiexec /qn /norestart /x {E7C97E98-4C2D-BEAF-5D2F-CC45A2F95D90}
start /wait msiexec /qn /norestart /x {77DCDCE3-2DED-62F3-8154-05E745472D07}

:: Ad-Aware Web Companion (various versions) // Ad-Aware Updater
start /wait msiexec /qn /norestart /x {88B10E3E-8911-4FAC-8663-CCF6E33C58B3}
start /wait msiexec /qn /norestart /x {FABDFEBE-A430-48B4-89F2-B35594E43965}
start /wait msiexec /qn /norestart /x {902C3D36-9254-437D-98AC-913B78E60864}

:: Adobe Bridge 1.0
start /wait msiexec /qn /norestart /x {B74D4E10-1033-0000-0000-000000000001}

:: Adobe Content Viewer
start /wait msiexec /qn /norestart /x {483A865C-A74A-12BF-1276-D0111A488F50}

:: Adobe Community Help
start /wait msiexec /qn /norestart /x {A127C3C0-055E-38CF-B38F-1E85F8BBBFFE}

:: Adobe Common File Installer
start /wait msiexec /qn /norestart /x {8EDBA74D-0686-4C99-BFDD-F894678E5B39}

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

:: Advertising Center 0.0.0.2
start /wait msiexec /qn /norestart /x {3784D297-8089-43B6-B57F-11B7E96413CD}

:: Alienware Customer Surveys
start /wait msiexec /qn /norestart /x {13A3A271-B2AA-486C-9AD5-F272079BB9B5}

:: AlignmentUtility (various versions)
start /wait msiexec /qn /norestart /x {4C5E314A-31CA-4223-9A90-CE0C4D5800A4}
start /wait msiexec /qn /norestart /x {B0D59FDC-FEAB-49A2-9B5A-E5E0A8F9D7E0}

:: Amazon 1Button App 1.0.0.4
start /wait msiexec /qn /norestart /x {134E190A-CE2A-4436-BDEB-387CC36A96C9}

:: AMD Accelerated Video Transcoding
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

:: AMD Catalyst Control Center - Branding
start /wait msiexec /qn /norestart /x {24D38277-CE6E-4E12-A2EE-F46832A4FA2F}

:: AMD Drag and Drop Transcoding (various versions)
start /wait msiexec /qn /norestart /x {0336B81E-E745-7FE9-74D5-157EBCDF71E3}
start /wait msiexec /qn /norestart /x {503F672D-6C84-448A-8F8F-4BC35AC83441}
start /wait msiexec /qn /norestart /x {5D2B5E19-C333-4519-3D32-AAB8EEE9ACA4}
start /wait msiexec /qn /norestart /x {D42B82F2-116E-8588-D868-5E98EF9B0CF8}
start /wait msiexec /qn /norestart /x {FEA214BD-EE6F-B3B9-FE9E-80D2B14849D5}

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

:: AOLIcon (lol)
start /wait msiexec /qn /norestart /x {FFC7F03B-7069-4F7B-B0A5-9C173E898AC9}

:: ArcSoft Magic-i Visual Effects 2, ArcSoft WebCam Companion 3 and 4
start /wait msiexec /qn /norestart /x {B1893E3F-9BDF-443F-BED0-1AAA2D9E0D68}
start /wait msiexec /qn /norestart /x {DE8AAC73-6D8D-483E-96EA-CAEDDADB9079}
start /wait msiexec /qn /norestart /x {B77DE05C-7C84-4011-B93F-A29D0D2840F4}

:: Ashampoo Burning Studio FREE v.1.14.5
start /wait msiexec /qn /norestart /x {91B33C97-91F8-FFB3-581B-BC952C901685}

:: Ask Toolbar
start /wait msiexec /qn /norestart /x {4F524A2D-5637-006A-76A7-A758B70C0300}
start /wait msiexec /qn /norestart /x {86D4B82A-ABED-442A-BE86-96357B70F4FE}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-4300-76A7-A758B70C2201}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-006A-76A7-A758B70C0F01}
start /wait msiexec /qn /norestart /x {9149AE79-3421-4A3A-834E-543948B045A2}
start /wait msiexec /qn /norestart /x {4F524A2D-5637-4300-76A7-A758B70C0A00}

:: ASPCA misc programs (we-care.com Macy's nagware)
start /wait msiexec /qn /norestart /x {7E482AF6-AA1F-4CC5-BA13-0536675F5744}
start /wait msiexec /qn /norestart /x {987F1753-1F42-4DF2-A5EA-0CCB777F3EB0}
start /wait msiexec /qn /norestart /x {E4FB0B39-C991-4EE7-95DD-1A1A7857D33D}
start /wait msiexec /qn /norestart /x {1F1E283D-23D9-4E09-B967-F46A053FEA89}

:: ASUS Ai Charger
start /wait msiexec /qn /norestart /x {7FB64E72-9B0E-4460-A821-040C341E414A}

:: Avery Toolbar
start /wait msiexec /qn /norestart /x {8D20B4D7-3422-4099-9332-39F27E617A6F}

:: AVG 2014
start /wait msiexec /qn /norestart /x {FC3B3A5D-7058-4627-9F1E-F95CC38B6054}
start /wait msiexec /qn /norestart /x {524569AC-B3EE-468B-BFD5-19A89EA7CE8E}
start /wait msiexec /qn /norestart /x {91569630-3DDC-43EB-9425-E6C41431D535}
start /wait msiexec /qn /norestart /x {A64D4055-F3E5-40E7-982A-C1FC10C3B4AF}
start /wait msiexec /qn /norestart /x {B53BE722-137D-4A7C-BC7A-F495DF36AF59}
start /wait msiexec /qn /norestart /x {F4735E8D-3570-4606-A4E9-0BE44F3B0DFC}

:: AVG 2015
start /wait msiexec /qn /norestart /x {3B3927B0-0A21-4B4C-9FF3-AB4C42E2AF79}
start /wait msiexec /qn /norestart /x {966F007B-0D8A-44A6-A6C3-5395983C356D}
start /wait msiexec /qn /norestart /x {0B7BE3CA-AF33-4CE3-BC27-1456C96EF996}
start /wait msiexec /qn /norestart /x {7A5DB14B-14B0-4F09-A130-BF60503B4248}

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

:: Bing Desktop
start /wait msiexec /qn /norestart /x {7D095455-D971-4D4C-9EFD-9AF6A6584F3A}

:: Browser Address Error Redirector
start /wait msiexec /qn /norestart /x {DF9A6075-9308-4572-8932-A4316243C4D9}

:: CA Pest Patrol Realtime Protection 001.001.0034
start /wait msiexec /qn /norestart /x {F05A5232-CE5E-4274-AB27-44EB8105898D}

:: Catalyst Control Center - Branding 1.00.0000
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

:: Catalyst Control Center multi-lingual Help files. Too many to individually list, Google each GUID for more info
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
start /wait msiexec /qn /norestart /x {244DFA33-CAE6-6D3A-BD58-B65EAD0AF73C}
start /wait msiexec /qn /norestart /x {252FC4D1-4056-7237-6B19-4C66D0CF45A9}
start /wait msiexec /qn /norestart /x {26070CDA-A7C5-2114-0533-38DE06C65E7F}
start /wait msiexec /qn /norestart /x {267D591E-CC5C-9951-890A-97BD66717E30}
start /wait msiexec /qn /norestart /x {2696556B-1D2B-26B3-75B1-52F342C150D0}
start /wait msiexec /qn /norestart /x {2701BCE6-FAAF-7F58-5993-78D631439450}
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
start /wait msiexec /qn /norestart /x {75B9B936-BB09-B904-FE0F-52954DB68DAA}
start /wait msiexec /qn /norestart /x {768012C6-AB93-3FDE-C3F6-6C0606948568}
start /wait msiexec /qn /norestart /x {768A7F56-650B-F84F-DF95-EB1926AB5A8F}
start /wait msiexec /qn /norestart /x {76B72651-1E7A-27C4-EAC6-81468BB968C2}
start /wait msiexec /qn /norestart /x {780B8B1A-3BE2-CFB3-3B07-4C5938A4FE3F}
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
start /wait msiexec /qn /norestart /x {9BE678EF-1CDB-8FBE-9DC1-F0289F481C5B}
start /wait msiexec /qn /norestart /x {9D3A232F-57E6-595E-1F77-637AFF16580C}
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
start /wait msiexec /qn /norestart /x {E8EE10CF-31E4-CA63-BD94-B0157BBB2444}
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

:: Comcast Desktop Software (v1.2.0.9) 23
start /wait msiexec /qn /norestart /x {CEF7211D-CE3A-44C4-B321-D84A2099AE94}

:: Connect To Tech-Support (malware)
start /wait msiexec /qn /norestart /x {A22B8513-EA8C-46A1-9735-F5BE971C368D}

:: CyberLink Blu-ray Disc Suite
start /wait msiexec /qn /norestart /x {1FBF6C24-C1FD-4101-A42B-0C564F9E8E79}

:: CyberLink Power2Go
start /wait msiexec /qn /norestart /x {2A87D48D-3FDF-41fd-97CD-A1E370EFFFE2}
start /wait msiexec /qn /norestart /x {40BF1E83-20EB-11D8-97C5-0009C5020658}

:: CyberLink PhotoDirector 5
start /wait msiexec /qn /norestart /x {5A454EC5-217A-42a5-8CE1-2DDEC4E70E01}

:: CyberLink PowerDVD 12 and DX
start /wait msiexec /qn /norestart /x {B46BEA36-0B71-4A4E-AE41-87241643FA0A}
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

:: Dell Access
start /wait msiexec /qn /norestart /x {F839C6BD-E92E-48FA-9CE6-7BFAF94F7096}

:: Dell Backup and Recovery Manager
start /wait msiexec /qn /norestart /x {975DFE7C-8E56-45BC-A329-401E6B1F8102}
start /wait msiexec /qn /norestart /x {50B4B603-A4C6-4739-AE96-6C76A0F8A388}
start /wait msiexec /qn /norestart /x {731B0E4D-F4C7-450C-95B0-E1A3176B1C75}
rd /s /q %SystemDrive%\dell\dbrm

:: Dell Client System Update
start /wait msiexec /qn /norestart /x {69093D49-3DD1-4FB5-A378-0D4DB4CF86EA}
start /wait msiexec /qn /norestart /x {04566294-A6B6-4462-9721-031073EB3694}
start /wait msiexec /qn /norestart /x {2B2B45B1-3CA0-4F8D-BBB3-AC77ED46A0FE}

:: Dell Command | Update
start /wait msiexec /qn /norestart /x {EC542D5D-B608-4145-A8F7-749C02BE6D94}

:: Dell Command | Power
start /wait msiexec /qn /norestart /x {DDDAF4A7-8B7D-4088-AECC-6F50E594B4F5}

:: Dell ControlPoint
start /wait msiexec /qn /norestart /x {A9C61491-EF2F-4ED8-8E10-FB33E3C6B55A}

:: Dell ControlVault Host Components Installer
start /wait msiexec /qn /norestart /x {5A26B7C0-55B1-4DA8-A693-E51380497A5E}

:: Dell Datasafe Online
start /wait msiexec /qn /norestart /x {7EC66A95-AC2D-4127-940B-0445A526AB2F}

:: Dell Digital Delivery
WMIC product where name="Dell Digital Delivery" call uninstall /nointeractive

:: Dell Dock
start /wait msiexec /qn /norestart /x {E60B7350-EA5F-41E0-9D6F-E508781E36D2}

:: Dell Feature Enhancement Pack
start /wait msiexec /qn /norestart /x {992D1CE7-A20F-4AB0-9D9D-AFC3418844DA}

:: Dell Getting Started Guide
start /wait msiexec /qn /norestart /x {7DB9F1E5-9ACB-410D-A7DC-7A3D023CE045}

:: Dell Power Manager
start /wait msiexec /qn /norestart /x {CAC1E444-ECC4-4FF8-B328-5E547FD608F8}

:: Dell Protected Workspace
wmic product where name="Dell Protected Workspace" call uninstall /nointeractive

:: Dell Resource CD
start /wait msiexec /qn /norestart /x {42929F0F-CE14-47AF-9FC7-FF297A603021}

:: Dell Support Center
start /wait msiexec /qn /norestart /x {0090A87C-3E0E-43D4-AA71-A71B06563A4A}

:: Desktop Doctor 2.5.5
start /wait msiexec /qn /norestart /x {D87149B3-7A1D-4548-9CBF-032B791E5908}

:: DisableMSDefender
start /wait msiexec /qn /norestart /x {74FE39A0-FB76-47CD-84BA-91E2BBB17EF2}

:: Download Windows Universal Tools 14.0.22823
start /wait msiexec /qn /norestart /x {7C361160-7ADC-46CE-AFDC-D10C6EADD032}

:: Drive Encryption For HP ProtectTools 7.0.28.30376
start /wait msiexec /qn /norestart /x {D5D422B9-6976-4E98-8DDF-9632CB515D7E}

:: Driver Detective 8.0.1
start /wait msiexec /qn /norestart /x {177CD779-4EEC-43C5-8DEA-4E0EC103624B}

:: Driver Manager 8.1
start /wait msiexec /qn /norestart /x {27F1E086-5691-4EB8-8BA1-5CBA87D67EB5}

:: Dropbox Setup 1.0.0.5
start /wait msiexec /qn /norestart /x {099218A5-A723-43DC-8DB5-6173656A1E94}

:: Dropbox Update Helper 1.3.27.33
start /wait msiexec /qn /norestart /x {4640FDE1-B83A-4376-84ED-86F86BEE2D41}

:: DTS Sound
start /wait msiexec /qn /norestart /x {793B70D2-41E9-46AB-9DDC-B34C99D07DB5}
start /wait msiexec /qn /norestart /x {F8EB8FFC-C535-49A1-A84D-CC75CB2D6ADA}
start /wait msiexec /qn /norestart /x {1BDEB6E2-6706-4132-A5D3-99190C6BECD8}
start /wait msiexec /qn /norestart /x {2DFA9084-CEB3-4A48-B9F7-9038FEF1B8F4}

:: EA Download Manager
start /wait msiexec /qn /norestart /x {EF7E931D-DC84-471B-8DB6-A83358095474}

:: eBay Worldwide
start /wait msiexec /qn /norestart /x {8549CF08-D327-4B73-9036-75564C0BBCFC}

:: Embassy Suite
start /wait msiexec /qn /norestart /x {20A4AA32-B3FF-4A0B-853C-ACDDCD6CB344}

:: Energy Star // Energy Star Digital Logo
start /wait msiexec /qn /norestart /x {465CA2B6-98AF-4E77-BE22-A908C34BB9EC}
start /wait msiexec /qn /norestart /x {51CB3204-2129-4D74-8AF8-3AEB52793969}
start /wait msiexec /qn /norestart /x {AC768037-7079-4658-AC24-2897650E0ABE}
start /wait msiexec /qn /norestart /x {BD1A34C9-4764-4F79-AE1F-112F8C89D3D4}

:: Epson Customer Participation
start /wait msiexec /qn /norestart /x {814FA673-A085-403C-9545-747FC1495069}

:: ESC Home Page Plugin
start /wait msiexec /qn /norestart /x {E738A392-F690-4A9D-808E-7BAF80E0B398}

:: Facebook Messenger 2.1.4814.0
start /wait msiexec /qn /norestart /x {7204BDEE-1A48-4D95-A964-44A9250B439E}

:: Facebook Video Calling 3.1.0.521
start /wait msiexec /qn /norestart /x {2091F234-EB58-4B80-8C96-8EB78C808CF7}

:: Find Junk Files 1.51
start /wait msiexec /qn /norestart /x {9FE8D71A-BEBC-48F3-9479-E5E25AE2A4F0}

:: FlashCatch browser plugin
start /wait msiexec /qn /norestart /x {A0AB2980-1FDD-4b6c-940C-FC87C84F05B7}

:: Get Dropbox (also called "Dropbox 25 GB" or "Dropbox 15 GB")
start /wait msiexec /qn /norestart /x {597A58EC-42D6-4940-8739-FB94491B013C}

:: GeekBuddy
start /wait msiexec /qn /norestart /x {17004FB0-9CFD-43DC-BB2D-E2BA612D98D0}

:: Google Toolbar for Internet Explorer
start /wait msiexec /qn /norestart /x {18455581-E099-4BA8-BC6B-F34B2F06600C}
start /wait msiexec /qn /norestart /x {2318C2B1-4965-11d4-9B18-009027A5CD4F}

:: Google Update Helper
start /wait msiexec /qn /norestart /x {60EC980A-BDA2-4CB6-A427-B07A5498B4CA}
start /wait msiexec /qn /norestart /x {A92DAB39-4E2C-4304-9AB6-BC44E68B55E2}

:: Hewlett-Packard ACLM.NET
start /wait msiexec /qn /norestart /x {6F340107-F9AA-47C6-B54C-C3A19F11553F}

:: HP 3D DriveGuard
start /wait msiexec /qn /norestart /x {E8D0E2B8-B64B-44BC-8E01-00DDACBDF78A}

:: HP 64 Bit HP CIO Components Installer
start /wait msiexec /qn /norestart /x {FF21C3E6-97FD-474F-9518-8DCBE94C2854}
start /wait msiexec /qn /norestart /x {BC741628-0AFC-405C-8946-DD46D1005A0A}

:: HP ActiveCheck component for HP Active Support Libary
start /wait msiexec /qn /norestart /x {254C37AA-6B72-4300-84F6-98A82419187E}
start /wait msiexec /qn /norestart /x {CBB639E0-B534-4827-97B5-CA1A4CA985B5}

:: HP BufferChm
start /wait msiexec /qn /norestart /x {FA0FF682-CC70-4C57-93CD-E276F3E7537E}

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

:: HP CUE Status (various versions)
start /wait msiexec /qn /norestart /x {5B025634-7D5B-4B8D-BE2A-7943C1CF2D5D}
start /wait msiexec /qn /norestart /x {CE938F96-2EDD-4377-942A-1B877616E523}
start /wait msiexec /qn /norestart /x {A0B9F8DF-C949-45ed-9808-7DC5C0C19C81}
start /wait msiexec /qn /norestart /x {03A7C57A-B2C8-409b-92E5-524A0DFD0DD3}
start /wait msiexec /qn /norestart /x {0EF5BEA9-B9D3-46d7-8958-FB69A0BAEACC}

:: HP Customer Experience Enhancements
start /wait msiexec /qn /norestart /x {07FA4960-B038-49EB-891B-9F95930AA544}
start /wait msiexec /qn /norestart /x {C9EF1AAF-B542-41C8-A537-1142DA5D4AEC}

:: HP CustomerResearchQFolder
start /wait msiexec /qn /norestart /x {6F5E2F4A-377D-4700-B0E3-8F7F7507EA15}

:: HP Connected Music
start /wait msiexec /qn /norestart /x {8126E380-F9C6-4317-9CEE-9BBDDAB676E5}

:: HP CoolSense
start /wait msiexec /qn /norestart /x {1504CF6F-8139-497F-86FC-46174B67CF7F}

:: HP D2400_Help
start /wait msiexec /qn /norestart /x {7EF7CCB0-52BF-4947-BE6E-E47D586E8842}

:: HP Deskjet 2510 series Setup Guide 
start /wait msiexec /qn /norestart /x {216C7F38-4BBC-4E9A-8392-C9FA21B54386}

:: HP Deskjet 3050 J610 series Help 140.0.63.63
start /wait msiexec /qn /norestart /x {F7632A9B-661E-4FD9-B1A4-3B86BC99847F}

:: HP Deskjet 3050 J610 series Product Improvement Study 22.0.334.0
start /wait msiexec /qn /norestart /x {FEB2C4AA-661E-483F-9626-21A8ACFD10F2}

:: HP Device Access Manager
start /wait msiexec /qn /norestart /x {2642BE09-1F9F-4E18-AAD4-0258B9BCE611}
start /wait msiexec /qn /norestart /x {9EC0BE64-2C6C-428A-A4C2-E7EDF831B29A}
start /wait msiexec /qn /norestart /x {DBCD5E64-7379-4648-9444-8A6558DCB614}

:: HP DeviceManagementQFolder
start /wait msiexec /qn /norestart /x {AB5D51AE-EBC3-438D-872C-705C7C2084B0}

:: HP Documentation
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

:: HPDiagnosticAlert
start /wait msiexec /qn /norestart /x {B6465A32-8BE9-4B38-ADC5-4B4BDDC10B0D}
start /wait msiexec /qn /norestart /x {846B5DED-DC8C-4E1A-B5B4-9F5B39A0CACE}

:: HP DisableMSDefender (disables Microsoft Defender...wtf?)
start /wait msiexec /qn /norestart /x {74FE39A0-FB76-47CD-84BA-91E2BBB17EF2}

:: HP Drive Encryption
start /wait msiexec /qn /norestart /x {1868D30B-72C7-41E8-9657-69C5DFE1C768}
start /wait msiexec /qn /norestart /x {9D380C34-58B7-4FF9-9DB8-05685AAD93D4}
start /wait msiexec /qn /norestart /x {3E9BC837-E48E-4964-AFFD-7AB40EBA5C50}
start /wait msiexec /qn /norestart /x {71EE298A-7B6D-4303-8438-C3E50567DA1F}
start /wait msiexec /qn /norestart /x {3F728815-C7E8-40EA-8D1A-F7B8E2382325}

:: HP ENVY 4500 series Help
start /wait msiexec /qn /norestart /x {95BECC50-22B4-4FCA-8A2E-BF77713E6D3A}

:: HP ESU for Microsoft Windows (Windows update hijacker)
start /wait msiexec /qn /norestart /x {A5F1C701-E150-4A86-A7F8-9E9225C2AE52}
start /wait msiexec /qn /norestart /x {6349342F-9CEF-4A70-995A-2CF3704C2603}
start /wait msiexec /qn /norestart /x {22706ADC-74A1-43A0-ABAE-47F84966B909}
start /wait msiexec /qn /norestart /x {2BF5E9CC-C55D-4B0F-ACAF-FFE77F333CD8}
start /wait msiexec /qn /norestart /x {A351CC1B-C92C-4F37-8109-9F6D33ACF5EF}

:: HP eSupportQFolder
start /wait msiexec /qn /norestart /x {66E6CE0C-5A1E-430C-B40A-0C90FF1804A8}

:: HP File Sanitizer
start /wait msiexec /qn /norestart /x {53D3E126-699A-4D92-AA66-6560D573553E}
start /wait msiexec /qn /norestart /x {60F90886-FAEE-4768-9817-093AB0F30540}

:: HP GPBaseService2 (popups)
start /wait msiexec /qn /norestart /x {BB3447F6-9553-4AA9-960E-0DB5310C5779}

:: HP miscellaneous Help and eDocs GUIDs (various versions for various products; most of these should be caught in the wildcard scan)
start /wait msiexec /qn /norestart /x {11C9A461-DD9D-4C71-85A4-6DCE7F99CC44}
start /wait msiexec /qn /norestart /x {24C7AD6B-F418-4D3B-B7F2-F3603FD720BF}
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

:: HP MarketResearch
start /wait msiexec /qn /norestart /x {95D08F4E-DFC2-4ce3-ACB7-8C8E206217E9}
start /wait msiexec /qn /norestart /x {D360FA88-17C8-4F14-B67F-13AAF9607B12}

:: HP On Screen Display (various versions)
start /wait msiexec /qn /norestart /x {9ADABDDE-9644-461B-9E73-83FA3EFCAB50}
start /wait msiexec /qn /norestart /x {D734D743-2385-46ED-9B3E-168A24A9E1A9}
start /wait msiexec /qn /norestart /x {EC8D12E4-A73C-4C27-B1C7-E9683052E556}

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

:: HP Product Assistant
start /wait msiexec /qn /norestart /x {150B6201-E9E6-4DFB-960E-CCBD53FBDDED}
start /wait msiexec /qn /norestart /x {67D3F1A0-A1F2-49b7-B9EE-011277B170CD}

:: HP Product Detection
start /wait msiexec /qn /norestart /x {A436F67F-687E-4736-BD2B-537121A804CF}

:: HP Product Improvement Study (various versions)
start /wait msiexec /qn /norestart /x {E3D43596-7E26-479E-B718-77CB3D9270F6}

:: HP PostScript Converter
start /wait msiexec /qn /norestart /x {6E14E6D6-3175-4E1A-B934-CAB5A86367CD}

:: HP Quick Launch and Quick Start (various versions)
start /wait msiexec /qn /norestart /x {E92D47A1-D27D-430A-8368-0BAFD956507D}
start /wait msiexec /qn /norestart /x {BAD0FA60-09CF-4411-AE6A-C2844C8812FA}
start /wait msiexec /qn /norestart /x {2856A1C2-70C5-4EC3-AFF7-E5B51E5530A2}
start /wait msiexec /qn /norestart /x {E4A80DC6-8475-4AD9-9952-5E4437889563}
start /wait msiexec /qn /norestart /x {6B7AB1ED-B64E-4545-A8E7-F9E071E12B6F}
start /wait msiexec /qn /norestart /x {566BB063-0E28-4273-A748-690BE86A7E26}

:: HP Recovery Manager
start /wait msiexec /qn /norestart /x {64BAA990-F1FC-4145-A7B1-E41FBBC9DA47}
start /wait msiexec /qn /norestart /x {D817481A-193E-4332-A4F3-E19132F744F0}
start /wait msiexec /qn /norestart /x {6369FC9E-FC8D-493F-AD87-D51FAB492705}
start /wait msiexec /qn /norestart /x {DB97D0DE-0AA1-413C-8398-92C7FA3F4A67}
start /wait msiexec /qn /norestart /x {4F46FDB9-B906-47BF-B3D5-C62E01B3C5EE}

:: HP Registration Service
start /wait msiexec /qn /norestart /x {D1E8F2D7-7794-4245-B286-87ED86C1893C}
start /wait msiexec /qn /norestart /x {C0C9A493-51CB-4F3F-A296-5B5E410C338E}
start /wait msiexec /qn /norestart /x {D1E7D876-6B86-4B35-A93D-15B0D6C43EAF}

:: HP Setup
start /wait msiexec /qn /norestart /x {438363A8-F486-4C37-834C-4955773CB3D3}

:: HP SimplePass
start /wait msiexec /qn /norestart /x {314FAD12-F785-4471-BCE8-AB506642B9A1}

:: HP SmartWebPrinting
start /wait msiexec /qn /norestart /x {8FF6F5CA-4E30-4E3B-B951-204CAAA2716A}
start /wait msiexec /qn /norestart /x {DC635845-46D3-404B-BCB1-FC4A91091AFA}

:: HP Status Alerts
start /wait msiexec /qn /norestart /x {9D1DE902-8058-4555-A16A-FBFAA49587DB}

:: HP Solution Center
start /wait msiexec /qn /norestart /x {BC5DD87B-0143-4D14-AAE6-97109614DC6B}
start /wait msiexec /qn /norestart /x {A36CD345-625C-4d6c-B3E2-76E1248CB451}

:: HP Support Assistant (various versions)
start /wait msiexec /qn /norestart /x {8C696B4B-6AB1-44BC-9416-96EAC474CABE}
start /wait msiexec /qn /norestart /x {904822F1-6C7D-4B91-B936-6A1C0810544C}
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
start /wait msiexec /qn /norestart /x {438363A8-F486-4C37-834C-4955773CB3D3}
start /wait msiexec /qn /norestart /x {FB4BB287-37F9-4E27-9C4D-2D3882E08EFF}

:: HP Support Information
start /wait msiexec /qn /norestart /x {B2B7B1C8-7C8B-476C-BE2C-049731C55992}

:: HP Support Solutions Framework
start /wait msiexec /qn /norestart /x {D7D5F438-26EF-45AB-AB89-C476FBCF8584}

:: HP System Event Utility
start /wait msiexec /qn /norestart /x {8B4EE87E-6D40-4C91-B5E8-0DC77DC412F1}

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

:: HP "Toolbox" (hidden)
start /wait msiexec /qn /norestart /x {292F0F52-B62D-4E71-921B-89A682402201}

:: HP UnloadSupport (hidden)
start /wait msiexec /qn /norestart /x {E06F04B9-45E6-4AC0-8083-85F7515F40F7}

:: HP Update
start /wait msiexec /qn /norestart /x {912D30CF-F39E-4B31-AD9A-123C6B794EE2}
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

:: HP USB Docking Video (wtf?)
start /wait msiexec /qn /norestart /x {B0069CFA-5BB9-4C03-B1C6-89CE290E5AFE}

:: HP Utility Center
start /wait msiexec /qn /norestart /x {B7B82520-8ECE-4743-BFD7-93B16C64B277}

:: HP WebReg
start /wait msiexec /qn /norestart /x {179C56A4-F57F-4561-8BBF-F911D26EB435}
start /wait msiexec /qn /norestart /x {8EE94FD8-5F52-4463-A340-185D16328158}
start /wait msiexec /qn /norestart /x {350C97B0-3D7C-4EE8-BAA9-00BCB3D54227}
start /wait msiexec /qn /norestart /x {29FA38B4-0AE4-4D0D-8A51-6165BB990BB0}
start /wait msiexec /qn /norestart /x {43CDF946-F5D9-4292-B006-BA0D92013021}
start /wait msiexec /qn /norestart /x {087A66B8-1F0F-4a8d-A649-0CFE276AA7C0}

:: HP Wireless Assistant // Wireless Button Driver // Wireless Hotspot
start /wait msiexec /qn /norestart /x {9AB1B6EC-AEA4-4D78-ADDB-0291BF7230F4}
start /wait msiexec /qn /norestart /x {547607B0-3294-4ECA-8F5E-921404676CBB}
start /wait msiexec /qn /norestart /x {13133E99-B0D5-4143-B832-AAD55C62A41C}
start /wait msiexec /qn /norestart /x {92F7E378-0F27-4D1E-ACAE-2AA7E546D082}
start /wait msiexec /qn /norestart /x {3082CB96-66E8-456D-8326-118A4F5DC0C6}
start /wait msiexec /qn /norestart /x {CFD917BE-F1F6-410E-ABEC-9EC819507D0D}
start /wait msiexec /qn /norestart /x {5601F151-A69F-4E30-8C60-37928124CD07}

:: Instant Housecall Specialist Sign-in
start /wait msiexec /qn /norestart /x {4A89B7B3-EB5B-4B33-B7B4-99E69792C081}

:: Intel(R) Identity Protection Technology
start /wait msiexec /qn /norestart /x {C01A86F5-56E7-101F-9BC9-E3F1025EB779}

:: Intel(R) Management Engine Components
start /wait msiexec /qn /norestart /x {5D1BFBB8-4923-4388-9559-C86F5D9E2740}
start /wait msiexec /qn /norestart /x {B434599E-E35F-4612-9803-A2FB7A8E066B}
start /wait msiexec /qn /norestart /x {65153EA5-8B6E-43B6-857B-C6E4FC25798A}

:: Intel(R) ME UninstallLegacy
start /wait msiexec /qn /norestart /x {FD37351B-3074-4652-8188-1B3FB784EC4E}
start /wait msiexec /qn /norestart /x {C9A90201-B2DE-44D0-A618-EF8C9060D318}
start /wait msiexec /qn /norestart /x {ECA145AF-55D0-42BA-870F-4213F0198A46}

:: Intel Trusted Connect Client
start /wait msiexec /qn /norestart /x {44B72151-611E-429D-9765-9BA093D7E48A}

:: Intel(R) Technology Access
start /wait msiexec /qn /norestart /x {413fe921-b226-41c8-bc3c-574074ceec4d}
start /wait msiexec /qn /norestart /x {583882E7-EA75-4BF0-94FA-7DD5A3731C76}

:: Intel(R) Trusted Connect Service Client
start /wait msiexec /qn /norestart /x {1B444AF9-1DBE-4884-8F35-969BEFCF69A8}
start /wait msiexec /qn /norestart /x {7D84E343-A23D-451C-B123-0195B2D903A6}

:: Intel(R) Trusted Execution Engine
start /wait msiexec /qn /norestart /x {E14B99BA-3282-4990-8BD7-20FD584A217F}

:: Intel(R) Trusted Execution Engine Driver
start /wait msiexec /qn /norestart /x {4021582A-4C27-4482-A287-5D49B80DB48F}

:: Intel(R) Turbo Boost Technology
start /wait msiexec /qn /norestart /x {D6C630BF-8DBB-4042-8562-DC9A52CB6E7E}

:: Intel Update
start /wait msiexec /qn /norestart /x {78091D68-706D-4893-B287-9F1DFB24F7AF}

:: Intel Update Manager
start /wait msiexec /qn /norestart /x {608E1B9B-A2E8-4A1F-8BAB-874EB0DD25E3}
start /wait msiexec /qn /norestart /x {43FA4AC8-46F8-423F-96FD-9A7D67048F1C}

:: Intel(R) Rapid Storage Technology
start /wait msiexec /qn /norestart /x {205AE40D-8AD7-4F29-A430-DD2168DA562D}
start /wait msiexec /qn /norestart /x {409CB30E-E457-4008-9B1A-ED1B9EA21140}
start /wait msiexec /qn /norestart /x {3E29EE6C-963A-4aae-86C1-DC237C4A49FC}

:: Intel WiMAX Tutorial
start /wait msiexec /qn /norestart /x {4F26C164-9373-4974-8F43-E0F2176AF937}

:: _is1 iolo technologies' System Mechanic Professional and UniBlue DriverScanner
start /wait msiexec /qn /norestart /x {BBD3F66B-1180-4785-B679-3F91572CD3B4}
start /wait msiexec /qn /norestart /x {C2F8CA82-2BD9-4513-B2D1-08A47914C1DA}

:: iSEEK AnswerWorks English Runtime
start /wait msiexec /qn /norestart /x {18A8E78B-9EF2-496E-B310-BCD8E4C1DAB3}
start /wait msiexec /qn /norestart /x {DBCC73BA-C69A-4BF5-B4BF-F07501EE7039}

:: Java Auto Updater
start /wait msiexec /qn /norestart /x {4A03706F-666A-4037-7777-5F2748764D10}
start /wait msiexec /qn /norestart /x {CCB6114E-9DB9-BD54-5AA0-BC5123329C9D}

:: Kaspersky Lab Network Agent
start /wait msiexec /qn /norestart /x {786A9F7E-CFEC-451F-B3C4-22EB11550FD8}

:: Kaspersky Internet Security
start /wait msiexec /qn /norestart /x {793B70D2-41E9-46AB-9DDC-B34C99D07DB5}

:: Lenovo Message Center Plus
start /wait msiexec /qn /norestart /x {3849486C-FF09-4F5D-B491-3E179D58EE15}

:: Lenovo Metrics Collector SDK
start /wait msiexec /qn /norestart /x {DDAA788F-52E6-44EA-ADB8-92837B11BF26}
start /wait msiexec /qn /norestart /x {C2B5B5B0-2545-4E94-B4BA-548D4BF0B196}

:: Lenovo Patch Utility
start /wait msiexec /qn /norestart /x {C6FB6B4A-1378-4CD3-9CD3-42BA69FCBD43}

:: Lenovo Reach and REACHit
start /wait msiexec /qn /norestart /x {3245D8C8-7FE0-4FD4-B04B-2720A333D592}
start /wait msiexec /qn /norestart /x {0B5E0E89-4BCA-4035-BBA1-D1439724B6E2}
start /wait msiexec /qn /norestart /x {4532E4C5-C84D-4040-A044-ECFCC5C6995B}

:: Lenovo Registration
start /wait msiexec /qn /norestart /x {6707C034-ED6B-4B6A-B21F-969B3606FBDE}

:: Lenovo SMB Customizations
start /wait msiexec /qn /norestart /x {AFD7B869-3B70-40C7-8983-769256BA3BD2}

:: Lenovo Solution Center
start /wait msiexec /qn /norestart /x {63942F7E-3646-45EC-B8A9-EAC40FEB66DB}
start /wait msiexec /qn /norestart /x {13BD494D-9ACD-420B-A291-E145DED92EF6}
start /wait msiexec /qn /norestart /x {4C2B6F96-3AED-4E3F-8DCE-917863D1E6B1}
start /wait msiexec /qn /norestart /x {1CA74803-5CB2-4C03-BDBE-061EDC81CC7F}

:: Lenovo System Update
start /wait msiexec /qn /norestart /x {25C64847-B900-48AD-A164-1B4F9B774650}
start /wait msiexec /qn /norestart /x {8675339C-128C-44DD-83BF-0A5D6ABD8297}
start /wait msiexec /qn /norestart /x {C9335768-C821-DD44-38FB-A0D5A6DB2879}

:: Lenovo User Guide
start /wait msiexec /qn /norestart /x {13F59938-C595-479C-B479-F171AB9AF64F}

:: Lenovo Warranty Info
start /wait msiexec /qn /norestart /x {FD4EC278-C1B1-4496-99ED-C0BE1B0AA521}

:: Lenovo Web Start
if exist "%LOCALAPPDATA%\Pokki\Engine\HostAppService.exe" "%LOCALAPPDATA%\Pokki\Engine\HostAppService.exe" /UNINSTALL04bb6df446330549a2cb8d67fbd1a745025b7bd1

:: Logitech eReg
start /wait msiexec /qn /norestart /x {3EE9BCAE-E9A9-45E5-9B1C-83A4D357E05C}

:: Setup1 (??)
start /wait msiexec /qn /norestart /x {86091EC1-DD17-4814-A54B-0A634CB8D82C}

:: SSN Librarian (some sketchy Russian program)
start /wait msiexec /qn /norestart /x {1D425886-3FE1-41AA-8D7A-E432CE29A4AE}

:: SupportSoft Assisted Service 15 // SupportUtility (various versions)
start /wait msiexec /qn /norestart /x {3002C8EB-2A7E-419B-B77F-5AD7E9F54A5A}
start /wait msiexec /qn /norestart /x {31AF8802-BF43-4C43-984B-EC597CF51505}
start /wait msiexec /qn /norestart /x {5A3F6A80-7913-475E-8B96-477A952CFA43}

:: McAfee LiveSafe - Internet Security
if exist %ProgramFiles(x86)%\McAfee\MSC\mcuihost.exe %ProgramFiles(x86)%\McAfee\MSC\mcuihost.exe /body:misp://MSCJsRes.dll::uninstall.html /id:uninstall
if exist %ProgramFiles%\McAfee\MSC\mcuihost.exe %ProgramFiles%\McAfee\MSC\mcuihost.exe /body:misp://MSCJsRes.dll::uninstall.html /id:uninstall

:: Media Gallery
start /wait msiexec /qn /norestart /x {115B60D5-BBDB-490E-AF2E-064D37A3CE01}

:: Microsoft Application Error Reporting
start /wait msiexec /qn /norestart /x {95120000-00B9-0409-1000-0000000FF1CE}

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

:: Microsoft Search Enhancement Pack
start /wait msiexec /qn /norestart /x {4CBA3D4C-8F51-4D60-B27E-F6B641C571E7}

:: Microsoft DVD App Installation for Microsoft.WindowsDVDPlayer_2019.6.11761.0_neutral_~_8wekyb3d8bbwe (x64)
start /wait msiexec /qn /norestart /x {986E003C-E56D-5A47-110E-D3C81F0E8535}

:: Network64, HP? malware?
start /wait msiexec /qn /norestart /x {6BFAB6C1-6D46-46DB-A538-A269907C9F2F}
start /wait msiexec /qn /norestart /x {48C0866E-57EB-444C-8371-8E4321066BC3}

:: Nuance Cloud Connector
start /wait msiexec /qn /norestart /x {EEE31B2B-F517-4BD2-8F92-57E4AE938BA3}

:: Nuance PDF Viewer Plus
start /wait msiexec /qn /norestart /x {042A6F10-F770-4886-A502-B795DCF2D3B5}

:: NVIDIA HD Aadio Driver
start /wait msiexec /qn /norestart /x {B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}

:: Office 2013 C2R Suite
start /wait msiexec /qn /norestart /x {90150000-0138-0409-0000-0000000FF1CE}
start /wait msiexec /x "C:\ProgramData\Microsoft\OEMOffice15\OOBE\x86\oemoobe.msi" /qn /norestart

:: opensource
start /wait msiexec /qn /norestart /x {3677D4D8-E5E0-49FC-B86E-06541CF00BBE}

:: PlayReady PC Runtime amd64
start /wait msiexec /qn /norestart /x {BCA9334F-B6C9-4F65-9A73-AC5A329A4D04}

:: PlayStation(R)Network Downloader (hidden)
start /wait msiexec /qn /norestart /x {B6659DD8-00A7-4A24-BBFB-C1F6982E5D66}

:: PlayStation(R)Store (hidden)
start /wait msiexec /qn /norestart /x {0E532C84-4275-41B3-9D81-D4A1A20D8EE7}

:: PSE10 STI Installer
start /wait msiexec /qn /norestart /x {11D08055-939C-432b-98C3-E072478A0CD7}

:: QuickTime 7
start /wait msiexec /qn /norestart /x {3D2CBC2C-65D4-4463-87AB-BB2C859C1F3E}
start /wait msiexec /qn /norestart /x {AF0CE7C0-A3E4-4D73-988B-B29187EC6E9A}
start /wait msiexec /qn /norestart /x {627FFC10-CE0A-497F-BA2B-208CAC638010}

:: Recovery Manager
start /wait msiexec /qn /norestart /x {44B2A0AB-412E-4F8C-B058-D1E8AECCDFF5}
start /wait msiexec /qn /norestart /x {C7231F7C-6530-4E65-ADA6-5B392CF5BEB1}

:: RealDownloader
start /wait msiexec /qn /norestart /x {C8E8D2E3-EF6A-4B1D-A09E-7B27EBE2F3CE}

:: Roxio BackOnTrack
start /wait msiexec /qn /norestart /x {5A06423A-210C-49FB-950E-CB0EB8C5CEC7}

:: Roxio DirectXInstallService
start /wait msiexec /qn /norestart /x {098122AB-C605-4853-B441-C0A4EB359B75}

:: Roxio Easy CD and DVD Burning
start /wait msiexec /qn /norestart /x {537BF16E-7412-448C-95D8-846E85A1D817}

:: Roxio File Backup
start /wait msiexec /qn /norestart /x {60B2315F-680F-4EB3-B8DD-CCDC86A7CCAB}

:: Samsung MagicTunePremium (monitor selection app)
start /wait msiexec /qn /norestart /x {79E9C7C5-4FCC-4DFF-B79E-17319E9522F3}

:: Samsung Story Album Viewer
start /wait msiexec /qn /norestart /x {698BBAD8-B116-495D-B879-0F07A533E57F}

:: Samsung SW Update (disables Windows Update; very bad)
start /wait msiexec /qn /norestart /x {AAFEFB05-CF98-48FC-985E-F04CD8AD620D}

:: ShufflePlusVLOI
start /wait msiexec /qn /norestart /x {0A80329D-1B59-4F10-8D1D-924C59B2840B}

:: Skype Click 2 Call
start /wait msiexec /qn /norestart /x {6D1221A9-17BF-4EC0-81F2-27D30EC30701}
start /wait msiexec /qn /norestart /x {981029E0-7FC9-4CF3-AB39-6F133621921A}
start /wait msiexec /qn /norestart /x {5EE47864-CF84-4629-86A6-50BEFF406BE5}

:: Skype Toolbars (various versions)
start /wait msiexec /qn /norestart /x {6D1221A9-17BF-4EC0-81F2-27D30EC30701}

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
start /wait msiexec /qn /norestart /x {BC5DD87B-0143-4D14-AAE6-97109614DC6B}
start /wait msiexec /qn /norestart /x {8D337F77-BE7F-41A2-A7CB-D5A63FD7049B}

:: Sony Media Go
start /wait msiexec /qn /norestart /x {167A1F6A-9BF2-4B24-83DB-C6D659F680EA}

:: Sony Messenger (Oasis2Service)
start /wait msiexec /qn /norestart /x {E50FC5DB-7CBD-407D-A46E-0C13E45BC386}

:: Sony OOBE
start /wait msiexec /qn /norestart /x {18894D16-5448-4BF9-A128-F7E937322F91}

:: Sony Quick Web Access
start /wait msiexec /qn /norestart /x {13EC74A6-4707-4D26-B9B9-E173403F3B08}

:: Sony Reader for PC
start /wait msiexec /qn /norestart /x {CF5B430D-C563-4EE6-803D-A8A133DFCE5E}

:: Sony Remote Play with Playstation(R)3
start /wait msiexec /qn /norestart /x {D56DA747-5FDB-4AD5-9A6A-3481C0ED44BD}

:: Sony TrackID(TM) with BRAVIA (poor Shazzam clone)
start /wait msiexec /qn /norestart /x {858B32BD-121C-4AC8-BD87-CE37C51C03E2}
start /wait msiexec /qn /norestart /x {2F41EF61-A066-4EBF-84F8-21C1B317A780}

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

:: swMSM -  Shockwave Player Merge Module (hidden)
start /wait msiexec /qn /norestart /x {612C34C7-5E90-47D8-9B5C-0F717DD82726}
start /wait msiexec /qn /norestart /x {C30E30A6-0AB5-470A-AB67-D322938F5429}

:: Spybot - Search & Destroy
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

:: Symantec WebReg
start /wait msiexec /qn /norestart /x {CCB9B81A-167F-4832-B305-D2A0430840B3}

:: System Requirements Lab for Intel
start /wait msiexec /qn /norestart /x {04C4B49D-45D9-4A28-9ED1-B45CBD99B8C7}
start /wait msiexec /qn /norestart /x {76CE5B47-F5A4-4E5C-99A0-CEFF6146EA4A}
start /wait msiexec /qn /norestart /x {DB2C58E0-6284-4B48-97F2-22A980B6360B}
start /wait msiexec /qn /norestart /x {25C64847-B900-48AD-A164-1B4F9B774650}
start /wait msiexec /qn /norestart /x {63B7AC7E-0178-4F4F-A79B-08D97ADD02D7}

:: Toshiba Audio Enhancement
start /wait msiexec /qn /norestart /x {1515F5E3-29EA-4CD1-A981-032D88880F09}

:: Toshiba Application Installer
start /wait msiexec /qn /norestart /x {21A63CA3-75C0-4E56-B602-B7CD2EF6B621}
start /wait msiexec /qn /norestart /x {970472D0-F5F9-4158-A6E3-1AE49EFEF2D3}

:: Toshiba App Place
start /wait msiexec /qn /norestart /x {ED3CBA78-488F-4E8C-B33F-8E3BF4DDB4D2}

:: TOSHIBA Assist
start /wait msiexec /qn /norestart /x {1B87C40B-A60B-4EF3-9A68-706CF4B69978}

:: Toshiba Book Place
start /wait msiexec /qn /norestart /x {11244D6B-9842-440F-8579-6A4D771A0D9B}
start /wait msiexec /qn /norestart /x {92C7DC44-DAD3-49FE-B89B-F92C6BA9A331}
start /wait msiexec /qn /norestart /x {39187A4B-7538-4BE7-8BAD-9E83303793AA}

:: Toshiba Bulletin Board
start /wait msiexec /qn /norestart /x {C14518AF-1A0F-4D39-8011-69BAA01CD380}
start /wait msiexec /qn /norestart /x {229C190B-7690-40B7-8680-42530179F3E9}

:: Toshiba Desktop Assist
start /wait msiexec /qn /norestart /x {95CCACF0-010D-45F0-82BF-858643D8BC02}

:: TOSHIBA Disc Creator 2.1.0.4 for x64
start /wait msiexec /qn /norestart /x {5DA0E02F-970B-424B-BF41-513A5018E4C0}

:: Toshiba Display Utility
start /wait msiexec /qn /norestart /x {0B39C39A-3ECE-4582-9C91-842D22819A24}

:: TOSHIBA Eco Utility
start /wait msiexec /qn /norestart /x {72EFCFA8-3923-451D-AF52-7CE9D87BC2A1}
start /wait msiexec /qn /norestart /x {5944B9D4-3C2A-48DE-931E-26B31714A2F7}

:: TOSHIBA HDD/SDD Alert 3.1.64.6
start /wait msiexec /qn /norestart /x {D4322448-B6AF-4316-B859-D8A0E84DCB38}

:: TOSHIBA Media Controller and TOSHIBA Media Controller Plug-in 1.0.5.11
start /wait msiexec /qn /norestart /x {983CD6FE-8320-4B80-A8F6-0D0366E0AA22}
start /wait msiexec /qn /norestart /x {F26FDF57-483E-42C8-A9C9-EEE1EDB256E0}

:: Toshiba Password Utility
start /wait msiexec /qn /norestart /x {26BB68BB-CF93-4A12-BC6D-A3B6F53AC8D9}

:: TOSHIBA Quality Application
start /wait msiexec /qn /norestart /x {E69992ED-A7F6-406C-9280-1C156417BC49}

:: TOSHIBARegistration
start /wait msiexec /qn /norestart /x {5AF550B4-BB67-4E7E-82F1-2C4300279050}

:: TOSHIBA Recovery Media Creator
start /wait msiexec /qn /norestart /x {B65BBB06-1F8E-48F5-8A54-B024A9E15FDF}

:: Toshiba ReelTime
start /wait msiexec /qn /norestart /x {24811C12-F4A9-4D0F-8494-A7B8FE46123C}

:: Toshiba Service Station
start /wait msiexec /qn /norestart /x {0DFA8761-7735-4DE8-A0EB-2286578DCFC6}
start /wait msiexec /qn /norestart /x {6499E894-43F8-458B-AE35-724F4732BCDE}

:: TOSHIBA Speech System Appplications, SR Engine(U.S.), TTS Engine(U.S.)
start /wait msiexec /qn /norestart /x {EE033C1F-443E-41EC-A0E2-559B539A4E4D}
start /wait msiexec /qn /norestart /x {008D69EB-70FF-46AB-9C75-924620DF191A}
start /wait msiexec /qn /norestart /x {3FBF6F99-8EC6-41B4-8527-0A32241B5496}

:: Toshiba System Driver
start /wait msiexec /qn /norestart /x {1E6A96A1-2BAB-43EF-8087-30437593C66C}

:: Toshiba System Settings
start /wait msiexec /qn /norestart /x {B040D5C9-C9AA-430A-A44E-696656012E61}
start /wait msiexec /qn /norestart /x {05A55927-DB9B-4E26-BA44-828EBFF829F0}

:: Toshiba Utility Common Driver (hidden)
start /wait msiexec /qn /norestart /x {12688FD7-CB92-4A5B-BEE4-5C8E0574434F}

:: Toshiba User's Guide
start /wait msiexec /qn /norestart /x {3384E1D9-3F18-4A98-8655-180FEF0DFC02}

:: Toshiba Value Added Package
start /wait msiexec /qn /norestart /x {066CFFF8-12BF-4390-A673-75F95EFF188E}

:: TOSHIBA Web Camera Application
start /wait msiexec /qn /norestart /x {5E6F6CF3-BACC-4144-868C-E14622C658F3}

:: TOSHIBA VIDEO PLAYER
start /wait msiexec /qn /norestart /x {FF07604E-C860-40E9-A230-E37FA41F103A}

:: Toshiba Wireless LAN Indicator
start /wait msiexec /qn /norestart /x {CDADE9BC-612C-42B8-B929-5C6A823E7FF9}

:: TrayApp (various versions)
start /wait msiexec /qn /norestart /x {CD31E63D-47FD-491C-8117-CF201D0AFAB5}
start /wait msiexec /qn /norestart /x {FF075778-6E50-47ed-991D-3B07FD4E3250}
start /wait msiexec /qn /norestart /x {4D304678-738E-42a0-931A-2B022F49DEB8}
start /wait msiexec /qn /norestart /x {1EC71BFB-01A3-4239-B6AF-B1AE656B15C0}
start /wait msiexec /qn /norestart /x {1B57D761-768E-4FB8-A6BB-057A977A7C81}
start /wait msiexec /qn /norestart /x {5ACE69F0-A3E8-44eb-88C1-0A841E700180}

:: Trend Micro Trial
start /wait msiexec /qn /norestart /x {BED0B8A2-2986-49F8-90D6-FA008D37A3D2}

:: Trend Micro Worry-Free Business Security Trial
start /wait msiexec /qn /norestart /x {0A07E717-BB5D-4B99-840B-6C5DED52B277}

:: VAIO - Media Gallery
start /wait msiexec /qn /norestart /x {7C7BC722-BB95-4A6E-9373-DA706D83430B}

:: VAIO - PMB
start /wait msiexec /qn /norestart /x {B6A98E5F-D6A7-46FB-9E9D-1F7BF443491C}

:: VAIO - PMB VAIO Edition Guide (and associated "Plugin" GUIDs)
start /wait msiexec /qn /norestart /x {339F9B4D-00CB-4C1C-BED8-EC86A9AB602A}
start /wait msiexec /qn /norestart /x {133D3F07-D558-46CE-80E8-F4D75DBBAD63}
start /wait msiexec /qn /norestart /x {270380EB-8812-42E1-8289-53700DB840D2}
start /wait msiexec /qn /norestart /x {8356CB97-A48F-44CB-837A-A12838DC4669}

:: VAIO - Remote Keyboard, Remote Keyboard with PlayStation(R)3, Remote Play with Playstation(R)3
start /wait msiexec /qn /norestart /x {7396FB15-9AB4-4B78-BDD8-24A9C15D2C65}
start /wait msiexec /qn /norestart /x {6466EF6E-700E-470F-94CB-D0050302C84E}
start /wait msiexec /qn /norestart /x {E682702C-609C-4017-99E7-3129C163955F}
start /wait msiexec /qn /norestart /x {07441A52-E208-478A-92B7-5C337CA8C131}

:: VAIO Care, VAIO Care Recovery, VAIO Help and Support
start /wait msiexec /qn /norestart /x {D9FFE40D-1A85-4541-992C-5EF505F391A4}
start /wait msiexec /qn /norestart /x {471F7C0A-CA3A-4F4C-8346-DE36AD5E23D1}
start /wait msiexec /qn /norestart /x {6ED1750E-F44F-4635-8F0D-B76B9262B7FB}
start /wait msiexec /qn /norestart /x {AD3E7141-A22E-40F1-A7A4-55E898AE35E3}

:: VAIO Control Center, CPU Fan Diagnostic, Data Restore Tool, and Easy Connect
start /wait msiexec /qn /norestart /x {8E797841-A110-41FD-B17A-3ABC0641187A}
start /wait msiexec /qn /norestart /x {BCE6E3D7-B565-4E1B-AC77-F780666A35FB}
start /wait msiexec /qn /norestart /x {3267B2E9-9DF5-4251-87C8-33412234C77F}
start /wait msiexec /qn /norestart /x {57B955CE-B5D3-495D-AF1B-FAEE0540BFEF}
start /wait msiexec /qn /norestart /x {7C80D30A-AC02-4E3F-B95D-29F0E4FF937B}

:: VAIO Gate, Gate Default, Help and Support, Improvement, and Manual
start /wait msiexec /qn /norestart /x {A7C30414-2382-4086-B0D6-01A88ABA21C3}
start /wait msiexec /qn /norestart /x {AE5F3379-8B81-457E-8E09-7E61D941AFA4}
start /wait msiexec /qn /norestart /x {B7546697-2A80-4256-A24B-1C33163F535B}
start /wait msiexec /qn /norestart /x {0164FA3B-182D-4237-B22A-081C0B55E0D3}
start /wait msiexec /qn /norestart /x {3A26D9BD-0F73-432D-B522-2BA18138F7EF}
start /wait msiexec /qn /norestart /x {C6E893E7-E5EA-4CD5-917C-5443E753FCBD}

:: VAIO Sample Contents, Satisfaction Survey., Transfer Support VAIO Update
start /wait msiexec /qn /norestart /x {547C9EB4-4CA6-402F-9D1B-8BD30DC71E44}
start /wait msiexec /qn /norestart /x {5DDAFB4B-C52E-468A-9E23-3B0CEEB671BF}
start /wait msiexec /qn /norestart /x {0899D75A-C2FC-42EA-A702-5B9A5F24EAD5}
start /wait msiexec /qn /norestart /x {9FF95DA2-7DA1-4228-93B7-DED7EC02B6B2}

:: VIP Access (Lenovo-installed OEM bloatware for Verisign)
start /wait msiexec /qn /norestart /x {E8D46836-CD55-453C-A107-A59EC51CB8DC}

:: WOT for Internet Explorer plugin
start /wait msiexec /qn /norestart /x {373B90E1-A28C-434C-92B6-7281AFA6115A}

:: WildTangent GUIDs. Thanks to /u/mnbitcoin
start /wait msiexec /qn /norestart /x {23170F69-40C1-2702-0938-000001000000}
start /wait msiexec /qn /norestart /x {EE691BD9-2B2C-6BFB-6389-ABAF5AD2A4A1}
start /wait msiexec /qn /norestart /x {6E3610B2-430D-4EB0-81E3-2B57E8B9DE8D}
start /wait msiexec /qn /norestart /x {9E9EF3EC-22BC-445C-A883-D8DB2908698D}
:: \/ "Delicious Emilys Childhood Memories Premium Edition"....wtf
start /wait msiexec /qn /norestart /x {FC0ADA4D-8FA5-4452-8AFF-F0A0BAC97EF7}
start /wait msiexec /qn /norestart /x {6F340107-F9AA-47C6-B54C-C3A19F11553F}
start /wait msiexec /qn /norestart /x {DD7C5FC1-DCA5-487A-AF23-658B1C00243F}
start /wait msiexec /qn /norestart /x {0F929651-F516-4956-90F2-FFBD2CD5D30E}
start /wait msiexec /qn /norestart /x {89C7E0A7-4D9D-4DCC-8834-A9A2B92D7EBB}
start /wait msiexec /qn /norestart /x {9B56B031-A6C0-4BB7-8F61-938548C1B759}
start /wait msiexec /qn /norestart /x {0C0F368E-17C4-4F28-9F1B-B1DA1D96CF7A}
start /wait msiexec /qn /norestart /x {36AC0D1D-9715-4F13-B6A4-86F1D35FB4DF}
start /wait msiexec /qn /norestart /x {03D562B5-C4E2-4846-A920-33178788BE00}

:: Windows 7 USB/DVD Download Tool
start /wait msiexec /qn /norestart /x {CCF298AF-9CE1-4B26-B251-486E98A34789}

:: Windows 7 Upgrade Advisor
start /wait msiexec /qn /norestart /x {AAF91344-2808-4D6B-9242-FBE5AF79D60A}

:: Windows Live Family Safety // Disabled by Vocatus for Tron (some family systems may be using this)
::start /wait msiexec /qn /norestart /x {5F611ADA-B98C-4DBB-ADDE-414F08457ECF}

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

:: Windows Live Toolbar
start /wait msiexec /qn /norestart /x {995F1E2E-F542-4310-8E1D-9926F5A279B3}

:: WinZip (various versions) // WinZip Courier
start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240ED}
start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240CD}
start /wait msiexec /qn /norestart /x {CD95F661-A5C4-11AF-B2CC-ABCD21A325B8}
start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240C3}
start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240CF}
start /wait msiexec /qn /norestart /x {CD95F661-A5C4-44F5-A6AA-ECDD91C240E3}
start /wait msiexec /qn /norestart /x {8A6EAACB-E2D6-D6BF-0338-F4AC9641B423}

:: Xmarks for IE
start /wait msiexec /qn /norestart /x {ABFA6EAE-C9C0-4B39-B722-02094EF6B889}

:: YouTube Downloader 2.7.2
start /wait msiexec /qn /norestart /x {1a413f37-ed88-4fec-9666-5c48dc4b7bb7}

:: Zinio Alert Messenger
start /wait msiexec /qn /norestart /x {D2E707E8-090E-EC5B-4833-1CA694FB7460}

:: ZoneAlarm Antivirus, Firewall, and Security
start /wait msiexec /qn /norestart /x {043A5C25-EC0E-4152-A53B-73065A4315DF}
start /wait msiexec /qn /norestart /x {537317B1-FB59-4578-953F-544914A8F25F}
start /wait msiexec /qn /norestart /x {9A121E1B-1E87-4F37-BC9C-F8D073047942}

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

<#
Purpose:       Script to remove many of the pre-loaded 3rd-party Metro "modern app" bloatware. Called by Tron in Stage 2: De-bloat
               Add any AppX uninstall commands to this list to target them for removal
Requirements:  1. Administrator access
               2. Windows 8 and up
Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
Version:       1.2.6 + Add additional user-submitted entries
               1.2.4 * Fixed variable re-use, thanks to github:madbomb22
               1.2.3 * Implement removal process improvements, thanks to github:madbomb22			   
#>
$ErrorActionPreference = "SilentlyContinue"


########
# PREP #
########
$METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION = "1.2.6"
$METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_DATE = "2018-07-25"


# Needed for Removal
$AppxPackages = Get-AppxProvisionedPackage -online | select-object PackageName,Displayname
$ProPackageList = Get-AppxPackage -AllUsers | select-object PackageFullName, Name
$Script:AppxCount3rd = 0

# App Removal function
Function Remove-App([String]$AppName){
	If($AppxPackages.DisplayName -match $AppName -or $ProPackageList.Name -match $AppName ) {
		$PackageFullName = ($ProPackageList | where {$_.Name -like $AppName}).PackageFullName
		$ProPackageFullName = ($AppxPackages | where {$_.Displayname -like $AppName}).PackageName
	
		If($PackageFullName -is [array]){
			For($i=0 ;$i -lt $PackageFullName.Length ;$i++) {
				$Script:AppxCount3rd++
				$Job = "TronScript3rd$AppxCount3rd"
				$PackageF = $PackageFullName[$i]
				$ProPackage = $ProPackageFullName[$i]
				write-output "$AppxCount3rd - $PackageF"
				Start-Job -Name $Job -ScriptBlock { 
					Remove-AppxPackage -Package $using:PackageF | Out-null
					Remove-AppxProvisionedPackage -Online -PackageName $using:ProPackage | Out-null
				} | Out-null
			}
		} Else {
			$Script:AppxCount3rd++
			$Job = "TronScript3rd$AppxCount3rd"
			write-output "$AppxCount3rd - $PackageFullName"
			Start-Job -Name $Job -ScriptBlock { 
				Remove-AppxPackage -Package $using:PackageFullName | Out-null
				Remove-AppxProvisionedPackage -Online -PackageName $using:ProPackageFullName | Out-null
			} | Out-null
		}
	}
}


###########
# EXECUTE #
###########
# Active identifiers
Remove-App "06DAC6F6.StumbleUpon"
Remove-App "09B6C2D8.TheTreasuresofMontezuma3"
Remove-App "134D4F5B.Box*"
Remove-App "1430GreenfieldTechnologie.PuzzleTouch*"
Remove-App "26720RandomSaladGamesLLC.HeartsDeluxe*"
Remove-App "26720RandomSaladGamesLLC.SimpleSolitaire*"
Remove-App "29982CsabaHarmath.UnCompress*"
Remove-App "2FE3CB00.PicsArt-PhotoStudio*"
Remove-App "37442SublimeCo.AlarmClockForYou"
Remove-App "46928bounde.EclipseManager*"
Remove-App "4AE8B7C2.Booking.comPartnerEdition*"
Remove-App "5269FriedChicken.YouTubeVideosDownloader*"
Remove-App "64885BlueEdge.OneCalendar*"
Remove-App "6Wunderkinder.Wunderlist"
Remove-App "7906AAC0.TOSHIBACanadaPartners*"
Remove-App "7906AAC0.ToshibaCanadaWarrantyService*"
Remove-App "7EE7776C.LinkedInforWindows"
Remove-App "7digitalLtd.7digitalMusicStore*"
Remove-App "828B5831.HiddenCityMysteryofShadows"
Remove-App "89006A2E.AutodeskSketchBook*"
Remove-App "95FE1D22.VUDUMoviesandTV"
Remove-App "9E2F88E3.Twitter"
Remove-App "A278AB0D.DisneyMagicKingdoms"
Remove-App "A278AB0D.DragonManiaLegends*"
Remove-App "A278AB0D.MarchofEmpires"
Remove-App "A34E4AAB.YogaChef*"
Remove-App "AD2F1837.DiscoverHPTouchpointManager"
Remove-App "AD2F1837.HPJumpStart"
Remove-App "AD2F1837.HPPowerManager"
Remove-App "AD2F1837.HPWelcome"
Remove-App "AD2F1837.SmartfriendbyHPCare"
Remove-App "ASUSCloudCorporation.MobileFileExplorer*"
Remove-App "AccuWeather.AccuWeatherforWindows8*"
Remove-App "AcerIncorporated*"
Remove-App "AcerIncorporated.AcerExplorer"
Remove-App "ActiproSoftwareLLC*"
Remove-App "ActiproSoftwareLLC.562882FEEB491"
Remove-App "AdobeSystemsIncorporated.AdobePhotoshopExpress*"
Remove-App "AdobeSystemsIncorporated.AdobeRevel*"
Remove-App "Amazon.com.Amazon*"
Remove-App "AppUp.IntelAppUpCatalogueAppWorldwideEdition*"
Remove-App "B9ECED6F.ASUSGIFTBOX*"
Remove-App "BD9B8345.AlbumbySony*"
Remove-App "BD9B8345.MusicbySony*"
Remove-App "BD9B8345.Socialife*"
Remove-App "BD9B8345.VAIOCare*"
Remove-App "BD9B8345.VAIOMessageCenter*"
Remove-App "C27EB4BA.DropboxOEM"
Remove-App "ChaChaSearch.ChaChaPushNotification*"
Remove-App "ClearChannelRadioDigital.iHeartRadio*"
Remove-App "COMPALELECTRONICSINC.Alienwaredockingaccessory"
Remove-App "COMPALELECTRONICSINC.AlienwareOSDKits"
Remove-App "COMPALELECTRONICSINC.AlienwareTypeCaccessory"
Remove-App "CrackleInc.Crackle*"
Remove-App "CyberLinkCorp.ac.AcerCrystalEye*"
Remove-App "CyberLinkCorp.ac.SocialJogger*"
Remove-App "CyberLinkCorp.hs.YouCamforHP*"
Remove-App "CyberLinkCorp.id.PowerDVDforLenovoIdea*"
Remove-App "D52A8D61.FarmVille2CountryEscape*"
Remove-App "D5EA27B7.Duolingo-LearnLanguagesforFree*"
Remove-App "DB6EA5DB.CyberLinkMediaSuiteEssentials*"
Remove-App "DailymotionSA.Dailymotion*"
Remove-App "DellInc.AlienwareCommandCenter"
Remove-App "DellInc.AlienwareCustomerConnect"
Remove-App "DellInc.AlienwareProductRegistration"
Remove-App "DellInc.DellCustomerConnect"
Remove-App "DellInc.DellHelpSupport"
Remove-App "DellInc.DellPowerManager"
Remove-App "DellInc.DellProductRegistration"
Remove-App "DellInc.DellShop"
Remove-App "DellInc.DellSupportAssistforPCs"
Remove-App "DolbyLaboratories.DolbyAccess*"
Remove-App "DolbyLaboratories.DolbyAtmosSoundSystem"
Remove-App "Drawboard.DrawboardPDF*"
Remove-App "DriverToaster*"
Remove-App "E046963F.LenovoCompanion*"
Remove-App "E046963F.LenovoSupport*"
Remove-App "E0469640.CameraMan*"
Remove-App "E0469640.DeviceCollaboration*"
Remove-App "E0469640.LenovoRecommends*"
Remove-App "E0469640.YogaCameraMan*"
Remove-App "E0469640.YogaPhoneCompanion*"
Remove-App "E0469640.YogaPicks*"
Remove-App "ESPNInc.WatchESPN*"
Remove-App "EncyclopaediaBritannica.EncyclopaediaBritannica*"
Remove-App "Evernote.Evernote"
Remove-App "Evernote.Skitch*"
Remove-App "F5080380.ASUSPowerDirector*"
Remove-App "Facebook.317180B0BB486"
Remove-App "Facebook.Facebook"
Remove-App "Facebook.InstagramBeta*"
Remove-App "FilmOnLiveTVFree.FilmOnLiveTVFree*"
Remove-App "Fingersoft.HillClimbRacing"
Remove-App "FingertappsInstruments*"
Remove-App "FingertappsOrganizer*"
Remove-App "Flipboard.Flipboard*"
Remove-App "FreshPaint*"
Remove-App "GAMELOFTSA.Asphalt8Airborne*"
Remove-App "GAMELOFTSA.SharkDash*"
Remove-App "GameGeneticsApps.FreeOnlineGamesforLenovo*"
Remove-App "GettingStartedwithWindows8*"
Remove-App "GoogleInc.GoogleSearch"
Remove-App "HPConnectedMusic*"
Remove-App "HPConnectedPhotopoweredbySnapfish*"
Remove-App "HPRegistration*"
Remove-App "HuluLLC.HuluPlus*"
Remove-App "JigsWar*"
Remove-App "K-NFBReadingTechnologiesI.BookPlace*"
Remove-App "KasperskyLab.KasperskyNow*"
Remove-App "KeeperSecurityInc.Keeper"
Remove-App "KindleforWindows8*"
Remove-App "LenovoCorporation.LenovoID*"
Remove-App "LenovoCorporation.LenovoSettings*"
Remove-App "MAGIX.MusicMakerJam*"
Remove-App "McAfeeInc.05.McAfeeSecurityAdvisorforASUS"
Remove-App "McAfeeInc.01.McAfeeSecurityAdvisorforDell"
Remove-App "MobileFileExplorer*"
Remove-App "MusicMakerJam*"
Remove-App "NAMCOBANDAIGamesInc.PAC-MANChampionshipEditionDXfo*"
Remove-App "NAVER.LINEwin8*"
Remove-App "NBCUniversalMediaLLC.NBCSportsLiveExtra*"
Remove-App "PandoraMediaInc.29680B314EFC2"
Remove-App "PinballFx2*"
Remove-App "Playtika.CaesarsSlotsFreeCasino*"
Remove-App "Priceline"
Remove-App "PricelinePartnerNetwork.Priceline.comTheBestDealso"
Remove-App "PublicationsInternational.iCookbookSE*"
Remove-App "RandomSaladGamesLLC.GinRummyProforHP*"
Remove-App "SAMSUNGELECTRONICSCO.LTD.SamsungPrinterExperience"
Remove-App "ShazamEntertainmentLtd.Shazam*"
Remove-App "SonicWALL.MobileConnect"
Remove-App "SpotifyAB.SpotifyMusic"
Remove-App "SymantecCorporation.NortonStudio*"
Remove-App "TelegraphMediaGroupLtd.TheTelegraphforLenovo*"
Remove-App "TheNewYorkTimes.NYTCrossword*"
Remove-App "ThumbmunkeysLtd.PhototasticCollage*"
Remove-App "ToshibaAmericaInformation.ToshibaCentral*"
Remove-App "TripAdvisorLLC.TripAdvisorHotelsFlightsRestaurants*"
Remove-App "TuneIn.TuneInRadio*"
Remove-App "UptoElevenDigitalSolution.mysms-Textanywhere*"
Remove-App "Vimeo.Vimeo*"
Remove-App "Weather.TheWeatherChannelforHP*"
Remove-App "Weather.TheWeatherChannelforLenovo*"
Remove-App "WildTangentGames*"
Remove-App "WildTangentGames.63435CFB65F55"
Remove-App "WinZipComputing.WinZipUniversal*"
Remove-App "XINGAG.XING"
Remove-App "XeroxCorp.PrintExperience"
Remove-App "YouSendIt.HighTailForLenovo*"
Remove-App "ZinioLLC.Zinio*"
Remove-App "eBayInc.eBay*"
Remove-App "esobiIncorporated.newsXpressoMetro*"
Remove-App "fingertappsASUS.FingertappsInstrumentsrecommendedb*"
Remove-App "fingertappsASUS.JigsWarrecommendedbyASUS*"
Remove-App "fingertappsasus.FingertappsOrganizerrecommendedbyA*"
Remove-App "flaregamesGmbH.RoyalRevolt2*"
Remove-App "king.com.BubbleWitch3Saga"
Remove-App "king.com.CandyCrushSaga"
Remove-App "king.com.CandyCrushSodaSaga"
Remove-App "sMedioforHP.sMedio360*"
Remove-App "sMedioforToshiba.TOSHIBAMediaPlayerbysMedioTrueLin*"
Remove-App "toolbar*"
Remove-App "zuukaInc.iStoryTimeLibrary*"


# Inactive identifers
#Remove-App "Netflix*"
#Remove-App "4DF9E0F8.Netflix"

##########
# Finish #
##########
# DO NOT REMOVE OR CHANGE (needs to be at end of script)
# Waits for Apps to be removed before Script Closes
Write-Output 'Finishing app removal, please wait...'
Wait-Job -Name "TronScript3rd*" | Out-null
Remove-Job -Name "TronScript3rd*" | Out-null

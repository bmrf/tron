<#
Purpose:       Script to remove many of the pre-loaded 3rd-party Metro "modern app" bloatware. Called by Tron in Stage 2: De-bloat
               Add any AppX uninstall commands to this list to target them for removal
Requirements:  1. Administrator access
               2. Windows 7 and up
Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
Version:       1.1.1 + Add flaregamesGmbH.RoyalRevolt2 to active apps. Thanks to /u//Phaellow
               1.1.0 * Update script to use cleaner removal function. Thanks to /u/madbomb122
               1.0.2 + Add 6Wunderkinder.Wunderlist, 2FE3CB00.PicsArt-PhotoStudio, Microsoft.NetworkSpeedTest, thanks to github:Bromeego
               1.0.1 + Add 46928bounde.EclipseManager, D5EA27B7.Duolingo-LearnLanguagesforFree, thanks to /u/phobos258
               1.0.0 + Add script version and date variables to support automatic updates at Tron runtime
#>
$ErrorActionPreference = "SilentlyContinue"


########
# PREP #
########
$METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION = "1.1.1"
$METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_DATE = "2017-04-13"

# Build the removal function
Function Remove-App([String]$AppName){
	$PackageFullName = (Get-AppxPackage $AppName).PackageFullName
	$ProPackageFullName = (Get-AppxProvisionedPackage -online | where {$_.Displayname -like $AppName}).PackageName
	Remove-AppxPackage -package $PackageFullName | Out-Null
	Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName | Out-Null
}

###########
# EXECUTE #
###########
# Active identifiers
Remove-App "*Evernote.Evernote*"
Remove-App "*06DAC6F6.StumbleUpon*"
Remove-App "*134D4F5B.Box*"
Remove-App "*1430GreenfieldTechnologie.PuzzleTouch*"
Remove-App "*26720RandomSaladGamesLLC.HeartsDeluxe*"
Remove-App "*26720RandomSaladGamesLLC.SimpleSolitaire*"
Remove-App "*29982CsabaHarmath.UnCompress*"
Remove-App "*46928bounde.EclipseManager*"
Remove-App "*4AE8B7C2.Booking.comPartnerEdition*"
Remove-App "*7906AAC0.TOSHIBACanadaPartners*"
Remove-App "*7906AAC0.ToshibaCanadaWarrantyService*"
Remove-App "*7digitalLtd.7digitalMusicStore*"
Remove-App "*9E2F88E3.Twitter*"
Remove-App "*A34E4AAB.YogaChef*"
Remove-App "*AD2F1837.HP*"
Remove-App "*ASUSCloudCorporation.MobileFileExplorer*"
Remove-App "*AccuWeather.AccuWeatherforWindows8*"
Remove-App "*AcerIncorporated.AcerExplorer*"
Remove-App "*AcerIncorporated.GatewayExplorer*"
Remove-App "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
Remove-App "*AdobeSystemsIncorporated.AdobeRevel*"
Remove-App "*Amazon.com.Amazon*"
Remove-App "*AppUp.IntelAppUpCatalogueAppWorldwideEdition*"
Remove-App "*B9ECED6F.ASUSGIFTBOX*"
Remove-App "*BD9B8345.AlbumbySony*"
Remove-App "*BD9B8345.MusicbySony*"
Remove-App "*BD9B8345.Socialife*"
Remove-App "*BD9B8345.VAIOCare*"
Remove-App "*BD9B8345.VAIOMessageCenter*"
Remove-App "*ChaChaSearch.ChaChaPushNotification*"
Remove-App "*ClearChannelRadioDigital.iHeartRadio*"
Remove-App "*CrackleInc.Crackle*"
Remove-App "*CyberLinkCorp.ac.AcerCrystalEye*"
Remove-App "*CyberLinkCorp.ac.SocialJogger*"
Remove-App "*CyberLinkCorp.hs.YouCamforHP*"
Remove-App "*CyberLinkCorp.id.PowerDVDforLenovoIdea*"
Remove-App "*D5EA27B7.Duolingo-LearnLanguagesforFree*"
Remove-App "*DailymotionSA.Dailymotion*"
Remove-App "*DellInc.DellShop*"
Remove-App "*E046963F.LenovoCompanion*"
Remove-App "*E046963F.LenovoSupport*"
Remove-App "*E0469640.CameraMan*"
Remove-App "*E0469640.DeviceCollaboration*"
Remove-App "*E0469640.LenovoRecommends*"
Remove-App "*E0469640.YogaCameraMan*"
Remove-App "*E0469640.YogaPhoneCompanion*"
Remove-App "*E0469640.YogaPicks*"
Remove-App "*EncyclopaediaBritannica.EncyclopaediaBritannica*"
Remove-App "*Evernote.Skitch*"
Remove-App "*F5080380.ASUSPhotoDirector*"
Remove-App "*F5080380.ASUSPowerDirector*"
Remove-App "*FilmOnLiveTVFree.FilmOnLiveTVFree*"
Remove-App "*FingertappsInstruments*"
Remove-App "*FingertappsOrganizer*"
Remove-App "*flaregamesGmbH.RoyalRevolt2*"
Remove-App "*Flipboard.Flipboard*"
Remove-App "*FreshPaint*"
Remove-App "*GAMELOFTSA.SharkDash*"
Remove-App "*GameGeneticsApps.FreeOnlineGamesforLenovo*"
Remove-App "*GettingStartedwithWindows8*"
Remove-App "*HPConnectedMusic*"
Remove-App "*HPConnectedPhotopoweredbySnapfish*"
Remove-App "*HPRegistration*"
Remove-App "*JigsWar*"
Remove-App "*KasperskyLab.KasperskyNow*"
Remove-App "*KindleforWindows8*"
Remove-App "*MAGIX.MusicMakerJam*"
Remove-App "*McAfee*"
Remove-App "*McAfeeInc.05.McAfeeSecurityAdvisorforASUS*"
Remove-App "*Microsoft.MinecraftUWP*"
Remove-App "*MobileFileExplorer*"
Remove-App "*MusicMakerJam*"
Remove-App "*NAMCOBANDAIGamesInc.PAC-MANChampionshipEditionDXfo*"
Remove-App "*NAVER.LINEwin8*"
Remove-App "*PinballFx2*"
Remove-App "*PublicationsInternational.iCookbookSE*"
Remove-App "*RandomSaladGamesLLC.GinRummyProforHP*"
Remove-App "*ShazamEntertainmentLtd.Shazam*"
Remove-App "*SymantecCorporation.NortonStudio*"
Remove-App "*TelegraphMediaGroupLtd.TheTelegraphforLenovo*"
Remove-App "*TheNewYorkTimes.NYTCrossword*"
Remove-App "*TripAdvisorLLC.TripAdvisorHotelsFlightsRestaurants*"
Remove-App "*TuneIn.TuneInRadio*"
Remove-App "*UptoElevenDigitalSolution.mysms-Textanywhere*"
Remove-App "*Weather.TheWeatherChannelforHP*"
Remove-App "*Weather.TheWeatherChannelforLenovo*"
Remove-App "*WildTangentGames*"
Remove-App "*YouSendIt.HighTailForLenovo*"
Remove-App "*ZinioLLC.Zinio*"
Remove-App "*eBayInc.eBay*"
Remove-App "*esobiIncorporated.newsXpressoMetro*"
Remove-App "*fingertappsASUS.FingertappsInstrumentsrecommendedb*"
Remove-App "*fingertappsASUS.JigsWarrecommendedbyASUS*"
Remove-App "*fingertappsasus.FingertappsOrganizerrecommendedbyA*"
Remove-App "*sMedioforHP.sMedio360*"
Remove-App "*sMedioforToshiba.TOSHIBAMediaPlayerbysMedioTrueLin*"
Remove-App "*toolbar*"
Remove-App "*zuukaInc.iStoryTimeLibrary*"
Remove-App "*6Wunderkinder.Wunderlist*"
Remove-App "*2FE3CB00.PicsArt-PhotoStudio*"
Remove-App "*Microsoft.NetworkSpeedTest*"

# Inactive identifers
#Remove-App "*Netflix*"

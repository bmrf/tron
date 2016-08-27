<#
Purpose:       Script to remove many of the pre-loaded 3rd-party Metro "modern app" bloatware. Called by Tron in Stage 2: De-bloat
               Add any AppX uninstall commands to this list to target them for removal
Requirements:  1. Administrator access
               2. Windows 7 and up
Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
Version:       1.0.0 + Add script version and date variables to support automatic updates at Tron runtime
#>
$ErrorActionPreference = "SilentlyContinue"


########
# PREP #
########
$METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION = "1.0.0"
$METRO_3RD_PARTY_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_DATE = "2016-08-27"



###########
# EXECUTE #
###########
#remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*Evernote.Evernote*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*06DAC6F6.StumbleUpon*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*134D4F5B.Box*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*1430GreenfieldTechnologie.PuzzleTouch*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*26720RandomSaladGamesLLC.HeartsDeluxe*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*26720RandomSaladGamesLLC.SimpleSolitaire*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*29982CsabaHarmath.UnCompress*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*4AE8B7C2.Booking.comPartnerEdition*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*7906AAC0.TOSHIBACanadaPartners*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*7906AAC0.ToshibaCanadaWarrantyService*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*7digitalLtd.7digitalMusicStore*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*9E2F88E3.Twitter*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*A34E4AAB.YogaChef*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*AD2F1837.HP*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*ASUSCloudCorporation.MobileFileExplorer*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*AccuWeather.AccuWeatherforWindows8*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*AcerIncorporated.AcerExplorer*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*AcerIncorporated.GatewayExplorer*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*AdobeSystemsIncorporated.AdobeRevel*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*Amazon.com.Amazon*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*AppUp.IntelAppUpCatalogueAppWorldwideEdition*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*B9ECED6F.ASUSGIFTBOX*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*BD9B8345.AlbumbySony*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*BD9B8345.MusicbySony*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*BD9B8345.Socialife*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*BD9B8345.VAIOCare*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*BD9B8345.VAIOMessageCenter*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*ChaChaSearch.ChaChaPushNotification*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*ClearChannelRadioDigital.iHeartRadio*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*CrackleInc.Crackle*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*CyberLinkCorp.ac.AcerCrystalEye*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*CyberLinkCorp.ac.SocialJogger*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*CyberLinkCorp.hs.YouCamforHP*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*CyberLinkCorp.id.PowerDVDforLenovoIdea*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*DailymotionSA.Dailymotion*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*DellInc.DellShop*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*E046963F.LenovoCompanion*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*E046963F.LenovoSupport*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*E0469640.CameraMan*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*E0469640.DeviceCollaboration*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*E0469640.LenovoRecommends*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*E0469640.YogaCameraMan*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*E0469640.YogaPhoneCompanion*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*E0469640.YogaPicks*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*EncyclopaediaBritannica.EncyclopaediaBritannica*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*Evernote.Skitch*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*F5080380.ASUSPhotoDirector*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*F5080380.ASUSPowerDirector*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*FilmOnLiveTVFree.FilmOnLiveTVFree*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*FingertappsInstruments*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*FingertappsOrganizer*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*Flipboard.Flipboard*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*FreshPaint*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*GAMELOFTSA.SharkDash*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*GameGeneticsApps.FreeOnlineGamesforLenovo*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*GettingStartedwithWindows8*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*HPConnectedMusic*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*HPConnectedPhotopoweredbySnapfish*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*HPRegistration*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*JigsWar*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*KasperskyLab.KasperskyNow*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*KindleforWindows8*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*MAGIX.MusicMakerJam*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*McAfee*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*McAfeeInc.05.McAfeeSecurityAdvisorforASUS*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*Microsoft.MinecraftUWP*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*MobileFileExplorer*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*MusicMakerJam*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*NAMCOBANDAIGamesInc.PAC-MANChampionshipEditionDXfo*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*NAVER.LINEwin8*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*Netflix*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*PinballFx2*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*PublicationsInternational.iCookbookSE*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*RandomSaladGamesLLC.GinRummyProforHP*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*ShazamEntertainmentLtd.Shazam*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*SymantecCorporation.NortonStudio*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*TelegraphMediaGroupLtd.TheTelegraphforLenovo*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*TheNewYorkTimes.NYTCrossword*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*TripAdvisorLLC.TripAdvisorHotelsFlightsRestaurants*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*TuneIn.TuneInRadio*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*UptoElevenDigitalSolution.mysms-Textanywhere*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*Weather.TheWeatherChannelforHP*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*Weather.TheWeatherChannelforLenovo*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*WildTangentGames*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*YouSendIt.HighTailForLenovo*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*ZinioLLC.Zinio*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*eBayInc.eBay*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*esobiIncorporated.newsXpressoMetro*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*fingertappsASUS.FingertappsInstrumentsrecommendedb*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*fingertappsASUS.JigsWarrecommendedbyASUS*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*fingertappsasus.FingertappsOrganizerrecommendedbyA*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*sMedioforHP.sMedio360*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*sMedioforToshiba.TOSHIBAMediaPlayerbysMedioTrueLin*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*toolbar*"}).PackageFullName
remove-appxpackage $(Get-AppxPackage | where {$_.name -like "*zuukaInc.iStoryTimeLibrary*"}).PackageFullName

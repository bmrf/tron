<#
Purpose:       Script to remove many of the pre-loaded Microsoft Metro "modern app" bloatware. Called by Tron in Stage 2: De-bloat
               Add any AppX package names to the $PackagesToRemove array to target them for removal
Requirements:  1. Administrator access
               2. Windows 7 and up
Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
Version:       1.0.3 ! Fix typo in $PackagesToRemove array. Thanks to JegElsker
               1.0.2 - Remove Calendar and Mail app from active target list. Thanks to /u/Reynbou
               1.0.1 + Add script version and date variables to support automatic updates at Tron runtime
#>
$ErrorActionPreference = "SilentlyContinue"


########
# PREP #
########
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION = "1.0.3"
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_DATE = "2017-02-09"

Function Remove-App([String]$AppName){
    $PackageFullName = (Get-AppxPackage $AppName).PackageFullName
    $ProPackageFullName = (Get-AppxProvisionedPackage -online | where {$_.Displayname -eq $AppName}).PackageName
    Remove-AppxPackage -package $PackageFullName | Out-Null
    Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName | Out-Null
}

###########
# EXECUTE #
###########
# Active identifiers
Remove-App "9E2F88E3.Twitter"                          # Twitter app
Remove-App "Facebook.Facebook"                         # Facebook app
Remove-App "D52A8D61.FarmVille2CountryEscape"          
Remove-App "GAMELOFTSA.Asphalt8Airborne"               
Remove-App "Microsoft.3DBuilder"                       # '3DBuilder' app
Remove-App "Microsoft.Advertising.Xaml"                
Remove-App "Microsoft.BingFinance"                     # 'Money' app - Financial news
Remove-App "Microsoft.BingFoodAndDrink"                # 'Food and Drink' app
Remove-App "Microsoft.BingHealthAndFitness"            # 'Health and Fitness' app
Remove-App "Microsoft.BingNews"                        # 'Generic news' app
Remove-App "Microsoft.BingSports"                      # 'Sports' app - Sports news
Remove-App "Microsoft.BingTranslator"                  # 'Translator' app - Bing Translate
Remove-App "Microsoft.BingTravel"                      # 'Travel' app
Remove-App "Microsoft.CommsPhone"                      # 'Phone' app
Remove-App "Microsoft.ConnectivityStore"               
Remove-App "Microsoft.FreshPaint"                      # 'Canvas' app
Remove-App "Microsoft.Getstarted"                      # 'Get Started' link
Remove-App "Microsoft.Messaging"                       # 'Messaging' app
Remove-App "Microsoft.MicrosoftJackpot"                # 'Jackpot' app
Remove-App "Microsoft.MicrosoftJigsaw"                 # 'Jigsaw' app
Remove-App "Microsoft.MicrosoftOfficeHub"              
Remove-App "Microsoft.MicrosoftSudoku"                 
Remove-App "Microsoft.MovieMoments"                    # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.Office.OneNote"                  # 'Onenote' app
Remove-App "Microsoft.Office.Sway"                     # 'Sway' app
Remove-App "Microsoft.People"                          # 'People' app
Remove-App "Microsoft.SkypeApp"                        # 'Get Skype' link
Remove-App "Microsoft.SkypeWiFi"                       
Remove-App "Microsoft.Studios.Wordament"               # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.Taptiles"                        # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.Windows.CloudExperienceHost"     # 'Cloud Experience' sigh
Remove-App "Microsoft.WindowsFeedback"                 # 'Feedback' functionality
Remove-App "Microsoft.WindowsFeedbackHub"              # 'Feedback' functionality
Remove-App "Microsoft.WindowsPhone"                    # 'Phone Companion' app
Remove-App "Microsoft.XboxApp"                         # Xbox junk  unfortunately 'Microsoft.XboxGameCallableUI' and 'Microsoft.XboxIdentityProvider' can't be removed
Remove-App "Microsoft.ZuneMusic"                       # 'Groove Music' app
Remove-App "Microsoft.ZuneVideo"                       # 'Groove Music' app
Remove-App "MicrosoftMahjong"                          # 'Mahjong' game
Remove-App "Windows.ContactSupport"                    
Remove-App "king.com.CandyCrushSodaSaga"               # Candy Crush app

# Inactive identifers
#Remove-App "Microsoft.Appconnector"                   # Not sure about this one
#Remove-App "Microsoft.BingWeather"                    # 'Weather' app
#Remove-App "Microsoft.BioEnrollment"                  # not sure about this one
#Remove-App "Microsoft.MicrosoftSolitaireCollection"   # Solitaire collection
#Remove-App "Microsoft.Windows.Photos"                 # Photos app
#Remove-App "Microsoft.WindowsAlarms"                  # 'Alarms and Clock' app
#Remove-App "Microsoft.WindowsCalculator"              # Calculator app
#Remove-App "Microsoft.WindowsCamera"                  # Camera app
#Remove-App "Microsoft.windowscommunicationsapps"      # 'Calendar and Mail' app
#Remove-App "Microsoft.WindowsMaps"                    # Maps app
#Remove-App "Microsoft.WindowsSoundRecorder"           # Sound Recorder app
#Remove-App "Microsoft.WindowsStore"                   # Windows Store

Read-Host "PAUSE"

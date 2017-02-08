<#
Purpose:       Script to remove many of the pre-loaded Microsoft Metro "modern app" bloatware. Called by Tron in Stage 2: De-bloat
               Add any AppX package names to the $PackagesToRemove array to target them for removal
Requirements:  1. Administrator access
               2. Windows 7 and up
Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
Version:       1.0.2 - Remove Calendar and Mail app from active target list. Thanks to /u/Reynbou
               1.0.1 + Add script version and date variables to support automatic updates at Tron runtime
#>
$ErrorActionPreference = "SilentlyContinue"


########
# PREP #
########
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION = "1.0.2"
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_DATE = "2017-02-08"


###########
# EXECUTE #
###########
# Active identifiers
$PackagesToRemove = (
    '9E2F88E3.Twitter',                         # Twitter app
    'D52A8D61.FarmVille2CountryEscape',         
    'GAMELOFTSA.Asphalt8Airborne',              
    'Microsoft.3DBuilder',                      # '3DBuilder' app
    'Microsoft.Advertising.Xaml',               
    'Microsoft.BingFinance',                    # 'Money' app - Financial news
    'Microsoft.BingFoodAndDrink',               # 'Food and Drink' app
    'Microsoft.BingHealthAndFitness',           # 'Health and Fitness' app
    'Microsoft.BingNews',                       # 'Generic news' app
    'Microsoft.BingSports',                     # 'Sports' app - Sports news
    'Microsoft.BingTranslator',                 # 'Translator' app - Bing Translate
    'Microsoft.BingTravel',                     # 'Travel' app
    'Microsoft.CommsPhone',                     # 'Phone' app
    'Microsoft.ConnectivityStore',              
    'Microsoft.FreshPaint',                     # 'Canvas' app
    'Microsoft.Getstarted',                     # 'Get Started' link
    'Microsoft.Messaging',                      # 'Messaging' app
    'Microsoft.MicrosoftJackpot',               # 'Jackpot' app
    'Microsoft.MicrosoftJigsaw',                # 'Jigsaw' app
    'Microsoft.MicrosoftOfficeHub',             
    'Microsoft.MicrosoftSudoku',                
    'Microsoft.MovieMoments',                   # imported from stage_2_de-bloat.bat
    'Microsoft.Office.OneNote',                 # 'Onenote' app
    'Microsoft.Office.Sway',                    # 'Sway' app
    'Microsoft.People',                         # 'People' app
    'Microsoft.SkypeApp',                       # 'Get Skype' link
    'Microsoft.SkypeWiFi',                      
    'Microsoft.Studios.Wordament',              # imported from stage_2_de-bloat.bat
    'Microsoft.Taptiles',                       # imported from stage_2_de-bloat.bat
    'Microsoft.Windows.CloudExperienceHost',    # 'Cloud Experience' sigh
    'Microsoft.WindowsFeedback',                # 'Feedback' functionality
    'Microsoft.WindowsFeedbackHub',             # 'Feedback' functionality
    'Microsoft.WindowsPhone',                   # 'Phone Companion' app
    'Microsoft.XboxApp',                        # Xbox junk, unfortunately 'Microsoft.XboxGameCallableUI' and 'Microsoft.XboxIdentityProvider' can't be removed
    'Microsoft.ZuneMusic',                      # 'Groove Music' app
    'Microsoft.ZuneVideo',                      # 'Groove Music' app
    'MicrosoftMahjong',                         # 'Mahjong' game
    'Windows.ContactSupport',                   
    'king.com.CandyCrushSodaSaga',              # Candy Crush app
)

# Inactive identifers
    # 'Microsoft.Appconnector',                 # Not sure about this one
    # 'Microsoft.BingWeather',                  # 'Weather' app
    # 'Microsoft.BioEnrollment',                # not sure about this one
    # 'Microsoft.MicrosoftSolitaireCollection', # Solitaire collection
    # 'Microsoft.Windows.Photos',               # Photos app
    # 'Microsoft.WindowsAlarms',                # 'Alarms and Clock' app
    # 'Microsoft.WindowsCalculator',            # Calculator app
    # 'Microsoft.WindowsCamera',                # Camera app
    # 'microsoft.windowscommunicationsapps'     # 'Calendar and Mail' app
    # 'Microsoft.WindowsMaps',                  # Maps app
    # 'Microsoft.WindowsSoundRecorder',         # Sound Recorder app
    # 'Microsoft.WindowsStore',                 # Windows Store



# Do the removal
Get-AppxProvisionedPackage -Online | Where-Object Name -In $PackagesToRemove | Remove-AppxProvisionedPackage -Online | Out-Null
Get-AppxPackage -AllUsers | Where-Object Name -In $PackagesToRemove | Remove-AppxPackage | Out-Null

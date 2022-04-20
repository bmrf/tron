<#
Purpose:       Script to remove many of the pre-loaded Microsoft Metro "modern app" bloatware. Called by Tron in Stage 2: De-bloat
               Add any AppX uninstall commands to this list to target them for removal
Requirements:  1. Administrator access
               2. Windows 8 and up
Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
Version:       1.3.7 + Add additional user-submitted entries
#>
$ErrorActionPreference = "SilentlyContinue"


########
# PREP #
########
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION = "1.3.7"
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_DATE = "2021-06-02"

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
				$Script:AppxCountMS++
				$Job = "TronScriptMS$AppxCountMS"
				$PackageF = $PackageFullName[$i]
				$ProPackage = $ProPackageFullName[$i]
				write-output "$AppxCountMS - $PackageF"
				Start-Job -Name $Job -ScriptBlock {
					Remove-AppxPackage -Package $using:PackageF | Out-null
					Remove-AppxProvisionedPackage -Online -PackageName $using:ProPackage | Out-null
				} | Out-null
			}
		} Else {
			$Script:AppxCountMS++
			$Job = "TronScriptMS$AppxCountMS"
			write-output "$AppxCountMS - $PackageFullName"
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
Remove-App "BrowserChoice"                             # "Browser Choice" screen required by the EU antitrust regulation
Remove-App "Microsoft.Advertising.JavaScript"          # Advertising framework
Remove-App "Microsoft.Advertising.Xaml"                # Advertising framework
Remove-App "Microsoft.BingFinance"                     # Money app - Financial news
Remove-App "Microsoft.BingFoodAndDrink"                # Food and Drink app
Remove-App "Microsoft.BingHealthAndFitness"            # Health and Fitness app
Remove-App "Microsoft.BingMaps"
Remove-App "Microsoft.BingNews"                        # Generic news app
Remove-App "Microsoft.BingSports"                      # Sports app - Sports news
Remove-App "Microsoft.BingTranslator"                  # Translator app - Bing Translate
Remove-App "Microsoft.BingTravel"                      # Travel app
Remove-App "Microsoft.BioEnrollment"
Remove-App "Microsoft.ConnectivityStore"
Remove-App "Microsoft.DiagnosticDataViewer"
Remove-App "Microsoft.FreshPaint"                      # Canvas app
Remove-App "Microsoft.GamingApp"
Remove-App "Microsoft.GetHelp"                         # Get Help link
Remove-App "Microsoft.Getstarted"                      # Get Started link
Remove-App "Microsoft.HelpAndTips"
Remove-App "Microsoft.HoganThreshold"
Remove-App "Microsoft.LanguageExperiencePacken-GB"
Remove-App "Microsoft.LanguageExperiencePackes-es"
Remove-App "Microsoft.LanguageExperiencePackes-mx"
Remove-App "Microsoft.LanguageExperiencePacklt-lt"
Remove-App "Microsoft.LanguageExperiencePacknl-nl"
Remove-App "Microsoft.LanguageExperiencePackpt-BR"
Remove-App "Microsoft.Lucille"                         # "Browser Choice" screen required by the EU antitrust regulation
Remove-App "Microsoft.Messaging"                       # Messaging app
Remove-App "Microsoft.MicrosoftJackpot"                # Jackpot app
Remove-App "Microsoft.MicrosoftJigsaw"                 # Jigsaw app
Remove-App "Microsoft.MicrosoftMahjong"                # Advertising framework
Remove-App "Microsoft.MicrosoftOfficeHub"
Remove-App "Microsoft.MicrosoftPowerBIForWindows"      # Power BI app - Business analytics
Remove-App "Microsoft.MicrosoftRewards"
Remove-App "Microsoft.MicrosoftSudoku"
Remove-App "Microsoft.MicrosoftTreasureHunt"
Remove-App "Microsoft.MinecraftUWP"
Remove-App "Microsoft.MovieMoments"                    # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.NetworkSpeedTest"
Remove-App "Microsoft.Office.Sway"                     # Sway app
Remove-App "Microsoft.OneConnect"                      # OneConnect app
Remove-App "Microsoft.People"                          # People app
Remove-App "Microsoft.SeaofThieves"
Remove-App "Microsoft.SkypeApp"                        # Get Skype link
Remove-App "Microsoft.SkypeWiFi"
Remove-App "Microsoft.Studios.Wordament"               # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.SurfaceDiagnostics"              # added 2021-06-02
Remove-App "Microsoft.Windows.FeatureOnDemand.InsiderHub"
Remove-App "Microsoft.WindowsFeedbackHub"              # Feedback app
Remove-App "Microsoft.WindowsReadingList"
Remove-App "Microsoft.WorldNationalParks"
Remove-App "Windows.CBSPreview"
Remove-App "Windows.ContactSupport"


# Inactive identifers
#Remove-App "Microsoft.Appconnector"                   # Not sure about this one
#Remove-App "Microsoft.BingWeather"                    # Weather app
#Remove-App "Microsoft.CommsPhone"                     # Phone app
#Remove-App "Microsoft.MSPaint"                        # MS Paint (Paint 3D)
#Remove-App "Microsoft.Microsoft3DViewer"              # 3D model viewer
#Remove-App "Microsoft.MicrosoftSolitaireCollection"   # Solitaire collection
#Remove-App "Microsoft.MicrosoftStickyNotes"           # Pulled from active list due to user requests
#Remove-App "Microsoft.Office.OneNote"                 # Onenote app
#Remove-App "Microsoft.Windows.Photos"                 # Photos app
#Remove-App "Microsoft.WindowsAlarms"                  # Alarms and Clock app
#Remove-App "Microsoft.WindowsCalculator"              # Calculator app
#Remove-App "Microsoft.WindowsCamera"                  # Camera app
#Remove-App "Microsoft.WindowsMaps"                    # Maps app
#Remove-App "Microsoft.WindowsSoundRecorder"           # Sound Recorder app
#Remove-App "Microsoft.WindowsStore"                   # Windows Store
#Remove-App "Microsoft.Xbox*"
#Remove-App "Microsoft.Xbox.TCUI"
#Remove-App "Microsoft.XboxApp"
#Remove-App "Microsoft.XboxGameCallableUI"
#Remove-App "Microsoft.XboxGameOverlay"
#Remove-App "Microsoft.XboxGamingOverlay"
#Remove-App "Microsoft.XboxIdentityProvider"
#Remove-App "Microsoft.XboxSpeechToTextOverlay"
#Remove-App "Microsoft.Zune"                           # Zune collection of apps
#Remove-App "Microsoft.ZuneMusic"
#Remove-App "Microsoft.ZuneVideo"
#Remove-App "Microsoft.windowscommunicationsapps"      # Calendar and Mail app

##########
# Finish #
##########
# DO NOT REMOVE OR CHANGE (needs to be at end of script)
# Waits for Apps to be removed before script closes
Write-Output 'Finishing app removal, please wait...'
Wait-Job -Name "TronScriptMS*" | Out-Null
Remove-Job -Name "TronScriptMS*" | Out-Null
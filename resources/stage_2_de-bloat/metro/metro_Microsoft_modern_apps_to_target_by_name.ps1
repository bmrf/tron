<#
Purpose:       Script to remove many of the pre-loaded Microsoft Metro "modern app" bloatware. Called by Tron in Stage 2: De-bloat
               Add any AppX package names to the $PackagesToRemove array to target them for removal
Requirements:  1. Administrator access
               2. Windows 7 and up
Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
Version:       1.1.7 + Add Microsoft.GetHelp
               1.1.6 ! Fix function evalution of * character. Thanks to u/madbomb122 and u/phant0md
               1.1.5 + Add Zune entries, thanks to /u/ComputeGuy
               1.1.4 + Add various entries, thanks to github:kronflux
               1.1.3 + Add various entries
               1.1.2 + Add Microsoft.WindowsFeedbackHub to active apps. Thanks to /u/Phaellow
                     + Add Microsoft.Microsoft3DViewer to inactive apps. Thanks to /u/Phaellow
               1.1.1 + Add missing entries Microsoft.OneConnect, Microsoft.WindowsReadingList. Thanks to /u/1nfestissumam
                     + Add Microsoft.MicrosoftStickyNotes to disabled list (user request)
                     - Move Microsoft.Windows.CloudExperienceHost and Windows.ContactSupport to disabled list due to erroring out
                     - Remove entry 9E2F88E3.Twitter (moved to Metro 3rd party list)
               1.1.0 * Update script to use cleaner removal function. Thanks to /u/madbomb122
               1.0.3 ! Fix typo in $PackagesToRemove array. Thanks to JegElsker
               1.0.2 - Remove Calendar and Mail app from active target list. Thanks to /u/Reynbou
               1.0.1 + Add script version and date variables to support automatic updates at Tron runtime
#>
$ErrorActionPreference = "SilentlyContinue"


########
# PREP #
########
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION = "1.1.7"
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_DATE = "2018-02-16"

$Win10Apps = @(
    "*Microsoft.MinecraftUWP*",
    "*Microsoft.NetworkSpeedTest*",
    "Microsoft.3DBuilder",
    "Microsoft.Bing*",
    "Microsoft.CommsPhone",
    "Microsoft.ConnectivityStore",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.Messaging",
    "Microsoft.MicrosoftJackpot",
    "Microsoft.MicrosoftJigsaw",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MicrosoftSudoku",
    "Microsoft.Office.OneNote",
    "Microsoft.Office.Sway",
    "Microsoft.OneConnect",
    "Microsoft.People",
    "Microsoft.SkypeApp",
    "Microsoft.SkypeWiFi",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.Zune*",
    "Microsoft.Advertising*"
)

# Query the packages once
$AppxPackages = Get-AppxPackage
$AppxProPackages = Get-AppxProvisionedPackage -Online


foreach ($app in $Win10Apps) {
    # Installed packages
    $AppxPackages | Where-Object { $_.PackageFullName -like $app } | ForEach-Object {
        Start-Job -Name "Remove $app" -ScriptBlock { Remove-AppxPackage -Package $_.PackageFullName }
        Wait-Job -Name "Remove $app"
    } | Out-Null
    # Provisioned packages
    $AppxProPackages | Where-Object { $_.PackageName -like $app } | ForEach-Object {
        Start-Job -Name "Remove $app - provisioned" -ScriptBlock { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName }
        Wait-Job -Name "Remove $app - provisioned"
    } | Out-Null
}

# Inactive identifers
#Remove-App "Microsoft.Appconnector"                   # Not sure about this one
#Remove-App "Microsoft.BingWeather"                    # Weather app
#Remove-App "Microsoft.BioEnrollment"                  # not sure about this one
#Remove-App "Microsoft.Microsoft3DViewer"              # 3D model viewer
#Remove-App "Microsoft.MicrosoftSolitaireCollection"   # Solitaire collection
#Remove-App "Microsoft.MicrosoftStickyNotes"           # Pulled from active list due to user requests
#Remove-App "Microsoft.Windows.Photos"                 # Photos app
#Remove-App "Microsoft.WindowsAlarms"                  # Alarms and Clock app
#Remove-App "Microsoft.WindowsCalculator"              # Calculator app
#Remove-App "Microsoft.WindowsCamera"                  # Camera app
#Remove-App "Microsoft.WindowsMaps"                    # Maps app
#Remove-App "Microsoft.WindowsSoundRecorder"           # Sound Recorder app
#Remove-App "Microsoft.WindowsStore"                   # Windows Store
#Remove-App "Microsoft.windowscommunicationsapps"      # Calendar and Mail app
#Remove-App "Microsoft.MSPaint"                        # MS Paint (Paint 3D)
#Remove-App "Microsoft.ZuneMusic"
#Remove-App "Microsoft.ZuneVideo"
#Remove-App "Microsoft.Xbox*"
#Remove-App "Microsoft.Xbox.TCUI"
#Remove-App "Microsoft.XboxApp"
#Remove-App "Microsoft.XboxGameCallableUI"
#Remove-App "Microsoft.XboxGameOverlay"
#Remove-App "Microsoft.XboxIdentityProvider"
#Remove-App "Microsoft.XboxSpeechToTextOverlay"

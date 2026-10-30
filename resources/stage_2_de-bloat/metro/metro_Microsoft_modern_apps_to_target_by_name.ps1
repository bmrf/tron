<#
Purpose:       Script to remove many of the pre-loaded Microsoft Metro "modern app" bloatware. Called by Tron in Stage 2: De-bloat
               Add any AppX uninstall commands to this list to target them for removal
Requirements:  1. Administrator access
               2. Windows 8 and up
Author:        vocatus on reddit.com/r/TronScript ( vocatus.gate at gmail ) // PGP key: 0x07d1490f82a211a2
Version:       1.4.2 ! Fix entries beginning with "*" never matching. Matching now uses -like only, so "*" is always a wildcard
                     ! Fix installed and provisioned packages being paired by list position. The two lists come from different sources and don't line
                       up, so provisioned packages were often skipped or passed a single character of a package name. Each list is now handled separately
                     ! Remove installed packages for all users (Windows 10 1803 and up) instead of only the user running the script. Falls back to the
                       current user if the all-users removal fails
                     * Remove packages one at a time, each in a separate PowerShell process with a timeout (default 180 seconds), instead of starting
                       every removal at once as background jobs with no timeout. A removal that doesn't finish in time is killed and logged as FAILED.
                       Background jobs aren't used because Stop-Job waits for a hung removal to finish instead of stopping it
                     * Skip all remaining removals after 3 timeouts (default), since a hung removal can hold up the AppX service and make every
                       following removal time out too. Caps the worst-case delay instead of stalling Tron
                     * Build the package lists in a separate process with a timeout too (default 360 seconds). If the lists can't be built, nothing is removed
                     * Log each package and whether its removal succeeded, failed (with the error) or was skipped, and print a summary at the end.
                       Multi-line error messages are joined onto one line. If a removal process ends without a result, its exit code and error output are logged
                     + Return exit code 0 if every removal succeeded, 1 if any removal failed, timed out or was skipped, or if the script couldn't run
                       (not admin, or app packages couldn't be listed)
                     + Stop early if not run as Administrator
                     * Skip a package if it was already attempted, so overlapping list entries don't cause a second removal attempt and a false FAILED result
                     * After all removals, re-check any that failed. A package that's no longer present (e.g. a staged copy that Windows cleaned up after
                       its provisioned package was removed) is logged and counted as removed, so the exit code reflects what's actually left on the system
                     ! Fix counter variable mismatch ($AppxCount3rd initialized, $AppxCountMS incremented)
                     - Remove Windows components (BioEnrollment, CBSPreview, WindowsAppRuntime.CBS) from the target list. Moved to the inactive list
                     - Remove apps from the list that are only present if the user explicitly installed them. Move to the inactive list
                     / Fix incorrect comment on Microsoft.MicrosoftMahjong
               1.4.1 + Add additional user-submitted entries
#>
$ErrorActionPreference = "SilentlyContinue"
$ProgressPreference = "SilentlyContinue"


########
# PREP #
########
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_VERSION = "1.4.2"
$METRO_MICROSOFT_MODERN_APPS_TO_TARGET_BY_NAME_SCRIPT_DATE = "2026-10-30"

# Seconds to wait for a single package removal before killing it and moving on
$TIMEOUT_SECONDS = 180
# Seconds to wait for the installed and provisioned package lists to be built
$LIST_TIMEOUT_SECONDS = 360
# After this many timed out removals, skip the rest. A hung removal can hold up the AppX service so every following removal also times out
$MAX_TIMEOUTS = 3

# Each removal runs in its own Windows PowerShell process so it can be killed if it hangs (Stop-Job waits for a hung removal instead of stopping it)
$PowerShellExe = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

# Must be run as Administrator, otherwise provisioned packages can't be removed
If (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Write-Output "   ERROR: Not running as Administrator. No apps removed."
	exit 1
}

# Runs a script block in a separate PowerShell process and returns its output lines
# If it doesn't finish within $Seconds the process is killed, and $Script:IsolatedTimedOut is set to $true
$Script:IsolatedCount = 0
Function Invoke-Isolated([ScriptBlock]$Code, [String]$Arguments, [Int]$Seconds){
	$Script:IsolatedTimedOut = $false
	$Script:IsolatedExitCode = ''
	$Script:IsolatedError = ''
	$Script:IsolatedCount++
	$OutFile = Join-Path $env:TEMP ("tron_appx_" + $PID + "_" + $Script:IsolatedCount + "_out.txt")
	$ErrFile = Join-Path $env:TEMP ("tron_appx_" + $PID + "_" + $Script:IsolatedCount + "_err.txt")
	$Encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes('& {' + $Code.ToString() + '} ' + $Arguments))
	Try {
		$Process = Start-Process -FilePath $PowerShellExe -ArgumentList "-NoProfile -NonInteractive -ExecutionPolicy Bypass -EncodedCommand $Encoded" -RedirectStandardOutput $OutFile -RedirectStandardError $ErrFile -NoNewWindow -PassThru -ErrorAction Stop
	} Catch {
		$Script:IsolatedError = "unable to start PowerShell process: " + $_.Exception.Message
		return @()
	}
	# Cache the process handle, otherwise ExitCode can come back empty when using -PassThru
	$null = $Process.Handle
	If (-not $Process.WaitForExit($Seconds * 1000)) {
		$Script:IsolatedTimedOut = $true
		Try { $Process.Kill() } Catch { }
		[void]$Process.WaitForExit(10000)
	} Else {
		$Script:IsolatedExitCode = [String]$Process.ExitCode
	}
	$Output = @(Get-Content -Path $OutFile)
	# Keep any error output on a single line for the log. Errors may be written as CLIXML, in which case only the error text is kept
	$ErrText = [String]::Join(' ', @(Get-Content -Path $ErrFile))
	If ($ErrText -like '#< CLIXML*') {
		$ErrText = [String]::Join(' ', @([regex]::Matches($ErrText, '<S S="Error">(.*?)</S>') | ForEach-Object { $_.Groups[1].Value })) -replace '_x000D_|_x000A_', ' '
	}
	$ErrText = ($ErrText -replace '\s+', ' ').Trim()
	If ($ErrText.Length -gt 500) { $ErrText = $ErrText.Substring(0, 500) + '...' }
	$Script:IsolatedError = $ErrText
	Remove-Item -Path $OutFile, $ErrFile -Force
	return $Output
}

# Build the package lists once, in a separate process so a hung AppX or DISM query can't stall the script. Last line must be END
$ListCode = {
	$ErrorActionPreference = "Stop"
	$ProgressPreference = "SilentlyContinue"
	Try {
		Get-AppxPackage -AllUsers | ForEach-Object { 'I|' + $_.Name + '|' + $_.PackageFullName }
		Get-AppxProvisionedPackage -Online | ForEach-Object { 'P|' + $_.DisplayName + '|' + $_.PackageName }
		'END'
	} Catch {
		'ERROR|' + ($_.Exception.Message -replace '\s*[\r\n]+\s*', ' ')
	}
}
$ListOutput = @(Invoke-Isolated $ListCode '' $LIST_TIMEOUT_SECONDS)
If ($Script:IsolatedTimedOut -or ($ListOutput.Count -eq 0) -or ($ListOutput[-1] -ne 'END')) {
	If ($Script:IsolatedTimedOut) { $Reason = "timed out after $LIST_TIMEOUT_SECONDS seconds" }
	ElseIf ($ListOutput.Count -eq 0) { $Reason = "no output, exit code " + $Script:IsolatedExitCode + " " + $Script:IsolatedError }
	Else { $Reason = $ListOutput[-1] }
	Write-Output "   ERROR: Unable to list app packages ($Reason). No apps removed."
	exit 1
}
$InstalledPackages = @()
$ProvisionedPackages = @()
ForEach ($Line in $ListOutput) {
	$Fields = $Line.Split('|')
	If ($Fields.Count -ne 3) { continue }
	If ($Fields[0] -eq 'I') { $InstalledPackages += New-Object PSObject -Property @{ Name = $Fields[1]; PackageFullName = $Fields[2] } }
	If ($Fields[0] -eq 'P') { $ProvisionedPackages += New-Object PSObject -Property @{ DisplayName = $Fields[1]; PackageName = $Fields[2] } }
}

# Remove-AppxPackage only has -AllUsers on Windows 10 1803 and up. Check for the parameter rather than the build number
If ((Get-Command Remove-AppxPackage).Parameters.ContainsKey('AllUsers')) { $RemoveForAllUsers = '$true' } Else { $RemoveForAllUsers = '$false' }
$Script:AppxCount = 0
$Script:AppxFailCount = 0
$Script:AppxSkipCount = 0
$Script:TimeoutCount = 0
$Script:AttemptedPackages = @{}
$Script:FailedPackages = @()
$Script:AppxRecheckCount = 0

# Removes one package. Runs in a separate process. Outputs a single line "RESULT|OK..." or "RESULT|FAILED: ..."
# The RESULT| marker lets the result be found even if something else writes to the output. Error messages often span several lines, so they're joined into one
$RemovalCode = {
	param($Type, $Package, $AllUsers)
	$ErrorActionPreference = "Stop"
	$ProgressPreference = "SilentlyContinue"
	Function Out-Result([String]$Text) { 'RESULT|' + ($Text -replace '\s*[\r\n]+\s*', ' ').Trim() }
	Try {
		If ($Type -eq 'Provisioned') {
			Remove-AppxProvisionedPackage -Online -PackageName $Package | Out-Null
			Out-Result 'OK'
		} ElseIf ($AllUsers) {
			Try {
				Remove-AppxPackage -Package $Package -AllUsers
				Out-Result 'OK'
			} Catch {
				$AllUsersError = $_.Exception.Message
				Try {
					Remove-AppxPackage -Package $Package
					Out-Result ('OK (current user only. All-users removal failed: ' + $AllUsersError + ')')
				} Catch {
					Out-Result ('FAILED: ' + $_.Exception.Message + ' (All-users removal: ' + $AllUsersError + ')')
				}
			}
		} Else {
			Remove-AppxPackage -Package $Package
			Out-Result 'OK'
		}
	} Catch {
		Out-Result ('FAILED: ' + $_.Exception.Message)
	}
}

# Remove one package and log the result
Function Invoke-Removal([String]$Type, [String]$Package){
	# Skip a package that was already attempted, e.g. when two list entries (or an entry and a wildcard) match the same package
	$Key = $Type + '|' + $Package
	If ($Script:AttemptedPackages.ContainsKey($Key)) { return }
	$Script:AttemptedPackages[$Key] = $true
	$Script:AppxCount++
	If ($Script:TimeoutCount -ge $MAX_TIMEOUTS) {
		$Script:AppxSkipCount++
		Write-Output "   $Script:AppxCount - [$Type] $Package - SKIPPED: $MAX_TIMEOUTS removals already timed out"
		return
	}
	$Arguments = "'" + $Type + "' '" + $Package.Replace("'", "''") + "' " + $RemoveForAllUsers
	$Output = Invoke-Isolated $RemovalCode $Arguments $TIMEOUT_SECONDS
	If ($Script:IsolatedTimedOut) {
		$Script:TimeoutCount++
		$Result = "FAILED: timed out after $TIMEOUT_SECONDS seconds, process killed"
	} Else {
		$ResultLine = [String]($Output | Where-Object { $_ -like 'RESULT|*' } | Select-Object -Last 1)
		If ($ResultLine) {
			$Result = $ResultLine.Substring(7)
		} Else {
			# The process ended without reporting a result (crashed, or failed to start). Log what it left behind
			$Result = 'FAILED: no result returned, exit code ' + $Script:IsolatedExitCode
			If ($Script:IsolatedError) { $Result += '. Error output: ' + $Script:IsolatedError }
			$Stray = ([String]::Join(' ', $Output) -replace '\s+', ' ').Trim()
			If ($Stray) { $Result += '. Other output: ' + $Stray }
		}
	}
	If ($Result -notlike 'OK*') {
		$Script:AppxFailCount++
		$Script:FailedPackages += $Key
	}
	Write-Output "   $Script:AppxCount - [$Type] $Package - $Result"
}

# App Removal function. $AppName is matched with -like: exact name (case-insensitive) unless it contains a * wildcard
# Installed and provisioned packages are matched separately, since one can exist without the other
Function Remove-App([String]$AppName){
	ForEach ($Package in @($InstalledPackages | Where-Object { $_.Name -like $AppName } | Select-Object -ExpandProperty PackageFullName -Unique)) {
		Invoke-Removal 'Installed' $Package
	}
	ForEach ($Package in @($ProvisionedPackages | Where-Object { $_.DisplayName -like $AppName } | Select-Object -ExpandProperty PackageName -Unique)) {
		Invoke-Removal 'Provisioned' $Package
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
Remove-App "Microsoft.BingWeather"                     # Weather app
Remove-App "Microsoft.CommsPhone"                      # Phone app
Remove-App "Microsoft.ConnectivityStore"
Remove-App "Microsoft.DiagnosticDataViewer"
Remove-App "Microsoft.Edge.GameAssist"
Remove-App "Microsoft.ForzaHorizon3Demo"
Remove-App "Microsoft.ForzaMotorsport7Demo"
Remove-App "Microsoft.FrenchRiviera"
Remove-App "Microsoft.FreshPaint"                      # Canvas app
Remove-App "Microsoft.GamingApp"
Remove-App "Microsoft.GetHelp"                         # Get Help link
Remove-App "Microsoft.Getstarted"                      # Get Started link
Remove-App "Microsoft.HelpAndTips"
Remove-App "Microsoft.HoganThreshold"
Remove-App "Microsoft.Lucille"                         # "Browser Choice" screen required by the EU antitrust regulation
Remove-App "Microsoft.M365Companions"
Remove-App "Microsoft.Messaging"                       # Messaging app
Remove-App "Microsoft.Microsoft3DViewer"               # 3D model viewer
Remove-App "Microsoft.MicrosoftJackpot"                # Jackpot app
Remove-App "Microsoft.MicrosoftJigsaw"                 # Jigsaw app
Remove-App "Microsoft.MicrosoftJournal"
Remove-App "Microsoft.MicrosoftMahjong"                # Mahjong game
Remove-App "Microsoft.MicrosoftOfficeHub"
Remove-App "Microsoft.MicrosoftRewards"
Remove-App "Microsoft.MicrosoftSudoku"
Remove-App "Microsoft.MicrosoftTreasureHunt"
Remove-App "Microsoft.MinecraftUWP"
Remove-App "Microsoft.MovieMoments"                    # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.NetworkSpeedTest"
Remove-App "Microsoft.Office.OneNote"                  # Onenote app
Remove-App "Microsoft.Office.Sway"                     # Sway app
Remove-App "Microsoft.OneConnect"                      # OneConnect app
Remove-App "Microsoft.People"                          # People app
Remove-App "Microsoft.SeaofThieves"
Remove-App "Microsoft.SkypeApp"                        # Get Skype link
Remove-App "Microsoft.SkypeWiFi"
Remove-App "Microsoft.Studios.Wordament"               # imported from stage_2_de-bloat.bat
Remove-App "Microsoft.SurfaceDiagnostics"              # added 2021-06-02
Remove-App "Microsoft.Windows.DevHome"
Remove-App "Microsoft.Windows.FeatureOnDemand.InsiderHub"
Remove-App "Microsoft.WindowsFeedbackHub"              # Feedback app
Remove-App "Microsoft.WindowsReadingList"
Remove-App "Microsoft.WorldNationalParks"
Remove-App "MicrosoftCorporationII.QuickAssist"
Remove-App "Windows.ContactSupport"


# Inactive identifers
# Windows components and frameworks
#Remove-App "Microsoft.BioEnrollment"
#Remove-App "Windows.CBSPreview"
#Remove-App "Microsoft.WindowsAppRuntime.CBS"

# Other
#Remove-App "Microsoft.Appconnector"                   # Not sure about this one
#Remove-App "Microsoft.MSPaint"                        # MS Paint (Paint 3D)
#Remove-App "Microsoft.MicrosoftSolitaireCollection"   # Solitaire collection
#Remove-App "Microsoft.MicrosoftStickyNotes"           # Pulled from active list due to user requests
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
# Re-check failed removals. A removal can fail and the package still end up gone, e.g. a staged copy that Windows cleans up once its provisioned
# package is removed. Skipped if removals already hit the timeout limit, since the AppX service is probably hung and the list would likely time out too
If ($Script:FailedPackages.Count -gt 0) {
	If ($Script:TimeoutCount -ge $MAX_TIMEOUTS) {
		Write-Output "   Recheck: skipped, $MAX_TIMEOUTS removals timed out and the AppX service may be hung."
	} Else {
		$RecheckOutput = @(Invoke-Isolated $ListCode '' $LIST_TIMEOUT_SECONDS)
		If ($Script:IsolatedTimedOut -or ($RecheckOutput.Count -eq 0) -or ($RecheckOutput[-1] -ne 'END')) {
			Write-Output "   Recheck: unable to list app packages, failed removals were not rechecked."
		} Else {
			$Remaining = @{}
			ForEach ($Line in $RecheckOutput) {
				$Fields = $Line.Split('|')
				If ($Fields.Count -ne 3) { continue }
				If ($Fields[0] -eq 'I') { $Remaining['Installed|' + $Fields[2]] = $true }
				If ($Fields[0] -eq 'P') { $Remaining['Provisioned|' + $Fields[2]] = $true }
			}
			ForEach ($Key in $Script:FailedPackages) {
				If (-not $Remaining.ContainsKey($Key)) {
					$Script:AppxFailCount--
					$Script:AppxRecheckCount++
					$Fields = $Key.Split('|')
					Write-Output "   Recheck: [$($Fields[0])] $($Fields[1]) - no longer present, counted as removed"
				}
			}
		}
	}
}
# Exit code: 0 = every removal succeeded (or nothing matched), 1 = at least one removal failed, timed out or was skipped
If ($Script:AppxSkipCount -gt 0) { Write-Output "   WARNING: $Script:AppxSkipCount removal(s) skipped after $MAX_TIMEOUTS timeouts. The AppX service may be hung. A reboot may be required before they can be removed." }
Write-Output "   Done. $Script:AppxCount package removal(s) matched (installed and provisioned counted separately), $Script:AppxFailCount failed or timed out, $Script:AppxSkipCount skipped, $Script:AppxRecheckCount failed but no longer present."
If (($Script:AppxFailCount + $Script:AppxSkipCount) -gt 0) { exit 1 } Else { exit 0 }
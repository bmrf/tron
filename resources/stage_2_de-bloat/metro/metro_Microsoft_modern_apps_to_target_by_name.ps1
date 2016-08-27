# Script to remove a lot of the pre-loaded Microsoft Metro "modern app" bloatware
# Initial creation by Garacesh at:  http://www.edugeek.net/forums/windows-10/161433-windows-10-removal-off-preinstalled-apps-bulk-sans-store.html#post1398039
# Modified for use with the Tron project by /u/vocatus on reddit.com/r/TronScript
$ErrorActionPreference = "SilentlyContinue"

# Active identifiers
$PackagesToRemove = (
	'9E2F88E3.Twitter',                       # Twitter app
	'D52A8D61.FarmVille2CountryEscape',
	'GAMELOFTSA.Asphalt8Airborne',
	'Microsoft.3DBuilder',                    # '3DBuilder' app
	'Microsoft.BingFinance',                  # 'Money' app - Financial news
	'Microsoft.BingFoodAndDrink',             # 'Food and Drink' app
	'Microsoft.BingHealthAndFitness',         # 'Health and Fitness' app
	'Microsoft.BingNews',                     # 'Generic news' app
	'Microsoft.BingSports',                   # 'Sports' app - Sports news
	'Microsoft.BingTranslator',               # 'Translator' app - Bing Translate
	'Microsoft.BingTravel',                   # 'Travel' app
	'Microsoft.CommsPhone',                   # 'Phone' app
	'Microsoft.ConnectivityStore',
	'Microsoft.FreshPaint',                   # 'Canvas' app
	'Microsoft.Getstarted',                   # 'Get Started' link
	'Microsoft.Messaging',                    # 'Messaging' app
	'Microsoft.MicrosoftJackpot',             # 'Jackpot' app
	'Microsoft.MicrosoftJigsaw',
	'Microsoft.MicrosoftOfficeHub',
	'Microsoft.MicrosoftSudoku',
	'Microsoft.MovieMoments',                 # imported from stage_2_de-bloat.bat
	'Microsoft.Office.OneNote',               # 'Onenote' app
	'Microsoft.Office.Sway',                  # 'Sway' app
	'Microsoft.People',                       # 'People' app
	'Microsoft.SkypeApp',                     # 'Get Skype' link
	'Microsoft.SkypeWiFi',
	'Microsoft.Studios.Wordament',            # imported from stage_2_de-bloat.bat
	'Microsoft.Taptiles',                     # imported from stage_2_de-bloat.bat
	'Microsoft.Windows.CloudExperienceHost',  # 'Cloud Experience' sigh
	'Microsoft.WindowsFeedback',              # 'Feedback' functionality
	'Microsoft.WindowsPhone',                 # 'Phone Companion' app
	'Microsoft.XboxApp',                      # Xbox junk, unfortunately 'Microsoft.XboxGameCallableUI' and 'Microsoft.XboxIdentityProvider' can't be removed
	'Microsoft.ZuneMusic',                    # 'Groove Music' app
	'Microsoft.ZuneVideo',                    # Groove Music
	'MicrosoftMahjong',                       # 'Mahjong' game
	'Windows.ContactSupport',
	'king.com.CandyCrushSodaSaga',            # Candy Crush app
	'microsoft.windowscommunicationsapps'     # 'Calendar and Mail' app
)
			
# Inactive identifers
	# 'Microsoft.Appconnector',					# Not sure about this one
	# 'Microsoft.BingWeather',                  # 'Weather' app
	# 'Microsoft.BioEnrollment',				# not sure about this one
	# 'Microsoft.MicrosoftSolitaireCollection',	# Solitaire collection
	# 'Microsoft.Windows.Photos',				# Photos app
	# 'Microsoft.WindowsAlarms',                # 'Alarms and Clock' app
	# 'Microsoft.WindowsCalculator',			# Calculator app
	# 'Microsoft.WindowsCamera',				# Camera app
	# 'Microsoft.WindowsMaps',					# Maps app
	# 'Microsoft.WindowsSoundRecorder',			# Sound Recorder app
	# 'Microsoft.WindowsStore',					# Windows Store
	

	
# Do the removal
Get-AppxProvisionedPackage -Online | Where-Object Name -In $PackagesToRemove | Remove-AppxProvisionedPackage -Online | Out-Null
Get-AppxPackage –AllUsers | Where-Object Name -In $PackagesToRemove | Remove-AppxPackage | Out-Null

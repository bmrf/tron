###############################
# Windows 8/10 Metro App Removals
# These start commented out so you choose
# Just remove the # (comment in PowerShell) on the apps you want to remove
###############################

# Candy Crush
Get-AppxPackage king.com.CandyCrushSaga |* Remove-AppxPackage
Get-AppxPackage king.com.CandyCrushSaga |* Remove-AppxProvisionedPackage
# Bing
Get-AppxPackage Microsoft.BingWeather* | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather* | Remove-AppxProvisionedPackage
Get-AppxPackage Microsoft.BingNews* | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews* | Remove-AppxProvisionedPackage
Get-AppxPackage Microsoft.BingSports* | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports* | Remove-AppxProvisionedPackage
Get-AppxPackage Microsoft.BingFinance* | Remove-AppxPackage
Get-AppxPackage Microsoft.BingFinance* | Remove-AppxProvisionedPackage
# Content Delivery Manager
#Get-AppxPackage Microsoft.Windows.CloudExperienceHost* | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.CloudExperienceHost* | Remove-AppxProvisionedPackage
# Content Delivery Manager
#Get-AppxPackage Microsoft.Windows.ContentDeliveryManager* | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.ContentDeliveryManager* | Remove-AppxProvisionedPackage
# Cortana (This app can’t be removed.)
#Get-AppxPackage Microsoft.Windows.Cortana* | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.Cortana* | Remove-AppxProvisionedPackage
# No clue
#Get-AppxPackage Microsoft.AAD.BrokerPlugin* | Remove-AppxPackage
#Get-AppxPackage Microsoft.AAD.BrokerPlugin* | Remove-AppxProvisionedPackage
# Microsoft Edge (This app can’t be removed.)
#Get-AppxPackage Microsoft.MicrosoftEdge* | Remove-AppxPackage
#Get-AppxPackage Microsoft.MicrosoftEdge* | Remove-AppxProvisionedPackage
# Xbox
Get-AppxPackage Microsoft.XboxApp* | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxApp* | Remove-AppxProvisionedPackage
Get-AppxPackage Microsoft.XboxIdentityProvider* | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxIdentityProvider* | Remove-AppxProvisionedPackage
Get-AppxPackage Microsoft.XboxGameCallableUI* | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxGameCallableUI* | Remove-AppxProvisionedPackage
# Windows Maps
Get-AppxPackage Microsoft.WindowsMaps* | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsMaps* | Remove-AppxProvisionedPackage
# Windows Phone Companion
Get-AppxPackage Microsoft.WindowsPhone* | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsPhone* | Remove-AppxProvisionedPackage
# Solitaire Collection
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection* | Remove-AppxProvisionedPackage
# People
#Get-AppxPackage Microsoft.People* | Remove-AppxPackage
#Get-AppxPackage Microsoft.People* | Remove-AppxProvisionedPackage
# Groove Music
Get-AppxPackage Microsoft.ZuneMusic* | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneMusic* | Remove-AppxProvisionedPackage
# Movies & TV
Get-AppxPackage Microsoft.ZuneVideo* | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo* | Remove-AppxProvisionedPackage
# OneNote
Get-AppxPackage Microsoft.Office.OneNote* | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.OneNote* | Remove-AppxProvisionedPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub* | Remove-AppxProvisionedPackage
# Photos
#Get-AppxPackage Microsoft.Windows.Photos* | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.Photos* | Remove-AppxProvisionedPackage
# Sound Recorder
#Get-AppxPackage Microsoft.WindowsSoundRecorder* | Remove-AppxPackage
#Get-AppxPackage Microsoft.WindowsSoundRecorder* | Remove-AppxProvisionedPackage
# Mail & Calendar
#Get-AppxPackage microsoft.windowscommunicationsapps* | Remove-AppxPackage
#Get-AppxPackage microsoft.windowscommunicationsapps* | Remove-AppxProvisionedPackage
# Parental Controls
Get-AppxPackage Microsoft.Windows.ParentalControls* | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.ParentalControls* | Remove-AppxProvisionedPackage
# Skype (Metro version)
Get-AppxPackage Microsoft.SkypeApp* | Remove-AppxPackage
Get-AppxPackage Microsoft.SkypeApp* | Remove-AppxProvisionedPackage
# Contact Support (This app can’t be removed.)
#Get-AppxPackage Microsoft.ContactSupport* | Remove-AppxPackage
#Get-AppxPackage Microsoft.ContactSupport* | Remove-AppxProvisionedPackage
# Feedback (This app can’t be removed.)
#Get-AppxPackage Microsoft.WindowsFeedback* | Remove-AppxPackage
#Get-AppxPackage Microsoft.WindowsFeedback* | Remove-AppxProvisionedPackage
# Get Started
Get-AppxPackage Microsoft.GetStarted* | Remove-AppxPackage
Get-AppxPackage Microsoft.GetStarted* | Remove-AppxProvisionedPackage
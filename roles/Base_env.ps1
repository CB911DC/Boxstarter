# A BoxStarter script for use with http://boxstarter.org/WebLauncher
# Updates a Windows machine and installs a range of software

#---- TEMPORARY ---
Disable-UAC

# Show more info for files in Explorer
Set-WindowsExplorerOptions -EnableShowProtectedOSFiles  -EnableShowFileExtensions -EnableShowFullPathInTitleBar

# Enable remote desktop
Enable-RemoteDesktop

# Small taskbar
Set-TaskbarOptions -Size Small -Combine Always

# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

# Allow unattended reboots
$Boxstarter.RebootOk=$true
$Boxstarter.NoPassword=$false
$Boxstarter.AutoLogin=$true

# Update Windows and reboot if necessary
Install-WindowsUpdate -AcceptEula
if (Test-PendingReboot) { Invoke-Reboot }

# Baseline install for CB911
#---------------------------------------------------
# Flash
cinst flashplayerplugin 
cinst flashplayeractivex
if (Test-PendingReboot) { Invoke-Reboot } 

# Java
cinst jre8 
cinst javaruntime 
cinst jdk8
if (Test-PendingReboot) { Invoke-Reboot }

# Browsers 
cinst googlechrome 
cinst firefox
if (Test-PendingReboot) { Invoke-Reboot }

# Media Tools
cinst adobereader
cinst vlc
if (Test-PendingReboot) { Invoke-Reboot }

# Compression Tools 
cinst 7zip 
if (Test-PendingReboot) { Invoke-Reboot }

# IT Tools
cinst sysinternals 
cinst powershell
if (Test-PendingReboot) { Invoke-Reboot }

# MS Libraries 
cinst vcredist2005 
cinst vcredist2008 
cinst vcredist2010 
cinst vcredist2012 
cinst vcredist2013 
cinst vcredist2015 
cinst vcredist2017
if (Test-PendingReboot) { Invoke-Reboot }

# Dev Tools
#-----Uncomment this section for Dev Tools ---------------
#cinst Git
#if (Test-PendingReboot) { Invoke-Reboot }
#cinst Microsoft-Hyper-V-All -source windowsFeatures
#if (Test-PendingReboot) { Invoke-Reboot }
#cinst Microsoft-Windows-Subsystem-Linux -source windowsfeatures
#if (Test-PendingReboot) { Invoke-Reboot }
#cinst docker-for-windows
#if (Test-PendingReboot) { Invoke-Reboot }
#cinst vscode
#if (Test-PendingReboot) { Invoke-Reboot }

#--- Uninstall unecessary applications that come with Windows out of the box ---

# 3D Builder
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage

# Alarms
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage

# Autodesk
Get-AppxPackage *Autodesk* | Remove-AppxPackage

# Bing Weather, News, Sports, and Finance (Money):
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

# BubbleWitch
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage

# Candy Crush
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage

# Comms Phone
Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage

# Dell
Get-AppxPackage *Dell* | Remove-AppxPackage

# Dropbox
Get-AppxPackage *Dropbox* | Remove-AppxPackage

# Facebook
Get-AppxPackage *Facebook* | Remove-AppxPackage

# Feedback Hub
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage

# Get Started
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage

# Keeper
Get-AppxPackage *Keeper* | Remove-AppxPackage

# Mail & Calendar
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage

# Maps
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage

# March of Empires
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage

# McAfee Security
Get-AppxPackage *McAfee* | Remove-AppxPackage

# Uninstall McAfee Security App
$mcafee = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "McAfee Security" } | select UninstallString
if ($mcafee) {
	$mcafee = $mcafee.UninstallString -Replace "C:\Program Files\McAfee\MSC\mcuihost.exe",""
	Write "Uninstalling McAfee..."
	start-process "C:\Program Files\McAfee\MSC\mcuihost.exe" -arg "$mcafee" -Wait
}

# Messaging
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage

# Minecraft
Get-AppxPackage *Minecraft* | Remove-AppxPackage

# Netflix
Get-AppxPackage *Netflix* | Remove-AppxPackage

# Office Hub
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage

# One Connect
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage

# OneNote
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage

# People
Get-AppxPackage Microsoft.People | Remove-AppxPackage

# Phone
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage

# Photos
Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage

# Plex
Get-AppxPackage *Plex* | Remove-AppxPackage

# Skype (Metro version)
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage

# Sound Recorder
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage

# Solitaire
Get-AppxPackage *Solitaire* | Remove-AppxPackage

# Sticky Notes
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage

# Sway
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage

# Twitter
Get-AppxPackage *Twitter* | Remove-AppxPackage

# Xbox
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage

# Zune Music, Movies & TV
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage

# Configure windows Hyper-V virtualization
#cinst Microsoft-Hyper-V-All -source windowsFeatures
#if (Test-PendingReboot) { Invoke-Reboot }

# Cleanup
del C:\eula*.txt
del C:\install.*
del C:\vcredist.*
del C:\vc_red.*

#--- Restore Temporary Settings ---
Enable-UAC
Enable-MicrosoftUpdate
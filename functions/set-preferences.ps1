Write-Host "Setting system preferences..." -ForegroundColor Yellow

# Show file extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
-Name "HideFileExt" -Value 0
Write-Host "File extensions will now be shown."

# Show hidden files
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
-Name "Hidden" -Value 1
Write-Host "Hidden files will now be shown."

# Set dark mode
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
-Name "AppsUseLightTheme" -Value 0 -PropertyType DWord -Force
Write-Host "Dark mode has been set for apps."

# Set taskbar to show small icons
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
-Name "TaskbarSmallIcons" -Value 1
Write-Host "Taskbar set to use small icons."

# Show This PC on desktop for future troubleshooting
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" `
-Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -PropertyType DWord -Force
Write-Host "This PC icon will be shown on the desktop."

# Disable Windows tips
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
-Name "SoftLandingEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
-Name "SubscribedContent-310093Enabled" -Value 0
Write-Host "Windows tips have been disabled."

Write-Host "System preferences applied! Still don't touch anything." -ForegroundColor Green
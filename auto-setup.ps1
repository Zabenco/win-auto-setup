# Create logs folder if it doesn't exist. Will be in the same directory as this script.
$logPath = "c:\Temp\logs"
if (!(Test-Path -Path $logPath)) {
    New-Item -ItemType Directory -Path $logPath
}

# Start logging
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$logFile = "$logPath\setup-log-$timestamp.txt"
Start-Transcript -Path $logFile

Write-Host "Hello, starting the auto-setup..." -ForegroundColor Cyan

# Installing Software
Write-Host "Installing software..." -ForegroundColor Yellow

winget install --id=Google.Chrome -e --silent
Write-Host "Google Chrome installed!" -ForegroundColor Green

winget install --id=Notepad++.Notepad++ -e --silent
Write-Host "Notepad++ installed!" -ForegroundColor Green

winget install --id=7zip.7zip -e --silent
Write-Host "7zip installed!" -ForegroundColor Green

winget install --id=Adobe.Acrobat.Reader.64-bit -e --silent
Write-Host "Adobe Acrobat installed!" -ForegroundColor Green

winget install --id=Zoom.Zoom -e --silent
Write-Host "Zoom installed!" -ForegroundColor Green

winget install --id=Microsoft.Office -e
Write-Host "If prompted, please complete the Microsoft Office installation manually." -ForegroundColor Yellow
Write-Host "Microsoft Office installed!" -ForegroundColor Green

winget install --id=Microsoft.Teams -e --silent
Write-Host "Microsoft Teams installed!" -ForegroundColor Green

Write-Host "Software installation complete! Don't touch anything yet." -ForegroundColor Green

#Configure Network
Write-Host "Would you like to configure network settings for this comptuer? (Y/N)" -ForegroundColor Cyan
$response = Read-Host

if ($response -ne 'Y' -and $response -ne 'y') {
    Write-Host "Skipping network configuration." -ForegroundColor Yellow
} else {
    # List available adapters
    Write-Host "`nGet's Get Started" -ForegroundColor Green
    Write-Host "`nAvailable network adapters:" -ForegroundColor Gray
    $adapters = Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}
    $adapters | ForEach-Object { Write-Host "$($_.InterfaceIndex): $($_.Name)" }

    # Prompt for adapter selection
    $adapterIndex = Read-Host "`nEnter the InterfaceIndex of the adapter to configure (Numbers only, e.g., 1, 2, etc.)"

    # Get the adapter name based on index
    $adapter = Get-NetAdapter | Where-Object { $_.InterfaceIndex -eq $adapterIndex }

    if (-not $adapter) {
        Write-Host "Invalid adapter selected. Skipping network config. Just configure it once the auto-setup is done." -ForegroundColor Red
        return
    }

    # Prompt for IP settings
    $ip = Read-Host "Enter static IP address (e.g., 192.168.1.100)"
    $subnet = Read-Host "Enter subnet prefix length (e.g., 24 for 255.255.255.0)"
    $gateway = Read-Host "Enter default gateway (e.g., 192.168.1.1)"
    $dns1 = Read-Host "Enter preferred DNS server"
    $dns2 = Read-Host "Enter alternate DNS server (optional)"

    # Apply static IP
    Try {
        New-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex `
                         -IPAddress $ip `
                         -PrefixLength $subnet `
                         -DefaultGateway $gateway `
                         -ErrorAction Stop
        Write-Host "IP address configured." -ForegroundColor Green
    }
    Catch {
        Write-Host "Failed to set IP address: $_" -ForegroundColor Red
    }

    # Set DNS
    Try {
        Set-DnsClientServerAddress -InterfaceIndex $adapter.InterfaceIndex `
                                   -ServerAddresses $dns1, $dns2 `
                                   -ErrorAction Stop
        Write-Host "DNS settings applied." -ForegroundColor Green
    }
    Catch {
        Write-Host "Failed to set DNS: $_" -ForegroundColor Red
    }

    Write-Host "`nNetwork configuration complete. Don't touch anything else yet, you're almost done." -ForegroundColor Cyan
}




# Set System Preferences
Write-Host "Setting system preferences..." -ForegroundColor Yellow

# Show file extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
-Name "HideFileExt" -Value 0
Write-Host "File extensions will now be shown."

# Show hidden files
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
-Name "Hidden" -Value 1
Write-Host "Hidden files will now be shown."

# Set dark mode for apps and system (taskbar, Start menu, Windows apps)
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
-Name "AppsUseLightTheme" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
-Name "SystemUsesLightTheme" -Value 0 -PropertyType DWord -Force
Write-Host "Dark mode has been set for apps, taskbar, Start menu, and system UI." -ForegroundColor Green

# Set taskbar to show small icons
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
-Name "TaskbarSmallIcons" -Value 1
Write-Host "Taskbar set to use small icons."

# Disable Windows tips
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
-Name "SoftLandingEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" `
-Name "SubscribedContent-310093Enabled" -Value 0
Write-Host "Windows tips have been disabled."

Write-Host "System preferences applied! Still don't touch anything." -ForegroundColor Green

Stop-Transcript

Write-Host "Setup complete. Log saved to $logFile. You may touch the computer." -ForegroundColor Green
Pause

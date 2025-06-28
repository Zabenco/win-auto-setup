# Create logs folder if it doesn't exist for some reason, entire thing crashes if it doesn't have it and i dont take chances
$logPath = ".\logs"
if (!(Test-Path -Path $logPath)) {
    New-Item -ItemType Directory -Path $logPath
}

# Start logging
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$logFile = "$logPath\setup-log-$timestamp.txt"
Start-Transcript -Path $logFile

Write-Host "Hello, starting the auto-setup..." -ForegroundColor Cyan

# Here are the scripts
. ".\functions\install-software.ps1"
. ".\functions\configure-network.ps1"
. ".\functions\set-preferences.ps1"

Stop-Transcript

Write-Host "Setup complete. Log saved to $logFile. You may touch the computer." -ForegroundColor Green
Pause

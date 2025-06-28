Write-Host "Would you like to configure network settings for this comptuer? (Y/N)" -ForegroundColor Cyan
$response = Read-Host

if ($response -ne 'Y' -and $response -ne 'y') {
    Write-Host "Skipping network configuration." -ForegroundColor Yellow
    return
}

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

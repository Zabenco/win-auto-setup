Write-Host "Installing software..." -ForegroundColor Yellow

winget install --id=Google.Chrome -e --silent

winget install --id=Notepad++.Notepad++ -e --silent

winget install --id=7zip.7zip -e --silent

winget install --id=Adobe.Acrobat.Reader.64-bit -e --silent

winget install --id=Zoom.Zoom -e --silent

winget install --id=Microsoft.Office -e --silent

winget install --id=Microsoft.Teams -e --silent

Write-Host "Software installation complete! Don't touch anything yet." -ForegroundColor Green

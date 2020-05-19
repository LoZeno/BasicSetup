Write-Host "Installing Chocolatey... " -ForegroundColor Yellow -NoNewline
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Write-Host "Done" -ForegroundColor Yellow

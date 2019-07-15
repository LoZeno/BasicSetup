Write-Host "Setting up a refreshenv function alias" -ForegroundColor Yellow
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
Invoke-Expression "refreshenv"

Write-Host "Installing software... " -ForegroundColor Yellow -NoNewline
choco install .\chocolatey\packages.config -y
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Upgrading Firefox for Developers... " -ForegroundColor Yellow -NoNewline
choco upgrade all -y
Write-Host "Done" -ForegroundColor Yellow

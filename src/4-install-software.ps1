Write-Host "Setting up a refreshenv function alias" -ForegroundColor Yellow
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
Invoke-Expression "refreshenv"

Write-Host "Installing software with chocolatey... " -ForegroundColor Yellow -NoNewline
choco install .\packages.config -y
Write-Host "Done" -ForegroundColor Yellow
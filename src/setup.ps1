Write-Host "Enabling virtualization and WSL... " -ForegroundColor Yellow -NoNewline
Invoke-Expression $PSScriptRoot\1-enable-windows-features.ps1
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Installing Chocolatey... " -ForegroundColor Yellow -NoNewline
Invoke-Expression $PSScriptRoot\2-install-chocolatey.ps1
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up a refreshenv function alias" -ForegroundColor Yellow
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
Invoke-Expression "refreshenv"

Write-Host "Installing software... " -ForegroundColor Yellow -NoNewline
Invoke-Expression $PSScriptRoot\3-install-software.ps1
Write-Host "Done" -ForegroundColor Yellow

Invoke-Expression "refreshenv"

Write-Host "Setting up powershell CORE modules and profile" -ForegroundColor Yellow -NoNewline
Start-Process pwsh.exe -Wait -Verb RunAs -Args "-noexit -executionpolicy bypass -command Set-Location \`"$PWD\`"; Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck"
Start-Process pwsh.exe -Wait -Args "-noexit -executionpolicy bypass -command Set-Location \`"$PWD\`"; $PSScriptRoot\4-setup-powershell.ps1;"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "setting up vscode plugins" -ForegroundColor Yellow
Invoke-Expression $PSScriptRoot\5-setup-vscode.ps1
Write-Host "Done" -ForegroundColor Yellow

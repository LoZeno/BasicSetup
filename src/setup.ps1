Write-Host "Performing Admin-level tasks... " -ForegroundColor Yellow -NoNewline
$args = "$PSScriptRoot\1-enable-windows-features.ps1; 
        $PSScriptRoot\2-install-chocolatey.ps1; 
        $PSScriptRoot\3-install-software.ps1;"
Start-Process powershell.exe -Wait -Verb RunAs -Args "-executionpolicy bypass -command Set-Location $PWD; $args;"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up a refreshenv function alias" -ForegroundColor Yellow
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
Invoke-Expression "refreshenv"

Write-Host "Setting up powershell CORE modules and profile" -ForegroundColor Yellow -NoNewline
Start-Process pwsh.exe -Wait -Verb RunAs -Args "-executionpolicy bypass -command Set-Location $PWD; Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck"
Start-Process pwsh.exe -Wait -Args "-executionpolicy bypass -command Set-Location $PWD; $PSScriptRoot\4-setup-powershell.ps1;"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up vscode plugins" -ForegroundColor Yellow
Invoke-Expression $PSScriptRoot\5-setup-vscode.ps1
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Copying wox theme... " -ForegroundColor Yellow -NoNewline
$woxAppFolder = Get-ChildItem $env:LOCALAPPDATA\Wox -Filter "app-*" | Select-Object -First 1
Copy-Item -Path .\wox\ZenoWhite.xaml -Destination $woxAppFolder.FullName\Themes
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Please reboot your machine."
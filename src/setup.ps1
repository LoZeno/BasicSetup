foreach ($item in Get-Content -Path .\resources\banner.txt) {
    Write-Host $item
}
$options = ("Y", "N", "y", "n")
Write-Host "Enter your Git setup details:" -ForegroundColor Yellow
$gitUser = Read-Host "Enter your Git user name: " 
$gitEmail = Read-Host  "Enter your Git email: "
while ($options -notcontains $gitGenerateSSH) {
    $gitGenerateSSH = Read-Host "Do you want to generate your SSH key? [Y]es/[N]o" 
}

Invoke-Expression $PSScriptRoot\1-parse-csv.ps1

Write-Host "Performing Admin-level tasks... " -ForegroundColor Yellow -NoNewline
$args = "$PSScriptRoot\2-enable-windows-features.ps1; 
        $PSScriptRoot\3-install-chocolatey.ps1; 
        $PSScriptRoot\4-install-software.ps1;"
Start-Process powershell.exe -Wait -Verb RunAs -Args "-executionpolicy bypass -command Set-Location $PWD; $args;"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up a refreshenv function alias" -ForegroundColor Yellow
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
Invoke-Expression "refreshenv"

Write-Host "Installing scoop... " -ForegroundColor Yellow
Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Installing software with scoop... " -ForegroundColor Yellow
Invoke-Expression $PSScriptRoot\5-install-scoop.ps1
Write-Host "Done" -ForegroundColor Yellow

Invoke-Expression "refreshenv"

Write-Host "Setting up powershell CORE modules and profile" -ForegroundColor Yellow -NoNewline
Start-Process pwsh.exe -Wait -Verb RunAs -Args "-executionpolicy bypass -command Set-Location $PWD; Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck"
Start-Process pwsh.exe -Wait -Args "-executionpolicy bypass -command Set-Location $PWD; $PSScriptRoot\6-setup-powershell.ps1;"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up vscode plugins" -ForegroundColor Yellow
Invoke-Expression $PSScriptRoot\7-setup-vscode.ps1
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up git" -ForegroundColor Yellow
Invoke-Expression "$PSScriptRoot\8-setup-git.ps1 '$gitUser' $gitEmail $gitGenerateSSH"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Please reboot your machine."
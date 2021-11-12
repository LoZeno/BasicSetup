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
while ($options -notcontains $installShovel) {
    $installShovel = Read-Host "Do you want to replace Scoop with Shovel? [Y]es/[N]o" 
}

Invoke-Expression $PSScriptRoot\1-parse-csv.ps1

if($null -eq (Get-Command "scoop" -ErrorAction SilentlyContinue)) {
    Write-Host "Installing scoop... " -ForegroundColor Yellow
    Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
    Write-Host "Done" -ForegroundColor Yellow

} else {
    Write-Host "Previous scoop installation detected" -ForegroundColor Yellow
}

Write-Host "Installing software with scoop... " -ForegroundColor Yellow
Invoke-Expression "$PSScriptRoot\2-install-scoop.ps1 $installShovel"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Performing Admin-level tasks... " -ForegroundColor Yellow -NoNewline
gsudo Set-ExecutionPolicy RemoteSigned
Unblock-File -Path $PSScriptRoot\3-enable-windows-features.ps1
Unblock-File -Path $PSScriptRoot\4-install-chocolatey.ps1
Unblock-File -Path $PSScriptRoot\5-install-software.ps1
Invoke-Expression "gsudo $PSScriptRoot\3-enable-windows-features.ps1; 
        gsudo $PSScriptRoot\4-install-chocolatey.ps1;
        gsudo $PSScriptRoot\5-install-software.ps1"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up a refreshenv function alias" -ForegroundColor Yellow
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
Invoke-Expression "refreshenv"

Write-Host "Setting up powershell CORE modules and profile" -ForegroundColor Yellow -NoNewline
Start-Process pwsh.exe -Wait -Args "-executionpolicy bypass -command Set-Location $PWD; Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck; $PSScriptRoot\6-setup-powershell.ps1"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up vscode plugins" -ForegroundColor Yellow
Invoke-Expression $PSScriptRoot\7-setup-vscode.ps1
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up git" -ForegroundColor Yellow
Invoke-Expression "$PSScriptRoot\8-setup-git.ps1 '$gitUser' $gitEmail $gitGenerateSSH"
Write-Host "Done" -ForegroundColor Yellow

# cleaning up

Remove-Item -Path "$PSScriptRoot\packages.config"
Remove-Item -Path "$PSScriptRoot\scoop.txt"
Remove-Item -Path "$PSScriptRoot\vscode.txt"

# scoop checkup
Write-Host "Checking up status of scoop..." -ForegroundColor White
Invoke-Expression "scoop checkup"

Write-Host "Please reboot your machine." - -ForegroundColor White
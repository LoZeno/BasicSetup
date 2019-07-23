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

while ($options -notcontains $installDotnet) {
    $installDotnet = Read-Host "Do you want to install the dotnet core development stack? [Y]es/[N]o" 
}

while ($options -notcontains $installJava) {
    $installJava = Read-Host "Do you want to install the java development stack? [Y]es/[N]o" 
}

Write-Host "Performing Admin-level tasks... " -ForegroundColor Yellow -NoNewline
$args = "$PSScriptRoot\1-enable-windows-features.ps1; 
        $PSScriptRoot\2-install-chocolatey.ps1; 
        $PSScriptRoot\3-install-software.ps1;"
Start-Process powershell.exe -Wait -Verb RunAs -Args "-executionpolicy bypass -command Set-Location $PWD; $args;"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up a refreshenv function alias" -ForegroundColor Yellow
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
Invoke-Expression "refreshenv"

Write-Host "Installing scoop... " -ForegroundColor Yellow
Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Installing software with scoop... " -ForegroundColor Yellow
Invoke-Expression $PSScriptRoot\4-install-scoop.ps1
Write-Host "Done" -ForegroundColor Yellow

Invoke-Expression "refreshenv"

Write-Host "Setting up powershell CORE modules and profile" -ForegroundColor Yellow -NoNewline
Start-Process pwsh.exe -Wait -Verb RunAs -Args "-executionpolicy bypass -command Set-Location $PWD; Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck"
Start-Process pwsh.exe -Wait -Args "-executionpolicy bypass -command Set-Location $PWD; $PSScriptRoot\5-setup-powershell.ps1;"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up vscode plugins" -ForegroundColor Yellow
Invoke-Expression $PSScriptRoot\6-setup-vscode.ps1
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Setting up git" -ForegroundColor Yellow
Invoke-Expression "$PSScriptRoot\7-setup-git.ps1 '$gitUser' $gitEmail $gitGenerateSSH"
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Please reboot your machine."
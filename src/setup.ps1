foreach ($item in Get-Content -Path .\resources\banner.txt) {
    Write-Host $item
}

# check windows version
$windowsVersion = [System.Environment]::OSVersion.Version

if ($windowsVersion.Major -lt 10) {
    Write-Error "This setup script requires Windows version 10 or greater" -ErrorAction Stop
}

# collecting Git user details to use at the end
$options = ("Y", "N", "y", "n")
Write-Host "Enter your Git setup details:" -ForegroundColor Yellow
$gitUser = Read-Host "Enter your Git user name: " 
$gitEmail = Read-Host  "Enter your Git email: "
while ($options -notcontains $gitGenerateSSH) {
    $gitGenerateSSH = Read-Host "Do you want to generate your SSH key? [Y]es/[N]o" 
}

# option to use Shovel [https://github.com/Ash258/Scoop-Core] instead of Scoop [https://github.com/ScoopInstaller/Scoop]
while ($options -notcontains $installShovel) {
    $installShovel = Read-Host "Do you want to replace Scoop with Shovel? [Y]es/[N]o" 
}



# parsing the CSV file and generating packages.config, scoop.txt, vscode.txt
# according to user preferences. These files will be used by the appropriate installers
# to install the applications selected.
Invoke-Expression $PSScriptRoot\1-parse-csv.ps1

# install scoop if not already present
if($null -eq (Get-Command "scoop" -ErrorAction SilentlyContinue)) {
    Write-Host "Installing scoop... " -ForegroundColor Yellow
    Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
    Write-Host "Done" -ForegroundColor Yellow

} else {
    Write-Host "Previous scoop installation detected" -ForegroundColor Yellow
}

# installing scoop packages
Write-Host "Installing software with scoop... " -ForegroundColor Yellow
Invoke-Expression "$PSScriptRoot\2-install-scoop.ps1 $installShovel"
Write-Host "Done" -ForegroundColor Yellow

# installing wsl with the new fancy wsl --install for the windows versions that support it
if (($windowsVersion.Major -ge 11) -or ($windowsVersion.Build -ge 19041)) {
    Write-Host "This is the list of wsl distributions available (output of wsl --list --online):" -ForegroundColor Yellow
    # show the list of available wsl distributions:
    Invoke-Expression "wsl --list --online"
    do {
        $selectedDistro = Read-Host "What distribution from the list do you want to install? (default is Ubuntu)"
        if ($null -eq $selectedDistro){
            $wslInstallResult = Invoke-Expression "wsl --install"
        } else {
            $wslInstallResult =  Invoke-Expression "wsl --install -d $selectedDistro"
        }
    } while ($wslInstallResult.StartsWith("Invalid distribution"))
}

# performing tasks that require elevated permissions (using gsudo to elevate):
# 1- enabling windows features
# 2- installing chocolatey
# 3- installing software with chocolatey from packages.config
Write-Host "Performing Admin-level tasks... " -ForegroundColor Yellow -NoNewline
gsudo Set-ExecutionPolicy RemoteSigned
Unblock-File -Path $PSScriptRoot\3-enable-windows-features.ps1
Unblock-File -Path $PSScriptRoot\4-install-chocolatey.ps1
Unblock-File -Path $PSScriptRoot\5-install-software.ps1
Invoke-Expression "gsudo $PSScriptRoot\3-enable-windows-features.ps1 $($windowsVersion.Major) $($windowsVersion.Build); 
        gsudo $PSScriptRoot\4-install-chocolatey.ps1;
        gsudo $PSScriptRoot\5-install-software.ps1"
Write-Host "Done" -ForegroundColor Yellow

# finally setting up the dev environment
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

# cleaning up - removing temporary files
Remove-Item -Path "$PSScriptRoot\packages.config"
Remove-Item -Path "$PSScriptRoot\scoop.txt"
Remove-Item -Path "$PSScriptRoot\vscode.txt"

# scoop checkup - shows actions to do manually to tweak scoop/shovel
Write-Host "Checking up status of scoop..." -ForegroundColor White
Invoke-Expression "scoop checkup"

Write-Host "Please reboot your machine." -ForegroundColor White
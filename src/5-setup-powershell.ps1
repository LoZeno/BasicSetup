#posh-git
Write-Host "Installing Posh-Git"
Install-Module Get-ChildItemColor -AllowClobber
PowerShellGet\Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force

#oh-my-posh
Write-Host "Installing oh-my-posh"
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module oh-my-posh -Scope CurrentUser

#thefuck
Write-Host "Installing TheFuck from PIP3"
Invoke-Expression "pip install thefuck"

#git-gud
Write-Host "Installing Git-Gud from PIP3"
Invoke-Expression "pip install gitgud"

#copy profile.ps1
Write-Host "Setting up powershell core profile"
Get-Content .\powershell-resources\powershell_profile.ps1 | Out-File $PROFILE -Append

Write-Host "Setup complete"
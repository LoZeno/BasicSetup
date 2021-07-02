#Setting PSGallery to "trusted repository"
Write-Host "Adding PSGallery to the trusted repositories"
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

#Get-ChildItemColor
Write-Host "Installing Get-ChildItemColor"
Install-Module -Name Get-ChildItemColor -AllowClobber

#oh-my-posh
Write-Host "Installing oh-my-posh"
Install-Module oh-my-posh -Scope CurrentUser
Set-PoshPrompt -Theme slim

#PSFzf
Write-Host "Installing Powershell wrapper for fzf"
Install-Module -Name PSFzf

Write-Host "Updating pip"
Invoke-Expression "python -m pip install --upgrade pip"

#pip-review
Write-Host "Installing pip-review from PIP3 (to easily update pip packages)"
Invoke-Expression "pip install pip-review"

#thefuck
Write-Host "Installing TheFuck from PIP3"
Invoke-Expression "pip install thefuck"

#git-gud
Write-Host "Installing Git-Gud from PIP3"
Invoke-Expression "pip install gitgud"

#copy profile.ps1
Write-Host "Setting up powershell core profile"
Get-Content .\resources\powershell_profile.ps1 | Out-File $PROFILE -Append

Write-Host "Setup complete"
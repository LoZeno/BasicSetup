#screenfetch

#posh-git
PowerShellGet\Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force

#oh-my-posh
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module oh-my-posh -Scope CurrentUser

#thefuck
Invoke-Expression "pip install thefuck"

#copy profile.ps1
Get-Content .\powershell-resources\powershell_profile.ps1 | Set-Content $PROFILE
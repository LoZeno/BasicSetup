
Write-Host "Enabling virtualization and WSL"
Invoke-Expression $PSScriptRoot\1-enable-windows-features.ps1
Write-Host "Installing Chocolatey"
Invoke-Expression $PSScriptRoot\2-install-chocolatey.ps1
Invoke-Expression "C:\ProgramData\chocolatey\bin\RefreshEnv.cmd"
Write-Host "Installing software"
Invoke-Expression $PSScriptRoot\3-install-software.ps1
Invoke-Expression "C:\ProgramData\chocolatey\bin\RefreshEnv.cmd"
Write-Host "Setting up powershell modules and profile"
Invoke-Expression $PSScriptRoot\4-setup-powershell.ps1
Write-Host "Setting up powershell CORE modules and profile"
Start-Process pwsh.exe -Wait -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $PSScriptRoot\4-setup-powershell.ps1;"
Write-Host "setting up vscode plugins"
Invoke-Expression $PSScriptRoot\5-setup-vscode.ps1

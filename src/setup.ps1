
Invoke-Expression $PSScriptRoot\1-enable-windows-features.ps1
Invoke-Expression $PSScriptRoot\2-install-chocolatey.ps1
Invoke-Expression "refreshenv"
Invoke-Expression $PSScriptRoot\3-install-software.ps1
Invoke-Expression "refreshenv"
Start-Process pwsh.exe -Wait -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $PSScriptRoot\4-setup-powershell.ps1;"
Invoke-Expression $PSScriptRoot\5-setup-vscode.ps1


Invoke-Expression $PSScriptRoot\1-enable-windows-features.ps1
Invoke-Expression $PSScriptRoot\2-install-chocolatey.ps1
Invoke-Expression $PSScriptRoot\3-install-software.ps1
Start-Process pwsh.exe -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $PSScriptRoot\4-setup-powershell.ps1;"
Invoke-Expression $PSScriptRoot\5-setup-vscode.ps1

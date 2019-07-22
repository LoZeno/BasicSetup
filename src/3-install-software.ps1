Write-Host "Setting up a refreshenv function alias" -ForegroundColor Yellow
Import-Module -Name C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1
Invoke-Expression "refreshenv"

Write-Host "Installing software with chocolatey... " -ForegroundColor Yellow -NoNewline
choco install .\chocolatey\packages.config -y
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Installing scoop... " -ForegroundColor Yellow
Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
Write-Host "Done" -ForegroundColor Yellow

Write-Host "Installing software with scoop... " -ForegroundColor Yellow
Invoke-Expression "scoop bucket add extras"
Invoke-Expression "scoop bucket add jetbrains"
Invoke-Expression "scoop bucket add java"
foreach ($item in Get-Content -Path .\scoop\scoop-prerequisites) {
    Invoke-Expression "scoop install $item"
}
foreach ($item in Get-Content -Path .\scoop\scoop-list) {
    Invoke-Expression "scoop install $item"
}
foreach ($item in Get-Content -Path .\scoop\scoop-dotnet) {
    Invoke-Expression "scoop install $item"
}
Write-Host "Done" -ForegroundColor Yellow
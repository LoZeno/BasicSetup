# Invoke-Expression "scoop config 7ZIPEXTRACT_USE_EXTERNAL $true"
Invoke-Expression "scoop install git-with-openssh aria2"

Write-Host "Adding scoop buckets: extra, java, jetbrains, versions" -ForegroundColor Yellow
Invoke-Expression "scoop bucket add extras"
Invoke-Expression "scoop bucket add jetbrains"
Invoke-Expression "scoop bucket add java"
Invoke-Expression "scoop bucket add versions"

$scoopCommand = "scoop install"
foreach ($item in Get-Content -Path ".\scoop.txt") {
    $scoopCommand = "$scoopCommand $item"
}
Write-Host $scoopCommand -ForegroundColor Yellow
Invoke-Expression "$scoopCommand"

$gsudoCommand = "gsudo config CacheMode auto"
Write-Host "Setting gsudo cache mode" -ForegroundColor Yellow
Write-Host $gsudoCommand -ForegroundColor Yellow
Invoke-Expression "$gsudoCommand"

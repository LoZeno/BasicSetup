function installCodeExtensions([string]$listName) {
    $scoopCommand = "code --install-extension"
    foreach ($item in Get-Content -Path ".\vs-code\plugin-$listName") {
        $scoopCommand = "$scoopCommand $item"
    }
    Write-Host $scoopCommand -ForegroundColor Yellow
    Invoke-Expression "$scoopCommand"
}

installCodeExtensions "list"

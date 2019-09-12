function installCodeExtensions([string]$listName) {
    $installCommand = "code --install-extension"
    foreach ($item in Get-Content -Path ".\vs-code\plugin-$listName") {
        $installCommand = "$installCommand $item"
    }
    Write-Host $installCommand -ForegroundColor Yellow
    Invoke-Expression "$installCommand"
}

installCodeExtensions "list"

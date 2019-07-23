function installFromScoopList([string]$listName) {
    $scoopCommand = "scoop install"
    foreach ($item in Get-Content -Path ".\scoop\scoop-$listName") {
        $scoopCommand = "$scoopCommand $item"
    }
    Write-Host $scoopCommand -ForegroundColor Yellow
    Invoke-Expression "$scoopCommand"
}

installFromScoopList "prerequisites"

Write-Host "Adding scoop buckets: extra, java, jetbrains" -ForegroundColor Yellow
Invoke-Expression "scoop bucket add extras"
Invoke-Expression "scoop bucket add jetbrains"
Invoke-Expression "scoop bucket add java"

installFromScoopList "list"

if (("Y", "y") -contains $installDotnet ) {
    installFromScoopList "dotnet" 
}

if (("Y", "y") -contains $installJava ) {
    installFromScoopList "java"
}

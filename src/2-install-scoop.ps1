$installShovel = $args[0]

Invoke-Expression "scoop install aria2 7zip git-with-openssh"

if (("Y", "y") -contains $installShovel) {
    if($null -eq (Get-Command "shovel" -ErrorAction SilentlyContinue)) {
        Write-Host "Replacing scoop with shovel... " -ForegroundColor Yellow
        Invoke-Expression "scoop install 7zip;
            scoop config SCOOP_REPO 'https://github.com/Ash258/Scoop-Core';
            scoop update"
        Write-Host "Done" -ForegroundColor Yellow
    } else {
        Write-Host "Shovel already installed. Run 'scoop checkup' after setup is completed." -ForegroundColor Yellow
    }
}

Write-Host "Adding scoop buckets: extras, java, jetbrains, versions" -ForegroundColor Yellow
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

Write-Host "Setting up registry keys for Visual Studio Code"
Invoke-Expression "$env:USERPROFILE\scoop\apps\vscode\current\vscode-install-context.reg"

Write-Host "Setting up registry keys for python"
Invoke-Expression "$env:USERPROFILE\scoop\apps\python\current\install-pep-514.reg"

$gsudoCommand = "gsudo config CacheMode auto"
Write-Host "Setting gsudo cache mode" -ForegroundColor Yellow
Write-Host $gsudoCommand -ForegroundColor Yellow
Invoke-Expression "$gsudoCommand"

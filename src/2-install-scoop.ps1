$installShovel = $args[0]

# Mandatory packages: aria2 for p2p downloads, 7zip for unpacking downloads, git for scoop updates
Invoke-Expression "scoop install aria2 7zip git-with-openssh"

# replace scoop with shovel if user requested, unless already present
if (("Y", "y") -contains $installShovel) {
    if($null -eq (Get-Command "shovel" -ErrorAction SilentlyContinue)) {
        Write-Host "Replacing scoop with shovel... " -ForegroundColor Yellow
        Invoke-Expression "scoop config SCOOP_REPO 'https://github.com/Ash258/Scoop-Core';
            scoop update"
        Write-Host "Done" -ForegroundColor Yellow
    } else {
        Write-Host "Shovel already installed. Run 'scoop checkup' after setup is completed." -ForegroundColor Yellow
    }
}

# registering scoop buckets for software sources
Write-Host "Adding scoop buckets: extras, java, jetbrains, versions" -ForegroundColor Yellow
Invoke-Expression "scoop bucket add extras"
Invoke-Expression "scoop bucket add jetbrains"
Invoke-Expression "scoop bucket add java"
Invoke-Expression "scoop bucket add versions"

# install each software listed in scoop.txt
$scoopCommand = "scoop install"
foreach ($item in Get-Content -Path ".\scoop.txt") {
    $scoopCommand = "$scoopCommand $item"
}
Write-Host $scoopCommand -ForegroundColor Yellow
Invoke-Expression "$scoopCommand"

# run registry changes to add VScode actions to right-click menu in Explorer
Write-Host "Setting up registry keys for Visual Studio Code"
Invoke-Expression "$env:USERPROFILE\scoop\apps\vscode\current\install-context.reg"

# set PythonPath and InstallPath to the installed version
Write-Host "Setting up registry keys for python"
Invoke-Expression "$env:USERPROFILE\scoop\apps\python\current\install-pep-514.reg"

# set gsudo cachemode to behave "like sudo on linux"
$gsudoCommand = "gsudo config CacheMode auto"
Write-Host "Setting gsudo cache mode" -ForegroundColor Yellow
Write-Host $gsudoCommand -ForegroundColor Yellow
Invoke-Expression "$gsudoCommand"

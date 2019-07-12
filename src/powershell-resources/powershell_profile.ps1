# TheFuck - brilliant commandline helper
$env:PYTHONIOENCODING="utf-8"
iex "$(thefuck --alias)"

# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Ensure posh-git is loaded
Import-Module -Name posh-git

# Ensure oh-my-posh is loaded
Import-Module -Name oh-my-posh

# Set the default prompt theme
Set-Theme paradox

#Repos folder alias
function repos {
    Set-Location ~\Repos
}

#Start new powershell prompt as administrator
function sudo {
    Start-Process pwsh.exe -Verb RunAs -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $args;" 
}

function elevate {
    Start-Process pwsh.exe -Verb RunAs -Args "-noexit -executionpolicy bypass -command Set-Location \`"$PWD\`"; $args;" 
}

function newAdmin {
    elevate $PROFILE
}

function nano ($File){
    $File = $File -replace “\\”, “/” -replace “ “, “\ “
    bash -c “nano $File”
}

Set-Alias la Get-ChildItem

function updateRepos {
    Get-ChildItem .\ -Directory -Force | ForEach-Object {
        Set-Location $_
        $dirName = $_.BaseName
        Write-Host "Repo: $dirName" -ForegroundColor Yellow
        if (Test-Path .\.git -PathType Container) {
            Invoke-Expression -Command "git reset --hard";
            Invoke-Expression -Command "git fetch";
            Invoke-Expression -Command "git pull --rebase";
        }
        Set-Location $_.Parent 
    } 
}

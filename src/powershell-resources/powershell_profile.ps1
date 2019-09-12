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

# PSFzf
Import-Module PSFzf -ArgumentList 'Ctrl+t','Ctrl+f'

# Set the default prompt theme
Set-Theme paradox

#REFRESHENV
Import-Module C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1

#Start new powershell prompt as administrator, and closes when command is completed
function su {
    Start-Process pwsh.exe -Verb RunAs -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $args;" 
}

#Start new powershell prompt as administrator
function elevate {
    Start-Process pwsh.exe -Verb RunAs -Args "-noexit -executionpolicy bypass -command Set-Location \`"$PWD\`"; $args;" 
}

function newAdmin {
    elevate $PROFILE
}

function nano ($File){
    $File = $File -replace “\\”, “/” -replace “ “, “\ “ -replace “[A-Z]:“, {"/mnt/"+$_.Value.ToLower()[0]}
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

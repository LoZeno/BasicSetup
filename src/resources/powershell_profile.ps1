# TheFuck - brilliant commandline helper
$env:PYTHONIOENCODING="utf-8"
iex "$(thefuck --alias)"

# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Set the default prompt theme
oh-my-posh init pwsh --config "$(scoop prefix oh-my-posh)\themes\slim.omp.json" | Invoke-Expression
$env:POSH_GIT_ENABLED = $true

# PSFzf
Import-Module PSFzf -ArgumentList 'Ctrl+t','Ctrl+f'

#REFRESHENV
Import-Module C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1

# Gsudo last command (!!)
Import-Module gsudoModule

# Import scoop completion command module
Import-Module "$(scoop prefix oh-my-posh)\supporting\completion\Scoop-Completion.psd1" -ErrorAction SilentlyContinue

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

function formatPathForWsl($FilePath){
    return $FilePath -replace “\\”, “/” -replace “ “, “\ “ -replace “[A-Z]:“, {"/mnt/"+$_.Value.ToLower()[0]}
}

function nano ($File){
    $File = formatPathForWsl($File)
    bash -c "nano $File"
}

function vim ($File){
    $File = formatPathForWsl($File)
    bash -c "vim $File"
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

function preview($File) {
    if ([string]::IsNullOrWhiteSpace($File))
    {
        $File = "{}"
    }
    Invoke-Expression "fzf --preview 'bat --color ""always"" $File'"
}

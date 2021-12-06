$windowsMajorVersion = $args[0]
$windowsBuild = $args[1]

Write-Host "Enabling virtualization and WSL... " -ForegroundColor Yellow -NoNewline

# enabling Microsoft-Windows-Subsystem-Linux is necessary only if on Windows 10 version predating build 19041
# for anything newer, wsl --install is used in setup.ps1
if (($windowsMajorVersion -lt 11) -and ($windowsBuild -lt 19041)) {
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart 
}
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -All -NoRestart
Write-Host "Done" -ForegroundColor Yellow

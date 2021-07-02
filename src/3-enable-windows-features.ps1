Write-Host "Enabling virtualization and WSL... " -ForegroundColor Yellow -NoNewline
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart 
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -All -NoRestart
Write-Host "Done" -ForegroundColor Yellow

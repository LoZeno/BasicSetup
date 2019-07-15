$args = "Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart; 
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart"

Start-Process powershell.exe -Wait -Verb RunAs -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $args;"

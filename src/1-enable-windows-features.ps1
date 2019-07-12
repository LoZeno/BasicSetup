$args = "Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All; 
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All"

Start-Process powershell.exe -Wait -Verb RunAs -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $args;"

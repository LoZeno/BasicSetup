$args = "choco install .\chocolatey\packages.config -y"
    
Start-Process powershell.exe -Verb RunAs -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $args;"

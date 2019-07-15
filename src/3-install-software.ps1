$args = "choco install .\chocolatey\packages.config -y"
    
Start-Process powershell.exe -Wait -Verb RunAs -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $args; choco upgrade -y all;"

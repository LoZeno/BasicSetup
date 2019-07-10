$args = "choco install .\chocolatey\packages.config -y"
    
Start-Process pwsh.exe -Verb RunAs -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $args;"

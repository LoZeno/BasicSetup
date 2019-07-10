$args = "Set-ExecutionPolicy Bypass -Scope Process -Force;
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    
Start-Process powershell.exe -Verb RunAs -Args "-executionpolicy bypass -command Set-Location \`"$PWD\`"; $args;" 

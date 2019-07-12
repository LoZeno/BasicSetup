# BasicSetup
Scripts for basic setup of a windows development machine (.NET Core and Node development)


## How to use: 
Open powershell, then type:
```
Invoke-WebRequest -Uri "https://github.com/LoZeno/BasicSetup/archive/master.zip" -OutFile master.zip

Expand-Archive -Path .\master.zip -DestinationPath .\

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

Then navigate to the `.\BasicSetup\src\` folder, and execute the scripts in order. Reboot at the end if necessary.

If you get the following error:

```
File .\4-setup-powershell.ps1 cannot be loaded because the execution of scripts is disabled on this system.
```
it's likely caused by the fact that at some point you closed and reopened your powershell shell, or that you opened pwsh.exe to complete the setup. If that happens, set the execution policy to "bypass" again, and all will be good (`Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process`)
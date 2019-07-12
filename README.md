# BasicSetup
Scripts for basic setup of a windows development machine (.NET Core and Node development)


## How to use: 
Open powershell, then type, in this order:
```powershell
Invoke-WebRequest -Uri "https://github.com/LoZeno/BasicSetup/archive/master.zip" -OutFile master.zip
Expand-Archive -Path .\master.zip -DestinationPath .\
Set-Location .\BasicSetup-master\src\
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
.\setup.ps1
```

If you get the following error:

```powershell
File .\4-setup-powershell.ps1 cannot be loaded because the execution of scripts is disabled on this system.
```
it's likely caused by the fact that at some point you closed and reopened your powershell shell, or that you opened pwsh.exe to complete the setup. If that happens, set the execution policy to "bypass" again, and all will be good (`Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process`)

## A note on the Console Emulator

I use the new Windows Terminal, which (at the time of this writing) is still in beta but available on the Microsoft Store; Fira Code (the font installed with these scripts) doesn't work on the standard conhost in windows, hence why the prompt modified by posh-git and oh-my-posh might look odd with several characters missing.

Unfortunately there is no way to automate installation of software from the Microsoft Store - you need to use the gui. Also, several workplaces block dowloads from the Microsoft Store, or even remove it from the Windows 10 image used. For those situations, I have included Cmder (https://cmder.net/) in the chocolatey installation file.
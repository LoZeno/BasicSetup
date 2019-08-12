# BasicSetup
Scripts for basic setup of a windows development machine (.NET Core and/or Node and/or java and/or Go development)


## How to use: 
Open powershell, then type, in this order:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-WebRequest -Uri "https://github.com/LoZeno/BasicSetup/archive/master.zip" -OutFile master.zip
Expand-Archive .\master.zip .\
cd .\BasicSetup-master\src\
.\setup.ps1
```
## Why both chocolatey and scoop?

Scoop is great but it does not have the same extensive library of software as chocolaey - especially when it's software that requires Admin privileges to be installed. So, to install things like Docker Desktop, Viscosity, and .NET framework (which is a prerequisite for Scoop anyway), I used chocolatey, and the script makes it run in an elevated prompt; to avoid adding more prompts for admin password, anything that needs Admin privileges to install is installed using chocolatey since there's already a step for it, and anything else using scoop.

## A note on the Console Emulator

I use the new Windows Terminal, which (at the time of this writing) is still in beta but available on the Microsoft Store; this is the reason for a couple of choices I made:
* Powershell Core is installed with chocolatey rather than scoop, so that the Windows Terminal can pick it once it's installed from the Microsoft Store
* Fira Code (the font installed with these scripts) doesn't work on the standard conhost in windows, hence why the prompt modified by posh-git and oh-my-posh might look odd with several characters missing.
* Unfortunately there is no way to automate installation of software from the Microsoft Store - you need to use the gui. Also, several workplaces block dowloads from the Microsoft Store, or even remove it from the Windows 10 image used. For those situations, I have included Cmder (https://cmder.net/) in the installation file.

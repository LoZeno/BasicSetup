# BasicSetup
Scripts for basic setup of a windows development machine (.NET Core and/or Node and/or java and/or Go development)

## Preface
This script was developed based on what **I** needed to rebuild on my laptop moving from one client to another. Your mileage may vary and nothing stops you from changing the stuff inside it.  
My preferred way of work is to NEVER login with an Administrator level account, and instead type the admin passwod every time a UAC popup shows on my screen, so I planned my setup around that. Some people hate that, if you're one of those people you can use this from an Administrator account as well, it will still work.

## How to use: 
Open powershell, then type, in this order:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-WebRequest -Uri "https://github.com/LoZeno/BasicSetup/archive/master.zip" -OutFile master.zip
Expand-Archive .\master.zip .\
cd .\BasicSetup-master\src\
.\setup.ps1
```

## What does it set up:

* Hyper-V and WSL (Windows Subsystem for Linux) in the Windows Features list. It does NOT install Ubuntu for WSL (or OpenSUSE for WSL or Kali or Debian...), for those you'll need to manually get them from the Microsoft Store
* [Chocolatey package manager](https://chocolatey.org/docs)
* [Scoop package manager](https://github.com/lukesampson/scoop/wiki)
* [Docker Desktop](https://www.docker.com/)
* [Viscosity OpenVPN Client](https://www.sparklabs.com/viscosity/)
* [Powershell Core](https://github.com/powershell/powershell)
* [FiraCode font](https://github.com/tonsky/FiraCode)
* IDE and binaries for the chosen development stack(s) (.NET Core, Java, Go, Javascript)
* Several CLI utilities: [GOW](https://github.com/bmatzelle/gow), [ag](https://geoff.greer.fm/ag/), [bat](https://github.com/sharkdp/bat), [fd](https://github.com/sharkdp/fd), [fzf](https://github.com/junegunn/fzf) and its Powershell wrapper [PSFzf](https://github.com/kelleyma49/PSFzf)
* Wonderful powershell and git utilities like [TheFuck](https://github.com/nvbn/thefuck), [PoshGit](https://github.com/dahlbyk/posh-git), [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh), [git gud](https://github.com/fsufitch/git-gud)
* Initial setup for Git based on the user's prompt
* Convenient aliases in powershell core profile
* Commonly used VSCode extensions
* Extra utilities and software that I find useful and/or often required in various offices. Software is organised in simple lists under the `chocolatey` and `scoop` folders, so if anything falls under your definition of crapware just remove the name from the list files.

## Why both chocolatey and scoop?

Scoop is great but it does not have the same extensive library of software as chocolatey - especially when it's software that requires Admin privileges to be installed. So, to install things like Docker Desktop, Viscosity, and .NET framework (which is a prerequisite for Scoop anyway), I used chocolatey, and the script makes it run in an elevated prompt; to avoid adding more prompts for admin password, anything that needs Admin privileges to install is installed using chocolatey since there's already a step for it, and anything else using scoop.

## A note on the Console Emulator

I use [the new Windows Terminal](https://github.com/Microsoft/Terminal), which (at the time of this writing) is still in beta but available on the Microsoft Store; this is the reason for a couple of choices I made:
* Powershell Core is installed with chocolatey rather than scoop, so that the Windows Terminal can pick it once it's installed from the Microsoft Store
* Fira Code (the font installed with these scripts) doesn't work on the standard conhost in windows, hence why the prompt modified by posh-git and oh-my-posh might look odd with several characters missing.
* Unfortunately there is no way to automate installation of software from the Microsoft Store - you need to use the gui. Also, several workplaces block dowloads from the Microsoft Store, or even remove it from the Windows 10 image used. For those situations, I have included Cmder (https://cmder.net/) in the installation file.

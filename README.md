# BasicSetup
Scripts for basic setup of a windows development machine (.NET Core and/or Node and/or java and/or Go and/or Rust development)

## Preface
This script was developed based on what **I** needed to rebuild on my laptop moving from one client to another. Your mileage may vary and nothing stops you from changing the stuff inside it.  
My preferred way of work is to NEVER login with an Administrator level account, and instead type the admin passwod every time a UAC popup shows on my screen, so I planned my setup around that. Some people hate that, if you're one of those people you can use this from an Administrator account as well, it will still work.

## Prerequisite
When I first wrote this script, the tools included were pretty much all portable and self-contained; with time, I've added more and more things (rust-msvc, python libraries) that rely on [Microsoft C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/).  
So, before using this script, download the Microsoft C++ Build Tools, run the installer, and select the **Desktop development with C++** workload.

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
* [Scoop package manager](https://github.com/lukesampson/scoop/wiki) or, alternatively, [Shovel](https://github.com/Ash258/Scoop-Core)
* [Docker Desktop](https://www.docker.com/)
* [Viscosity OpenVPN Client](https://www.sparklabs.com/viscosity/)
* [Powershell Core](https://github.com/powershell/powershell)
* [FiraCode font](https://github.com/tonsky/FiraCode)
* IDE and binaries for the chosen development stack(s) (.NET Core, Java, Go, Javascript, Rust)
* [gsudo - a sudo for Windows](https://github.com/gerardog/gsudo) (probably the best sudo-like tool for Windows that I have ever seen)
* Several CLI utilities: [GOW](https://github.com/bmatzelle/gow), [ag](https://geoff.greer.fm/ag/), [bat](https://github.com/sharkdp/bat), [fd](https://github.com/sharkdp/fd), [noti](https://github.com/variadico/noti), [fzf](https://github.com/junegunn/fzf) and its Powershell wrapper [PSFzf](https://github.com/kelleyma49/PSFzf), a [tldr-pages client](https://github.com/tldr-pages/tldr)
* [Sysinternals tools](https://docs.microsoft.com/en-us/sysinternals/)
* [Microsoft Powertoys](https://github.com/microsoft/PowerToys)
* Wonderful powershell and git utilities like [TheFuck](https://github.com/nvbn/thefuck), [PoshGit](https://github.com/dahlbyk/posh-git), [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh), [git gud](https://github.com/fsufitch/git-gud)
* Initial setup for Git based on the user's prompt
* Convenient aliases in powershell core profile
* Commonly used VSCode extensions
* Extra utilities and software that I find useful and/or often required in various offices.

The list of applications and plugins that will be installed is stored in `softwareList.csv`.  
The CSV file shows the stack that each package/plugin belongs to, and the installer/application that will be used to download and install it (scoop, chocolatey or VisualStudio Code in case of its own plugins). During the execution of the script you'll be prompted to confirm installation of each list except for "base", which contain the "mandatory" stuff to install.  

Before running the script you can easily edit the `softwareList.csv` file to include your favourite packages or delete stuff you don't need, add new lists if you like and so on; I strongly advise against modifying the packages listed as "base" since some of those are necessary to make the rest of the scripts work.

## Why both chocolatey and scoop?

Scoop is great but it does not have the same extensive library of software as chocolatey - especially when it's software that requires Admin privileges to be installed. So, to install things like Docker Desktop, Viscosity, and .NET framework (which is a prerequisite for Scoop anyway), I used chocolatey, and the script makes it run in an elevated prompt; to avoid adding more prompts for admin password, anything that needs Admin privileges to install is installed using chocolatey since there's already a step for it, and anything else using scoop.

## A note on the Console Emulator

I use [the new Windows Terminal](https://github.com/Microsoft/Terminal), with the FiraCode font instead of the default Cascadia Code; the powershell profile that gets updated by these scripts assumes FiraCode is used, so opening the normal Powershell window will result in missing characters in the oh-my-posh prompt.

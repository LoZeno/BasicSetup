# BasicSetup
Scripts for basic setup of a windows development machine (.NET Core and Node development)


## How to use: 
Open powershell, then type:
```
Invoke-WebRequest -Uri "https://github.com/LoZeno/BasicSetup/archive/master.zip" -OutFile master.zip

Expand-Archive -Path .\master.zip -DestinationPath .\

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

Then execute the scripts in order. Reboot at the end if necessary.

$options = ("Y", "N", "y", "n")
$stackOptions = ("Y", "N", "S", "y", "n", "s")

$csvFile =  Import-Csv .\softwareList.csv

# ask the user which software stacks they want to install
while (('Y', 'y') -notcontains $accepted) {
    $accepted = "";
    $stacks = $csvFile | Group-Object -Property "List" | Sort-Object -Property "Name" | Select-Object Name

    $selectedStacks = @()
    $stacks | ForEach-Object -Process {
        $installStack = ""
        $stackName = $_.Name

        while (($stackName -ne "base") -and ($stackOptions -notcontains $installStack)) {
            $installStack = Read-Host "Do you want to install the $stackName stack? [Y]es/[N]o/[S]how packages in $stackName"
            if (("S", "s") -contains $installStack) {
                $csvFile | Where-Object List -eq $stackName | Select-Object PackageName, List | more
                $installStack = ""
            } 
        }
        if (($stackName -eq "base") -or (('Y','y') -contains $installStack)) {
            $selectedStacks += $stackName
        }
    }

    $selectedPackages = $csvFile | Where-Object List -In $selectedStacks
    while ($options -notcontains $showList) {
        $showList = Read-Host "Do you want to see the list of software that will be installed? [Y]es/[N]o"
    }
    if (("Y", "y") -contains $showList) {
        $selectedPackages | Sort-Object -Property "List" | Select-Object PackageName, List | more
    }
    while ($options -notcontains $accepted) {
        $accepted = Read-Host "Are you happy with Your selection? [Y]es/[N]o"
    }
}

# prepare packages.config for chocolatey
$chocolateyPackages = $selectedPackages | Where-Object Installer -eq "chocolatey" | Select-Object PackageName

[xml]$xmlDocument = New-Object System.Xml.XmlDocument
$decoration = $xmlDocument.CreateXmlDeclaration("1.0", "utf-8", $null)
$xmlDocument.AppendChild($decoration) | Out-Null

$root = $xmlDocument.CreateNode("element", "packages", $null)
$xmlDocument.AppendChild($root) | Out-Null

foreach($package in $chocolateyPackages) {
    $packageNode = $xmlDocument.CreateNode("element", "package", $null)
    $packageNode.SetAttribute("id", $package.PackageName) | Out-Null
    $root.AppendChild($packageNode) | Out-Null
}

$xmlDocument.Save("$PSScriptRoot\packages.config") | Out-Null

# prepare list file for scoop
$scoopPackages = $selectedPackages | Where-Object Installer -eq "scoop" | Sort-Object -Property "PackageName" | Select-Object PackageName

foreach($package in $scoopPackages) {
    Add-Content -Path "$PSScriptRoot\scoop.txt" -Value $package.PackageName
}

# prepare list file for vscode plugins
$vscodePlugins = $selectedPackages | Where-Object Installer -eq "vs-code" | Sort-Object -Property "PackageName" | Select-Object PackageName

foreach($plugin in $vscodePlugins) {
    Add-Content -Path "$PSScriptRoot\vscode.txt" -Value $plugin.PackageName
}
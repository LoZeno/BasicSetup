$options = ("Y", "N", "y", "n")

$csvFile =  Import-Csv .\softwareList.csv

$stacks = $csvFile | group -Property List | select Name

$selectedStacks = @()
$stacks | ForEach-Object -Process {
    $installStack = ""
    $stackName = $_.Name

    while (($stackName -ne "base") -and ($options -notcontains $installStack)) {
        $installStack = Read-Host "Do you want to install the $stackName stack? [Y]es/[N]o" 
    }
    if (($stackName -eq "base") -or (('Y','y') -contains $installStack)) {
        $selectedStacks += $stackName
    }
}

$selectedPackages = $csvFile | ? List -In $selectedStacks

Write-Host "Here's the list of software that will be installed:"
$selectedPackages | sort -Property "List" | select PackageName, List | more

# prepare packages.config for chocolatey
$chocolateyPackages = $selectedPackages | ? Installer -eq "chocolatey" | select PackageName

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

$scoopPackages = $selectedPackages | ? Installer -eq "scoop" | sort -Property "PackageName" | select PackageName

foreach($package in $scoopPackages) {
    Add-Content -Path "$PSScriptRoot\scoop.txt" -Value $package.PackageName
}
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
# prepare packages.config for chocolatey

$chocolateyPackages = $csvFile | ? List -In ("base", "cli", "common") | ? Installer -eq "chocolatey" | select PackageName

Write-Output $chocolateyPackages
[xml]$xmlDocument = New-Object System.Xml.XmlDocument
$decoration = $xmlDocument.CreateXmlDeclaration("1.0", "utf-8", $null)
$xmlDocument.AppendChild($decoration)

$root = $xmlDocument.CreateNode("element", "packages", $null)
$xmlDocument.AppendChild($root)

foreach($package in $chocolateyPackages) {
    $packageNode = $xmlDocument.CreateNode("element", "package", $null)
    $packageNode.SetAttribute("id", $package.PackageName) | Out-Null
    $root.AppendChild($packageNode) | Out-Null
}

$xmlDocument.Save("$PSScriptRoot\packages.config")

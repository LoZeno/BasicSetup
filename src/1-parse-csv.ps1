$options = ("Y", "N", "y", "n")

$stacks = Import-Csv .\softwareList.csv | group -Property List | select Name

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

Write-Output $selectedStacks
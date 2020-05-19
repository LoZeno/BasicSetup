$installCommand = "code --install-extension"
foreach ($item in Get-Content -Path ".\vscode.txt") {
    $installCommand = "$installCommand $item"
}
Write-Host $installCommand -ForegroundColor Yellow
Invoke-Expression "$installCommand"

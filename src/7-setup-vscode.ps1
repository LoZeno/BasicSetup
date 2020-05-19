foreach ($item in Get-Content -Path ".\vscode.txt") {
    $installCommand = "code --install-extension $item"
    Write-Host $installCommand -ForegroundColor Yellow
    Invoke-Expression "$installCommand"
}

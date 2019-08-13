$user = $args[0]
$email = $args[1]
$generateSSH = $args[2]

Write-Host "Setting up git user name"
Invoke-Expression "git config --global user.name '$user'"
Write-Host "Setting up git user email"
Invoke-Expression "git config --global user.email $email"
Write-Host "Setting up vscode as git default editor"
Invoke-Expression "git config --global core.editor 'code --wait'"
Write-Host "Setting up git lg alias for prettified one-line logs"
Invoke-Expression "git config --global alias.lg `"log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit`""
if (('Y', 'y') -contains $generateSSH) {
    Write-Host "Generating a new ssh key using $email as the label"
    Invoke-Expression "ssh-keygen -t rsa -b 4096 -C '$email'"
    Start-Service ssh-agent
    Invoke-Expression "ssh-add ~\.ssh\id_rsa"
}

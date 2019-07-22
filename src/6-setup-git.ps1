$user = $args[0]
$email = $args[1]
$generateSSH = $args[2]

Invoke-Expression "git config --global user.email $email"
Invoke-Expression "git config --global user.name '$user'"
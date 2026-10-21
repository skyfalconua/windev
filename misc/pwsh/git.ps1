# -- -- -- --

git config --global user.name "username"
git config --global user.email "your_email@company.com"

# -- -- -- --

ssh-keygen -t ed25519 -C "some comment"

cat $HOME\.ssh\id_ed25519.pub

# -- -- -- --

$sshdir = Join-Path $HOME ".ssh"
New-Item -ItemType Directory -Path $sshdir -Force

$config = @"
Host github.com
  User git
  IdentityFile "$HOME\.ssh\id_ed25519"
"@

Write-Output $config
notepad (Join-Path $sshdir "config")

# Add-Content -Path (Join-Path $sshdir "config") -Value $config -Encoding ascii

# -- -- -- --

git config --global url."git@github.com:".insteadOf "https://github.com/"

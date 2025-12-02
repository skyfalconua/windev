cd "C:\opt"
oh-my-posh --init --shell pwsh --config 'spaceship' | Invoke-Expression
$env:Path = "C:\opt\.windev\pbin;" + $env:Path

# . "C:\opt\.local\config.ps1"

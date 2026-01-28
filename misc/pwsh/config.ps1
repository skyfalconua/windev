#
# to install oh-my-posh run
#   winget install JanDeDobbeleer.OhMyPosh
#
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
  oh-my-posh --init --shell pwsh --config 'spaceship' | Invoke-Expression
}

function Remove-Path($path) {
  $env:Path = ($env:Path -split ';' | Where-Object { $_ -ne $path }) -join ';'
}
function Prepend-Path($path) {
  Remove-Path $path
  $env:Path = "$path;$env:Path"
}
# function Remove-Path-Permanent($path) {
#   $current = [Environment]::GetEnvironmentVariable("Path", "User")
#   $newPath = ($current -split ';' | Where-Object { $_ -ne $path }) -join ';'
#   [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
# }
# function Prepend-Path-Permanent($path) {
#   Remove-Path-Permanent $path
#   $current = [Environment]::GetEnvironmentVariable("Path", "User")
#   [Environment]::SetEnvironmentVariable("Path", "$path;$current".TrimEnd(';'), "User")
# }

Prepend-Path "C:\opt\.windev\pbin"

#
# edit config
#   notepad C:\opt\.windev\misc\pwsh\config.ps1
#

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

# rundll32.exe sysdm.cpl,EditEnvironmentVariables

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
# Prepend-Path-Permanent "C:\opt\msys64\usr\bin"
# Prepend-Path-Permanent "C:\opt\msys64\ucrt64\bin"
# Prepend-Path-Permanent "C:\opt\Apps\VSCode\bin"
# Prepend-Path-Permanent (Join-Path $env:LOCALAPPDATA "Programs\Zed\bin")
# Prepend-Path-Permanent "C:\opt\Bins"

# $h = (Get-PSReadlineOption).HistorySavePath ; Remove-Item $h -Force

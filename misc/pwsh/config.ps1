#
# edit configs
#  notepad $PROFILE
#  notepad C:\opt\.windev\misc\pwsh\config.ps1
#

# to clear history run
#  $h = (Get-PSReadlineOption).HistorySavePath ; Remove-Item $h -Force

# -- oh-my-posh configuration -- --

#
# to install oh-my-posh run
#   winget install JanDeDobbeleer.OhMyPosh
#
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
  oh-my-posh --init --shell pwsh --config 'spaceship' | Invoke-Expression
}

# -- path management functions -- -- --

function Remove-Path($path) {
  $env:Path = ($env:Path -split ';' | Where-Object { $_ -ne $path }) -join ';'
}
function Add-Path-start($path) {
  Remove-Path $path
  $env:Path = "$path;$env:Path"
}

# rundll32.exe sysdm.cpl,EditEnvironmentVariables

function Remove-Path-Permanent($path) {
  $current = [Environment]::GetEnvironmentVariable("Path", "User")
  $newPath = ($current -split ';' | Where-Object { $_ -ne $path }) -join ';'
  [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
}
function Add-Path-Permanent-start($path) {
  Remove-Path-Permanent $path
  $current = [Environment]::GetEnvironmentVariable("Path", "User")
  [Environment]::SetEnvironmentVariable("Path", "$path;$current".TrimEnd(';'), "User")
}
function Add-Path-Permanent-end($path) {
  Remove-Path-Permanent $path
  $current = [Environment]::GetEnvironmentVariable("Path", "User")
  [Environment]::SetEnvironmentVariable("Path", "$current;$path".TrimStart(';'), "User")
}

# Add-Path-Permanent-start "C:\opt\msys64\usr\bin"
# Add-Path-Permanent-start "C:\opt\msys64\ucrt64\bin"
# Add-Path-Permanent-start "C:\opt\Apps\VSCode\bin"
# Add-Path-Permanent-start (Join-Path $env:LOCALAPPDATA "Programs\Zed\bin")
# Add-Path-Permanent-start (Join-Path $HOME ".local\bin")
# Add-Path-Permanent-start "C:\opt\bin"

# put uv and vp to opt/bin then

# -- --

vp
Add-Path-Permanent-start "$env:LOCALAPPDATA\vite-plus\bin"
Add-Path-Permanent-end "$env:LOCALAPPDATA\vite-plus\data\fallback-bin"

# -- --

uv python install 3.12

# example to install github
uv tool install specify-cli

function uvpv($version) {
  if (-not $version) {
    uv python list --only-installed
    return
  }

  $python = uv python find --managed-python $version
  if (-not $python) { return }

  # remove old uv-managed python entries from user PATH
  $root = (uv python dir).Trim()
  $user = [Environment]::GetEnvironmentVariable("Path", "User")
  foreach ($p in $user -split ';') {
    if ($p -and $p.StartsWith($root, 'OrdinalIgnoreCase')) { Remove-Path-Permanent $p }
  }

  $dir = Split-Path $python
  Add-Path-Permanent-start "$dir\Scripts"
  Add-Path-Permanent-start $dir
  Write-Host "Active: $dir"
}

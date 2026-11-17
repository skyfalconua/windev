# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
# Common functions
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

#
# edit configs
#  notepad $PROFILE
#
function edit-prof() {
  code $PROFILE
}

function Import-DotEnv($path = '.env') {
  if (!(Test-Path -Lit $path -PathType Leaf)) { throw "File not found: $path" }

  foreach ($line in Get-Content -Lit $path) {
    if ($line -notmatch '^\s*(?:export\s+)?([A-Za-z_]\w*)\s*=\s*(.*?)\s*$') { continue }
    $name, $value = $Matches[1], $Matches[2]

    # Quoted value: strip quotes (and any trailing comment). Unquoted: strip " # comment".
    if ($value -match '^"(.*)"(?:\s+#.*)?$' -or $value -match "^'(.*)'(?:\s+#.*)?$") { $value = $Matches[1] }
    else { $value = $value -replace '\s+#.*$' }

    Set-Item "Env:$name" $value
  }
}
Set-Alias source Import-DotEnv

# -- codex --

function cdx() {
  codex --no-daemon
}
function cdxr() {
  codex resume --no-daemon
}

function cdp() {
  cd "C:\opt\Projects"
}

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
# Don't sleep function
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

$code = @'
using System;
using System.Runtime.InteropServices;

public static class PowerUtil {
  [DllImport("kernel32.dll", SetLastError = true)]
  public static extern uint SetThreadExecutionState(uint esFlags);
}
'@

Add-Type -TypeDefinition $code -ErrorAction Stop

function stes {
  $ES_CONTINUOUS       = [uint32]"0x80000000"
  $ES_DISPLAY_REQUIRED = [uint32]"0x00000002"

  [PowerUtil]::SetThreadExecutionState($ES_CONTINUOUS -bor $ES_DISPLAY_REQUIRED) | Out-Null

  Write-Host "Press Ctrl+C to stop."
  while ($true) { Start-Sleep -Seconds 60 }
}

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
# Tabs management
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

function wttb {
  $ui  = "C:\opt\Projects\app_ui"
  $api   = "C:\opt\Projects\app"

  # profile + title + suppress flag + directory
  function opts($title, $dir, $prof = 'Windows PowerShell') {
    "-p `"$prof`" --title $title --suppressApplicationTitle -d `"$dir`""
  }

  $misc    = opts Misc    $PWD.Path
  $apiOpts = opts app_api $api
  $uiOpts  = opts app_ui  $ui
  $zshApi  = opts zsh-api $api zsh
  $zshUi   = opts zsh-ui  $ui  zsh

  $Host.UI.RawUI.WindowTitle = 'Misc'

  $wtArgs = @(
    # Tab 1: scratch, two panes stacked (-w 0 = current window)
    "-w 0 split-pane -H $misc -s 0.2"

    # Tab 2: API, small pane below
    "new-tab $apiOpts"
    "split-pane -H $apiOpts -s 0.2"
    "split-pane -V $apiOpts -s 0.5"

    # Tab 3: UI, top pane + bottom pane split into left/right
    "new-tab $uiOpts"
    "split-pane -H $uiOpts -s 0.2"

    # Tab 4-5: zsh, UI on top, API below
    "new-tab $zshApi"
    "new-tab $zshUi"

    # Back to the Misc tab, cursor in its top pane
    "focus-tab -t 0"
  ) -join ' ; '

  Start-Process wt -ArgumentList $wtArgs
}

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
# Path management
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

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

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
# Misc
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

# to clear history run
#  $h = (Get-PSReadlineOption).HistorySavePath ; Remove-Item $h -Force

# -- oh-my-posh configuration -- --

#
# to install oh-my-posh run
#   winget install JanDeDobbeleer.OhMyPosh
#
# if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
#   oh-my-posh --init --shell pwsh --config 'spaceship' | Invoke-Expression
# }

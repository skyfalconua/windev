# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
#  Scripts to manage Codex sessions
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

$CodexSessionsDir = "$HOME/.codex/sessions"
$CodexIndexPath   = "$HOME/.codex/session_index.jsonl"

# --- helpers ---

# Session id = the UUID at the end of the rollout file name (last 36 chars).
function Get-Id-codex($file) { $file.BaseName -replace '^.*(?=.{36}$)' }

# Rollout files whose id starts with $Id (all files when $Id is empty).
function Get-Sessions-codex($Id) {
  Get-ChildItem $CodexSessionsDir -Filter *.jsonl -File -Recurse |
    Where-Object { (Get-Id-codex $_) -like "$Id*" }
}

# Exactly one rollout file for an id prefix, otherwise throw.
function Find-Session-codex($Id) {
  $f = @(Get-Sessions-codex $Id)
  if (-not $f)    { throw "Session '$Id' not found." }
  if ($f.Count -gt 1) { throw "Session prefix '$Id' is ambiguous. Use a longer ID." }
  $f[0]
}

function Get-Title-codex($id) {
  $e = Select-String -Path $CodexIndexPath -Pattern $id -SimpleMatch -List -ErrorAction Ignore |
    ForEach-Object { $_.Line | ConvertFrom-Json }
  $e.thread_name, '(untitled)' | Where-Object { $_ } | Select-Object -First 1
}

function Get-Cwd-codex($file) {
  $h = Get-Content $file.FullName -TotalCount 1 -Encoding UTF8 | ConvertFrom-Json -ErrorAction Ignore
  $h.cwd, $h.payload.cwd | Where-Object { $_ } | Select-Object -First 1
}

# --- commands ---

function cdxls([string]$Filter) {
  Get-Sessions-codex | Sort-Object LastWriteTime -Descending | ForEach-Object {
    $id  = Get-Id-codex $_
    $title = Get-Title-codex $id
    $cwd   = Get-Cwd-codex $_

    if ("$id $title $cwd" -like "*$Filter*") {
      '{0}  {1:yyyy-MM-dd HH:mm}  {2,-40}  {3}' -f
        ($id[0..12] -join ''), $_.LastWriteTime, $title, $cwd
    }
  }
}

function cdxdet([Parameter(Mandatory)]$Id) {
  $f  = Find-Session-codex $Id
  $full = Get-Id-codex $f

  "Full ID     : $full"
  "Title       : $(Get-Title-codex $full)"
  "Updated     : $($f.LastWriteTime)"
  "Working dir : $(Get-Cwd-codex $f)"
  "Entries     : $((Get-Content $f.FullName).Count)"
  "Size        : $([math]::Round($f.Length / 1KB, 1)) KB"
  "File        : $($f.FullName)"
  "`n--- First 3 entries ---"
  Get-Content $f.FullName -TotalCount 3 -Encoding UTF8 | ForEach-Object { $_ -replace '^(.{140}).+', '$1...' }
}

function cdxrm([Parameter(Mandatory)]$Id, [switch]$Force) {
  $f  = Find-Session-codex $Id
  $full = Get-Id-codex $f

  if (-not $Force -and (Read-Host "Delete '$(Get-Title-codex $full)' [$full]? (y/N)") -ne 'y') {
    'Cancelled.'; return
  }

  # Try the Codex CLI first; if the file is still there, delete it manually.
  if (Get-Command codex -ErrorAction Ignore) { codex delete $full 2>$null }

  if (Test-Path $f.FullName) {
    Remove-Item $f.FullName -Force
    if (Test-Path $CodexIndexPath) {
      # WriteAllLines = UTF-8 without BOM in both PowerShell versions.
      $keep = @(Get-Content $CodexIndexPath -Encoding UTF8 | Where-Object { $_ -notmatch $full })
      [IO.File]::WriteAllLines($CodexIndexPath, [string[]]$keep)
    }
  }

  "Session $full deleted."
}

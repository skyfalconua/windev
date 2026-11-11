$dir = "$env:USERPROFILE\.claude"
$file = "$dir\settings.json"

New-Item -ItemType Directory -Force -Path $dir

$json = @'
{
  "$schema": "https://schemastore.org",
  "env": {
    "ANTHROPIC_BASE_URL": "https://internal.anthropic.url.company.com",
    "ANTHROPIC_AUTH_TOKEN": "YOUR_TOKEN_HERE",
    "CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS": "1"
  },
  "theme": "dark",
  "hasCompletedProjectOnboarding": true,
  "hasTrustDialogAccepted": true,
  "model": "haiku"
}
'@

[System.IO.File]::WriteAllText($file, $json)
notepad.exe $file

# -- -- -- --

[Environment]::SetEnvironmentVariable("ANTHROPIC_AUTH_TOKEN", "token", "User")

# -- -- -- --

npx ccusage@latest

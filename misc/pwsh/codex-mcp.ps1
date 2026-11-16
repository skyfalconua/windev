# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
#  General Codex MCP commands
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

codex mcp list

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
#  Figma MCP
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

codex mcp add figma --url https://mcp.figma.com/mcp

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
#  Azure DevOps MCP
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

# 1. Install Azure CLI for Windows via zip
#> https://aka.ms/installazurecliwindowszipx64

# 2. Add to PATH
rundll32.exe sysdm.cpl,EditEnvironmentVariables
#> C:\your\path\to\azure-cli\bin

# 3. Login to Azure CLI
az login
az account show  # optional, just check

# 4. Install Azure DevOps MCP CLI
npm i -g  @azure-devops/mcp
# OR
vp i -g  @azure-devops/mcp

# 5. Add Azure DevOps MCP Server
codex mcp add azure-devops -- mcp-server-azuredevops "<Organisation>" --authentication azcli -d core work-items repositories

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -
#  GitHub MCP
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - -

# 1. Install GitHub MCP Server for Windows via zip
https://github.com/github/github-mcp-server/releases
# For example, extract to C:\opt\bin\github-mcp-server

# 2. Add to PATH
rundll32.exe sysdm.cpl,EditEnvironmentVariables
#> "C:\your\path\to\bin"
# OR
Add-Path-Permanent-start "C:\opt\bin"

# 3. Add GitHub MCP Server
codex mcp add github -- github-mcp-server stdio --toolsets repos,issues,pull_requests

# 4. Configure Personal Access Token for GitHub MCP Server
# https://github.com/settings/tokens -> Personal access tokens (classic)`

# 5. Configure GitHub MCP Server token
notepad $HOME\.codex\config.toml

# [mcp_servers.github]
# command = "github-mcp-server"
# args = ["stdio", "--toolsets", "repos,issues,pull_requests"]
# env = { GITHUB_PERSONAL_ACCESS_TOKEN = "ghp_" }  << HERE

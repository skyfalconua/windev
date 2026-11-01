# For python tools installed there (e.g. poetry, uv tools, pipx apps)
export PATH="$(cygpath -u "$USERPROFILE")/.local/bin:$PATH"

# Vite+ cli for Node.js versions, npm, Vite etc
export PATH="$(cygpath -u "$LOCALAPPDATA")/vite-plus/bin:$PATH"

# C:\opt\bin (custom binaries)
export PATH="/c/opt/bin:$PATH"

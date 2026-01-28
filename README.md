### powershell

```powershell
winget install --id Git.Git -e --source winget
winget install JanDeDobbeleer.OhMyPosh

New-Item -ItemType Directory -Path (Split-Path -Parent $PROFILE) -Force
New-Item -ItemType File -Path $PROFILE -Force

notepad $PROFILE
#> . C:\opt\.windev\misc\pwsh\config.ps1
```

### zsh

```sh
#-- run bash

pacman -S zsh git
notepad C:\opt\msys64\msys2_shell.cmd
#> "LOGINSHELL=zsh"

pac install \
  mc p7zip unrar cygutils \
  mingw-w64-ucrt-x86_64-fzf \
  mingw-w64-ucrt-x86_64-fd \
  mingw-w64-ucrt-x86_64-sd \
  mingw-w64-ucrt-x86_64-ripgrep \
  mingw-w64-ucrt-x86_64-micro \
  mingw-w64-ucrt-x86_64-delta \
  mingw-w64-ucrt-x86_64-gitui \
  mingw-w64-ucrt-x86_64-yazi \
  mingw-w64-ucrt-x86_64-zoxide

# notepad $HOME/.zshrc
#> source /c/opt/.windev/misc/msys/config.sh

# pmsys
```

### windows terminal

```yaml
Name:
  Msys2 Zsh

Cmd:
  C:\opt\msys64\msys2_shell.cmd -ucrt64 -defterm -no-start -here

Color scheme: CGA or Tango
Font face: Cascadia Code NF
Font size: 14
```

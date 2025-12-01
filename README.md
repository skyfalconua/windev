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
pmsys
pacman -S zsh

notepad $HOME/.zshrc
#> source /c/opt/.windev/misc/msys/config.sh

notepad C:\opt\msys64\msys2_shell.cmd
#> "LOGINSHELL=zsh"
```

### windows terminal

```yaml
Name:
  Msys2 Zsh

Cmd:
  C:\opr\msys64\msys2_shell.cmd -ucrt64 -defterm -no-start -here

Color scheme: CGA
Font face: Cascadia Code NF
Font size: 14
```

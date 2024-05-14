
# config
My personal configuration for my terminal live: vimrc, fish abbreviations and just stuff to remember when I switch to a new linux distro or simply want to reconfigure something from a clean slate.


## To remember for new systems

#### Names/commands/locations
  - picom: `cp /etc/xdg/picom.conf ~/.config/picom`

.gitconfig with pretty decorate formats
```
[user]
	email = hoeslilars@gmail.com
	name = lrshsl
[init]
	defaultBranch = main
[alias]
lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all

lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all

lg = !"git lg1"
```

#### Linux | Unix (shell) commands and their Rusty modern equivalents:
- cd                : zoxide
- ls                : exa
- grep              : rg (ripgrep)
- find              : fd
- cat               : bat
- sed               : sd
- ps                : procs
- top, htop         : ytop
- man, tldr         : tealdeer

#### Other command line utils
- tokei : Information about code
- hyperfine : Benchmarking via cli
- [broot](https://github.com/Canop/broot) : Nice way to find files


## Universal scripts && commands

- Set keyboard layout
```sh
# X11
setxkbmap "us(colemak),ch" -option "grp:shifts_toggle"
setxkbmap "us(colemak),us,ch" -option "grp:shifts_toggle,caps:backspace"

# To get more options
grep -E "caps:" /usr/share/X11/xkb/rules/base.lst

# Worst case || just to dive deeper: /usr/share/X11/xkb/
# There are great arch wiki articles for that
```

- Dualmonitor (X11)
    - (a|x)randr
    - autorandr for automation
```sh
# duplicate monitor
xrandr --output HDMI-1 --same-as eDP-1

## Not tested ##
# extend monitor
xrandr --output HDMI-1 --right-of eDP-1

# disable
xrandr --output HDMI-1 --off

# enable again
xrandr --output HDMI-1 --auto
```

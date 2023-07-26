
# config
My personal configuration for neovim, zsh etc


## To remember for new systems

#### Names/commands/locations
  - picom
    - default config  :   /etc/xdg/picom.conf
    - user config     :   .config/picom

#### Linux | Unix (shell) commands and their Rusty modern equivalents:
- cd                : zoxide
- ls                : exa
- grep              : rg (ripgrep)
- find              : fd
- cat               : bat
- sed               : sd
- ps                : procs
- top => htop       : ytop
- man => tldr       : tealdeer

#### Other command line utils
- tokei : Information about code, written in Rust
- hyperfine : Benchmarking via cli, in Rust
- [broot](https://github.com/Canop/broot) : Nice [Ranger]() alternative in Rust


## Universal scripts && commands

- Set keyboard layout
```sh
# X11
setxkbmap "us(colemak),ch" -option "grp:shifts_toggle"
setxkbmap "us(colemak),us,ch" -option "grp:shifts_toggle,caps:backspace"

# To get more options
grep -E "caps:" /usr/share/X11/xkb/rules/base.lst

# Worst case || Wayland || just to dive deeper: /usr/share/X11/xkb/
# There are great arch wiki articles for that
```

- Dualmonitor (X11)
    - (a|x)randr
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

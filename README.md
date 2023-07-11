
# config
My personal configuration for neovim, zsh etc


## Remember

1. Names/commands/locations
  - picom
    - default config :   /etc/xdg/picom.conf
    - user config    :   .config/picom


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
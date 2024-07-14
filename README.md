
# config
My personal configuration for my terminal live: vimrc, fish abbreviations and just stuff to remember when I switch to a new linux distro or simply want to reconfigure something from a clean slate.

Contents:
- [To remember](#to-remember-for-new-systems)
- [Universal scripts && commands](#universal-scripts-commands)
    - Keyboard layout with setxkbmap
    - Multi monitor setup (X11)


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

## Keyboard layout
```sh
# X11
setxkbmap "us(colemak),ch" -option "grp:shifts_toggle"
setxkbmap "us(colemak),us,ch" -option "grp:shifts_toggle,caps:backspace"

# To get more options
grep -E "caps:" /usr/share/X11/xkb/rules/base.lst

# Worst case || just to dive deeper: /usr/share/X11/xkb/
# There are great arch wiki articles for that
```

## Multi monitor setup (X11)
    - (a|x)randr
    - autorandr for automation --> See [scripts/](scripts/)

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

## Urxvt config

Start daemon in background
```sh
urxvtd -p -f -o
```

Reload config
```sh
xrdb -merge ~/.Xresources
```

> When an error occurs about fonts (`char width can't be calculated` or similar), just first try to increase the font size.
> Don't ask.

## Bluetooth

Error: `No default controler available`

How I once succeeded:

#### Maybe it's just blocked?

```sh
rfkill list
```
The last time, the controler didn't even show up, only the wifi interface. If it does, just unblock it:
```sh
sudo rfkill unblock all
```

#### Reinstall bluez packages (lib may not be necessary)
```sh
sudo pacman -S bluez bluez-utils bluez-lib
```

#### Kernel module loaded?
```sh
# Kernel module
## Everything bluetooth related
lsmod | head -n 2 && lsmod | rg blue

## Btusb might also be needed
lsmod | rg btusb
```

```sh
# (Re)load btusb module
sudo rmmod btusb
sleep 5
sudo modprobe btusb
```

#### Service loaded?
```sh
# Bluetooth service
systemctl status bluetooth
```

```sh
# Start service
sudo systemctl enable --now bluetooth
```


#### Check logs
```sh
sudo dmesg | rg -i bluetooth
```
This might show that a certain firmware could not be loaded --> Install this firmware.


#### Did it work?

```sh
bluetoothctl power on
```

#### Else

Uninstall blueman or other bluetooth managers and reboot
```sh
sudo pacman -Rns blueman
reboot
```

Or just reboot
```sh
reboot
```

After playing with those commands and rebooting, I installed blueman again and it worked.



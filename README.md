
# config
My personal configuration for my terminal live: vimrc, fish abbreviations and just stuff to remember when I switch to a new linux distro or simply want to reconfigure something from a clean slate.

Contents:
- [To remember](#to-remember-for-new-systems)
- [Universal scripts && commands](#universal-scripts-commands)
    - Keyboard layout with setxkbmap
    - Multi monitor setup (X11)
    - [tty](#tty)
- [Troubleshooting](#troubleshooting)


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


## TTY

```sh
loadkeys us colemak
setfont ter-u14n.psf.gz
echo -e '\033[?8;0;0c' 		# green block cursor
```

## Troubleshooting

### Bluetooth

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



### Virtualbox

#### Error kernel driver not installed

Error:
> Kernel driver not installed (rc = -1908)
>
> The VirtualBox Linux kernel driver (vboxdrv) is either not loaded or there is a permission problem with / dev / vboxdrv. Please reinstall the kernel module by executing
> '/sbin/vboxconfig'
> as root.
> 
> where: suplibOsInit what: 3 VERR_VM_DRIVER_NOT_INSTALLED (-1908) - The driver support is not installed. On linux, open returned ENOENT.

`/sbin/vboxconfig` does not exist.

- Make sure the kernel, headers and host-modules are installed and updated
	- linux kernel: `sudo pacman -S linux linux-headers virtualbox-host-modules-arch`
	- other kernels need `virtualbox-host-dkms` instead of `virtualbox-host-modules-arch`
	- linux zen: `sudo pacman -S linux linux-headers virtualbox-host-dkms`
- To load mandatory module: `sudo modprobe vboxdrv`
	- see [archwiki](https://wiki.archlinux.org/title/VirtualBox#Load_the_VirtualBox_kernel_modules)
- Try reinstalling / uninstalling other kernels..
	- Full system update: `sudo pacman -Syyu`
- Reboot


#### Install guest editions

1. Install iso
	- `sudo pacman -S virtual-guest-iso`
	- It will be installed to `/usr/lib/virtualbox/additions/VBoxGuestAdditions.iso`
2. Mount it from the vm
3. Open it in a file explorer
4. Run the executable



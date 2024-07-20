#!/bin/sh

# laptop
# - mobile configuration with colemak-ch layouts

setxkbmap "us(colemak),ch" -option grp:shifts_toggle

notify-send -i display "Autorandr profile" "Laptop configuration loaded"

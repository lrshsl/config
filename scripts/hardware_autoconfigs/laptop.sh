#!/bin/sh

# laptop
# - mobile configuration with colemak-ch

autorandr --load laptop
setxkbmap "us(colemak),ch" -option grp:shifts_toggle


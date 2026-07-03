#!/bin/sh

# loads extern_uwhd configuration
# - external ultrawide screen
# - external keyboard that expects us layout

setxkbmap "us,ch" -option 

nitrogen --set-zoom ~/Pictures/wallpapers/dark_moon3.png

notify-send -i display "Autorandr profile" "Home configuration loaded"

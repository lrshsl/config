#!/bin/sh

# loads extern_uwhd
# - external ultrawide screen
# - external keyboard that expects us layout

autorandr --load extern_uwhd
setxkbmap us

nitrogen --set-zoom ~/Pictures/wallpapers/dark_moon3.png


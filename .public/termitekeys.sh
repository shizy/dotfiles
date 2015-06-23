#!/bin/bash

#xdotool windowactivate --sync $(xdotool search --sync --name top) key Shift+Page_Up
#(xdotool windowactivate --sync $(xdotool getactivewindow) key Shift+Page_Up)
aw=$(xdotool getactivewindow)
name=$(xwininfo -id $aw | head -n 2 | grep -oP '(?<=").*?(?=")')

xdotool windowactivate --sync $aw
xdotool keyup --clearmodifiers Alt

case $name in
    "term" | "top" | "bottom" | "left" | "right")
        if [ $1 == "up" ]; then
            xdotool key --clearmodifiers Shift+Page_Up
        else
            xdotool key --clearmodifiers Shift+Page_Down
        fi
        ;;
    "search")
        if [ $1 == "up" ]; then
            xdotool key --clearmodifiers Up
        else
            xdotool key --clearmodifiers Down
        fi
        ;;
esac

#xdotool keydown --clearmodifiers Alt

#!/bin/bash

if [ ! -d "$HOME/.wallpaper" ]; then
    mkdir $HOME/.wallpaper 2>/dev/null
fi

if [ "$1" ]; then
    x=$(basename $1)
    mv -f $1 "$HOME/.wallpaper/$x"
else
    x=$(ls -t $HOME/.wallpaper 2>/dev/null | tail -n 1)
fi

touch "$HOME/.wallpaper/$x"
feh --bg-fill --no-fehbg "$HOME/.wallpaper/$x"
echo -n "feh --bg-fill --no-fehbg '$HOME/.wallpaper/$x'" > $XDG_CACHE_HOME/fehbg

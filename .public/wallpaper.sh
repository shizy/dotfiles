#!/bin/bash

if [ ! -d "$XDG_DATA_HOME/wallpaper" ]; then
    mkdir $XDG_DATA_HOME/wallpaper 2>/dev/null
fi

if [ "$1" ]; then
    x=$(basename $1)
    mv -f $1 "$XDG_DATA_HOME/wallpaper/$x"
else
    x=$(ls -t $XDG_DATA_HOME/wallpaper 2>/dev/null | tail -n 1)
fi

touch "$XDG_DATA_HOME/wallpaper/$x"
feh --bg-fill --no-fehbg "$XDG_DATA_HOME/wallpaper/$x"
echo -n "feh --bg-fill --no-fehbg '$XDG_DATA_HOME/wallpaper/$x'" > $XDG_CACHE_HOME/fehbg

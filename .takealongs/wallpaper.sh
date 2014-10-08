#!/bin/bash

if [ ! -d "$HOME/.wallpaper" ]; then
    mkdir $HOME/.wallpaper 2>/dev/null
fi

if [ "$1" ]; then
    x=$(date +%s)-$(basename $1)
    mv -f $x "$HOME/.wallpaper/$x"
else
    x=$(ls -t ~/.wallpaper 2>/dev/null | tail -n 1) 
fi

touch "$HOME/.wallpaper/$x"
feh --bg-scale "$HOME/.wallpaper/$x"

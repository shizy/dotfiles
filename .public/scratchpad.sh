#!/bin/bash

# TODO:
#
# get from xprop: WM_NORMAL_HINTS: resize increment
# support for disjointed screensizes for multiple screens

FONT_WIDTH=7
FONT_HEIGHT=15

running=$(i3-msg -t get_tree | grep -c "\"name\":\"$1\"")

# if not running, spawn scratchpad based on direction and workspace size
if [ $running == 0 ] || [ $1 === "search" ]; then
    # needle may not be static, specifically "focused"
    res="$(i3-msg -t get_workspaces | grep -oP '(?<="focused":true,"rect":).*?(?=})'),"

    w_top=$(grep -oP '(?<="y":).*?(?=,)' <<< "$res")
    w_left=$(grep -oP '(?<="x":).*?(?=,)' <<< "$res")
    w_width=$(grep -oP '(?<="width":).*?(?=,)' <<< "$res")
    w_height=$(grep -oP '(?<="height":).*?(?=,)' <<< "$res")

    case $1 in
        *"top"*)
            x=$w_left
            y=$w_top
            h=$(($w_height / 2))
            w=$w_width
            ;;
        *"bot"* | *"sea"*)
            x=$w_left
            y=$((($w_height / 2) + $w_top))
            h=$(($w_height / 2))
            w=$w_width
            ;;
        *"lef"*)
            x=$w_left
            y=$w_top
            h=$w_height
            w=$(($w_width / 2))
            ;;
        *"rig"*)
            x=$(($w_width / 2))
            y=$w_top
            h=$w_height
            w=$(($w_width / 2))
            ;;
    esac

    col=$((($w / $FONT_WIDTH) + 1))
    row=$(($h / $FONT_HEIGHT))
    cmd=''

    if [ $2 ]; then
       cmd="-e $2"
    fi

    exec urxvtc -geometry ${col}x${row} -name $1 $cmd &
    wait $!
    i3-msg "[class=\"URxvt\" instance=\"$1\"] move scratchpad, border none, move position ${x}px ${y}px"
else
    i3-msg "[class=\"URxvt\" instance=\"$1\"] scratchpad show"
fi



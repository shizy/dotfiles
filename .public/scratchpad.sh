#!/bin/bash

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
        "top")
            x=$w_left
            y=$w_top
            h=$(($w_height / 2))
            w=$w_width
            ;;
        "bottom" | "search")
            x=$w_left
            y=$((($w_height / 2) + $w_top))
            h=$(($w_height / 2))
            w=$w_width
            ;;
        "left")
            x=$w_left
            y=$w_top
            h=$w_height
            w=$(($w_width / 2))
            ;;
        "right")
            x=$(($w_width / 2))
            y=$w_top
            h=$w_height
            w=$(($w_width / 2))
            ;;
    esac

    cmd=''

    if [ $2 ]; then
       cmd="-e $2 &"
    fi

    termite --geometry ${w}x${h} --title=$1 $cmd & disown
    sleep 0.25
    i3-msg "[class=\"Termite\" title=\"$1\"] move scratchpad, move position ${x}px ${y}px"
else
    i3-msg "[class=\"Termite\" title=\"$1\"] scratchpad show"
fi



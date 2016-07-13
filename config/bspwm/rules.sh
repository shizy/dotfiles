#!/bin/bash

# Rules by Class

bspc rule -a xfreerdp desktop=^1
bspc rule -a qutebrowser desktop=^2

# Rules by Title

wid=$1
class=$2
instance=$3

if [ "$class" = Termite ]; then
    title=$(xtitle "$wid")
    case "$title" in
        vim)
            echo "desktop=^3"
            ;;
        irc)
            echo "desktop=^4"
            ;;
        scratchbottom|scratchleft|scratchright|scratchsearch)
            echo "state=floating border=on sticky=on"
            ;;
        scratchtop)
            echo "state=floating border=on sticky=on"
            flap -s n:scratchtop -w 90% -h 45% -x c -y t-2 #hack
            ;;
        dispatch)
            echo "desktop=^1"
            ;;
    esac
fi

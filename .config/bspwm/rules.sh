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
            echo "desktop=^9"
            ;;
        mutt)
            echo "desktop=^10"
            ;;
        scratchtop|scratchbottom|scratchleft|scratchright|scratchsearch)
            echo "state=floating border=off"
            ;;
        scratchjeeves)
            echo "state=floating sticky=on locked=on layer=ABOVE"
            ;;
        dispatch)
            echo "desktop=^1"
            ;;
    esac
fi

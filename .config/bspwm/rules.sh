#!/bin/bash

# Rules by Class

bspc rule -a Firefox desktop=^2

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
        connman)
            echo "floating=on"
            ;;
        scratchtop|scratchbottom|scratchleft|scratchright|scratchsearch)
            echo "floating=on border=off"
            ;;
        scratchjeeves)
            echo "floating=on sticky=on locked=on layer=ABOVE"
            ;;
        dispatch)
            echo "desktop=^1"
            ;;
    esac
fi

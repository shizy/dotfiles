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
        top|bottom|left|right|search)
            echo "floating=on border=off"
            ;;
        jeeves)
            echo "floating=on sticky=on locked=on"
            ;;
    esac
fi

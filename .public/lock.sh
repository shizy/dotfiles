#!/bin/bash

if [ ! $(pidof | pgrep xautolock) ] || [[ $1 == *"start"* ]]; then
    rm /tmp/xautolock-disable
    xset s 600 600
    xset +dpms
    xautolock -time 10 -locker i3lock-wrapper
else
    pkill xautolock
    xset -dpms
    xset s off
    touch /tmp/xautolock-disable
fi

#!/bin/bash

# $1 can be left or right

multi=$(xrandr | grep -wc connected)

if [ $multi -gt 1 ]; then
    # multi screen mode
    i3-msg "focus output $1"
else
    # single screen mode
    dir=''
    if [ $1 == "left" ]; then
       dir="prev"
   else
       dir="next"
    fi
    i3-msg "workspace $dir"
fi

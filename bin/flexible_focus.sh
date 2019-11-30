#! /usr/bin/bash

#get active workspace
wsnum=$(swaymsg -t get_workspaces | jq '.[] | select(.focused == true).name' | grep -oP '\d+:')

#get count of open windows in workspace
count=$(swaymsg -t get_tree | jq --arg ws "$wsnum" '.. | select(.type? == "workspace" and (.name | contains($ws))).nodes | length')

if [[ $count -gt 1 ]]; then
    swaymsg focus right
else
    swaymsg workspace back_and_forth
fi

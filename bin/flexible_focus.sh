#! /usr/bin/bash

#get active workspace
wsnum=$(i3-msg -t get_workspaces | jq '.[] | select(.focused == true).name' | grep -oP '\d+:')

#get count of open windows in workspace
count=$(i3-msg -t get_tree | jq --arg ws "$wsnum" '.. | select(.type? == "workspace" and (.name | contains($ws))).nodes | length')

if [[ $count -gt 1 ]]; then
    i3-msg focus right
else
    i3-msg workspace back_and_forth
fi

#!/bin/bash

if [ $(pidof | pgrep fzf) ]; then
    i3-msg '[class="URxvt" instance="search"] kill'
    exit
fi

result=$(ag -p $XDG_CONFIG_HOME/ag/agignore -fli --hidden -g "" ~ /etc 2>/dev/null | fzf -m --query="$1" --select-1 --exit-0)
ftype=$(file $result --mime-type | awk '{print $2}')

case $ftype in
    *"image"*)
        i3-msg exec feh $result
        ;;
    *"text"*)
        if [ ! -e "$XDG_RUNTIME_DIR/nvim-$(hostname)" ]; then
            i3-msg "exec urxvtc -name vim -e $PUBLIC/nvim.sh"
        fi

        python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim-$(hostname)'); nvim.command('e $result');"
        ;;
    *"pdf"*)
        zathura --fork $result
        ;;
    *"video"*)
        i3-msg exec mplayer $result &
        i3-msg '[class="MPlayer"] workspace 8:'
        ;;
esac


i3-msg '[class="URxvt" instance="search"] kill'

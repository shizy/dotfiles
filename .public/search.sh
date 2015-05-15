#!/bin/bash

if [ $(pidof | pgrep fzf) ]; then
    i3-msg '[class="URxvt" instance="search"] kill'
    exit
fi

file=$(ag -p $XDG_CONFIG_HOME/ag/agignore -fli --hidden -g "" ~ /etc 2>/dev/null | fzf -m --select-1 --query="$1" --exit-0)
file=(${file//\r\n/ })

for f in "${file[@]}"
do
    ftype=$(file $file --mime-type | awk '{print $2}')

    case $ftype in
        *"image"*)
            i3-msg exec feh $f > /dev/null
            ;;
        *"text"* | *"empty"*)
            if [ ! -e "$XDG_RUNTIME_DIR/nvim-$(hostname)" ]; then
                i3-msg "exec urxvtc -name vim -e $PUBLIC/nvim.sh" > /dev/null
            fi

            python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim-$(hostname)'); nvim.command('hide e $f');"
            ;;
        *"pdf"*)
            zathura --fork $f
            ;;
        *"video"*)
            i3-msg exec mplayer $f > /dev/null
            ;;
    esac
done

i3-msg '[class="URxvt" instance="search"] kill'

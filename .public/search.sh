#!/bin/bash

if [ $(pidof | pgrep fzf) ]; then
    i3-msg '[class="URxvt" instance="search"] kill'
    exit
fi

file=$(ag -fli --hidden -g "" /etc /tmp ~ 2>/dev/null | fzf --query="$1" --select-1 --exit-0)
ftype=$(file $file --mime-type | awk '{print $2}')

case $ftype in
    *"image"*)
        i3-msg exec feh $file
        ;;
    *"text"*)
        if [ ! -e "/tmp/nvim" ]; then
            i3-msg 'exec urxvtc -name vim -e zsh -c "NVIM_LISTEN_ADDRESS=/tmp/nvim nvim -S ~/.nvim/sessions/session.vim"'
        fi

        python2 -c "from neovim import attach; nvim=attach('socket', path='/tmp/nvim'); nvim.command('e $file');"
        ;;
    *"pdf"*)
        zathura --fork $file
        ;;
    *"video"*)
        i3-msg exec mplayer $file &
        i3-msg '[class="MPlayer"] workspace 8:'
        ;;
esac

i3-msg '[class="URxvt" instance="search"] kill'

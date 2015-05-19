#!/bin/bash

if [ $(pidof | pgrep fzf) ]; then
    i3-msg '[class="URxvt" instance="search"] kill'
    exit
fi

# ag file search
stack+=$(ag -p $XDG_CONFIG_HOME/ag/agignore -fli --hidden -g "" ~ /etc 2>/dev/null | sed -e 's/^/file:\t/')
# man page search
stack+=$(/usr/bin/man -k "" | awk '{print $1,$2}' | sed -e 's/^/man:\t/')

# will probably choke on a file / folder with a space in it!
selection=$(fzf -m --select-1 --exit-0 <<< "$stack" | sed -e 's/[\t|\ |)]//g' -e 's/(/:/g')
selection=(${selection//\r\n/ })

i3-msg '[class="URxvt" instance="search"] scratchpad show'

for sel in "${selection[@]}"
do
    sel=(${sel//:/ })
    target=${sel[1]}

    case ${sel[0]} in
        "file")
            ftype=$(file $target --mime-type | awk '{print $2}')

            case $ftype in
                *"image"*)
                    i3-msg exec feh $target > /dev/null
                    ;;
                *"text"* | *"empty"*)
                    if [ ! -e "$XDG_RUNTIME_DIR/nvim-$(hostname)" ]; then
                        i3-msg "exec urxvtc -name vim -e $PUBLIC/nvim.sh" > /dev/null
                    fi

                    python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim-$(hostname)'); nvim.command('hide e $target');"
                    ;;
                *"pdf"*)
                    zathura --fork $target
                    ;;
                *"video"*)
                    i3-msg exec mplayer $target > /dev/null
                    ;;
            esac
            ;;
        "man")
            if [ ! -e "$XDG_RUNTIME_DIR/man-$(hostname)" ]; then
                i3-msg "exec urxvtc -name man -e $PUBLIC/nvim.sh man" > /dev/null
                python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/man-$(hostname)'); nvim.command('AirlineToggle');"
            fi

            python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/man-$(hostname)'); nvim.command('Man $target'); nvim.command('only');"
            ;;
    esac
done

i3-msg '[class="URxvt" instance="search"] kill'

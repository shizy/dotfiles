#!/bin/bash

if [ $(pidof | pgrep fzf) ]; then
    i3-msg '[class="Termite" title="search"] kill'
    exit
fi

# ag file search
stack+=$(ag -p $XDG_CONFIG_HOME/ag/agignore -fli --hidden -g "" ~ /etc 2>/dev/null | sed -e 's/^/file:\t/')
# man page search
stack+=$(/usr/bin/man -k "" | awk '{print $1,$2}' | sed -e 's/^/man:\t/')
# process search
#stack+=$(ps -eo "%p : %U %c %a" | sed -e 's/^/proc:\t/')

# will probably choke on a file / folder with a space in it!
selection=$(fzf -m --select-1 --exit-0 <<< "$stack" | sed -e 's/[\t|\ |)]//g' -e 's/(/:/g')
selection=(${selection//\r\n/ })

launch () {

    case $1 in
        "file")
            ftype=$(file $2 --mime-type | awk '{print $2}')

            case $ftype in
                *"image"*)
                    i3-msg exec feh $2 > /dev/null
                    ;;
                *"text"* | *"empty"* | *"javascript"*)
                    $PUBLIC/nvim.sh "hide e $2"
                    #python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim-$(hostname)'); nvim.command('hide e $2');"
                    ;;
                *"pdf"*)
                    zathura --fork $2
                    ;;
                *"video"*)
                    i3-msg exec mplayer $2 > /dev/null
                    ;;
                *"symlink"*)
                    target=$(readlink $2)
                    launch $1 $target
                    ;;
            esac
            ;;
        "man")
            $PUBLIC/nvim.sh "Man $2"
            #python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/man-$(hostname)'); nvim.command('Man $2'); nvim.command('only');"
            ;;
        "proc")
            if [ "x$2" != "x" ]
            then
                kill -${1:-9} $2
            fi
            ;;
    esac
}

i3-msg '[class="Termite" title="search"] scratchpad show'

for sel in "${selection[@]}"
do
    sel=(${sel//:/ })
    target=${sel[1]}
    launch ${sel[0]} $target
done

i3-msg '[class="URxvt" title="search"] kill'

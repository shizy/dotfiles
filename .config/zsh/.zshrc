# autoload
autoload -U compinit promptinit colors
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
promptinit
colors

# prompt
CMD_PROMPT="%~ %{$reset_color%}%{$(echo "\a")%}"

# path
typeset -U path
path=($path)

# default start dir
cd ~

# vim-mode
bindkey -v
function zle-line-init zle-keymap-select {
    NORMAL="%F{cyan}  $CMD_PROMPT  "
    INSERT="%F{green}  $CMD_PROMPT: "
    PROMPT="${${KEYMAP/vicmd/$NORMAL}/(main|viins)/$INSERT}"
    RPROMPT=""
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# keybinds
bindkey "\eh" backward-char
bindkey "\el" forward-char
bindkey "^?" backward-delete-char

bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'jk' accept-line

# aliases
alias ..="cd .."
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias wallpaper="$PUBLIC/wallpaper.sh"
alias vpn="$PRIVATE/vpn-pls.sh"
alias help='curl -F "f:1=<-" ix.io'
alias vnc="vncviewer"
alias src="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias ssh="$PUBLIC/ssh.sh"
alias men="/usr/bin/man -k"

man () {

    if [ ! -e "$XDG_RUNTIME_DIR/man-$(hostname)" ]; then
        i3-msg "exec urxvtc -name man -e $PUBLIC/nvim.sh man" > /dev/null
        python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/man-$(hostname)'); nvim.command('AirlineToggle');"
    fi

    python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/man-$(hostname)'); nvim.command('Man $1'); nvim.command('only');"
}

edit () {
    file="$(pwd)/$1"

    if [ ! -e $file ]; then
        touch $file
    fi

    ftype=$(file $file --mime-type | awk '{print $2}')

    if [[ $ftype == *"text"* ]] || [[ $ftype == *"empty"* ]]; then

        if [ ! -e "$XDG_RUNTIME_DIR/nvim-$(hostname)" ]; then
            i3-msg "exec urxvtc -name vim -e $PUBLIC/nvim.sh" > /dev/null
        fi

        python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim-$(hostname)'); nvim.command('hide e $file');"
    fi
}

rdp () {
    echo -n "Address: "
    read add
    echo -n "User@Domain: "
    read user
    xfreerdp /size:100% /u:$user /cert-ignore -grab-keyboard /v:$add
}

# backup dots / eratta to git
backup () {
    # public
	if [ ! -d "$PUBLIC" ]; then
		mkdir $PUBLIC 2>/dev/null
	fi

    # private
	if [ ! -d "$PRIVATE" ]; then
		mkdir $PRIVATE 2>/dev/null
	fi

    case $1 in
        *"pri"*)
            tar -cvf $HOME/private.tar -C $PRIVATE/ .
            gpg -r shizukesa --trust-model always --encrypt -o $HOME/private.tar.gpg $HOME/private.tar
            # requires gdrive from: https://github.com/prasmussen/gdrive
            gdrive -c $PRIVATE/gdrive upload -f $HOME/private.tar.gpg -p 0B1YL7dapddvyVjdSUVViUGwxRDA
            rm $HOME/private.tar
            rm $HOME/private.tar.gpg
            ;;
        *"doc"*)
            tar -cvf $HOME/docs.tar -C $HOME/docs/ .
            gpg -r shizukesa --trust-model always --encrypt -o $HOME/docs.tar.gpg $HOME/docs.tar
            # requires gdrive from: https://github.com/prasmussen/gdrive
            gdrive -c $PRIVATE/gdrive upload -f $HOME/docs.tar.gpg -p 0B1YL7dapddvyVjdSUVViUGwxRDA
            rm $HOME/docs.tar
            rm $HOME/docs.tar.gpg
            ;;
        *"con"*)
            # packages
            pacman -Qqne > $PUBLIC/pacman-backup
            pacman -Qqm > $PUBLIC/aur-backup
            mv $HOME/.git.off $HOME/.git
            git add -A
            git commit -m "$(date)"
            git push dot master
            mv $HOME/.git $HOME/.git.off
            ;;
    esac
}

# autoload
autoload -U compinit promptinit colors
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
promptinit
colors

# prompt
CMD_PROMPT="%~ %{$reset_color%}%{$(echo "\a")%}"

# path
typeset -U path
path=(~/bin ~/.npm/bin $path)

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

rdp ()
{
    echo -n "Address: "
    read add
    echo -n "User@Domain: "
    read user
    xfreerdp /u:$user /cert-ignore -grab-keyboard /v:$add
}

# backup dots / eratta to git
backup ()
{
    # public
	if [ ! -d "$PUBLIC" ]; then
		mkdir $PUBLIC 2>/dev/null
	fi

    # private
	if [ ! -d "$PRIVATE" ]; then
		mkdir $PRIVATE 2>/dev/null
	fi

    # backup private data
    if [[ $1 == *"pri"* ]]; then
        tar -cvf $HOME/private.tar -C $PRIVATE/ .
        gpg -r shizukesa --trust-model always --encrypt -o $HOME/private.tar.gpg $HOME/private.tar
        # requires gdrive from: https://github.com/prasmussen/gdrive
        gdrive -c $PRIVATE/gdrive upload -f $HOME/private.tar.gpg -p 0B1YL7dapddvyVjdSUVViUGwxRDA
        rm $HOME/private.tar
        rm $HOME/private.tar.gpg
    fi

    # backup docs
    if [[ $1 == *"doc"* ]]; then
        tar -cvf $HOME/docs.tar -C $HOME/docs/ .
        gpg -r shizukesa --trust-model always --encrypt -o $HOME/docs.tar.gpg $HOME/docs.tar
        # requires gdrive from: https://github.com/prasmussen/gdrive
        gdrive -c $PRIVATE/gdrive upload -f $HOME/docs.tar.gpg -p 0B1YL7dapddvyVjdSUVViUGwxRDA
        rm $HOME/docs.tar
        rm $HOME/docs.tar.gpg
    fi

    # backup config to git
    if [[ $1 == *"con"* ]]; then
        # packages
        pacman -Qqne > $PUBLIC/pacman-backup
        pacman -Qqm > $PUBLIC/aur-backup

        mv $HOME/.git.off $HOME/.git
        git add -A
        git commit -m "$(date)"
        git push dot master
        mv $HOME/.git $HOME/.git.off
    fi
}

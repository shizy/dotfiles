# autoload
autoload -U compinit promptinit colors
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
promptinit
colors

# prompt
CMD_PROMPT="%~ %{$reset_color%}%{$(echo "\a")%}"

# path
typeset -U path
path=($NPM_CONFIG_PREFIX/bin $HOME/dev/go/bin $GEM_PATH/bin $path)

# default start dir
cd ~

# vim-mode
bindkey -v
function zle-line-init zle-keymap-select {
    NORMAL="%B%F{200}  $CMD_PROMPT%f%b  "
    INSERT="%B%F{200}  $CMD_PROMPT%f%b: "
    PROMPT="${${KEYMAP/vicmd/$NORMAL}/(main|viins)/$INSERT}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# keybinds
bindkey "^?" backward-delete-char

bindkey -M vicmd "\eh" backward-word
bindkey -M vicmd "\el" forward-word
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'jk' accept-line

# aliases
alias ~="cd ~"
alias ..="cd .."
alias ls="ls -AlhF --group-directories-first --color=auto"
alias grep="grep --color=auto"
alias src="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias scp="scp -F $PRIVATE/ssh/ssh_config"
alias ssh="$LOCALDIR/bin/ssh"
alias men="/usr/bin/man -k"
alias rclone="rclone --config $PRIVATE/rclone/config"

man () {
    python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim'); nvim.command('Man $1');"
}

edit () {
    file="$(pwd)/$1"
    [[ ! -e "$file" ]] && touch "$file"
    ftype=$(file $file --mime-type | awk '{print $2}')
    if [[ $ftype == *"text"* ]] || [[ $ftype == *"empty"* ]]; then
        python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim'); nvim.command('hide e $file');"
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

    # private
	if [ ! -d "$PRIVATE" ]; then
		mkdir $PRIVATE 2>/dev/null
	fi

    case $1 in
        *"pri"*)
            tar -cvf $HOME/private.tar -C $PRIVATE/ .
            gpg -r shizukesa --trust-model always --encrypt -o $HOME/private.tar.gpg $HOME/private.tar
            rclone copy $HOME/private.tar.gpg gdrive:Backup
            rm $HOME/private.tar
            rm $HOME/private.tar.gpg
            ;;
        *"doc"*)
            tar -cvf $HOME/docs.tar -C $HOME/docs/ .
            gpg -r shizukesa --trust-model always --encrypt -o $HOME/docs.tar.gpg $HOME/docs.tar
            rclone copy $HOME/docs.tar.gpg gdrive:Backup
            rm $HOME/docs.tar
            rm $HOME/docs.tar.gpg
            ;;
        *"con"*)
            # packages
            /usr/bin/ls -1 $HOME/local/src > $XDG_CACHE_HOME/aur-backup
            cd ~/local
            git add -A
            git commit -m "$(date)"
            git push git@github.com:shizy/dotfiles.git
            ;;
    esac
}

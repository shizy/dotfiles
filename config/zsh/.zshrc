# autoload
autoload -U compinit promptinit colors
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
setopt transient_rprompt
promptinit
colors

# prompt
source /usr/share/git/completion/git-prompt.sh
CMD_PROMPT="%~ %{$reset_color%}%{$(echo "\a")%}"

# path
typeset -U path
path=($NPM_CONFIG_PREFIX/bin $HOME/dev/go/bin $GEM_PATH/bin $path)

# default start dir
cd ~

# vim-mode
bindkey -v
function zle-line-init zle-keymap-select {
    NORMAL=" $(__git_ps1 " %s ")%B%F{200}$CMD_PROMPT%f%b  "
    INSERT=" $(__git_ps1 " %s ")%B%F{200}$CMD_PROMPT%f%b: "
    [[ -z "$SSH_CLIENT" ]] && RPROMPT="" || RPROMPT="%{$reset_color%}%M"
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
alias rm="rm -rf"
alias ls="ls -AlhF --group-directories-first --color=auto"
alias grep="grep --color=auto"
alias src="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias scp="scp -F $PRIVATE/ssh/ssh_config"
alias ssh="$LOCALDIR/bin/ssh"
alias rclone="rclone --config $PRIVATE/rclone/config"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias du="du --time -had 1 | sort -t '/' -k 2,2"
alias userctl="systemctl --user"
alias prox="proxychains -f $XDG_CONFIG_HOME/proxychains/proxychains.conf -q"

man () {
    python -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim'); nvim.command('Man $1');"
}

edit () {
    file="$(pwd)/$1"
    [[ ! -e "$file" ]] && touch "$file"
    ftype=$(file $file --mime-type | awk '{print $2}')
    if [[ $ftype == *"text"* ]] || [[ $ftype == *"empty"* ]]; then
        python -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim'); nvim.command('bad $file');"
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
    esac
}

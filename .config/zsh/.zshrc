# autoload
autoload -U compinit promptinit colors
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
promptinit
colors

# prompt
CMD_PROMPT="%~ %{$reset_color%}%{$(echo "\a")%}"

# path
typeset -U path
path=($NPM_CONFIG_PREFIX/bin $HOME/dev/go/bin $path)

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
alias vpn="$PRIVATE/vpn-pls.sh"
alias help='curl -F "f:1=<-" ix.io'
alias vnc="vncviewer"
alias src="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias scp="scp -F $PRIVATE/ssh/ssh_config"
alias men="/usr/bin/man -k"
alias firefox="firefox --profile $XDG_CACHE_HOME/mozilla/firefox -P shizy"

man () { nvim "Man $1" }

edit () {
    file="$(pwd)/$1"

    if [ ! -e $file ]; then
        touch $file
    fi

    ftype=$(file $file --mime-type | awk '{print $2}')

    if [[ $ftype == *"text"* ]] || [[ $ftype == *"empty"* ]]; then

        nvim "hide e $file"
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
            #pacman -Qqne > $XDG_CACHE_HOME/pacman-backup
            pacman -Qqm > $XDG_CACHE_HOME/aur-backup
            #mv $HOME/.git.off $HOME/.git
            mv $XDG_CONFIG_HOME/gitignore $HOME/.gitignore
            git --work-tree=$HOME --git-dir=$HOME/.local/git add -A
            git --work-tree=$HOME --git-dir=$HOME/.local/git commit -m "$(date)"
            #git $params push origin master
            #mv $HOME/.git $HOME/.git.off
            mv $HOME/.gitignore $XDG_CONFIG_HOME/gitignore
            ;;
    esac
}

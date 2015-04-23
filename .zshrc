# autoload
autoload -U compinit promptinit colors
compinit
promptinit
colors

# prompt
CMD_PROMPT="%~ %{$reset_color%}%{$(echo "\a")%}: "

# path
typeset -U path
path=(~/bin ~/.npm/bin $path)

# default start dir
cd ~

# vim-mode
bindkey -v
function zle-line-init zle-keymap-select {
    NORMAL="%F{cyan}! $CMD_PROMPT"
    INSERT="%F{green}  $CMD_PROMPT"
    PROMPT="${${KEYMAP/vicmd/$NORMAL}/(main|viins)/$INSERT}"
    RPROMPT=""
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# exports
export EDITOR=nvim

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wallpaper='~/.public/wallpaper.sh'
alias vpn='~/.private/vpn-pls.sh'
alias help="curl -F 'f:1=<-' ix.io"
alias xclip="xclip -selection clipboard"
alias vnc="vncviewer"

# backup dots / eratta to git
backup ()
{
    # public
	if [ ! -d "$HOME/.public" ]; then
		mkdir $HOME/.public 2>/dev/null
	fi

    # private
	if [ ! -d "$HOME/.private" ]; then
		mkdir $HOME/.private 2>/dev/null
	fi

    # tar and encrypt .private / Docs
    tar -cvf $HOME/private.tar -C $HOME/.private/ .
    tar -cvf $HOME/docs.tar -C $HOME/Docs/ .
    gpg -r shizukesa --trust-model always --encrypt -o $HOME/private.tar.gpg $HOME/private.tar
    gpg -r shizukesa --trust-model always --encrypt -o $HOME/docs.tar.gpg $HOME/docs.tar
    # requires gdrive from: https://github.com/prasmussen/gdrive
    gdrive upload -f $HOME/private.tar.gpg -p 0B1YL7dapddvyVjdSUVViUGwxRDA
    gdrive upload -f $HOME/docs.tar.gpg -p 0B1YL7dapddvyVjdSUVViUGwxRDA
    rm $HOME/private.tar
    rm $HOME/private.tar.gpg
    rm $HOME/docs.tar
    rm $HOME/docs.tar.gpg


    # packages
    pacman -Qqne > $HOME/.public/pacman-backup
    pacman -Qqm > $HOME/.public/aur-backup

    mv $HOME/.git.off $HOME/.git
    git add -A
    git commit -m "$(date)"
    git push dot master
    mv $HOME/.git $HOME/.git.off
}

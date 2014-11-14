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
export EDITOR=vim

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wallpaper='~/.takealongs/wallpaper.sh'
alias unpackaged="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type d -print | sed 's/\([^/]\)$/\1\//' | sort -u) <(pacman -Qlq | sort -u)"
alias vpn='~/.staybehinds/vpn-pls.sh'
alias help="curl -F 'f:1=<-' ix.io"

# backup dots / eratta to git
backup ()
{
    # public
	if [ ! -d "$HOME/.takealongs" ]; then
		mkdir $HOME/.takealongs 2>/dev/null
	fi

    # private
	if [ ! -d "$HOME/.staybehinds" ]; then
		mkdir $HOME/.staybehinds 2>/dev/null
	fi

    # tar and encrypt .staybehinds
    tar -cvf $HOME/staybehinds.tar -C $HOME/.staybehinds/ .
    gpg -r shizukesa --trust-model always --encrypt -o $HOME/staybehinds.tar.gpg $HOME/staybehinds.tar
    # requires gdrive from: https://github.com/prasmussen/gdrive
    gdrive upload -f $HOME/staybehinds.tar.gpg -p 0B1YL7dapddvyVjdSUVViUGwxRDA
    rm $HOME/staybehinds.tar
    rm $HOME/staybehinds.tar.gpg

    # packages
    pacman -Qqne > $HOME/.takealongs/pacman-backup
    pacman -Qqm > $HOME/.takealongs/aur-backup

    mv $HOME/.git.off $HOME/.git
    git add -A
    git commit -m "$(date)"
    git push dot master
    mv $HOME/.git $HOME/.git.off
}

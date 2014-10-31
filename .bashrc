#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# default start dir
cd ~

# vi mode
set -o vi

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
    cd $HOME
    # public
	if [ ! -d "$HOME/.takealongs" ]; then
		mkdir $HOME/.takealongs 2>/dev/null
	fi

    # private
	if [ ! -d "$HOME/.staybehinds" ]; then
		mkdir $HOME/.staybehinds 2>/dev/null
	fi

    # tar and encrypt .staybehinds
    tar -cvf $HOME/staybehinds.tar .staybehinds/
    gpg -r shizukesa --trust-model always --encrypt -o $HOME/staybehinds.tar.gpg $HOME/staybehinds.tar
    # requires gdrive from: https://github.com/prasmussen/gdrive
    gdrive upload -f $HOME/staybehinds.tar.gpg -p 0B1YL7dapddvyVjdSUVViUGwxRDA
    rm $HOME/staybehinds.tar
    rm $HOME/staybehinds.tar.gpg

    # packages
	pacman -Qqne > $HOME/.takealongs/pacman-backup
	pacman -Qqm > $HOME/.takealongs/aur-backup

    # folders
    git add $HOME/.takealongs
    git add $HOME/.i3
    git add $HOME/.fonts

    # files
    git add $HOME/.ssh/config
    git add $HOME/.weechat/weechat.conf
    git add $HOME/.gitignore
    git add $HOME/.muttrc
    git add $HOME/.Xresources
    git add $HOME/.xinitrc
    git add $HOME/.bashrc
    git add $HOME/.bash_profile
    git add $HOME/.vimrc

    git commit -m "$(date)"
    git push dot master
}

PS1='[\[\e[0;36m\] \w \[\e[0m\]]: \a'
PATH=$PATH:~/.npm/bin

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# default start dir
if [ "$(whoami)" != 'root' ]; then
  cd ~
fi

# vi mode
set -o vi
export EDITOR=vim
export editor=vim

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wallpaper='~/.takealongs/wallpaper.sh'
alias unpackaged="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type d -print | sed 's/\([^/]\)$/\1\//' | sort -u) <(pacman -Qlq | sort -u)"
alias vpn='~/.staybehinds/vpn-pls.sh'

# backup dots / eratta to git
backup ()
{
	if [ ! -d "$HOME/.takealongs" ]; then
		mkdir $HOME/.takealongs 2>/dev/null
	fi

	pacman -Qqne > $HOME/.takealongs/pacman-backup
	pacman -Qqm > $HOME/.takealongs/aur-backup

    # folders
    git add $HOME/.takealongs
    git add $HOME/.i3
    git add $HOME/.fonts

    # files
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

PS1='[\[\e[0;36m\] \w \[\e[0m\]]: '
PATH=$PATH:~/.npm/bin

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
export editor=vim

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wallpaper='~/.takealongs/wallpaper.sh'

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
    git add $HOME/.urlview
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

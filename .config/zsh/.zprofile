export PAGER=less
export EDITOR=nvim
export BROWSER=google-chrome
export TERM=rxvt-unicode-256color

# XDG
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# git
export GIT_SSH=$HOME/.public/ssh.sh

# gnupg
export GNUPGHOME=$XDG_CONFIG_HOME/gnupg

# gimp
export GIMP2_DIRECTORY=$XDG_CONFIG_HOME/gimp

# less
export LESSHISTFILE=/dev/null

# mplayer
export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer

# pass
export PASSWORD_STORE_DIR=$HOME/.private/password-store

# texlive
export TEXMFVAR=$XDG_CACHE_HOME/texlive

# urxvt
export RXVT_SOCKET=$XDG_CONFIG_HOME/urxvt/urxvtd-$(hostname)

# x11
export XAUTHORITY=$XDG_RUNTIME_DIR/.Xauthority


exec startx $XDG_CONFIG_HOME/x11/xinitrc

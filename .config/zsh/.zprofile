export PRIVATE=$HOME/.private
export PUBLIC=$HOME/.public

export PAGER=less
export EDITOR=nvim
export BROWSER=google-chrome
export TERM=rxvt-unicode-256color

# XDG
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

# cargo
export CARGO_HOME=$XDG_CACHE_HOME/cargo

# git
export GIT_SSH=$PUBLIC/ssh.sh

# gnupg
export GNUPGHOME=$XDG_CONFIG_HOME/gnupg

# gimp
export GIMP2_DIRECTORY=$XDG_CONFIG_HOME/gimp

# less
export LESSHISTFILE=$XDG_CACHE_HOME/less/lesshist

# mplayer
export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer

# neovim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/nvim/nvimrc" | source $MYVIMRC'

# pass
export PASSWORD_STORE_DIR=$PRIVATE/password-store

# texlive
export TEXMFVAR=$XDG_CACHE_HOME/texlive

# urxvt
export RXVT_SOCKET=$XDG_RUNTIME_DIR/urxvtd-$(hostname)

# x11
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority


exec startx $XDG_CONFIG_HOME/x11/xinitrc

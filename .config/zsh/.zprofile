
export PRIVATE=$HOME/.local/private
export PAGER=less
export EDITOR=nvim
export BROWSER=firefox

# XDG
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

export PATH=$HOME/.local/bin:$PATH

# bzr
export BZR_LOG=/dev/null

# cargo
export CARGO_HOME=$XDG_CACHE_HOME/cargo

#firefox
export XRE_IMPORT_PROFILES=1

# git
export GIT_SSH=$HOME/.local/bin/ssh

# gnupg
export GNUPGHOME=$XDG_CONFIG_HOME/gnupg

# go
export GOPATH=$HOME/dev/go

# gimp
export GIMP2_DIRECTORY=$XDG_CONFIG_HOME/gimp

# less
export LESSHISTFILE=$XDG_CACHE_HOME/less/lesshist

# mplayer
export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer

# neovim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/nvim/nvimrc" | source $MYVIMRC'
export NVIM_LISTEN_ADDRESS=$XDG_RUNTIME_DIR/nvim

# npm
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_PREFIX=$XDG_DATA_HOME/node_modules

# pass
export PASSWORD_STORE_DIR=$PRIVATE/password-store

# pentadactyl
export PENTADACTYL_RUNTIME=$XDG_CONFIG_HOME/pentadactyl
export PENTADACTYL_INIT='source $XDG_CONFIG_HOME/pentadactyl/pentadactylrc'

# texlive
export TEXMFVAR=$XDG_CACHE_HOME/texlive

# urxvt
export RXVT_SOCKET=$XDG_RUNTIME_DIR/urxvtd-$(hostname)


source <(dircolors $XDG_CONFIG_HOME/termite/dircolors)
if [[ $(tty) == "/dev/tty1" ]]; then
    exec mystartx $XDG_CONFIG_HOME/x11/xinitrc
fi

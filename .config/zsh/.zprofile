
export PRIVATE=$HOME/.local/private
export PAGER=less
export EDITOR=nvim
export BROWSER=qutebrowser

# XDG
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

export PATH=$HOME/.local/bin:$HOME/.local/private/bin:$PATH

# bzr
export BZR_LOG=/dev/null

# cargo
export CARGO_HOME=$XDG_DATA_HOME/cargo

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
export NVIM_LISTEN_ADDRESS=$XDG_RUNTIME_DIR/nvim

# notmuch
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/notmuchrc
export NMBGIT=$XDG_DATA_HOME/notmuch/nmbug

# npm
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_PREFIX=$XDG_DATA_HOME/npm

# pass
export PASSWORD_STORE_DIR=$PRIVATE/password-store

# ruby
export GEM_HOME=$XDG_DATA_HOME/gems
export GEM_PATH=$XDG_DATA_HOME/gems
export GEM_SPEC_CACHE=$XDG_DATA_HOME/gems

# texlive
export TEXMFVAR=$XDG_CACHE_HOME/texlive

# virtualbox
export VBOX_USER_HOME=$XDG_DATA_HOME/virtualbox

# x11
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export XINITRC=$XDG_CONFIG_HOME/x11/xinitrc

source <(dircolors $XDG_CONFIG_HOME/termite/dircolors)

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] &&
    unset SESSION_MANAGER
    export DISPLAY=":$XDG_VTNR"
    xinit "$XINITRC" -- $DISPLAY vt"$XDG_VTNR" -keeptty -nolisten tcp -br -auth "$XAUTHORITY"

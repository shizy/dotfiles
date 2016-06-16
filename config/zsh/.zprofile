# Personal Preferences
export DESKTOP_ICONS="  :   :  :   :   :   :   :   :   :   "
export COLOR_URGENT="#B1D631"
export COLOR_NORMAL="#F1FAEE"
export COLOR_NOTIFY="#7E8AA2"
export FONT_MONO="M+ 1m"
export FONT_ICON="Icons"
export PAGER=less
export EDITOR=nvim
export BROWSER=qutebrowser
export PRIVATE=$LOCALDIR/private

# Path
export PATH=$LOCALDIR/bin:$PRIVATE/bin:$PATH:/usr/bin/core_perl

# bzr
export BZR_LOG=/dev/null

# cargo
export CARGO_HOME=$XDG_DATA_HOME/cargo

# elinks
export ELINKS_CONFDIR=$XDG_CONFIG_HOME/elinks

# git
export GIT_SSH=$LOCALDIR/bin/ssh

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

# texlive
export TEXMFVAR=$XDG_CACHE_HOME/texlive

# virtualbox
export VBOX_USER_HOME=$XDG_DATA_HOME/virtualbox

# x11
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export XINITRC=$XDG_CONFIG_HOME/x11/xinitrc


source <(dircolors $XDG_CONFIG_HOME/termite/dircolors)

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    unset SESSION_MANAGER
    export DISPLAY=":$XDG_VTNR"
    xinit "$XINITRC" -- $DISPLAY vt"$XDG_VTNR" -keeptty -br
fi

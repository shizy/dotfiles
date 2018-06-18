# Personal Preferences
export COLOR_DARK="#080808"
export COLOR_DARK_OFFSET="#585858"
export COLOR_URGENT="#B1D631"
export COLOR_NORMAL="#F1FAEE"
export COLOR_NOTIFY="#7E8AA2"
export FONT_MONO="M\+ 1m"
export FONT_SIZE=11
export FONT_ICON="Icons"
export ICON_SIZE=14
export PAGER=less
export EDITOR=nvim
export BROWSER=qutebrowser
export PRIVATE=$LOCALDIR/private

# bzr
export BZR_LOG=/dev/null

# cargo
export CARGO_HOME=$XDG_DATA_HOME/cargo

# elinks
export ELINKS_CONFDIR=$XDG_CONFIG_HOME/elinks

# git
export GIT_SSH=$LOCALDIR/bin/ssh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="verbose"

# gnupg
export GNUPGHOME=$XDG_CONFIG_HOME/gnupg

# go
export GOPATH=$XDG_DATA_HOME/go:$XDG_RUNTIME_DIR
if [ ! -L $XDG_RUNTIME_DIR/src ]; then
    ln -s $HOME/dev $XDG_RUNTIME_DIR/src
fi

# gimp
export GIMP2_DIRECTORY=$XDG_CONFIG_HOME/gimp

# ipfs
export IPFS_PATH=$XDG_DATA_HOME/ipfs

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

# ruby
export GEM_PATH=$XDG_DATA_HOME/ruby/bin
export GEM_HOME=$XDG_DATA_HOME/ruby
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/ruby
export GEMRC=$XDG_CONFIG_HOME/ruby/gemrc

# ssh
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# texlive
export TEXMFVAR=$XDG_CACHE_HOME/texlive

# weechat
export WEECHAT_HOME=$PRIVATE/weechat

# x11
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export XINITRC=$XDG_CONFIG_HOME/x11/xinitrc

# Path
export PATH=$LOCALDIR/bin:$PRIVATE/bin:$PATH:/usr/bin/core_perl:$GEM_PATH:$XDG_DATA_HOME/go/bin

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    unset SESSION_MANAGER
    export DISPLAY=":$XDG_VTNR"
    xinit "$XINITRC" -- $DISPLAY vt"$XDG_VTNR" -keeptty -br
fi

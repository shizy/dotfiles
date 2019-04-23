# vim: ft=sh:

# Personal Preferences
set -x COLOR_DARK "#080808"
set -x COLOR_DARK_OFFSET "#585858"
set -x COLOR_URGENT "#2EC6C6"
set -x COLOR_NORMAL "#F1FAEE"
set -x COLOR_NOTIFY "#7E8AA2"
set -x FONT_MONO "Iosevka SS08"
set -x FONT_SIZE 11
set -x FONT_ICON "Icons"
set -x ICON_SIZE 14
set -x PAGER less
set -x EDITOR nvim
set -x BROWSER qutebrowser
set -x PRIVATE $LOCALDIR/private

# bzr
set -x BZR_LOG /dev/null

# cargo
set -x CARGO_HOME $XDG_DATA_HOME/cargo

# elinks
set -x ELINKS_CONFDIR $XDG_CONFIG_HOME/elinks

# fzf
set -x FZF_DEFAULT_OPTS "--margin=2,5 --color dark,hl:200,pointer:200,marker:202,prompt:200 -m --select-1 --exit-0 --bind 'esc:abort,alt-j:down,alt-k:up,alt-h:backward-char,alt-l:forward-char,alt-enter:toggle,alt-x:unix-line-discard'"

# git
set -x GIT_SSH $LOCALDIR/bin/ssh
set -x GIT_PS1_SHOWDIRTYSTATE 1
set -x GIT_PS1_SHOWSTASHSTATE 1
set -x GIT_PS1_SHOWUPSTREAM "auto"

# gnupg
set -x GNUPGHOME $XDG_CONFIG_HOME/gnupg

# go
set -x GOPATH $XDG_DATA_HOME/go:$XDG_RUNTIME_DIR
if test ! -e $XDG_RUNTIME_DIR/src
    ln -s $HOME/dev $XDG_RUNTIME_DIR/src
end

# gimp
set -x GIMP2_DIRECTORY $XDG_CONFIG_HOME/gimp

# ipfs
set -x IPFS_PATH $XDG_DATA_HOME/ipfs

# less
set -x LESSHISTFILE $XDG_CACHE_HOME/less/lesshist

# mplayer
set -x MPLAYER_HOME $XDG_CONFIG_HOME/mplayer

# neovim
set -x NVIM_LISTEN_ADDRESS $XDG_RUNTIME_DIR/nvim

# notmuch
set -x NOTMUCH_CONFIG $XDG_CONFIG_HOME/notmuch/notmuchrc
set -x NMBGIT $XDG_DATA_HOME/notmuch/nmbug

# npm
set -x NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -x NPM_CONFIG_PREFIX $XDG_DATA_HOME/npm

# ruby
#set -x GEM_PATH $XDG_DATA_HOME/ruby/bin
set -x GEM_HOME $XDG_DATA_HOME/ruby
set -x GEM_SPEC_CACHE $XDG_CACHE_HOME/ruby
set -x GEMRC $XDG_CONFIG_HOME/ruby/gemrc

# ssh
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

# texlive
set -x TEXMFVAR $XDG_CACHE_HOME/texlive

# weechat
set -x WEECHAT_HOME $PRIVATE/weechat

# wine
set -x WINEPREFIX $XDG_DATA_HOME/wine

# x11
set -x XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -x XINITRC $XDG_CONFIG_HOME/x11/xinitrc

# Path
set -x PATH $LOCALDIR/bin $PRIVATE/bin /usr/bin/core_perl $GEM_PATH $XDG_DATA_HOME/go/bin $PATH


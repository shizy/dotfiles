# Personal Preferences
set -x COLOR_000    "#101010"
set -x COLOR_001    "#7c7c7c"
set -x COLOR_002    "#8e8e8e"
set -x COLOR_003    "#a0a0a0"
set -x COLOR_004    "#686868"
set -x COLOR_005    "#747474"
set -x COLOR_006    "#868686"
set -x COLOR_007    "#b9b9b9"
set -x COLOR_008    "#525252"
set -x COLOR_009    "#7c7c7c"
set -x COLOR_010    "#8e8e8e"
set -x COLOR_011    "#a0a0a0"
set -x COLOR_012    "#686868"
set -x COLOR_013    "#747474"
set -x COLOR_014    "#868686"
set -x COLOR_015    "#b9b9b9"

set -x COLOR_DARK   "$COLOR_000"
set -x COLOR_DARK2  "$COLOR_008"
set -x COLOR_MEDIUM "#928374"
set -x COLOR_LIGHT  "#fbf1c7"
set -x COLOR_ADD    "#b8bb26"
set -x COLOR_CHANGE "#ff9800"
set -x COLOR_REMOVE "#fb4934"
if test -z "$COLOR_ACCENT"
    set -x COLOR_ACCENT (random choice "#e7f695" "#a5f69d" "#90e1f9" )
end

set -x FONT_MONO "Iosevka Custom"
set -x FONT_SIZE 11
set -x FONT_ICON "Icons"
set -x ICON_SIZE 14
set -x MANPAGER "/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
set -x PAGER less
set -x EDITOR nvim
set -x BROWSER qutebrowser
set -x PRIVATE $XDG_RUNTIME_DIR/private

# bash
set -x HISTFILE $XDG_CACHE_HOME/bash_history

# bzr
set -x BZR_LOG /dev/null

# cargo
set -x CARGO_HOME $XDG_DATA_HOME/cargo

# elinks
set -x ELINKS_CONFDIR $XDG_CONFIG_HOME/elinks

# fzf
set -x FZF_DEFAULT_OPTS "--color dark,hl:$COLOR_ACCENT,pointer:$COLOR_ACCENT,marker:$COLOR_ACCENT,prompt:$COLOR_ACCENT -m --select-1 --exit-0 --bind 'esc:abort,alt-j:down,alt-k:up,alt-h:backward-char,alt-l:forward-char,alt-x:unix-line-discard'"

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


# Personal Preferences
export COLOR_000="#101010"
export COLOR_001="#7c7c7c"
export COLOR_002="#8e8e8e"
export COLOR_003="#a0a0a0"
export COLOR_004="#686868"
export COLOR_005="#747474"
export COLOR_006="#868686"
export COLOR_007="#b9b9b9"
export COLOR_008="#525252"
export COLOR_009="#7c7c7c"
export COLOR_010="#8e8e8e"
export COLOR_011="#a0a0a0"
export COLOR_012="#686868"
export COLOR_013="#747474"
export COLOR_014="#868686"
export COLOR_015="#b9b9b9"


export COLOR_DARK="$COLOR_000"
export COLOR_DARK2="$COLOR_008"
export COLOR_MEDIUM="#928374"
export COLOR_LIGHT="#fbf1c7"
export COLOR_ADD="#b8bb26"
export COLOR_CHANGE="#ff9800"
export COLOR_REMOVE="#fb4934"

#accent_choices=("#e7f695" "#a5f69d" "#90e1f9")
export COLOR_ACCENT="#e7f695"


export FONT_MONO="Iosevka Custom"
export FONT_SIZE=11
export FONT_ICON="Icons"
export ICON_SIZE=14
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
export PAGER=less
export EDITOR=nvim
export BROWSER=qutebrowser
export PRIVATE=$XDG_RUNTIME_DIR/private


# bash
export HISTFILE=$XDG_CACHE_HOME/bash_history


# bzr
export BZR_LOG=/dev/null


# cargo
export CARGO_HOME=$XDG_DATA_HOME/cargo


# elinks
export ELINKS_CONFDIR=$XDG_CONFIG_HOME/elinks


# fzf
export FZF_DEFAULT_OPTS="--color dark,hl:$COLOR_ACCENT,pointer:$COLOR_ACCENT,marker:$COLOR_ACCENT,prompt:$COLOR_ACCENT -m --select-1 --exit-0 --bind 'esc:abort,alt-j:down,alt-k:up,alt-h:backward-char,alt-l:forward-char,alt-x:unix-line-discard'"


# git
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=$XDG_CACHE_HOME/ssh/known_hosts"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"


# gnupg
export GNUPGHOME=$XDG_CONFIG_HOME/gnupg


# gimp
export GIMP2_DIRECTORY=$XDG_CONFIG_HOME/gimp


# ipfs
export IPFS_PATH=$XDG_DATA_HOME/ipfs


# less
export LESSHISTFILE=$XDG_CACHE_HOME/less/lesshist


# mplayer
export MPLAYER_HOME=$XDG_CONFIG_HOME/mplayer


# notmuch
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/notmuchrc
export NMBGIT=$XDG_DATA_HOME/notmuch/nmbug


# npm
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
export NPM_CONFIG_PREFIX=$XDG_DATA_HOME/npm


# qt
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1


# ruby
#export GEM_PATH $XDG_DATA_HOME/ruby/bin
export GEM_HOME=$XDG_DATA_HOME/ruby
export GEM_SPEC_CACHE=$XDG_CACHE_HOME/ruby
export GEMRC=$XDG_CONFIG_HOME/ruby/gemrc


# rust
export RUSTUP_HOME=$XDG_DATA_HOME/rust/rustup
export CARGO_HOME=$XDG_CACHE_HOME/cargo


# ssh
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket


# texlive
export TEXMFVAR=$XDG_CACHE_HOME/texlive


# weechat
export WEECHAT_HOME=$PRIVATE/weechat


# wine
export WINEPREFIX=$XDG_DATA_HOME/wine


# x11
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export XINITRC=$XDG_CONFIG_HOME/x11/xinitrc


# Path
export PATH=$LOCALDIR/bin:$PRIVATE/bin:/usr/bin/core_perl:$GEM_PATH:$XDG_DATA_HOME/go/bin:$PATH:$RUSTUP_HOME


if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    sway
fi

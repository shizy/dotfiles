#!/bin/bash

target="nvim"
suffix="-S $XDG_CACHE_HOME/nvim/session.vim -i $XDG_CACHE_HOME/nvim/nviminfo"

if [ ! -e "$XDG_RUNTIME_DIR/nvim" ]; then
    termite --title=vim -e "/usr/bin/nvim $suffix" & disown
fi

#foreach!
if [ "$1" ]; then
    python2 -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim'); nvim.command('$1');"
fi
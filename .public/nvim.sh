#!/bin/bash

# using nvim to view man pages in a dedicated workspace
if [[ $1 == "man" ]]; then
    target="man"
    suffix= ""
else
    target="nvim"
    suffix="-S $XDG_CACHE_HOME/nvim/session.vim"
fi

rm $XDG_RUNTIME_DIR/$target-$(hostname) 2>/dev/null
NVIM_LISTEN_ADDRESS=$XDG_RUNTIME_DIR/$target-$(hostname) /usr/bin/nvim $suffix

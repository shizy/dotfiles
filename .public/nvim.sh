#!/bin/bash

NVIM_LISTEN_ADDRESS=$XDG_RUNTIME_DIR/nvim-$(hostname) /usr/bin/nvim -S $XDG_CACHE_HOME/nvim/session.vim

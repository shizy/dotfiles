#!/bin/bash

if [[ -e $XDG_RUNTIME_DIR/quteproxy ]]; then
    echo "set --print network proxy system" >> "$QUTE_FIFO"
    rm $XDG_RUNTIME_DIR/quteproxy
else
    echo "set --print network proxy socks://127.0.0.1:8888" >> "$QUTE_FIFO"
    touch $XDG_RUNTIME_DIR/quteproxy
fi


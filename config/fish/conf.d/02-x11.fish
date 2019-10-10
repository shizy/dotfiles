if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        #set -e SESSION_MANAGER
        #set -x DISPLAY ":$XDG_VTNR"
        #xinit "$XINITRC" -- $DISPLAY vt"$XDG_VTNR" -keeptty -br
        cat $XDG_CONFIG_HOME/sway/template | sed 's/#000000/'"$COLOR_DARK"'/g; s/#888888/'"$COLOR_MEDIUM"'/g; s/#FFFFFF/'"$COLOR_LIGHT"'/g; s/#FF0000/'"$COLOR_ACCENT"'/g;' > $XDG_RUNTIME_DIR/swayconfig

        exec sway -c $XDG_RUNTIME_DIR/swayconfig
    end
end

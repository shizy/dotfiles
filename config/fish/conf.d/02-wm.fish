if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec sway
    end
end

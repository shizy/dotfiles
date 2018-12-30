# vim: ft=sh:

if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        set -e SESSION_MANAGER
        set -x DISPLAY ":$XDG_VTNR"
        xinit "$XINITRC" -- $DISPLAY vt"$XDG_VTNR" -keeptty -br
    end
end

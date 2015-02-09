[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]
export PASSWORD_STORE_DIR=~/.private/.password-store
exec startx

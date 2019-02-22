# vim: ft=sh:

set color_normal (echo $COLOR_NORMAL | sed -e 's/#//g')
set color_urgent (echo $COLOR_URGENT | sed -e 's/#//g')
set color_dark_offset (echo $COLOR_DARK_OFFSET | sed -e 's/#//g')

set -U fish_greeting
set fish_color_command $color_normal
set fish_color_redirection $color_urgent
set fish_color_end $color_urgent
set fish_pager_color_prefix $color_urgent
set fish_pager_color_description $color_dark_offset

# Alias{{{
alias ..="pushd .."
alias rm="rm -rf"
alias ls="ls -AlhF --group-directories-first --color=auto"
alias grep="grep --color=auto"
alias src="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias scp="scp -F $PRIVATE/ssh/ssh_config"
alias ssh="$LOCALDIR/bin/ssh"
alias rclone="rclone --config $PRIVATE/rclone/config"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias du="du --time -had 1 | sort -t '/' -k 2,2"
alias userctl="systemctl --user"
alias prox="proxychains -f $XDG_CONFIG_HOME/proxychains/proxychains.conf -q"
alias netctl="sudo netctl-auto"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
#}}}

# Prompt {{{
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'no'
set __fish_git_prompt_showupstream 'no'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red
set __fish_git_prompt_char_untrackedfiles ''
set __fish_git_prompt_char_dirtystate '  '
set __fish_git_prompt_char_stagedstate '  '
set __fish_git_prompt_char_stashstate ' '
set __fish_git_prompt_char_upstream_behind ' '
set __fish_git_prompt_char_upstream_ahead ' '
set __fish_git_prompt_char_upstream_equal ''

set fish_prompt_pwd_dir_length 4
set fish_cursor_default block
set fish_cursor_insert underscore
set fish_cursor_visual block

function fish_mode_prompt
end
function fish_prompt
    set mode ">"
    switch $fish_bind_mode
        case 'default'
            set mode ":"
    end
    set git (__fish_git_prompt)
    if test ! -z "$git"
        set git (echo $git | sed -e 's/(/\ \ /;s/[()…]//g')
        set git " $git "
    end
    echo -n "$git"
    set_color -o $color_urgent
    echo -n " " (prompt_pwd)
    set_color -o $color_dark_offset
    echo -n "  $mode  "
    set_color normal
end
#}}}

# Binds{{{
function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M default \e\r accept-autosuggestion
    bind -M insert \e\r accept-autosuggestion
    bind -M insert -m default jj backward-char force-repaint
    bind -M default \eh backward-word
    bind -M default \el forward-word
    bind -M default \eH 'pushd ..; commandline -f repaint'
    bind -M insert \eH 'pushd ..; commandline -f repaint'
    bind -M default \eL 'popd > /dev/null ^ /dev/null; commandline -f repaint'
    bind -M insert \eL 'popd > /dev/null ^ /dev/null; commandline -f repaint'
    bind -M insert \e/ complete-and-search
    bind -M default \e/ complete-and-search
end
#}}}

function edit
    set file (pwd)/$argv
    python -c "from neovim import attach; nvim=attach('socket', path='$XDG_RUNTIME_DIR/nvim'); nvim.command('bad $file');"
end

function backup

    switch $argv
        case '*pri*'
            tar -cvf $HOME/private.tar -C $PRIVATE/ .
            gpg -r shizukesa --trust-model always --encrypt -o $HOME/private.tar.gpg $HOME/private.tar
            rclone copy $HOME/private.tar.gpg gdrive:Backup
            rm $HOME/private.tar
            rm $HOME/private.tar.gpg
        case '*doc*'
            tar -cvf $HOME/docs.tar -C $HOME/docs/ .
            gpg -r shizukesa --trust-model always --encrypt -o $HOME/docs.tar.gpg $HOME/docs.tar
            rclone copy $HOME/docs.tar.gpg gdrive:Backup
            rm $HOME/docs.tar
            rm $HOME/docs.tar.gpg
    end
end

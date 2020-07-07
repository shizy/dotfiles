set color_light (echo $COLOR_LIGHT | sed -e 's/#//g')
set color_accent (echo $COLOR_ACCENT | sed -e 's/#//g')
set color_medium (echo $COLOR_MEDIUM | sed -e 's/#//g')
set color_dark (echo $COLOR_DARK | sed -e 's/#//g')
set color_add (echo $COLOR_ADD | sed -e 's/#//g')
set color_change (echo $COLOR_CHANGE | sed -e 's/#//g')
set color_remove (echo $COLOR_REMOVE | sed -e 's/#//g')
set color_dark2 (echo $COLOR_DARK2 | sed -e 's/#//g')

set -U fish_greeting

# Alias {{{
alias ..="pushd .."
alias rm="rm -rf"
alias ls="ls -AlhF --group-directories-first --color=auto"
alias grep="grep --color=auto"
alias src="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias ssh="$LOCALDIR/bin/ssh"
alias rclone="rclone --config $PRIVATE/rclone/config"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias du="du --time -had 1 | sort -t '/' -k 2,2"
alias icat="/usr/bin/kitty +kitten icat"
alias userctl="systemctl --user"
alias prox="proxychains -f $XDG_CONFIG_HOME/proxychains/proxychains.conf -q"
alias netctl="netctl-auto"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias cat="bat"
alias more="bat"
alias updatemirrorlist="sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist"
alias meson="meson .build"
#}}}

# Prompt {{{
set fish_color_autosuggestion $color_dark2
set fish_color_cancel normal
set fish_color_command $color_light --bold
set fish_color_comment normal
set fish_color_cwd normal
set fish_color_cwd_root normal
set fish_color_end $color_accent
set fish_color_error normal
set fish_color_escape $color_change
set fish_color_history_current normal
set fish_color_host normal
set fish_color_match normal
set fish_color_normal normal
set fish_color_operator normal
set fish_color_param normal
set fish_color_quote $color_dark2
set fish_color_redirection $color_accent
set fish_color_search_match normal
set fish_color_selection normal
set fish_color_user normal
set fish_color_valid_path normal

set fish_pager_color_description $color_medium
set fish_pager_color_prefix $color_accent
set fish_pager_color_progress $color_light

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'no'
set __fish_git_prompt_showupstream 'no'
set __fish_git_prompt_color_branch $color_medium
set __fish_git_prompt_color_dirtystate $color_medium
set __fish_git_prompt_color_stagedstate $color_medium
set __fish_git_prompt_color_invalidstate $color_medium
set __fish_git_prompt_color_cleanstate $color_medium
set __fish_git_prompt_color_stashstate $color_medium
set __fish_git_prompt_color_untrackedfiles $color_medium
set __fish_git_prompt_color_bare $color_medium
set __fish_git_prompt_color_merging $color_medium
set __fish_git_prompt_color_prefix $color_medium
set __fish_git_prompt_color_suffix $color_medium
set __fish_git_prompt_color_flags $color_medium
set __fish_git_prompt_color_upstream_ahead $color_medium
set __fish_git_prompt_color_upstream_behind $color_medium
set __fish_git_prompt_color_upstream $color_medium
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
    set clr $color_accent
    switch $fish_bind_mode
        case 'default'
            set mode " "
            set clr $color_light
    end
    printf "\n"
    set_color -o $clr
    echo -n " " (prompt_pwd)
    set_color -o $color_medium
    echo -n "  $mode  "
    set_color normal
end
function fish_right_prompt
    set git (__fish_git_prompt)
    if test ! -z "$git"
        set git (echo $git | sed -e 's/(/\ \ /;s/[()…]//g')
        set git " $git "
    end
    set_color -o $color_medium
    echo -n "$git"
    set_color normal
end
#}}}

# Binds {{{
function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert \t forward-word
    bind -M default \e\t accept-autosuggestion
    bind -M insert \e\t accept-autosuggestion
    bind -M insert -m default jj backward-char force-repaint
    bind -M default \eh backward-word
    bind -M insert \eh backward-word
    bind -M default \el forward-word
    bind -M insert \el forward-word
    bind -M default \eh 'pushd ..; commandline -f repaint'
    bind -M insert \eh 'pushd ..; commandline -f repaint'
    bind -M default \el 'popd > /dev/null ^ /dev/null; commandline -f repaint'
    bind -M insert \el 'popd > /dev/null ^ /dev/null; commandline -f repaint'
    bind -M insert \e/ complete-and-search
    bind -M default \e/ complete-and-search
    bind -M insert ! bind_bang
    bind -M insert '$' bind_dollar
    bind -M insert "&&" 'commandline -i "; and"'
    bind -M insert "||" 'commandline -i "; or"'
    bind -M default \eo 'pushd (tree -dfi -L 3 -- $HOME / | fzf --prompt="cd > "); commandline -f repaint'
    bind -M insert \eo 'pushd (tree -dfi -L 3 -- $HOME / | fzf --prompt="cd > "); commandline -f repaint'
    bind -M default \eO 'commandline -t (tree -dfi -L 3 -- $HOME / | fzf --prompt="insert > "); commandline -f repaint'
    bind -M insert \eO 'commandline -t (tree -dfi -L 3 -- $HOME / | fzf --prompt="insert > "); commandline -f repaint'
    bind -M default \eb 'pushd; commandline -f repaint'
    bind -M insert \eb 'pushd; commandline -f repaint'
end
#}}}

function bind_bang
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function bind_dollar
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

function edit
    set file (pwd)/$argv
    python -c "from neovim import attach;attach('socket', path='$XDG_RUNTIME_DIR/nvim.sock').command('bad $file');"
end

function backup

    switch $argv
        case '*pri*'
            tar -cvf $HOME/private.tar -C $PRIVATE/ .
        case '*doc*'
            tar -cvf $HOME/docs.tar -C $HOME/docs/ .
            gpg -r shizukesa --trust-model always --encrypt -o $HOME/docs.tar.gpg $HOME/docs.tar
            rclone copy $HOME/docs.tar.gpg gdrive:Backup
            rm $HOME/docs.tar
            rm $HOME/docs.tar.gpg
    end
end

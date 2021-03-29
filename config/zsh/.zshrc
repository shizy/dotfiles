# autoload
autoload -U compinit promptinit colors
compinit -d $XDG_CACHE_HOME/zsh/zcompdump
setopt transient_rprompt
promptinit
colors


# alias
alias ~="pushd ~"
alias ..="pushd .."
alias rm="rm -rf"
alias ls="ls -AlhF --group-directories-first --color=auto"
alias grep="grep --color=auto"
alias netctl="netctl-auto"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias cat="bat"
alias more="bat"


# default dir
cd ~


# prompt
source /usr/share/git/completion/git-prompt.sh
CMD_PROMPT="  %B%F{$COLOR_ACCENT}%~ %F{$COLOR_MEDIUM}"
NORMAL="$CMD_PROMPT    "
INSERT="$CMD_PROMPT >  "


function zle-line-init zle-keymap-select {
    PROMPT="${${KEYMAP/vicmd/$NORMAL}/(main|viins)/$INSERT}%b%f"
    GITPROMPT=${${${${${${$(__git_ps1 "  %s ")//\*/  }//\+/  }//\<\>/   }/\</  }//\>/  }/\=/}
    RPROMPT="%B%F{$COLOR_MEDIUM}$GITPROMPT"
    zle reset-prompt
}


# bindings / vim-mode
prevdir() { pushd -q ..; zle zle-line-init; zle redisplay }
nextdir() { popd -q; zle zle-line-init; zle redisplay }


zle -N zle-line-init
zle -N zle-keymap-select
zle -N nextdir
zle -N prevdir


bindkey -v
bindkey '\el' nextdir
bindkey '\eh' prevdir


bindkey "^?" backward-delete-char
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M viins 'jk' accempt-line


# functions
edit () {
    python -c "from neovim import attach;attach('socket', path='$XDG_RUNTIME_DIR/nvim.sock').command('bad $1');"
}


ssh () {
    if [ -f $XDG_RUNTIME_DIR/ssh/ssh_config ]; then
        /usr/bin/ssh -F $XDG_RUNTIME_DIR/ssh/ssh_config -o "UserKnownHostsFile=$XDG_CACHE_HOME/ssh/known_hosts" $@
    else
        /usr/bin/ssh -o "UserKnownHostsFile=$XDG_CACHE_HOME/ssh/known_hosts" $@
    fi
}

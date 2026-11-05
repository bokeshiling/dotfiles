#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '
#PS1='\[\e[42m\]\u@\h\[\e[0m\]:\[\e[31m\]\w\[\e[0m\]\$ '

export VIMINIT='let $MYVIMRC=expand($XDG_CONFIG_HOME . "/vim/vimrc") | if filereadable($MYVIMRC) | source $MYVIMRC | else | source ~/.config/vim/vimrc | endif'

[ -f "/usr/share/bash-completion/bash_completion" ] && . /usr/share/bash-completion/bash_completion

[ -f "$HOME/.config/dircolors" ] && eval $(dircolors "$HOME/.config/dircolors")

bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

SHELL_CONFIG="$HOME/.config/shell" # general shell configs
[ -f "$SHELL_CONFIG/aliases.sh" ] && . "$SHELL_CONFIG/aliases.sh"
[ -f "$SHELL_CONFIG/teleport.sh" ] && . "$SHELL_CONFIG/teleport.sh"
[ -f "$SHELL_CONFIG/functions.sh" ] && . "$SHELL_CONFIG/functions.sh"

BASH_CONFIG="$HOME/.config/bash" # bash specifc configs
[ -f "$BASH_CONFIG/aliases.bash" ] && . "$BASH_CONFIG/aliases.bash"
[ -f "$BASH_CONFIG/functions.bash" ] && . "$BASH_CONFIG/functions.bash"
[ -d "$BASH_CONFIG/completions" ] && \
    for completion in $BASH_CONFIG/completions/*; do . "$completion"; done

set -o vi

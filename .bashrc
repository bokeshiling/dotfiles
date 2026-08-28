#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Clash Verge 终端代理快捷键
alias proxy_on='export http_proxy="http://127.0.0.1:7897" https_proxy="http://127.0.0.1:7897" no_proxy="localhost,127.0.0.1,*.edu.cn,*.cn"; echo "终端代理已开启"'
alias proxy_off='unset http_proxy https_proxy no_proxy; echo "终端代理已关闭"'

# 输入法（Fcitx5）
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx

export EDITOR='vim'

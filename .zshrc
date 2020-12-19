autoload -Uz colors
colors

autoload -Uz compinit
compinit

autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt extended_history
setopt correct

chpwd() { ls -Gltr }

PROMPT='[%F{green}%n@%m%f %~]$ '
RPROMPT='%F{green}%D{%Y/%m/%d} %*%f'

export EDITOR=vim
export LANG=ja_JP.UTF-8

export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls='ls -G'
alias grep='grep --color=auto'

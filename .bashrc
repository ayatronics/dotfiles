#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[1;36m\][\u@\h \W]\$\[\e[m\] '

export EDITOR=vim
export LANG=ja_JP.UTF-8

export PAGER='vimpager'
alias less=$PAGER

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export CLASSPATH=$CLASSPATH:.

alias sudo='sudo '
alias rm='echo "You can not use rm."; false'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias pacman-pkglist='comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)'
alias pacman-remove-orphan='sudo pacman -Rns $(pacman -Qtdq)'
alias pacman-update-mirrorlist='sudo reflector --verbose --country Japan --country '\''United States'\'' --country '\''United Kingdom'\'' --country Germany --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

alias fuck='$(thefuck $(fc -ln -1))'
alias shfmt-google='shfmt -i 2 -ci'

alias ghci='stack ghci'
alias ghc='stack ghc --'
alias runghc='stack runghc --'

source /usr/share/git/completion/git-completion.bash

#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=${PATH}:${HOME}/.cabal/bin:${HOME}/.cargo/bin:${HOME}/bin

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

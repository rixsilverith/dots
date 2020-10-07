#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin

alias gccr='~/uni-setup/scripts/compile_c_and_run.sh'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load shared shell aliases and environment variables
export DOTS_HOME=$HOME/.dots
source "$DOTS_HOME/shell/init.sh"

PS1='[\u@\h \W]\$ '

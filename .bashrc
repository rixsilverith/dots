#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export DOTFILES_HOME=$HOME/.dotfiles

export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$DOTFILES_HOME/bin

# Enable aliases to be sudo'ed
alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."

# Jumps
alias ~="cd ~"
alias unic="cd Uni/CompSci-1/semester-1"

alias gccr='~/university-setup/scripts/compile_c_and_run.sh'

#!/usr/bin/zsh

setopt HIST_IGNORE_ALL_DUPS  # Remove older commands from the history if a duplicate is to be added
setopt HIST_FCNTL_LOCK

HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
HISTSIZE=1000
SAVEHIST=1000


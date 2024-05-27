#!/usr/bin/zsh

setopt APPEND_HISTORY  # zsh sessions append their history to the history file, rather than replace it
setopt HIST_FCNTL_LOCK  # use fcntl for history file locking
setopt HIST_FIND_NO_DUPS  # dont show duplicate history entries on find
setopt HIST_IGNORE_ALL_DUPS  # remove older commands from the history if a duplicate is to be added
setopt HIST_IGNORE_DUPS  # dont insert duplicates in history
setopt HIST_IGNORE_SPACE  # ignore typed commands when prepended with a space
setopt HIST_SAVE_NO_DUPS  # dont save duplicates to history file
setopt SHARE_HISTORY  # share history between sessions

HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTUP=erase

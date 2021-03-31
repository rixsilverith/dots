# Remove older command from the history if a duplicate is to be added
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
# Change directory by typing only its name
setopt autocd
# Extended globbing
setopt extendedglob

# Get Zim to work
source "$ZIM_HOME/init.zsh"

# Load shared shell aliases and environment variables
source "$DOTS_HOME/shell/init.sh"

# Load Z
source "$DOTS_HOME/modules/z/z.sh"

# Async mode for autocompletion
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300

# History files
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
HISTSIZE=1000
SAVEHIST=1000

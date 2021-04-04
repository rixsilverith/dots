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

dot-widget() {
  source "$DOTS_HOME/scripts/core/dot.sh"

  local paths="$(dot::list_scripts)"

  script="$(
    echo "$paths" |
      xargs -I % sh -c 'echo "$(basename $(dirname %)) $(basename %)"' |
      fzf \
        --layout reverse-list \
        --height 10% \
        --min-height 1 \
        --cycle \
        --pointer '➜' \
        --color 'hl:255,hl+:255,pointer:255:bold,marker:255,info:248,prompt:255,bg+:-1' \
        --preview '"$DOTS_HOME/bin/dot" $(echo {} | cut -d" " -f 1) $(echo {} | cut -d" " -f 2) -h'
  )"

  local ret=$?

  script="dot $script"
  RBUFFER=${script}${RBUFFER}

  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  zle vi-end-of-line

  return $ret
}

zle -N dot-widget
bindkey '^f' dot-widget

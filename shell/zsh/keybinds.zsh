#!/usr/bin/zsh

# General key bindings
autoload -Uz edit-command-line && zle -N edit-command-line
bindkey '^K' edit-command-line
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^H' backward-kill-word
bindkey '^l' clear-screen
bindkey '^D' backward-kill-line

# Use `ctrl + u` to go one directory up
up-directory() {
  builtin cd ..
  if (( $? == 0 )); then
    local precmd
    for precmd in $precmd_functions; do $precmd; done
    zle reset-prompt
  fi
}

zle -N up-directory
bindkey '^u' up-directory

# Use `beam` cursor style
zle-line-init() {
  zle -K viins
  echo -ne '\033[0 q' # Use `beam` cursor style
}

zle -N zle-line-init

# Trigger `dot` command using `ctrl + f`
dot-widget() {
  source "$DOTS_HOME/scripts/core/dot.sh"
  # Prevent the terminal from killing itself when `Esc` is pressed while
  # running this widget
  set +e

  local -r paths="$(dot::list_scripts)"
  script="$(
    echo "$paths" |
      xargs -I % sh -c 'echo "$(basename $(dirname %)) $(basename %)"' |
      fzf --layout reverse-list --height 9 --cycle --pointer '➜' \
        --preview-window='right,65%,border-sharp' \
        --color 'hl:255,hl+:255,pointer:255:bold,marker:255,info:248,prompt:255,bg+:-1' \
        --preview '"$DOTS_HOME/bin/dot" $(echo {} | cut -d" " -f 1) $(echo {} | cut -d" " -f 2) -h'
  )"

  if [[ -n $script ]]; then
    script="dot $script"
    RBUFFER="${script} ${RBUFFER}"
  fi

  zle reset-prompt
  zle vi-end-of-line
}

zle -N dot-widget
bindkey '^f' dot-widget

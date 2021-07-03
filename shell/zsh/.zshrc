# Remove older command from the history if a duplicate is to be added
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
# Change directory by typing only its name
setopt autocd
# Extended globbing
setopt extendedglob

source "$ZIM_HOME/init.zsh"        # Get Zim to work
source "$DOTS_HOME/shell/init.sh"  # Load shared shell aliases, exports and functions
source "$DOTS_HOME/modules/z/z.sh" # Load Z

# Async mode for autocompletion
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300

# History files
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
HISTSIZE=1000
SAVEHIST=1000

fpath=("$DOTS_HOME/shell/zsh/themes" $fpath)

autoload -Uz promptinit && promptinit
prompt ${DOTS_THEME:-darkin}

dot-widget() {
  source "$DOTS_HOME/scripts/core/dot.sh"
  # Prevent the terminal from killing itself when `Esc` is pressed while
  # running this widget
  set +e

  local -r paths="$(dot::list_scripts)"
  script="$(
    echo "$paths" |
      xargs -I % sh -c 'echo "$(basename $(dirname %)) $(basename %)"' |
      fzf --layout reverse-list --height 20% --min-height 1 --cycle --pointer '➜' \
        --color 'hl:255,hl+:255,pointer:255:bold,marker:255,info:248,prompt:255,bg+:-1' \
        --preview '"$DOTS_HOME/bin/dot" $(echo {} | cut -d" " -f 1) $(echo {} | cut -d" " -f 2) -h'
  )"

  if [[ -n $script ]]; then
    script="dot $script"
    RBUFFER="${script} ${RBUFFER}"
  fi

  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  zle vi-end-of-line
}

zle -N dot-widget
bindkey '^f' dot-widget

if [[ "${DOTS_BENCHMARK_PROMPT_THEME:-false}" == "true" ]]; then
  typeset -F SECONDS start

  precmd() { start=$SECONDS; }
  bmark() { PREDISPLAY="[Prompt theme elapsed time: $(( $SECONDS - $start )) s] "; }

  zle -N zle-line-init bmark
fi

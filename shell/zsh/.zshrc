#!/usr/bin/zsh

# General zsh configs
setopt autocd           # Enable cd into a directory by typing its name
setopt extendedglob     # Extended globbing

source "$DOTS_HOME/shell/init.sh"   # Load shared shell aliases, exports and functions
source "$DOTS_HOME/modules/z/z.sh"  # Initialize Z
source "$ZIM_HOME/init.zsh"         # Initialize zim

source "${ZDOTDIR:-$DOTS_HOME/shell/zsh}/history.zsh"  # Load zsh history config
source "${ZDOTDIR:-$DOTS_HOME/shell/zsh}/keybinds.zsh"  # Load zsh key bindings

fpath=("$DOTS_HOME/shell/zsh/themes" $fpath)  # Set path for themes

# Initialize prompt theme
autoload -Uz promptinit && promptinit
prompt ${DOTS_THEME:-darkin}

# Log a visit to a directory in fre database
fre_chpwd() { fre --add "$(pwd)"; }
typeset -gaU chpwd_functions
chpwd_functions+=fre_chpwd

# Async mode for autocompletion
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300

# Prompt theme rendering benchmark
if [[ "${DOTS_BENCHMARK_PROMPT_THEME:-false}" == "true" ]]; then
  typeset -F SECONDS start

  precmd() { start=$SECONDS; }
  bmark() { PREDISPLAY="[Prompt theme elapsed time: $(( $SECONDS - $start )) s] "; }

  zle -N zle-line-init bmark
fi

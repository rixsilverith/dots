# `init.sh` allows sharing functions, aliases and almost all environment
# variables across the bash and zsh shells.

source "$DOTS_HOME/shell/exports.sh"
source "$DOTS_HOME/shell/functions.sh"
source "$DOTS_HOME/shell/aliases.sh"

[[ -f "$DOTS_HOME/shell/extra.hidden.sh" ]] && source "$DOTS_HOME/shell/extra.hidden.sh"

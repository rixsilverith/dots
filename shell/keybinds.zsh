#!/usr/bin/zsh

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^H' backward-kill-word
bindkey '^L' clear-screen
bindkey '^D' backward-kill-line

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# use `ctrl + j` to jump to a bookmarked directory
jump-directory() {
  local dir=$(cat $DOTS_HOME/misc/dirs.index | fzf \
    --layout reverse-list --height 20% --cycle \
    --pointer '➜' \
    --color 'hl:255,hl+:255,pointer:255:bold,marker:255,info:248,prompt:255,bg+:-1')
  local resolved_dir="$HOME/$dir"

  [[ -d $resolved_dir ]] && builtin cd $resolved_dir
  local precmd
  for precmd in $precmd_functions; do $precmd; done
  zle reset-prompt

  if [[ ! -d $resolved_dir ]]; then
    [[ $dir == " " ]] && echo -e "\n! $dir directory does not exists"
    for precmd in $precmd_functions; do $precmd; done
    zle reset-prompt
  fi
}

bindkey -r '^K'
bindkey -s '^K' 'bookmark-multiplexer\n'

# use `ctrl + o` to open the file explorer in the current directory
open-file-explorer-here() {
  $FILE_EXPLORER $(pwd) &> /dev/null & disown
}

zle -N open-file-explorer-here
bindkey '^o' open-file-explorer-here

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

# see https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
__fzfcmd() {
  [ -n "${TMUX_PANE-}" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "${FZF_TMUX_OPTS-}" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected="$(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} ${FZF_DEFAULT_OPTS-} -n2..,.. --scheme=history --bind=ctrl-r:toggle-sort,ctrl-z:ignore ${FZF_CTRL_R_OPTS-} --query=${(qqq)LBUFFER} +m" $(__fzfcmd))"
  local ret=$?
  if [ -n "$selected" ]; then
    num=$(awk '{print $1}' <<< "$selected")
    if [[ "$num" =~ '^[1-9][0-9]*\*?$' ]]; then
      zle vi-fetch-history -n ${num%\*}
    else # selected is a custom query, not from history
      LBUFFER="$selected"
    fi
  fi
  zle reset-prompt
  return $ret
}
zle     -N            fzf-history-widget
bindkey -M emacs '^R' fzf-history-widget
bindkey -M vicmd '^R' fzf-history-widget
bindkey -M viins '^R' fzf-history-widget

# bookmark a directory if not bookmarked yet.
# removes it if in bookmarks
bookmark-directory() {
  DIRS_INDEX="$DOTS_HOME/misc/dirs.index"
  [[ ! -f $DIRS_INDEX ]] && touch $DIRS_INDEX

  direc=${$(pwd)/$HOME\//}

  if ! grep -E "^${direc}$" $DIRS_INDEX &> /dev/null; then
    echo $direc >> $DIRS_INDEX
  else
    sed "$(grep -n -E "^${direc}$" $DIRS_INDEX | awk -F: '{print $1}')d" -i $DIRS_INDEX
  fi

  local precmd
  for precmd in $precmd_functions; do $precmd; done
  zle reset-prompt
}

zle -N bookmark-directory
bindkey '^b' bookmark-directory

# Use `beam` cursor style
zle-line-init() {
  zle -K viins
  echo -ne '\033[0 q' # Use `beam` cursor style
}

zle -N zle-line-init

# Trigger `doit` command using `ctrl + f`
doit-widget() {
  source "$DOTS_HOME/scripts/core/doit.sh"
  # prevent the terminal from killing itself when `Esc` is pressed while
  # running this widget
  set +e

  local -r paths="$(doit::list_scripts)"
  script="$(
    echo "$paths" |
      xargs -I % sh -c 'echo "$(basename $(dirname %)) $(basename %)"' |
      fzf --layout reverse-list --height 9 \
        --preview-window='right,65%,border-sharp' \
        --preview '"$DOTS_HOME/bin/doit" $(echo {} | cut -d" " -f 1) $(echo {} | cut -d" " -f 2) -h'
  )"

  if [[ -n $script ]]; then
    script="doit $script"
    RBUFFER="${script} ${RBUFFER}"
  fi

  zle reset-prompt
  zle vi-end-of-line
}

zle -N doit-widget
bindkey '^f' doit-widget


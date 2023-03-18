#!/usr/bin/zsh

# General key bindings
autoload -Uz edit-command-line && zle -N edit-command-line
bindkey '^K' edit-command-line
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^H' backward-kill-word
bindkey '^l' clear-screen
bindkey '^D' backward-kill-line

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

zle -N jump-directory
bindkey '^j' jump-directory

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
      fzf --layout reverse-list --height 9 --cycle --pointer '➜' \
        --preview-window='right,65%,border-sharp' \
        --color 'hl:255,hl+:255,pointer:255:bold,marker:255,info:248,prompt:255,bg+:-1' \
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

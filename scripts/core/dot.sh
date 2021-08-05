#!/usr/bin/bash

if ! ${DOT_MAIN_SOURCED:-false}; then
  for file in $DOTS_HOME/scripts/core/{args,docs,log,script}.sh; do
    source "$file";
  done;
  unset file;

  readonly DOT_MAIN_SOURCED=true
fi

dot::alias() {
  local -r context="$1"
  case $context in
    fs)   echo filesystem ;;
    img)  echo image ;;
    pkg)  echo package ;;
    proc) echo process ;;
    net)  echo network ;;
    sec)  echo security ;;
    sh)   echo shell ;;
    sys)  echo system ;;
    *)    echo $context ;;
  esac
}

dot::list_scripts() {
  contexts=$(find "$DOTS_HOME/scripts" -mindepth 2 -maxdepth 2 -executable -type f | grep -v core)
  printf "%s" "$contexts" | sort -u
}

dot::script_exists() {
  [[ -x "$DOTS_HOME/scripts/${1}/${2}" ]]
}

dot::completion() {
  local paths="$1"

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

  printf "%s" "$script"
  read -r args

  "$DOTS_HOME/bin/dot" $script $args
}

dot::show_help() {
  echo
  echo -e "$(tput bold)An entry point for all scripts inside this dotfiles$(tput sgr0)"
  echo -e "\nUsage: $(tput bold)dot <context> <script> [<args>...]\n"
  echo -e "\t$(tput bold)dot self update$(tput sgr0)      Check for updates"
  echo -e "\nOptions:"
  echo -e "\t$(tput bold)dot -h$(tput sgr0)                      Show this help message"
  echo -e "\t$(tput bold)dot <context> <script> -h$(tput sgr0)   Show help for a command\n"
}


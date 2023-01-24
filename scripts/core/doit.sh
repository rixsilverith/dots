#!/usr/bin/bash

if ! ${DOT_MAIN_SOURCED:-false}; then
  for file in $DOTS_HOME/scripts/core/{args,docs,log,script}.sh; do
    source "$file";
  done;
  unset file;

  readonly DOT_MAIN_SOURCED=true
fi

# resolve a script context alias
doit::context_alias() {
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

doit::list_scripts() {
  contexts=$(find "$DOTS_HOME/scripts" -mindepth 2 -maxdepth 2 -executable -type f | grep -v core)
  printf "%s" "$contexts" | sort -u
}

doit::script_exists() {
  [[ -x "$DOTS_HOME/scripts/${1}/${2}" ]]
}

# if 'doit' is run without arguments, list all available scripts
doit::completion() {
  local paths="$1"

  script="$(
    echo "$paths" |
      xargs -I % sh -c 'echo "$(basename $(dirname %)) $(basename %)"' |
      fzf --layout reverse-list --height 10% --min-height 1 --cycle --pointer '➜' \
        --color 'hl:255,hl+:255,pointer:255:bold,marker:255,info:248,prompt:255,bg+:-1' \
        --preview '"$DOTS_HOME/bin/dot" $(echo {} | cut -d" " -f 1) $(echo {} | cut -d" " -f 2) -h'
  )"

  printf "%s" "$script"
  read -r args

  "$DOTS_HOME/bin/doit" $script $args
}

doit::show_help() {
  echo -e "doit script entrypoint"
  echo -e "Usage: doit <context> <script> [<args>...]\n"
  echo -e "Running \`doit <context> <script> -h\` will show specific help for a given script."
  exit 1
}


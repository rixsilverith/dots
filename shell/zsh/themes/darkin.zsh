#!/usr/bin/zsh

DARKIN_PROMPT_ADD_NEWLINE="${DARKIN_PROMPT_ADD_NEWLINE=false}"
DARKIN_PROMPT_SHORT_PWD="${DARKIN_PROMPT_SHORT_PWD=true}"
DARKIN_PROMPT_DIR_PREFIX="${DARKIN_PROMPT_DIR_PREFIX="in "}"
DARKIN_PROMPT_SHOW_USER="${DARKIN_PROMPT_SHOW_USER=false}"
DARKIN_PROMPT_SHOW_GIT_REPO_STATUS="${DARKIN_PROMPT_SHOW_GIT_REPO_STATUS=true}"
DARKIN_BUFFER_EMPTY="${DARKIN_BUFFER_EMPTY=false}"
DARKIN_SHOW_PROMPT_SYMBOL="${DARKIN_SHOW_PROMPT_SYMBOL=true}"

DARKIN_PROMPT_SYMBOL="${DARKIN_PROMPT_SYMBOL=" "}"

DARKIN_GIT_BRANCH_SYMBOL=" "
DARKIN_GIT_CLEAN_STATUS_SYMBOL=""
DARKIN_GIT_DIRTY_STATUS_SYMBOL="*"
DARKIN_GIT_SYNCED_STATUS_SYMBOL=""
DARKIN_GIT_BEHIND_STATUS_SYMBOL="  "
DARKIN_GIT_AHEAD_STATUS_SYMBOL="  "
DARKIN_GIT_DIVERGED_STATUS_SYMBOL="  "

DARKIN_LAST_STATUS='0'

darkin::symbol() {
  [[ $DARKIN_SHOW_PROMPT_SYMBOL == false ]] && return
  [[ $DARKIN_LAST_STATUS == '0' ]] && darkin_symbol="$DARKIN_PROMPT_SYMBOL" || darkin_symbol="%F{red}$DARKIN_PROMPT_SYMBOL%f%B"

  echo $darkin_symbol
}

darkin::user() {
  [[ $DARKIN_PROMPT_SHOW_USER == false ]] && return
  local -r user="$(whoami) "
  echo $user
}

darkin::dir() {
  local dir="$(pwd)"
  local dir_segment="${dir/$HOME/~}"
  local is_bookmark=""

  if [[ -f "$DOTS_HOME/misc/dirs.index" ]]; then
    if grep -E "^${dir/$HOME\//}$" "$DOTS_HOME/misc/dirs.index" &> /dev/null; then
      is_bookmark=" [*]"
    fi
  fi

  if [[ $DARKIN_PROMPT_SHORT_PWD == true && $dir != $HOME ]]; then
    # Hmm... yeah WTF. Stolen with <3 from https://github.com/CodelyTV/dotly/blob/master/scripts/core/short_pwd
    dir=$(echo ${${${:-/${(j:/:)${(M)${(s:/:)${(D)PWD:h}}#(|.)[^.]}}/${PWD:t}}//\/~/\~}/\/\//\/})
    dir_segment="$dir"
  fi

  dir_segment="$dir_segment$is_bookmark"

  echo "$DARKIN_PROMPT_DIR_PREFIX$dir_segment"
}

darkin::virtual_env() {
  [[ -n "$VIRTUAL_ENV" ]] || return
  echo " (${VIRTUAL_ENV:t})"
}

darkin::git::ensure_git_repo() {
  [[ $(git rev-parse --is-inside-work-tree &> /dev/null; echo "$?") == '0' ]]
}

darkin::git() {
  darkin::git::ensure_git_repo || return

  local -r git_current_branch="$(git symbolic-ref -q --short HEAD)"
  local git_segment=" on $DARKIN_GIT_BRANCH_SYMBOL$git_current_branch"

  if [[ $DARKIN_PROMPT_SHOW_GIT_REPO_STATUS == true ]]; then
    git_repo_status=$(git diff --quiet --ignore-submodules HEAD &> /dev/null; echo "$?")
    [[ $git_repo_status == '1' ]] && git_repo_status="$DARKIN_GIT_DIRTY_STATUS_SYMBOL" || git_repo_status="$DARKIN_GIT_CLEAN_STATUS_SYMBOL"

    # Ensure the Git repo is not empty and that it has an upstream branch to avoid reference errors
    if [[ $(git log &> /dev/null; echo "$?") == '0' && $(git rev-parse --symbolic-full-name ${git_current_branch}@{u} &> /dev/null; echo "$?") == '0' ]]; then
      local -r upstream='@{u}'
      local -r loc=$(git rev-parse @)
      local -r remote=$(git rev-parse "$upstream")
      local -r base=$(git merge-base @ "$upstream")

      if [[ "$loc" == "$remote" ]]; then git_repo_status="$git_repo_status$DARKIN_GIT_SYNCED_STATUS_SYMBOL";
      elif [[ "$loc" == "$base" ]]; then git_repo_status="$git_repo_status$DARKIN_GIT_BEHIND_STATUS_SYMBOL";
      elif [[ "$remote" == "$base" ]]; then git_repo_status="$git_repo_status$DARKIN_GIT_AHEAD_STATUS_SYMBOL";
      else git_repo_status="$git_repo_status$DARKIN_GIT_DIVERGED_STATUS_SYMBOL"; fi
    fi

    git_segment="$git_segment$git_repo_status"
  fi

  echo $git_segment
}

darkin::prompt() {
  DARKIN_LAST_STATUS="$status"
  DARKIN_PROMPT="%B$(darkin::symbol)$(darkin::user)$(darkin::dir)$(darkin::virtual_env)$(darkin::git)%b "
  PROMPT="$DARKIN_PROMPT"

  [[ $DARKIN_PROMPT_ADD_NEWLINE == true ]] && PROMPT="$PROMPT"$'\n> '
  unset RPS1
}

darkin::buffer_empty() {
  [[ -n "$BUFFER" ]] && { zle accept-line && return; }
  darkin::prompt
}

darkin::setup() {
  autoload -Uz add-zsh-hook
  prompt_opts=(cr percent sp subst)

  add-zsh-hook precmd darkin::prompt

  if [[ $DARKIN_BUFFER_EMPTY == true ]]; then
    zle -N buffer-empty darkin::buffer_empty
    bindkey '^M' buffer-empty
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=buffer-empty
  fi
}

darkin::setup "$@"

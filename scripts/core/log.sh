#!/usr/bin/bash
set -euo pipefail

_w() {
    local -r text="${1:-}"
    echo -e "$text"
}

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
purple=$(tput setaf 5)
bold=$(tput bold)
reset=$(tput sgr0)

log::info()    { _w " ${bold}${green}>${reset} $1"; }
log::success() { _w " ${green}✔  $1${reset}"; }
log::warn()    { _w " ${yellow}${bold}! $1${reset}"; }
log::error()   { _w " ${red}✖  $1${reset}"; }
log::quest()   { read -rp "${bold}$1${reset} " "$2"; }

feedback::confirmation() {
    local -r msg="$1"
    local -r default_yes="${2:-true}"
    local options

    if $default_yes; then
        options="[Y/n]"
    else
        options="[y/N]"
    fi

    #_info "$msg $options "
    read -rp "$(_info "$msg $options ")" reply  #</dev/tty
    #local reply="$REPLY"

    if [[ -z "$reply" ]]; then
        if $default_yes; then
            return 0
        else
            return 1
        fi
    fi

    echo
    if echo "$reply" | grep -E '^[Yy]$' >/dev/null; then
        return 0
    else
        return 1
    fi
}

_confirm() {
    local yn YN confirm ret
    if [[ "$1" == "y" ]]; then
        yn="y"
        YN="Y/n"
        ret=1
        shift
    elif [[ "$1" == "n" ]]; then
        yn="n"
        YN="y/N"
        ret=1
        shift
    else
        YN="y/n"
        ret=-1
    fi

    echo -n "$@($YN)>"
    read confirm
    confirm=$(echo $confirm | tr '[:upper:]')

    case $confirm in
        y|yes) return 0 ;;
        n|no) return 1 ;;
        "") if [ $ret -eq -1 ]; then
            echo "Please answer yes or no"
            _confirm $@
        else
            return $ret
        fi
        ;;
        *) echo "Please y/n"
            _confirm $yn $@
    esac
}

log::color() {
    case "$@" in
        *reset*) tput sgr0; return 0 ;;
        *black*) tput setaf 0 ;;
        *red*) tput setaf 1 ;;
        *green*) tput setaf 2 ;;
        *yellow*) tput setaf 3 ;;
        *blue*) tput setaf 4 ;;
        *purple*) tput setaf 5 ;;
        *cyan*) tput setaf 6 ;;
        *white*) tput setaf 7 ;;
    esac
    case "$@" in
        *regular*) tput sgr0 ;;
        *bold*) tput bold ;;
        *standout*) tput smso ;;
        *underline*) tput smul ;;
    esac
}

log::colorfef() {
   case "$@" in
      *reset*) echo "$(tput sgr0)"; return 0 ;;
      *black*) color=30 ;;
      *red*) color=31 ;;
      *green*) color=32 ;;
      *yellow*) color=33 ;;
      *blue*) color=34 ;;
      *purple*) color=35 ;;
      *cyan*) color=36 ;;
      *white*) color=37 ;;
   esac
   case "$@" in
      *regular*) mod=0 ;;
      *bold*) mod=1 ;;
      *underline*) mod=4 ;;
   esac
   case "$@" in
      *background*) bg=true ;;
      *bg*) bg=true ;;
   esac

   if $bg; then
      echo "\e[${color}m"
   else
      echo "\e[${mod:-0};${color}m"
   fi
}

_log() {
    local template=$1
    shift
    echo -e $(printf "$template" "$@")
   #local template=$1
   #shift
   #echoerr -e $(printf "$template" "$@")
}

_header() {
   local TOTAL_CHARS=60
   local total=$TOTAL_CHARS-2
   local size=${#1}
   local left=$((($total - $size) / 2))
   local right=$(($total - $size - $left))
   printf "%${left}s" '' | tr ' ' =
   printf " $1 "
   printf "%${right}s" '' | tr ' ' =
}

#log::header()  { _log "\n$()$(log::color bold)%s$(log::color reset)\n" "$@"; }
#log::success() { _log "$(log::color green)✔ %s$(log::color reset)\n" "$@"; }
#log::error()   { _log "$(log::color red)✖ %s$(log::color reset)\n" "$@"; }
#log::warning() { _log "$(log::color yellow)➜ %s$(log::color reset)\n" "$@"; }
#log::info()    { _log "$(log::color blue)%s$(log::color reset)\n" "$@"; }

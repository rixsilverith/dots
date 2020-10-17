#!/usr/bin/bash
set -euo pipefail

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

log::header()  { _log "\n$()$(log::color bold)%s$(log::color reset)\n" "$@"; }
log::success() { _log "$(log::color green)✔ %s$(log::color reset)\n" "$@"; }
log::error()   { _log "$(log::color red)✖ %s$(log::color reset)\n" "$@"; }
log::warning() { _log "$(log::color yellow)➜ %s$(log::color reset)\n" "$@"; }
log::info()    { _log "$(log::color blue)➜ %s$(log::color reset)\n" "$@"; }
#log::info()    { _log "$(log::color blue)%s$(log::color reset)\n" "$@"; }

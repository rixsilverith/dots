#!/usr/bin/bash
set -euo pipefail

docs::parse() {
  local -r file="$0"
  while getopts "h" opt; do
    case "$opt" in
    h|\?)
        grep "^##?" "$file" | cut -c 5-
        exit 0
        ;;
    esac
  done
}

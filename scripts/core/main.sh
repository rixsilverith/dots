#!/usr/bin/bash
set -euo pipefail

_version() { 
    echo -e "\n➜ You're running version $(tput bold)0.1.1$(tput sgr0) of the $(tput bold)dot$(tput sgr0) CLI\n" 
}

_alias() {
    local -r arg=$1
    case "$arg" in
        net) echo network ;;
        sys) echo system ;;
        *) echo "$arg" ;;
    esac
}

_list_contexts() {
    echo -e "\n➜ Available contexts:"
    tput bold
    find "${DOTFILES_PATH}/.scripts/" -maxdepth 1 -executable -type d |
        #grep -v core | awk -F"/" echo -e "\t$(tput bold)$(NF)$(tput sgr0) | Context" | sort
        grep -v core | awk -F"/" '{print "\t"$(NF)"$"$(tput sgr0)" | Context"}' | sort
        #grep -v core | awk -F"/" '{print "\t"$(tput bold)"$(NF)"$(tput sgr0)" | Context"}' | sort
    tput sgr0
    echo
}

_list_context_commands() {
    local -r context_query=$1
    echo -e "\n➜ Available commands for the $(tput bold)$context_query$(tput sgr0) context:"
    find "${DOTFILES_PATH}/.scripts/${context_query}/" -maxdepth 2 -executable -type f |
        awk -F"/" '{print "\t"$(NF)" | Command"}' | sort
    echo ""
}

doc::help_msg() {
    local -r file="$1"
    grep "^##?" "$file" | cut -c 5-
}

doc::help_or_fail() {
    local -r file="$0"
    doc::help_msg "$file"
    exit 1
}

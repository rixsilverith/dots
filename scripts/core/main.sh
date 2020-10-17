#!/usr/bin/bash
set -euo pipefail

source "${DOTFILES_HOME}/scripts/core/log.sh"

_version() {
    local -r ver=$(grep "^##?" "${DOTFILES_HOME}/bin/dot" | cut -c 5-)
    echo -e "\n➜ You're running version $(tput bold)$ver$(tput sgr0) of the $(tput bold)dot$(tput sgr0) CLI\n" 
}

_alias2() {
    local -r arg=$1
    case "$arg" in
        fs)  echo filesystem ;;
        net) echo network ;;
        sys) echo system ;;
        *)   echo "$arg" ;;
    esac
}

_list_contexts2() {
    echo -e "\n➜ Available contexts:"
    tput bold
    find "${DOTFILES_PATH}/.scripts/" -maxdepth 1 -mindepth 1 -executable -type d |
        #grep -v core | awk -F"/" echo -e "\t$(tput bold)$(NF)$(tput sgr0) | Context" | sort
        grep -v core | awk -F"/" '{print "\t"$NF}' | sort
        #grep -v core | awk -F"/" '{print "\t"$(tput bold)"$(NF)"$(tput sgr0)" | Context"}' | sort
    tput sgr0
    echo
}

#get_ctx_info() {
#    echo -e $1
#}

_print_context() {
    local -r ctx_dir=$1
    local -r ctx=$(echo $ctx_dir | awk -F"/" '{print $NF}')
    echo -e "\t$(tput bold)$ctx$(tput sgr0) | $(get_ctx_info $ctx_dir)"
}

_list_contexts() {
    echo -e "\n$(log::color green)➜$(log::color reset) Available contexts:"
    #local context_folders
    #tput bold
    local context_folders=($(find "${DOTFILES_PATH}/.scripts/" -maxdepth 1 -mindepth 1 -executable -type d |
        grep -v core | sort))
        #grep -v core | sort | awk -F"/" '{print $(NF)}'))
        #grep -v core | awk -F"/" echo -e "\t$(tput bold)$(NF)$(tput sgr0) | Context" | sort
        #grep -v core | awk -F"/" '{$(NF)}' | sort)
        #grep -v core | awk -F"/" '{print "\t"$(NF)}' | sort)
        #grep -v core | awk -F"/" '{print "\t"$(tput bold)"$(NF)"$(tput sgr0)" | Context"}' | sort
    #tput sgr0

    for c in "${context_folders[@]}"; do
        _print_context $c
    done
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

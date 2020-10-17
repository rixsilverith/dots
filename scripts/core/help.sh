#!/usr/bin/bash
set -euo pipefail

source "${DOTFILES_HOME}/scripts/core/log.sh"

doc::help() {
    echo -e ""
    log::header "A hub for an all-purpose set of scripts"
    echo -e "\nUsage:" 
    echo -e "\t$(tput bold)$(log::color cyan)dot <context> [subcontext] <command> [<args>...]"
    echo -e "\tdot <context>$(tput sgr0) | Show available commands from a context"
    echo -e "\t$(log::color cyan bold)dot self update$(tput sgr0) | Check for updates"
    echo -e "\nOptions:"
    echo -e "\t$(log::color cyan bold)dot (-h|--help)$(tput sgr0) | Show this help message"
    echo -e "\t$(log::color cyan bold)dot (-v|--version)$(tput sgr0) | Show the current version of the $(tput bold)dot$(tput sgr0) CLI"
    echo -e "\t$(log::color cyan bold)dot (-c|--contexts)$(tput sgr0) | Show available contexts"
    echo -e "\t$(log::color cyan bold)dot <context> [subcontext] <command> (-h|--help)$(tput sgr0) | Show help for a command\n"
}

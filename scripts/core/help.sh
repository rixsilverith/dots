#!/usr/bin/bash
set -euo pipefail

source "$DOTS_HOME/scripts/core/log.sh"

doc::help() {
    echo
    log::header "An entry point for all scripts inside this dotfiles"
    echo -e "\nUsage: $(tput bold)dot <context> [<subcontext>] <command> [<args>...]\n"
    echo -e "\tdot <context>$(tput sgr0)        Show available commands from a context"
    echo -e "\t$(tput bold)dot self update$(tput sgr0)      Check for updates"
    echo -e "\nOptions:"
    echo -e "\t$(tput bold)dot -h, --help$(tput sgr0)                      Show this help message"
    echo -e "\t$(tput bold)dot -v, --version$(tput sgr0)                   Show the current version of the $(tput bold)dot$(tput sgr0) CLI"
    echo -e "\t$(tput bold)dot -c, --contexts$(tput sgr0)                  Show available contexts"
    echo -e "\t$(tput bold)dot <context> <command> -h, --help$(tput sgr0)  Show help for a command\n"
}

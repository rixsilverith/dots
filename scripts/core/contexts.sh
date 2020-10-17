#!/usr/bin/bash
set -euo pipefail
source "${DOTFILES_HOME}/scripts/core/log.sh"

_alias() {
    local -r ctx=$1
    case "$ctx" in
        fs)  echo filesystem ;;
        net) echo network ;;
        sys) echo system ;;
        wp)  echo wallpaper ;;
        *)   echo "$ctx" ;;
    esac
}

_ctx_descs() {
    local -r ctx=$1
    case "$ctx" in
        cloud) echo 'CRUD operations on Google Drive from the terminal' ;;
        config) echo 'Customization settings such as wallpaper, wm options, etc.' ;;
        drive) echo 'CRUD operations on the local drive where the system is installed' ;;
        filesystem) echo 'File system utilities such as zip and unzip files' ;;
        network) echo 'Manage network connections and interfaces' ;;
        self) echo 'dot command functionalities (update, reinstall, etc.)' ;;
        system) echo 'Configure system settings such as audio or screen resolution' ;;
        *) echo "Description for the $ctx context" ;;
    esac
}

get_ctx_info() {
    local -r ctx=$1
    echo -e "$(_ctx_descs $ctx)"
}

list_contexts() {
    #echo -e "\n$(log::color green)$(log::color reset) Available contexts:"
    echo; log::info "Available scripts under the dot command:\n"
    local -r ctx_dirs=($(find "${DOTFILES_PATH}/.scripts/" -mindepth 1 -maxdepth 1 -executable -type d |
        grep -v core | sort))

    for ctx_dir in "${ctx_dirs[@]}"; do
        local ctx=$(echo $ctx_dir | awk -F"/" '{print $NF}')
        echo -e "\t$(log::color bold cyan)$ctx$(tput sgr0) | $(get_ctx_info $ctx)"
    done
    echo
}

list_ctx_commands() {
    local -r ctx_query=$1
    echo -e "\n$(log::color green)$(log::color reset) Available commands for the $(tput bold)$ctx_query$(tput sgr0) context:"
    local cmd_files=($(find "${DOTFILES_PATH}/.scripts/${ctx_query}" -maxdepth 1 -executable -type f | sort))

    for cmd_file in "${cmd_files[@]}"; do
        local cmd=$(echo $cmd_file | awk -F"/" '{print $NF}')
        echo -e "\t$(tput bold)$cmd$(tput sgr0) | $(grep "^#??" "$cmd_file" | cut -c 5-)"
    done
    echo
}

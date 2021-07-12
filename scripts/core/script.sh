#!/usr/bin/bash
source "$DOTS_HOME/scripts/core/log.sh"

script::depends_on() {
  declare -A install_deps
  for dep in "$@"; do
    command -v $dep &> /dev/null || install_deps+=$dep
  done

  for dep in ${install_deps[@]}; do
    read -rp " ${green}>${reset} ${cyan}$dep${reset} is a dependency of this script. Install it? [Y/n] " should_install_dep
    if [[ $should_install_dep =~ [Yy] ]] || [[ -z $should_install_dep ]]; then sudo pacman -S "$dep" --noconfirm > /dev/null;
    else log::abort "The script can't be run without \`$dep\` being installed before."; fi
    unset $should_install_dep
  done
}

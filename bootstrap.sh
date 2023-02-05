#!/usr/bin/bash

set -euo pipefail

info() { echo -e "> $1"; }
ded()  { echo -e "\033[1;31m>\033[0m $1" && exit 1; }

command -v git &> /dev/null || ded "Git is not installed. Please, install git and run the script again"

export DOTS_HOME="$HOME/self/code/dots"
[ -d "$DOTS_HOME" ] && ded "\$DOTS_HOME ($DOTS_HOME) already exist :v"

echo -e "! Before running this thing: you'll probably want to backup your current configuration"
echo -e "files if not done already, since this script is likely to nuke at least some of them."
echo -e "Just to be sure, back things up before moving on. You've been warned.\n"

read -p "Proceed with the installation? [y/N] " yn
case $yn in
  [yY]) echo ;;
  *) exit 1 ;;
esac

info "Cloning rixsilverith/dots into \$DOTS_HOME ($DOTS_HOME)"
git clone https://github.com/rixsilverith/dots.git "$DOTS_HOME" > /dev/null 2>&1

info "Updating Git submodules"
(cd "$DOTS_HOME" && git submodule update --init --recursive 2>&1)

"$DOTS_HOME/bin/doit" self bootstrap

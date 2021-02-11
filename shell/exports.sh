# This file defines the environment variables to be exported and shared
# between both zsh and bash

# define XDG Base Directories

# the XDG_CONFIG_HOME variable determines where user-specific configurations
# should be written (analogous to /etc). Default to $HOME/.config
export XDG_CONFIG_HOME=${DOTS_HOME:-$HOME}/.config
# the XDG_CACHE_HOME variable determines where user-specific non-essential
# (cached) data should be written (analogous to /var/cache). Default to
# $HOME/.cache
export XDG_CACHE_HOME=${DOTS_HOME:-$HOME}/.cache
# the XDG_DATA_HOME variable determines where user-specific data files 
# should be written (analogous to /usr/share). Default to $HOME/.local/share
export XDG_DATA_HOME=${DOTS_HOME:-$HOME}/.local/share

# home directory clean up
# export XINITRC=${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc
# export XAUTHORITY=${XDG_CONFIG_HOME:-$HOME/.config}/x11/Xauthority

# default programs
export EDITOR='nvim'
export TERMINAL='alacritty'
export BROWSER='firefox'

# locales
# export LANG='en_GB.UTF-8'
# export LC_ALL='es_ES.UTF-8'

# other program settings
export TEXINPUTS=$HOME/Uni/latex-stuff:

# path
export PATH=$PATH:$DOTS_HOME/bin

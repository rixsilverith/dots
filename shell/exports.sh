# This file defines the environment variables to be exported and shared
# between both zsh and bash

[[ -f "$DOTS_HOME/secrets.env" ]] && source "$DOTS_HOME/secrets.env"

# Make NeoVim the default text editor
export EDITOR='nvim'
# Make Alacritty the default terminal emulator
export TERMINAL='alacritty'
# Make Firefox the default browser
export BROWSER='firefox'

# Use British English with UTF-8 encoding
export LANG='en_GB.UTF-8'
export LC_ALL='en_GB.UTF-8'

export SUDO_PROMPT="🔑authenticate (%U): "

# Tell the LaTeX compiler to look for classes and packages in the
# following directories
export TEXINPUTS=$HOME/Uni/latex-stuff:

# Make Python use UTF-8 encoding for output to stdin, stdout and stderr
export PYTHONIOENCONDING='UTF-8'

export FZF_DEFAULT_OPTS="--reverse --cycle --no-sort --tiebreak=index \
  --bind='alt-j:preview-down,alt-k:preview-up' --pointer '➜' \
  --color 'hl:255,hl+:255,pointer:255:bold,marker:255,info:248,prompt:255,fg:250,bg+:-1'"

# ~/ Clean-up
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs, such as LightDM
export XINITRC="$DOTS_HOME/wm/X11/xinitrc"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"
export ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/readline/inputrc"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export _Z_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/.z"

# Add the following directories to the PATH
export PATH=$PATH:$DOTS_HOME/bin

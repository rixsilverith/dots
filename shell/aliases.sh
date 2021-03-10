# This file defines the aliases to be shared between bash and zsh

# Enable aliases to be sudo'ed
alias sudo='sudo '

# Easier navigation
alias ..='cd ..'
alias ...='cd ../..'

# Colorize `ls` output
alias ls='ls --color --group-directories-first'

# List files in long format
alias ll='ls -lh'

# List all files, excluding . and ..
alias la='ls -A'

# List all files in long format, excluding . and ..
alias lla='ls -lhA'

# List only directories
alias lsd='ls -l | grep "^d"'

# `bat` styling
alias bat='\bat --theme=GitHub'

# Always enable colored `grep` and `diff` output
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Add a cute cat to the cat command
alias cat="$DOTS_HOME/scripts/system/cat"

# Simpler command to give execution permissions
alias chmox='chmod +x'

# Shorter `nvim` command
alias nv='nvim'

# Networking
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ifconfig getifaddr enp5s0'
alias whois='whois -h whois-servers.net'

# Human-readable disk usage
alias dskusg='df -Tha --total'

# Merge PDF files, preserving hyperlinks
# Usage: `mergepdf input{1,2,3}.pdf`
alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

# Intuitive map function. For instance, to list all directories that
# contain a certain file run `find . -name .gitattributes | map dirname`
alias map='xargs -n1'

# Reload Shell
alias reloadshell="exec $SHELL -l"

# Show CPU temperature
alias cputemp='watch -n 0 "sensors | grep Core"'

# Display GPU temperature using NVIDIA System Management Interface
alias gputemp='watch -n 0 "nvidia-smi -q -d temperature"'

# Display current clock speed
alias clockspeed='watch -n 0 "lscpu | grep \"Mhz\""'

# Git
alias gst='git status'
alias gl='git log'
alias gaa='git add -A'
alias gus='git restore --staged'
alias gpl='git pull'
alias gps='git push'
alias gnuke='git clean -df && git reset --hard'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Use $XINITRC variable if file exists
[ -f "$XINITRC" ] && alias startx="startx $XINITRC"

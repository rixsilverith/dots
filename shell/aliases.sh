# `aliases.sh` defines some aliases that are shared across the
# bash and zsh shells.

# Enable aliases to be sudo'ed
alias sudo='sudo '
# Intuitive map function. For instance, to list all directories that
# contain a certain file run `find . -name .gitattributes | map dirname`
alias map='xargs -n1'
# Simpler command to give execution permissions
alias chmox='chmod +x'
# Simpler command to open files
alias open='xdg-open'
# Shortcut for extracing compressed files
alias ext='dot filesystem extract'
# Human-readable disk usage
alias dskusg='df -Tha --total'
# Reload current shell
alias reloadshell="exec $SHELL -l"
# Print each $PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
# Simpler copy to clipboard
has xclip && alias clip='xclip -sel clip'
# Shorter `nvim` command
has nvim && alias nv='nvim' || alias nv='vim'
# Ensure rsync uses (a)rchive mode, compression (z) and (v)erbose mode
has rsync && alias rsync='rsync -azv --delete --progress'
# Show public IP address
has curl && alias publicip='curl https://ipinfo.io/ip && echo'
# Merge PDF files, preserving hyperlinks
# Usage: `mergepdf input{1,2,3}.pdf`
has gs && alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

if has valgrind; then
  # Use Valgrind Memcheck tool to search for memory leaks in a program, tracing
  # the origins of all uninitialised values that may cause an error. `man valgrind`
  # for more information.
  alias vgd='valgrind --tool=memcheck --leak-check=full --track-origins=yes'
  # Use Valgrind Massif tool to profile and log heap memory and stack usage of a
  # program. `man valgrind` for more information.
  alias vgdlg='valgrind --tool=massif --stacks=yes'
fi;

# Enable colored `ls` output
alias ls='ls --color --group-directories-first'
# List files in long format
alias ll='ls -lh'
# List all files, excluding . and ..
alias la='ls -A'
# List all files in long format, excluding . and ..
alias lla='ls -lhA'
# List only directories
alias lsd='ls -l | grep --color=never "^d"'

# Enable colored `grep` and `diff` output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias pgrep='pgrep --color=auto'
alias diff='diff --color=auto'

# Use Nord theme by default in `bat`
has bat && alias bat='\bat --theme=Nord'
# Add a cute cat to the cat command
alias cat="$DOTS_HOME/scripts/system/cat"

# View the current working tree status using the short format
alias gst='git status -s'
# View abbreviated SHA, description, and history graph of the latest 20 commits
alias gl='git log --pretty=oneline -n 20 --graph --abbrev-commit'
# Stage all changes in the working directory
alias gaa='git add -A'
# Git add shortcut
alias ga='git add'
# Easy restore a staged file
alias grs='git restore --staged'
# Show the diff between the latest commit and the current state
alias gdf='git diff-index --quiet HEAD -- || clear; git --no-pager diff --patch-with-stat'
# Simpler command to list all branches
alias gbr='git branch -avv'
# Other Git shortcuts
alias gpl='git pull'
alias gps='git push'
alias gnuke='git clean -df && git reset --hard'

# Use $XINITRC variable in `startx` if `xinitrc` file exists
[ -f "$XINITRC" ] && alias startx="startx $XINITRC"

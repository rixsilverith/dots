# `aliases.sh` defines some aliases that are shared across the
# bash and zsh shells.

alias sudo='sudo ' # enable aliases to be sudo'ed
alias fuck='sudo $(fc -ln -1)'

# intuitive map function. ex: list all directories that
# contain a certain file `find . -name <file> | map dirname`
alias map='xargs -n1'

# safe and verbose chmod and chown: --preserve-root prevents operating recursively on /
alias chmod='chmod --preserve-root -v'
alias chown='chown --preserve-root -v'

has safe-rm && alias rm='safe-rm' # safe rm

alias ext="$DOTS_HOME/scripts/filesystem/extract"
alias path='echo -e ${PATH//:/\\n}' # print each $PATH entry on a separate line

alias serviceinfo='systemctl list-units --type=service'

has xclip && alias clip='xclip -sel clip'
has nvim && alias nv='nvim' || alias nv='vim'
has safe-rm && alias srm='safe-rm'

# ensure rsync uses (a)rchive mode, compression (z) and (v)erbose mode
has rsync && alias rsync='rsync -azv --delete --progress'
has curl && alias publicip='curl https://ipinfo.io/ip && echo'

# merge PDF files, preserving hyperlinks
# usage: `mergepdf input{1,2,3}.pdf`
has gs && alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

if has valgrind; then
  # use Valgrind Memcheck tool to search for memory leaks in a program, tracing
  # the origins of all uninitialised values that may cause an error. `man valgrind`
  # for more information.
  alias vgd='valgrind --tool=memcheck --leak-check=full --track-origins=yes'
  # use Valgrind Massif tool to profile and log heap memory and stack usage of a
  # program. `man valgrind` for more information.
  alias vgdlg='valgrind --tool=massif --stacks=yes'
fi
alias df='df --print-type --human-readable' # df -Th: human-readable disk usage
alias du='du --human-readable'

alias mkdir='mkdir -pv'
# safer versions of some commands
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -Iv --one-file-system' # -I less intrusive than -i

alias ls='ls --color --group-directories-first'
alias ll='ls -lh' # list all files in long format, with human-readable sizes
alias l='ll -A' # list all files, excluding . and .. (-A)
alias lla='ls -lhA' # list all files in long format, excluding . and .. (-A)
alias lsd='ls -l | grep --color=never "^d"' # list only directories

alias grep='grep --color=auto'
alias diff='diff --color=auto'

has bat && alias bat='\bat --theme=Nord'
alias cat="$DOTS_HOME/scripts/system/cat" # make cat command an actual cat

alias gst='git status --short'
alias gl="$DOTS_HOME/scripts/git/explore-commits"
alias ga='git add'
alias grs='git restore --staged'
alias gifu='git fetch origin && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'


# use $XINITRC variable in `startx` if `xinitrc` file exists
[[ -f "$XINITRC" ]] && alias startx="startx $XINITRC"

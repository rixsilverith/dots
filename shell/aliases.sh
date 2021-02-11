# This file defines the aliases to be shared between bash and zsh

# Enable aliases to be sudo'ed
alias sudo='sudo '

alias ..='cd ..'
alias ...='cd ../..'

alias ~='cd ~'

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias nv='nvim'

alias latex-compile='latexmk -shell-escape -f -synctex=1 -pdf -silent -interaction=nonstopmode'
alias latex-watch='latexmk -shell-escape -f -synctex=1 -pdf -silent -interaction=nonstopmode -pvc'

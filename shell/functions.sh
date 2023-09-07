# `functions.sh` defines different utility functions that are shared
# across the bash and zsh shells.

# check if a given command is installed.
# usage: has <command>
has() {
  local -r cmd="$1"
  [[ -n $cmd ]] && command -v "$cmd" &> /dev/null
}

# create directory and cd into it
# usage: mkcd <directory>
mkcd() {
  local -r dir="$1"
  [[ -z $dir ]] && printf "mkcd: cannot create directory with empty name\nusage: mkcd <dirname>" && exit 1
  mkdir -p "$dir" && builtin cd "$dir" || exit
}

# copy a file or folder, creating the filepath if it doesn't exist
# usage: mkcp <origin> <destination>
mkcp() {
  local dir="$2"
  local tmp="$2"; tmp="${tmp:-1}"
  [[ "$tmp" != "/" ]] && dir="$(dirname "$2")"
  [[ -d "$dir" ]] || mkdir -p "$dir" && cp -r "$@"
}

# move a file or folder, creating the filepath if it doesn't exist
# usage: mkmv <origin> <destination>
mkmv() {
  local dir="$2"
  local tmp="$2"; tmp="${tmp:-1}"
  [[ "$tmp" != "/" ]] && dir="$(dirname "$2")"
  [[ -d "$dir" ]] || mkdir -p "$dir" && mv "$@"
}

# cd to a directory using Z (see https://github.com/rupa/z)
# usage: d [directory]
d() { _z "${1:-$HOME}"; }

# create backups for a given list of files.
# usage: back <file1> <file2> ...
back() { for file in "$@"; do cp "$file" "$file".bak; done; }

# Preview CSV files.
# Usage: csvpreview <file>
# Source: http://stackoverflow.com/questions/1875305/command-line-csv-viewer
# csvpreview() { sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t | less -N -S }

# create an ed25519 SSH key
# usage: ssh-create-key <name> [passphrase]
# if no [passphrase] is provided, the created key will be passwordless
ssh-create-key() {
  ! has ssh-keygen || [[ -z "$1" ]] && return
  local -r keyname="$1"
  local -r passphrase="${2:-}"

  [[ ! -d "$XDG_CONFIG_HOME/ssh/keys" ]] && mkdir -p "$XDG_CONFIG_HOME/ssh/keys"
  ssh-keygen -t ed25519 -f "$XDG_CONFIG_HOME/ssh/keys/$keyname" -N "$passphrase" -C "$keyname"
  chmod 700 "$XDG_CONFIG_HOME/ssh/keys/$keyname*"
}

# check for open ports in the current machine.
# usage: ports
ports() { netstat -tulpn | grep LISTEN | less; }

# generate a random integer in a given interval [min, max]
# usage: nrand [min (default: 0)] [max (default: 1)]
nrand() {
  local -r floor="${1:-0}"
  local -r ceiling="${2:-1}"
  echo $(( RANDOM % ( ceiling - floor + 1 ) + floor ))
}

git() {
  # git commit wrapper to include identity confirmation before commit

  if [[ "$1" == "commit" ]]; then
    echo -en "Committing as \033[7m$(git config user.name) ($(git config user.email))\033[27m Is this fine? [y/N] "
    read -r yn
    case "$yn" in
      [yY]) echo ;;
      *) return 1 ;;
    esac
    shift
    command git commit "$@"
  else
    command git "$@"
  fi
}

bookmark-multiplexer() {
  local entries=""
  local tmux_sessions=$(tmux ls)
  if [[ -n "$tmux_sessions" ]]; then
    entries="$(echo "$tmux_sessions" | sed -E 's/^([^:]+): ([0-9]+) windows \(created[^)]+\)/\1 [tmux session]/')\n"
  fi

  if [[ -f "$DIRS_INDEX" ]]; then
    dirs_index_entries=$(cat "$DIRS_INDEX")
    [[ -n "$dirs_index_entries" ]] && entries="$entries$dirs_index_entries"
  fi

  local selected_entry=$(echo -e "$entries" | fzf)
  [[ -z "$selected_entry" ]] && return 0

  # tmux session selected
  if echo "$selected_entry" | grep "\[tmux session\]" &> /dev/null; then
    local session_name=$(echo "$selected_entry" | cut -d' ' -f1)
    [[ -z "$TMUX" ]] && tmux attach-session -t "$session_name" || tmux switch-client -t "$session_name"
    return 0
  fi

  # directory selected: new tmux session on dir if not already attached to session, else just cd into dir
  local resolved_dir="$HOME/$selected_entry"
  if [[ -z "$TMUX" ]]; then
    local session_name=$(basename "$selected_entry" | tr . _)
    if ! tmux has-session -t "$session_name" 2> /dev/null; then
      tmux new-session -s "$session_name" -c "$resolved_dir"
    else
      tmux attach-session -t "$session_name"
    fi
    return 0
  fi

  [[ -d "$resolved_dir" ]] && cd "$resolved_dir" || echo "! $selected_entry directory does not exist or is invalid"
}

# remove dead entries from directory bookmark index
bookmark-dirindex-clean() {
  DIRS_INDEX="$DOTS_HOME/misc/dirs.index"
  [[ ! -f $DIRS_INDEX ]] && return 1

  entries=($(cat "$DIRS_INDEX"))
  for entry in "${entries[@]}"; do
    if [[ ! -d "$HOME/$entry" ]]; then
      echo "-- removing dead entry from directory bookmark index: $entry"
      sed "$(grep -n -E "^${entry}$" $DIRS_INDEX | awk -F: '{print $1}')d" -i $DIRS_INDEX
    fi
  done
}


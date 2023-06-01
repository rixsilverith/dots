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


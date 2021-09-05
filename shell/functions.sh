# `functions.sh` defines different utility functions that are shared
# across the bash and zsh shells.

# Check if a given command is installed.
# Usage: has <command>
has() {
  local -r cmd="$1"
  [ -n $cmd ] && command -v $cmd &> /dev/null
}

# Create a directory and jump to it.
# Usage: mkcd <directory>
mkcd() {
  local -r dir="$*"
  mkdir -p "$dir" && cd "$dir"
}

# Copy a file or folder. Create the filepath if it doesn't exist.
# Usage: mkcp <origin> <destination>
mkcp() {
  local dir="$2"
  local tmp="$2"; tmp="${tmp:-1}"
  [ "$tmp" != "/" ] && dir="$(dirname "$2")"
  [ -d "$dir" ] || mkdir -p "$dir" && cp -r "$@"
}

# Move a file or a folder. Create the filepath if it doesn't exist.
# Usage: mkmv <origin> <destination>
mkmv() {
  local dir="$2"
  local tmp="$2"; tmp="${tmp:-1}"
  [ "$tmp" != "/" ] && dir="$(dirname "$2")"
  [ -d "$dir" ] || mkdir -p "$dir" && mv "$@"
}

# Jump to a directory using Z.
# Usage: d [directory]
# See: https://github.com/rupa/z
d() { _z "${1:-$HOME}"; }

# Create backups for a given list of files.
# Usage: back <file1> <file2> ...
back() { for file in "$@"; do cp "$file" "$file".bak; done; }

# Preview CSV files.
# Usage: csvpreview <file>
# Source: http://stackoverflow.com/questions/1875305/command-line-csv-viewer
csvpreview() { sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t | less -N -S }

# Create an ed25519 SSH key.
# Usage: ssh-create-key <name> [passphrase]
# If no [passphrase] is provided, the created key will be passwordless.
ssh-create-key() {
  ! has ssh-keygen || [ -z "$1" ] && return
  local -r keyname="$1"
  local -r passphrase="${2:-}"

  [ ! -d "$XDG_CONFIG_HOME/ssh/keys" ] && mkdir -p "$XDG_CONFIG_HOME/ssh/keys"
  ssh-keygen -t ed25519 -f "$XDG_CONFIG_HOME/ssh/keys/$1" -N "$2" -C "$1"
  chmod 700 $XDG_CONFIG_HOME/ssh/keys/$1*
}

# Check for open ports in the current machine.
# Usage: ports
ports() { sudo netstat -tulpn | grep LISTEN | less; }

# Ping to a given address.
# Usage: ping [address] [n_packages]
# [address] defaults to 8.8.8.8 and [n_packages] to 3.
ping() {
  local pcmd="ping"
  local -r address="${1:-8.8.8.8}"
  local -r npings="${2:-3}"

  has prettyping && pcmd="prettyping"
  $pcmd -c$npings $address
}

# Generate a random number in a given interval.
# Usage: nrand [min] [max]
# [min] defaults to 0, [max] to 1.
nrand() {
  local -r floor="${1:-0}"
  local -r ceiling="${2:-1}"

  range=$(( $ceiling - $floor + 1 ))
  result=$RANDOM

  let "result %= $range"
  result=$(( $result + $floor ))
  echo $result
}

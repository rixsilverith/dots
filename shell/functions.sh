# Create a new directory and enter it
function mk() { mkdir -p "$@" && cd "$@"; }

# preview csv files. source: http://stackoverflow.com/questions/1875305/command-line-csv-viewer
function csvpreview(){
    sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t | less -#2 -N -S
}

function glog() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}

function j() {
  fname=$(declare -f -F _z)

  [ -n "$fname" ] || source "$DOTS_HOME/modules/z/z.sh"

  _z "$1"
}

function _cc() { $1 | xclip -selection clipboard }
function _cv() { xclip -o selection clipboard }

function has() {
  local -r cmd="$1"
  [[ ! -z $cmd ]] && command -v $cmd &> /dev/null
}

function nrandom() {
  local -r floor="${1:-0}"
  local -r ceiling="${2:-1}"

  range=$(( $ceiling - $floor + 1 ))
  result=$RANDOM

  let "result %= $range"
  result=$(( $result + $floor ))
  echo $result
}

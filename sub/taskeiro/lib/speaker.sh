# https://misc.flogisoft.com/bash/tip_colors_and_formatting
export FG_CYAN='\e[36m'
export FG_LGREEN='\e[92m'
export FG_LRED='\e[91m'
export FG_LYELLOW='\e[93m'
export FG_LBLUE='\e[94m'
export BG_RED='\e[41m'
export NC='\033[0m' # No Color

function _outerr() {
  local first=1
  for value in "$@"; do
    if [ -n "$first" ]; then
      first=''
    else
      _outerr_single ' '
    fi
    _outerr_single "$value"
  done
}

function _outerr_single() {
  >&2 printf -- '%b' "$1"
}

function _fatal_error() {
  _outerr "${BG_RED}" "$@" "${NC}\n"
  exit 1
}

function _success() {
  _outerr "${FG_LGREEN}" "$@" "${NC}\n"
}

function _infov() {
  local LABEL="$1"
  shift
  _outerr "${FG_CYAN}" "${LABEL}:" "${NC}" "$@" "\n"
}

function _debug() {
  if [ -n "$TASKEIRO_DEBUG" ]; then
    _outerr "${FG_LBLUE}" "$@" "${NC}\n"
  fi
}

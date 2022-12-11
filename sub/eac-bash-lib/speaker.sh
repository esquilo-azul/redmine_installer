set -u
set -e

export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;93m'
export CYAN='\033[0;36m'
export NC='\033[0m'

function outerr() {
  local first=1
  for value in "$@"; do
    if [ -n "$first" ]; then
      first=''
    else
      >&2 outout ' '
    fi
    >&2 outout "$value"
  done
}
export -f outerr

function outout() {
  printf -- '%b' "$1"
}
export -f outout

# Outputs a error message.
function error() {
  outerr "${RED}Error: ${NC}"
  outerr "$@"
  outerr "\n"
}
export -f error

function infom() {
  outerr "${YELLOW}$@${NC}\n"
}
export -f infom

function infov() {
  outerr "${CYAN}$1: ${NC}"
  shift
  outerr "$@"
  outerr "\n"
}
export -f infov

function infov_compact() {
  for variable in "$@"; do
    infov "$variable" "${!variable}"
  done
}

# Outputs a error message and exit with error code.
function fatal_error() {
  set -u
  set -e

  error "$@"
  exit 1
}
export -f fatal_error

function info_ok() {
  outerr "${GREEN}$@${NC}\n"
}
export -f info_ok

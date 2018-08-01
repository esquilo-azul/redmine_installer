# https://misc.flogisoft.com/bash/tip_colors_and_formatting
export FG_CYAN='\e[36m'
export FG_LGREEN='\e[92m'
export FG_LRED='\e[91m'
export FG_LYELLOW='\e[93m'
export FG_LBLUE='\e[94m'
export BG_RED='\e[41m'
export NC='\033[0m' # No Color

function _fatal_error() {
  >&2 printf "$BG_RED$1$NC\n"
  exit 1
}

function _success() {
  >&2 printf "$FG_LGREEN$1$NC\n"
}

function _infov() {
  >&2 printf "$FG_CYAN$1:$NC $2\n"
}

function _debug() {
  if [ -n "$TASKEIRO_DEBUG" ]; then
    >&2 printf "${FG_LBLUE}${1}${NC}\n"
  fi
}

#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
export TASKEIRO_ROOT="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

export ERROR_EACBASHLIB_NOT_FOUND=1
export EACBASHLIB_SOURCE_URL='https://github.com/esquilo-azul/eac-bash-lib'

function taskeiro() {
  export TASKEIRO_EXECUTER="$0"
  export TASKEIRO_PATH=
  export TASKEIRO_TASKS=
  export TASKEIRO_DEBUG="${TASKEIRO_DEBUG:-}"
  export TASKEIRO_CHECKED_TASKS='|'
  hash_init 'EXTRA_DEPENDENCIES'

  # Terminal colors
  export FG_LGREEN='\e[92m'
  export FG_LRED='\e[91m'
  export FG_LYELLOW='\e[93m'
  export FG_LBLUE='\e[94m'

  for file in "${TASKEIRO_ROOT}/lib/"*.sh; do
    source "$file"
  done

  taskeiro_read_args "$@"
  taskeiro_start_banner
  taskeiro_validate
  taskeiro_before_run
  taskeiro_run
}
export -f taskeiro

if [[ ! -v 'EACBASHLIB_ROOT' ]]; then
  export EACBASHLIB_ROOT="$(dirname "$PROGRAMEIRO_ROOT_ROOT")/eac-bash-lib"
fi
export EACBASHLIB_RC="${EACBASHLIB_ROOT}/init.sh"

if [[ ! -f "$EACBASHLIB_RC" ]]; then
  >&2 printf "%s\n" "\"$EACBASHLIB_RC\" not found."
  >&2 printf "%s %s\n" "You need to have a copy of ${EACBASHLIB_SOURCE_URL} in"
    "\"$EACBASHLIB_ROOT\" or in directory pointed by \$EACBASHLIB_ROOT." \
  exit $ERROR_EACBASHLIB_NOT_FOUND
fi

if [[ ${BASH_SOURCE[0]} == $0 ]]; then
  taskeiro "${@}"
  exit $?
fi

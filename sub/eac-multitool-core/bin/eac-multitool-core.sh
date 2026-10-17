#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
export EACMULTITOOLCORE_BIN="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

function add_to_pathvar() {
  local MULTITOOL_NODE="$1"
  local PATHVAR="$2"
  local SUBPATH="$3"

  var_set_by FULLPATH path_expand "$SUBPATH" "$MULTITOOL_NODE"

  if [[ -d "$FULLPATH" ]] && [[ ":${!PATHVAR}:" != *":$FULLPATH:"* ]]; then
    pathvar_push "$PATHVAR" "$FULLPATH"
  fi
}

function eac_multitool_core() {
  programeiro_run "$@"
}
export -f eac_multitool_core

source "${EACMULTITOOLCORE_ROOT}/sub/eac-bash-lib/init.sh"
source "${EACMULTITOOLCORE_ROOT}/sub/programeiro/programeiro.sh"
source "${EACMULTITOOLCORE_ROOT}/sub/taskeiro/taskeiro.sh"

pathvar_assert 'MULTITOOL_PATH'
pathvar_push 'MULTITOOL_PATH' "${EACMULTITOOLCORE_ROOT}"

pathvar_assert 'PROGRAMEIRO_PATH'
pathvar_assert 'TASKEIRO_PATH'

while read -r MULTITOOL_NODE; do
  SETUP_FILE="${MULTITOOL_NODE}/setup.sh"
  if [[ -f "$SETUP_FILE" ]]; then
    source "${SETUP_FILE}"
  fi
  add_to_pathvar "$MULTITOOL_NODE" 'PROGRAMEIRO_PATH' 'program'
  add_to_pathvar "$MULTITOOL_NODE" 'TASKEIRO_PATH' 'task'
done < <(pathvar_to_lines 'MULTITOOL_PATH')

if [[ ${BASH_SOURCE[0]} == $0 ]]; then
  eac_multitool_core "${@}"
  exit $?
fi

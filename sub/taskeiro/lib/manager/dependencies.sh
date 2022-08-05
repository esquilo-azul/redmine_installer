hash_init 'EXTRA_DEPENDENCIES'

function taskeiro_task_dependencies() {
  local EXTRA="$(_extra_dependencies_get "$1")"
  local SELF="$(_call_task_function "$1" task_dependencies 1)"
  if [[ -n "$EXTRA" ]] && [[ -n "$SELF" ]]; then
    echo "$EXTRA $SELF"
  elif [[ -n "$EXTRA" ]]; then
    echo "$EXTRA"
  elif [[ -n "$SELF" ]]; then
    echo "$SELF"
  else
    echo ''
  fi
}

function taskeiro_add_dependency() {
  local TARGET="$1"
  shift
  for DEPENDENCY in "$@"; do
    _extra_dependencies_add "$TARGET" "$DEPENDENCY"
  done
}

function _extra_dependencies_add() {
  local TARGET="$1"
  local DEPENDENCY="$2"

  local VALUE="$(hash_get 'EXTRA_DEPENDENCIES' "$1")"
  if [[ -n "$VALUE" ]]; then
    VALUE="$VALUE "
  fi
  VALUE="${VALUE}${DEPENDENCY}"

  hash_put 'EXTRA_DEPENDENCIES' "$TARGET" "$VALUE"
}

function _extra_dependencies_get() {
  hash_get 'EXTRA_DEPENDENCIES' "$1"
}

function _join_by() {
  local IFS="$1"
  shift
  echo "$*"
}

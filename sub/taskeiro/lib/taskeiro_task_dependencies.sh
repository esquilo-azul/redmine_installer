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

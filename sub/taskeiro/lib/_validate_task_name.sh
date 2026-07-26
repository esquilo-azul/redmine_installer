function _validate_task_name() {
  if ! _task_valid_name "$1"; then
    fatal_error "Invalid task name: \"$1\""
  fi
}

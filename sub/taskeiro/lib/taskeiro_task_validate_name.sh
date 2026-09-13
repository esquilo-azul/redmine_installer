function taskeiro_task_validate_name() {
  if ! taskeiro_task_valid_name "$1"; then
    fatal_error "Invalid task name: \"$1\""
  fi
}
export -f taskeiro_task_validate_name

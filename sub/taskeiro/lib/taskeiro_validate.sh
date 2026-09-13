function taskeiro_validate() {
  if [ -z "$TASKEIRO_PATH" ]; then
    fatal_error "TASKEIRO_PATH is empty"
  fi
  printf "$TASKEIRO_TASKS" | while read TASK; do
     taskeiro_task_validate_name "$TASK"
    local task_path=$(taskeiro_task_path "$TASK")
    if [ ! -f "$task_path" ]; then
      fatal_error "No file found for task \"$TASK\""
    fi
  done
}
export -f taskeiro_validate

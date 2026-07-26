function taskeiro_validate() {
  if [ -z "$TASKEIRO_PATH" ]; then
    fatal_error "TASKEIRO_PATH is empty"
  fi
  printf "$TASKEIRO_TASKS" | while read TASK; do
     _validate_task_name "$TASK"
    local task_path=$(taskeiro_task_path "$TASK")
    if [ ! -f "$task_path" ]; then
      fatal_error "Task file \"$task_path\" not found"
    fi
  done
}

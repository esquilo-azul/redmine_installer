function taskeiro_task_checked() {
  taskeiro_task_validate_name "$1"
  echo "$TASKEIRO_CHECKED_TASKS" | grep "|$1|" > /dev/null
}
export -f taskeiro_task_checked

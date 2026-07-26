function _task_checked() {
  _validate_task_name "$1"
  echo "$TASKEIRO_CHECKED_TASKS" | grep "|$1|" > /dev/null
}

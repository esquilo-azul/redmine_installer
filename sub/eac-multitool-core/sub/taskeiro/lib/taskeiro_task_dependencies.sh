function taskeiro_task_dependencies() {
  for TASK in $(taskeiro_task_dependencies_extra "$1"); do
    outout_nl "$TASK"
  done
  for TASK in $(taskeiro_task_call_function "$1" task_dependencies 1); do
    outout_nl "$TASK"
  done
}
export -f taskeiro_task_dependencies

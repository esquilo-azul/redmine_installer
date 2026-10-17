function taskeiro_task_check() {
  taskeiro_debug "CHECK $1"
  export TASKEIRO_CHECKED_TASKS=$TASKEIRO_CHECKED_TASKS"$1|"
}
export -f taskeiro_task_check

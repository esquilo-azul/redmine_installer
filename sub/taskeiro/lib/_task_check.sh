function _task_check() {
  _debug "CHECK $1"
  export TASKEIRO_CHECKED_TASKS=$TASKEIRO_CHECKED_TASKS"$1|"
}

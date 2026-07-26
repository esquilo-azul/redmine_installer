function _task_run() {
  _debug "START $1"
  if _task_checked "$1" ; then
    _debug "END $1 (ALREADY CHECKED: $TASKEIRO_CHECKED_TASKS)"
    return
  fi
  _task_check "$1"
  for dep in $(taskeiro_task_dependencies "$1"); do
    _debug "DEPENDENCY $1 -> $dep"
    _task_run "$dep"
  done
  _taskeiro_path_callback '_before_task.sh'
  if ! _task_pass "$1" 1 ; then
    _call_task_function "$1" task_fix
    if ! _task_pass "$1" 0 ; then
      fatal_error "Task \"$1\" failed to pass"
    fi
  fi
  _debug "END $1"
}

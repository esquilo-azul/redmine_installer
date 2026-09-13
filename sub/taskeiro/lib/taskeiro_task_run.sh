function taskeiro_task_run() {
  taskeiro_debug "START $1"
  if taskeiro_task_checked "$1" ; then
    taskeiro_debug "END $1 (ALREADY CHECKED: $TASKEIRO_CHECKED_TASKS)"
    return
  fi
  taskeiro_task_check "$1"
  for dep in $(taskeiro_task_dependencies "$1"); do
    taskeiro_debug "DEPENDENCY $1 -> $dep"
    taskeiro_task_run "$dep"
  done
  taskeiro_path_callback '_before_task.sh'
  if ! taskeiro_task_pass "$1" 1 ; then
    taskeiro_task_call_function "$1" task_fix
    if ! taskeiro_task_pass "$1" 0 ; then
      fatal_error "Task \"$1\" failed to pass"
    fi
  fi
  taskeiro_debug "END $1"
}
export -f taskeiro_task_run

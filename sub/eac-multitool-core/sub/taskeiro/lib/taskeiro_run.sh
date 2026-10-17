function taskeiro_run() {
  printf "$TASKEIRO_TASKS" | while read TASK; do taskeiro_task_run "$TASK" ; done
}
export -f taskeiro_run

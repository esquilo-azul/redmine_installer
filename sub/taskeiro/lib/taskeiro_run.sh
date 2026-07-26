function taskeiro_run() {
  printf "$TASKEIRO_TASKS" | while read TASK; do _task_run "$TASK" ; done
}

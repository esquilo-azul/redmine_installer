function taskeiro_task_path() {
  pathvar_find_file 'TASKEIRO_PATH' "$1.sh"
}
export -f taskeiro_task_path

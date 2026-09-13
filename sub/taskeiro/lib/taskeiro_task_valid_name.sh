function taskeiro_task_valid_name() {
  echo $1 | grep '^[a-z0-9_]\+\(/[a-z0-9_]\+\)*$' > /dev/null
}
export -f taskeiro_task_valid_name

function taskeiro_find_tasks() {
  local PATTERN="$1"
  while read -r TASK; do
    if [[ "${TASK}" == $PATTERN ]]; then
      outout_nl "${TASK}"
    fi
  done < <(taskeiro_all_tasks)
}
export -f taskeiro_find_tasks

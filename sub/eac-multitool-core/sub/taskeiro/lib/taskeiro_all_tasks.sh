function taskeiro_all_tasks() {
  while read -r NODE; do
    (cd "${NODE}" ; find . -name '*.sh' | sed 's|^./||g' | sed 's|\.sh$||g')
  done < <(pathvar_to_lines 'TASKEIRO_PATH')
}
export -f taskeiro_all_tasks

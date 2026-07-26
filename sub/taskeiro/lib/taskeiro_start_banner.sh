function taskeiro_start_banner() {
  infov 'Path' "$TASKEIRO_PATH"
  local tasks=$(printf "$TASKEIRO_TASKS" | xargs -ILINE printf "LINE ")
  infov 'Tasks' "$tasks"
}

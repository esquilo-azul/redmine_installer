function taskeiro_path_callback() {
  SUBPATH="$1"
  taskeiro_debug "START taskeiro_path_callback()" "$@"

  while read -r BEFORE_RUN_PATH; do
    taskeiro_debug "Callback ${BEFORE_RUN_PATH}: found"
    source "$BEFORE_RUN_PATH"
  done < <(pathvar_find_files 'TASKEIRO_PATH' "$SUBPATH" )

  taskeiro_debug "END taskeiro_path_callback()" "$@"
}
export -f taskeiro_path_callback

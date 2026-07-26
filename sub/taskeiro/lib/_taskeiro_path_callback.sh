function _taskeiro_path_callback() {
  SUBPATH="$1"
  _debug "START _taskeiro_path_callback()" "$@"
  local IFS=:
  for p in $TASKEIRO_PATH; do
    BEFORE_RUN_PATH="${p}/${SUBPATH}"
    if [ -f "$BEFORE_RUN_PATH" ]; then
      _debug "Callback ${BEFORE_RUN_PATH}: found"
      source "$BEFORE_RUN_PATH"
    else
      _debug "Callback ${BEFORE_RUN_PATH}: not found"
    fi
  done
  _debug "END _taskeiro_path_callback()" "$@"
}

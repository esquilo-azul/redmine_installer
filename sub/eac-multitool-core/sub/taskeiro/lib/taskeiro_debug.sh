function taskeiro_debug() {
  if [ -n "$TASKEIRO_DEBUG" ]; then
    outerr "${FG_LBLUE}" "$@" "${NC}\n"
  fi
}
export -f taskeiro_debug

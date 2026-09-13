function taskeiro_add_dependency() {
  local TARGET="$1"
  shift
  for DEPENDENCY in "$@"; do
    taskeiro_dependencies_extra_add "$TARGET" "$DEPENDENCY"
  done
}
export -f taskeiro_add_dependency

function taskeiro_task_dependencies_extra() {
  hash_assert 'EXTRA_DEPENDENCIES'
  hash_get 'EXTRA_DEPENDENCIES' "$1"
}
export -f taskeiro_task_dependencies_extra

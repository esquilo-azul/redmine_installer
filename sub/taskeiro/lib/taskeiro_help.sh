function taskeiro_help() {
  cat <<EOS
Usage:

  $TASKEIRO_EXECUTER -p|--path <TASKS_DIR>
  $TASKEIRO_EXECUTER -h|--help
EOS
  exit 0
}

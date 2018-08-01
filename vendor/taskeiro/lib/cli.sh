function taskeiro_read_args() {
  while [[ $# > 0 ]] ; do
    key="$1"
    case $key in
      -h|--help)
      taskeiro_help
      exit 0
      ;;
      -p|--path)
      TASKEIRO_PATH=$(readlink -f "$2")
      shift
      ;;
      *)
      TASKEIRO_TASKS="$TASKEIRO_TASKS$1\n"
      ;;
    esac
    shift
  done
}

function taskeiro_help() {
  cat <<EOS
Usage:

  $TASKEIRO_EXECUTER -p|--path <TASKS_DIR>
  $TASKEIRO_EXECUTER -h|--help
EOS
  exit 0
}

function taskeiro_start_banner() {
  _infov 'Path' "$TASKEIRO_PATH"
  local tasks=$(printf "$TASKEIRO_TASKS" | xargs -ILINE printf "LINE ")
  _infov 'Tasks' "$tasks"
}

function taskeiro_validate() {
  if [ ! -d "$TASKEIRO_PATH" ]; then
    _fatal_error "TASKEIRO_PATH \"$TASKEIRO_PATH\" is not a directory."
  fi
  printf "$TASKEIRO_TASKS" | while read TASK; do
     _validate_task_name "$TASK"
    local task_path=$(taskeiro_task_path "$TASK")
    if [ ! -f "$task_path" ]; then
      _fatal_error "Task file \"$task_path\" not found"
    fi
  done
}

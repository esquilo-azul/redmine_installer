function taskeiro_read_args() {
  while [[ $# > 0 ]] ; do
    key="$1"
    case $key in
      -h|--help)
      taskeiro_help
      exit 0
      ;;
      -p|--path)
      TASKEIRO_PATH="$2"
      shift
      ;;
      *)
      TASKEIRO_TASKS="$TASKEIRO_TASKS$1\n"
      ;;
    esac
    shift
  done
}

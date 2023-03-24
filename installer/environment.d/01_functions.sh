source "${SUB_ROOT}/eac-bash-lib/init.sh"

function _build_plugins_path {
  SUBDIR="$1"
  RESULT=''
  for DIR in "${REDMINE_ROOT}/plugins/"*"/installer/${SUBDIR}"; do
    if [ -n "$RESULT" ]; then
      RESULT+=':'
    fi
    RESULT+="$DIR"
  done
  printf -- "$RESULT\n"
}
export -f _build_plugins_path

function programeiro_path {
  _build_plugins_path "programs"
}
export -f programeiro_path

function programeiro {
  PPATH="$(programeiro_path)" "${SUB_ROOT}/programeiro/run.sh" "$@"
}
export -f programeiro

function taskeiro_path {
  _build_plugins_path "tasks"
}
export -f taskeiro_path

function taskeiro {
  "${SUB_ROOT}/taskeiro/taskeiro" --path "$(taskeiro_path)" "$@"
}
export -f taskeiro

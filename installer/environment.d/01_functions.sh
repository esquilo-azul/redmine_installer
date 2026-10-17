source "${EACBASHLIB_ROOT}/init.sh"

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

function programeiro {
  "${EACMULTITOOLCORE_ROOT}/bin/eac-multitool-core" "$@"
}
export -f programeiro

function taskeiro {
  programeiro /taskeiro/run "$@"
}
export -f taskeiro

function cli_arg() {
  if [ $# -lt 2 ]; then
    fatal_error "Usage: ${FUNCNAME[0]} <POSITION> <DEFAULT_VALUE> [<ARGV>...]\n"
  fi
  local POSITION="$1"
  shift
  local DEFAULT_VALUE="$1"
  shift
  if [ $# -ge "$POSITION" ]; then
    printf "%s\n" "${!POSITION}"
  else
    printf "%s\n" "$DEFAULT_VALUE"
  fi
}
export -f cli_arg

function cli_file_path_exist() {
  if [ -f "$1" ] || [ -b "$1" ] || [ -c "$1" ]; then
    return 0
  fi
  for ARG in "$@"; do
    if [ "$ARG" = "$1" ]; then
      return 0
    fi
  done

  return 1
}
export -f cli_file_path_exist

function cli_file_path_or_default() {
  local RESULT="$1"
  local DEFAULT_RESULT="$2"
  if [ "$RESULT" = '-' ]; then
    local RESULT="$DEFAULT_RESULT"
  elif ! cli_file_path_exist "$RESULT" "$DEFAULT_RESULT"; then
    fatal_error "File \"$RESULT\" does not exist or is not a file/device (${FUNCNAME[@]})\n"
    return 1
  fi
  printf "%s\n" "$RESULT"
}
export -f cli_file_path_or_default

function cli_file_path_or_stdin() {
  cli_file_path_or_default "$1" '/dev/stdin'
}
export -f cli_file_path_or_stdin

function cli_file_path_or_stdout() {
  cli_file_path_or_default "$1" '/dev/stdout'
}
export -f cli_file_path_or_stdout

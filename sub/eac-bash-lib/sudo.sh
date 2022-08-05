set -u
set -e

function sudoers_read() {
  if [ $# -lt 1 ]; then
    printf "Usage: ${FUNCNAME[0]} <SOURCE_FILE>"
    return 1
  fi

  sudo cat "$1" 2> /dev/null
}
export -f sudoers_read

function sudoers_write() {
  if [ $# -lt 1 ]; then
    error "Usage: ${FUNCNAME[0]} <TARGET_FILE> [<SOURCE_FILE>='-']\n"
    return 1
  fi

  local TARGET_FILE="$1"
  local SOURCE_FILE="$(cli_arg 2 '-' "$@")"
  SOURCE_FILE="$(cli_file_path_or_stdin "$SOURCE_FILE")"

  sudo EDITOR='tee' visudo -f "$TARGET_FILE" < "$SOURCE_FILE"
  sudo chmod 440 "$TARGET_FILE"
}
export -f sudoers_write

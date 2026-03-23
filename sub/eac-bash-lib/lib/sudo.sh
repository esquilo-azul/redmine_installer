set -u
set -e

export DEFAULT_SUDO_USE_ENVVAR='SUDO'
export DEFAULT_SUDO_USE_VALUE="${DEFAULT_FALSE_VALUE}"
export DEFAULT_SUDO_USER_ENVVAR='SUDO_USER'
export DEFAULT_SUDO_USER_VALUE=''

function sudo_use_r() {
  bool_pr "${DEFAULT_SUDO_USE_ENVVAR}" || sudo_user_r
}

function sudo_user_r() {
  [ "$(sudo_user_s)" != '' ]
}

function sudo_user_s() {
  if var_present_r "${DEFAULT_SUDO_USER_ENVVAR}"; then
    outout "${!DEFAULT_SUDO_USER_ENVVAR}\n"
  else
    outout ''
  fi
}

function sudo_run() {
  PRE_COMMAND_ARGS=()
  if sudo_user_r; then
    PRE_COMMAND_ARGS=(sudo --user "$(sudo_user_s)")
  elif sudo_use_r; then
    PRE_COMMAND_ARGS=(sudo)
  fi

  "${PRE_COMMAND_ARGS[@]}" "$@"
}
export -f sudo_run

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

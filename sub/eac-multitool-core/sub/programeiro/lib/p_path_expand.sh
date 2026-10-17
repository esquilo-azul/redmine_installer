function p_path_expand() {
  PATH_ARG="$1"
  if [ $# -ge 2 ]; then
    BASE_ARG="$2"
  else
    BASE_ARG='/'
  fi

  if [[ "$PATH_ARG" == '/'* ]]; then
    TARGET_PATH="$(printf -- "%s\n" "$PATH_ARG")"
  else
    TARGET_PATH="$(printf -- "%s/%s\n" "$BASE_ARG" "$PATH_ARG")"
  fi

  realpath --canonicalize-missing --no-symlinks "${TARGET_PATH}"
}

function file_mime_type() {
  file --mime-type --brief "$@"
}

function path_expand() {
  PATH_ARG="$1"
  if [ $# -ge 2 ]; then
    BASE_ARG="$2"
  else
    BASE_ARG="$PWD"
  fi

  if [[ "$PATH_ARG" == '/'* ]]; then
    printf -- "%s\n" "$PATH_ARG"
  else
    printf -- "%s/%s\n" "$BASE_ARG" "$PATH_ARG"
  fi
}
export -f path_expand

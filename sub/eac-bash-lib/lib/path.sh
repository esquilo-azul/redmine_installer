function basename_without_extension() {
  local THE_PATH="$1"
  var_set_by BASENAME basename "$THE_PATH"
  path_without_extension "${BASENAME}"
}
export -f basename_without_extension

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

function path_extension() {
  local THE_PATH="$1"
  local BASE="${THE_PATH##*/}"
  outout "${BASE##*.}"
}
export -f path_extension

function path_without_extension() {
  local THE_PATH="$1"
  outout "${THE_PATH%.*}"
}
export -f path_without_extension

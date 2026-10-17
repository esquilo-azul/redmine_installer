export PATHVAR_SEP=':'

function pathvar_assert() {
  local PATHVAR="$1"
  if [[ ! -v "$PATHVAR" ]]; then
    export "$PATHVAR"=''
  fi
}
export -f pathvar_assert

function pathvar_find_file() {
  local PATHVAR="$1"
  local FILE_SUBPATH_PATTERN="$2"

  while read -r FOUND_FILE; do
    outout "$FOUND_FILE"
    return 0
  done < <(pathvar_find_files "${PATHVAR}" "${FILE_SUBPATH_PATTERN}")

  return 1
}
export -f pathvar_find_file

function pathvar_find_files() {
  pathvar_find_multiple "$1" "$2" -type f
}
export -f pathvar_find_files

function pathvar_find_multiple() {
  local PATHVAR="$1"
  local FILE_SUBPATH_PATTERN="$2"
  shift
  shift

  while read -r NODE; do
    [ -d "$NODE" ] || continue
    find "${NODE}" "$@" -path "${NODE}/${FILE_SUBPATH_PATTERN}" 2>/dev/null
  done < <(pathvar_to_lines "${PATHVAR}")
}
export -f pathvar_find_multiple

function pathvar_join() {
  local ACUM=''
  for VALUE in "$@"; do
    if [[ -n "$VALUE" ]]; then
      if [[ -n "$ACUM" ]]; then
        ACUM="${ACUM}${PATHVAR_SEP}${VALUE}"
      else
        ACUM="${VALUE}"
      fi
    fi
  done
  outout "$ACUM"
}
export -f pathvar_join

function pathvar_push() {
  local PATHVAR="$1"
  shift

  for VALUE in "$@"; do
    var_set_by "$PATHVAR" pathvar_join "${!PATHVAR}" "${VALUE}"
  done
}
export -f pathvar_push

function pathvar_to_lines() {
  local PATHVAR="$1"

  outout_nl "${!PATHVAR}" | tr "${PATHVAR_SEP}" '\n'
}
export -f pathvar_to_lines

function pathvar_unshift() {
  local PATHVAR="$1"
  shift

  for VALUE in "$@"; do
    var_set_by "$PATHVAR" pathvar_join "${VALUE}" "${!PATHVAR}"
  done
}
export -f pathvar_unshift

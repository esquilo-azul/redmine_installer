export PATHVAR_SEP=':'

function pathvar_assert() {
  local PATHVAR="$1"
  if [[ ! -v "$PATHVAR" ]]; then
    export "$PATHVAR"=''
  fi
}
export -f pathvar_assert

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

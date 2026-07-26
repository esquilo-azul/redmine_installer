function _extra_dependencies_add() {
  local TARGET="$1"
  local DEPENDENCY="$2"

  local VALUE="$(hash_get 'EXTRA_DEPENDENCIES' "$1")"
  if [[ -n "$VALUE" ]]; then
    VALUE="$VALUE "
  fi
  VALUE="${VALUE}${DEPENDENCY}"

  hash_put 'EXTRA_DEPENDENCIES' "$TARGET" "$VALUE"
}

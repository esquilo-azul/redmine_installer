function programeiro_extension_set() {
  local EXTENSION="$1"
  local RUNNER="$2"

  hash_assert PROGRAMEIRO_EXTENSIONS
  hash_put PROGRAMEIRO_EXTENSIONS "${EXTENSION}" "${RUNNER}"
}
export -f programeiro_extension_set

function programeiro_extension_get() {
  local EXTENSION="$1"

  hash_assert PROGRAMEIRO_EXTENSIONS
  hash_get_or_default PROGRAMEIRO_EXTENSIONS "${EXTENSION}"
}
export -f programeiro_extension_get

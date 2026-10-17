function programeiro_mime_type_get() {
  local MIME_TYPE="$1"

  hash_assert PROGRAMEIRO_MIME_TYPES
  hash_get_or_default PROGRAMEIRO_MIME_TYPES "${MIME_TYPE}"
}
export -f programeiro_mime_type_get

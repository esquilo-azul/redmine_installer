function programeiro_mime_type_set() {
  local MIME_TYPE="$1"
  local RUNNER="$2"

  hash_assert PROGRAMEIRO_MIME_TYPES
  hash_put PROGRAMEIRO_MIME_TYPES "${MIME_TYPE}" "${RUNNER}"
}
export -f programeiro_mime_type_set

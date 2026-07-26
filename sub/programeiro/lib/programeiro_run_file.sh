function programeiro_run_file() {
  local FILE="$1"
  shift
  var_set_by MIME_TYPE file_mime_type "${FILE}"
  var_set_by RUNNER programeiro_mime_type_get "${MIME_TYPE}"
  if [[ -z "${RUNNER}" ]]; then
    var_set_by EXTENSION path_extension "${FILE}"
    var_set_by RUNNER programeiro_extension_get "${EXTENSION}"
  fi
  if [[ -n "${RUNNER}" ]]; then
    "${RUNNER}" "${FILE}" "$@"
  else
    "${FILE}" "$@"
  fi
}
export -f programeiro_run_file

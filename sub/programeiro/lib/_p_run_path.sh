function _p_run_path() {
  local prgname="$1"
  local prgpath="$(p_find_program "$prgname")"
  if [ -z "$prgpath" ]; then
    return $PROGRAMEIRO_NOT_FOUND_ERROR
  fi
  if [ ! -f "$prgpath" ]; then
    >&2 echo "\"$prgpath\" is not a file"
    return 4
  fi
  if [ ! -x "$prgpath" ]; then
    >&2 echo "\"$prgpath\" is not executable"
    return 5
  fi
  printf "%s\n" "$prgpath"
}

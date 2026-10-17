function p_find_program {
  local prgname=$1
  programeiro_paths | while read path; do
    prgpath="$(_p_find_program_in_path "$prgname" "$path")"
    if [[ -n "$prgpath" ]]; then
      printf '%s\n' "${prgpath}"
      return
    fi
  done

  return $PROGRAMEIRO_NOT_FOUND_ERROR
}

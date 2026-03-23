function shell_join() {
  RESULT=''
  FIRST=true

  for ARG in "$@"; do
    if bool_r "$FIRST"; then
      FIRST=false
    else
      outout ' '
    fi
    printf '%q' "$ARG"
  done

  outout "\n"
}

function events_reset() {
   if [ -f "$EVENTS_FILE" ]; then
    rm -r "$EVENTS_FILE"
  fi
  export EVENTS_FILE=$(mktemp)
  printf '|' > "$EVENTS_FILE"
}
export -f events_reset

function events_add() {
  printf "$1|" >> "$EVENTS_FILE"
}
export -f events_add

function events_contain() {
  grep "|$1|" "$EVENTS_FILE" > /dev/null 2> /dev/null
}
export -f events_contain

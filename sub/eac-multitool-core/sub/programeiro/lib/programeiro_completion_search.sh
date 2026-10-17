function programeiro_completion_search() {
  programeiro_paths | while read path; do
    programeiro_completion_search_in_node "$path" '' "$1" "$(_ends_with_slash "$1")"
  done
}
export -f programeiro_completion_search

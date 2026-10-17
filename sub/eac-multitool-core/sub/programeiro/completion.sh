#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
export PROGRAMEIRO_ROOT="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

if [[ -z $PROGRAMEIRO_ALIAS ]]; then
  PROGRAMEIRO_ALIAS="programeiro"
fi
FUNCTION_NAME="_p_completion_$PROGRAMEIRO_ALIAS"

_p_completion() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  case "$COMP_CWORD" in
    1)
    mapfile -t COMPREPLY < <( programeiro_completion_search "$cur" )
    ;;

    *)
    mapfile -t COMPREPLY < <( compgen -o default -- "$cur" )
    if [[ ${#COMPREPLY[@]} -gt 0 ]]; then
      compopt -o filenames +o nospace 2>/dev/null || true
    fi
    ;;
  esac
  return 0
}

eval "${FUNCTION_NAME}() { source '$PROGRAMEIRO_ROOT/lib.sh'; set +u; set +e; _p_completion; return 0; }"
complete -F "$FUNCTION_NAME" -o nospace "$PROGRAMEIRO_ALIAS"

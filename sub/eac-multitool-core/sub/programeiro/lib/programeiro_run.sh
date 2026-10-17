function programeiro_run {
  set +u
  local prgname=$1
  shift
  set -u
  if [ -z "${PPWD+x}" ]; then
    export PPWD='/'
  fi
  if [ -z "$prgname" ]; then
    >&2 echo 'Program name not set'
    exit 3
  fi

  local prgpath=''
  if [[ $prgname != '/'* ]] && [[ "$PPWD" != '/' ]]; then
    local prgname0="$(p_path_expand "$prgname" "$PPWD")"
    set +e
    prgpath="$(_p_run_path "$prgname0")"
    set -e
  fi

  if [[ -z "$prgpath" ]]; then
    local prgname0="$(p_path_expand "$prgname")"
    set +e
    prgpath="$(_p_run_path "$prgname0")"
    set -e
  fi

  if [[ -z "$prgpath" ]]; then
    >&2 echo "\"$prgname\" not found"
    exit 1
  fi
  PPWD="$(dirname "$prgname")" programeiro_run_file "$prgpath" "$@"
}
export -f programeiro_run

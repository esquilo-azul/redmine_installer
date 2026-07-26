function var_blank_r() {
  if var_present_r "$1"; then
    return 1
  else
    return 0
  fi
}
export -f var_blank_r

function var_present_r() {
  [[ -v "$1" ]] && [[ -n "${!1}" ]]
}
export -f var_present_r

function var_set_by() {
  local _var_name="$1"
  shift
  local _output
  _output="$("$@")" || return $?
  printf -v "$_var_name" '%s' "$_output"
}
export -f var_set_by

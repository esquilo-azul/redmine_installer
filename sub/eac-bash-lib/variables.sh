set -u
set -e

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

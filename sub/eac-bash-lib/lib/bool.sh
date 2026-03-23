set -u
set -e

export DEFAULT_FALSE_VALUE='false'
export DEFAULT_TRUE_VALUE='true'

function bool_pr() {
  if var_present_r "$1"; then
    bool_r "${!1}"
  else
    bool_r "${DEFAULT_FALSE_VALUE}"
  fi
}
export -f bool_pr

function bool_r() {
  if [ $# -lt 1 ]; then
    return 1
  fi
  if [ -z "$1" ]; then
    return 1
  fi
  INPUT="$(printf -- "$1" | awk '{print tolower($0)}')"
  TRUE_VALUES=(yes y 0 "${DEFAULT_TRUE_VALUE}" t)
  FALSE_VALUES=(no n "${DEFAULT_FALSE_VALUE}" f)
  for VALUE in "${TRUE_VALUES[@]}"; do
    if [ "$INPUT" == "$VALUE" ]; then
      return 0
    fi
  done
  for VALUE in "${FALSE_VALUES[@]}"; do
    if [ "$INPUT" == "$VALUE" ]; then
      return 1
    fi
  done
  if [[ "$INPUT" =~ ^[0-9]+$ ]] ; then
    return 1
  fi
  return 0
}
export -f bool_r

function bool_s() {
  TRUE_VALUE='TRUE'
  FALSE_VALUE='FALSE'
  if [ $# -ge 2 ]; then
    TRUE_VALUE="$2"
  fi
  if [ $# -ge 3 ]; then
    FALSE_VALUE="$3"
  fi
  if bool_r "$1"; then
    printf "$TRUE_VALUE"
  else
    printf "$FALSE_VALUE"
  fi
}
export -f bool_s

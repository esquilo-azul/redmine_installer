set -u
set -e

function bool_r() {
  if [ $# -lt 1 ]; then
    return 1
  fi
  if [ -z "$1" ]; then
    return 1
  fi
  INPUT="$(printf -- "$1" | awk '{print tolower($0)}')"
  TRUE_VALUES=(yes y 0 true t)
  FALSE_VALUES=(no n false f)
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

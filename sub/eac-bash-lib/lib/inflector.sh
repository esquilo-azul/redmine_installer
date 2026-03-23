set -u
set -e

function parameterize() {
  if [ $# -ge 1 ]; then
    printf -- '%s' "$@" | parameterize
  else
    RESULT="$(sed ':a;N;$!ba;s/\n/ /g' | sed 's/[^a-z0-9A-Z]\+/-/g' <&0 | sed 's/^-\+//g' | sed 's/-\+$//g')"
    printf -- "%s\n" "${RESULT,,}"
  fi
}
export -f parameterize

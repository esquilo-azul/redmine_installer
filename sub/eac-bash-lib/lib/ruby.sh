export RUBY_PACKAGE_SOURCE_SEPARATOR=':'

function ruby_install_multiple() {
  gem install -V "$@"
}
export -f ruby_install_multiple

function ruby_installed_single() {
  IFS="$RUBY_PACKAGE_SOURCE_SEPARATOR" read -ra PARTS <<< "${1}"
  local VERSION=''
  if [ ${#PARTS[@]} -ge 2 ]; then
    VERSION="${PARTS[1]}"
  fi
  local PACKAGE="${PARTS[0]}"
  local TEST1=$(gem list --local | grep -i "^${PACKAGE}\s")
  if [ -z "$TEST1" ]; then
    return 1
  fi

  if [ -n "$VERSION" ]; then
    TEST2=$(echo "$TEST1" | grep "[^\d]${VERSION}[^\d]" )
    if [ -z "$TEST2" ]; then
      return 2
    fi
  fi
}
export -f ruby_installed_single

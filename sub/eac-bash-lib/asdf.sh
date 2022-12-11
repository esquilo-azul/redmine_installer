set -u
set -e

export DEFAULT_ASDF_ROOT="${HOME}/.asdf"
export DEFAULT_ASDF_VERSION='0.10.2'

function asdf_plugin_assert_installed() {
  if ! asdf_plugin_installed "$1"; then
    asdf_run plugin add "$1"
  fi
}
export -f asdf_plugin_assert_installed

function asdf_plugin_installed() {
  asdf_run plugin-list | grep \^"$1"\$ > /dev/null
}
export -f asdf_plugin_installed

function asdf_root() {
  if var_present_r 'ASDF_ROOT'; then
    outout "$ASDF_ROOT"
  else
    outout "$DEFAULT_ASDF_ROOT"
  fi
}
export -f asdf_root

function asdf_run() {
  source "$(asdf_root)/asdf.sh"
  asdf "$@"
}
export -f asdf_run

function asdf_version() {
  if var_present_r 'ASDF_VERSION'; then
    outout "$ASDF_VERSION"
  else
    outout "$DEFAULT_ASDF_VERSION"
  fi
}
export -f asdf_version

function asdf_version_assert_global() {
  PLUGIN="$1"
  VERSION="$2"
  asdf_version_assert_installed "$PLUGIN" "$VERSION"
  if [ "$(asdf_version_global "$PLUGIN")" != "${VERSION}" ]; then
    asdf_run global "${PLUGIN}" "${VERSION}"
  fi
}
export -f asdf_version_assert_global

function asdf_version_assert_installed() {
  PLUGIN="$1"
  VERSION="$2"
  asdf_plugin_assert_installed "$PLUGIN"
  if ! asdf_version_installed "$PLUGIN" "$VERSION"; then
    asdf_run install "$PLUGIN" "$VERSION"
  fi
}
export -f asdf_version_assert_installed

function asdf_version_global() {
  PLUGIN="$1"
  set +e
  OUTPUT=$(asdf_run current "$PLUGIN" global)
  RESULT=$?
  set -e
  if [ $RESULT -eq 0 ]; then
    outout "$OUTPUT" | awk '{print $2}'
  elif [ $RESULT -eq 126 ]; then
    return 0
  else
    return $RESULT
  fi
}
export -f asdf_version_global

function asdf_version_installed() {
  PLUGIN="$1"
  VERSION="$2"
  asdf_run list "$PLUGIN" "$VERSION" > /dev/null
}
export -f asdf_version_installed

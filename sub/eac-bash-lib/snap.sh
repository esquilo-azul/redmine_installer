set -u
set -e

source "$EACBASHLIB_ROOT/bool.sh"

function snap_install_multiple() {
  sudo snap install --edge "$@"
}
export -f snap_install_multiple

function snap_uninstall_multiple() {
  sudo snap remove "$@"
}
export -f snap_install_multiple

# Deprecated: use "package_installed snap" instead.
function snap_installed() {
  if snap_installed_single "$1"; then
    bool_s 'TRUE'
  else
    bool_s 'FALSE'
  fi
}
export -f snap_installed

function snap_installed_single() {
  if ! snap list "$1" > /dev/null 2> /dev/null; then
    return 1
  fi
}
export -f snap_installed_single

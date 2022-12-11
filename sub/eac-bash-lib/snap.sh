set -u
set -e

source "$EACBASHLIB_ROOT/bool.sh"

function snap_install_multiple() {
  sudo snap install --edge "$@"
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

# Deprecated: use "package_assert snap" instead.
function snap_assert_installed() {
  TO_INSTALL=()
  for PACKAGE in "$@"; do
    INSTALLED="$(snap_installed "$PACKAGE")"
    if ! bool_r "$INSTALLED"; then
      TO_INSTALL+=("$PACKAGE")
    fi
  done
  if [ ${#TO_INSTALL[@]} -ne 0 ]; then
    infom "Installing SNAP packages ${TO_INSTALL[@]}..."
    snap_install_multiple "${TO_INSTALL[@]}"
    infom "Installed"
  fi
}
export -f snap_assert_installed

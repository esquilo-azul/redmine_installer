set -u
set -e

source "$EACBASHLIB_ROOT/bool.sh"

function snap_installed() {
  if snap list "$1" > /dev/null 2> /dev/null; then
    bool_s 'TRUE'
  else
    bool_s 'FALSE'
  fi
}
export -f snap_installed

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
    sudo snap install --edge "${TO_INSTALL[@]}"
    infom "Installed"
  fi
}
export -f snap_assert_installed

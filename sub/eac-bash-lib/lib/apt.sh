set -u
set -e

export APT_PACKAGE_SOURCE_SEPARATOR='@'

function apt_get_run() {
  infom "Running \"apt-get $@\"..."
  sudo DEBIAN_FRONTEND=noninteractive apt-get -y "$@"
}
export -f apt_get_run

function apt_install_multiple() {
  PACKAGES=()
  for PACKAGE in "$@"; do
    IFS="$APT_PACKAGE_SOURCE_SEPARATOR" read -ra PARTS <<< "$PACKAGE"
    if [ ${#PARTS[@]} -ge 2 ]; then
      sudo add-apt-repository --yes "${PARTS[1]}"
    fi
    PACKAGES+=("${PARTS[0]}")
  done
  if [ ${#PACKAGES[@]} -eq 0 ]; then
    return 0
  fi
  apt_get_run update
  apt_get_run install "${PACKAGES[@]}"
}
export -f apt_install_multiple

function apt_installed_single() {
  PACKAGES=()
  for PACKAGE in "$@"; do
    IFS="$APT_PACKAGE_SOURCE_SEPARATOR" read -ra PARTS <<< "$PACKAGE"
    PACKAGES+=("${PARTS[0]}")
  done
  dpkg_installed "${PACKAGES[@]}"
}
export -f apt_installed_single

function apt_uninstall_multiple() {
  apt_get_run purge "$@"
}
export -f apt_uninstall_multiple

function apt_update() {
  apt_get_run update
}
export -f apt_update

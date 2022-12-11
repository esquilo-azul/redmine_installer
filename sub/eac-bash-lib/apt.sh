set -u
set -e

function apt_get_run() {
  infom "Running \"apt-get $@\"..."
  sudo DEBIAN_FRONTEND=noninteractive apt-get -y "$@"
}
export -f apt_get_run

function apt_install_multiple() {
  apt_get_run update
  apt_get_run install "$@"
}
export -f apt_install_multiple

function apt_installed_single() {
  dpkg_installed "$@"
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

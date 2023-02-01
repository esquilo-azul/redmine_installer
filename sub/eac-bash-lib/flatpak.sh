set -u
set -e

function flatpak_install_multiple() {
  sudo flatpak --system --assumeyes --noninteractive "$@"
}
export -f flatpak_install_multiple

function flatpak_installed_single() {
  flatpak_run --system info "$1"
}
export -f flatpak_installed_single

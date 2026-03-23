set -u
set -e

# Deprecated: use "package_assert apt" instead.
function deb_assert_installed() {
  package_assert apt "$@"
}
export -f deb_assert_installed

# Deprecated: use dpkg_installed() instead.
function deb_installed() {
  dpkg_installed "$@"
}
export -f deb_installed

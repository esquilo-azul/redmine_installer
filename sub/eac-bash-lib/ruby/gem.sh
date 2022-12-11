# Deprecated: use "package_assert ruby" instead.
function ruby_gem_install() {
  package_assert ruby "$@"
}

# Deprecated: use "package_installed ruby" instead.
function ruby_gem_installed() {
  package_installed ruby "$@"
}

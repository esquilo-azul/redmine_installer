function php_install_multiple() {
  php_composer_run require "$@"
}
export -f php_install_multiple

function php_installed_single() {
  php_composer_run show | awk '{print $1}' | grep '^'"$1"'$' > /dev/null
}
export -f php_installed_single

function php_composer_run() {
  composer global --no-interaction "$@"
}
export -f php_composer_run

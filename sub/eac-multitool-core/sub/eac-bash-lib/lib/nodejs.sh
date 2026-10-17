function nodejs_install_multiple() {
  nodejs_npm_run install "$@"
}
export -f nodejs_install_multiple

function nodejs_installed_single() {
  nodejs_npm_run ls "$1" > /dev/null
}
export -f nodejs_installed_single

function nodejs_npm_run() {
  npm --global "$@"
}
export -f nodejs_npm_run

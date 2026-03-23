export DEFAULT_PIP_COMMAND='pip'

function python_install_multiple() {
  "$(python_pip_command)" install "$@"
}
export -f python_install_multiple

function python_installed_single() {
  pip show "$1" > /dev/null
}
export -f python_installed_single

function python_pip_command() {
  if var_present_r 'PIP_COMMAND'; then
    outout "${PIP_COMMAND}\n"
  else
    outout "${DEFAULT_PIP_COMMAND}\n"
  fi
}

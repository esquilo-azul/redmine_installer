export DEFAULT_PIP_COMMAND='pip'

function python_assert_installed() {
  INSTALL=()
  for PKG in $@; do
    if ! python_installed "$PKG" ; then
      INSTALL+=("$PKG")
    fi
  done

  if [ ${#INSTALL[@]} -gt 0 ]; then
    infom "Será necessário instalar os seguintes pacotes Python: $INSTALL"
    sudo "$(python_pip_command)" install "${INSTALL[@]}"
  fi
}
export -f python_assert_installed

function python_installed() {
  for PKG in $@; do
    RESULT="$("$(python_pip_command)" list | cut -d ' ' -f1 | grep "$PKG")"
    if [ "$RESULT" != "$PKG" ] ; then
      return 1
    fi
  done
}
export -f python_installed

function python_pip_command() {
  if var_present_r 'PIP_COMMAND'; then
    outout "${PIP_COMMAND}\n"
  else
    outout "${DEFAULT_PIP_COMMAND}\n"
  fi
}

function python_assert_installed() {
  INSTALL=()
  for PKG in $@; do
    if ! python_installed "$PKG" ; then
      INSTALL+=("$PKG")
    fi
  done

  if [ ${#INSTALL[@]} -gt 0 ]; then
    infom "Será necessário instalar os seguintes pacotes Python: $INSTALL"
    sudo pip install "${INSTALL[@]}"
  fi
}
export -f python_assert_installed

function python_installed() {
  for PKG in $@; do
    RESULT="$(pip list | cut -d ' ' -f1 | grep "$PKG")"
    if [ "$RESULT" != "$PKG" ] ; then
      return 1
    fi
  done
}
export -f python_installed

set -u
set -e

function deb_assert_installed() {
  INSTALL=()
  for PKG in $@; do
    if ! deb_installed "$PKG" ; then
      INSTALL+=("$PKG")
    fi
  done

  if [ ${#INSTALL[@]} -gt 0 ]; then
    infom "Será necessário instalar os seguintes pacotes debian: $INSTALL"
    sudo DEBIAN_FRONTEND=noninteractive apt-get -y install "${INSTALL[@]}"
  fi
}
export -f deb_assert_installed

function deb_installed() {
  for PKG in $@; do
    RESULT=`dpkg-query -W '-f=${Status}' "$PKG"`
    if [ "$RESULT" != 'install ok installed' ] ; then
      return 1
    fi
  done
}
export -f deb_installed

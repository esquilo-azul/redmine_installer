set -u
set -e

function dpkg_file_installed() {
  for DEB_FILE in $@; do
    PACKAGE_NAME="$(dpkg --field "$DEB_FILE" Package)"
    if ! deb_installed "$PACKAGE_NAME"; then
      return 1
    fi
  done
}
export -f dpkg_file_installed

function dpkg_installed() {
  for PKG in $@; do
    RESULT=`dpkg-query -W '-f=${Status}' "$PKG"`
    if [ "$RESULT" != 'install ok installed' ] ; then
      return 1
    fi
  done
}
export -f dpkg_installed

#!/bin/bash

set -u
set -e

INSTALL=()
for PKG in $@; do
  set +e
  RESULT="$(dpkg-query -W '-f=${Status}' "$PKG")"
  set -e
  if [ "$RESULT" != 'install ok installed' ] ; then
    >&2 echo "Package \"$PKG\" is not installed"
    INSTALL+=("$PKG")
  fi
done

if [ ${#INSTALL[@]} -gt 0 ]; then
  >&2 echo "Será necessário instalar os seguintes pacotes debian: $INSTALL"
  sudo apt-get -y install "${INSTALL[@]}"
fi

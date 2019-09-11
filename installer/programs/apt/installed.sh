#!/bin/bash

set -u
set -e

for PKG in $@; do
  RESULT=`dpkg-query -W '-f=${Status}' "$PKG"`
  if [ "$RESULT" != 'install ok installed' ] ; then
    exit 1
  fi
done

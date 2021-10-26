#!/bin/bash

set -u
set -e

NAME="$1"
VERSION=''

if [ $# -ge 2 ]; then
  VERSION="$2"
fi

INSTALL_ARGS=("$NAME")
if [ -n "$VERSION" ]; then
  INSTALL_ARGS+=("-v=${VERSION}")
fi

gem install -V --conservative "${INSTALL_ARGS[@]}"

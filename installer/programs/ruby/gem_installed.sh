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

TEST1=$(gem list --local | grep -i "^${NAME}\s")
if [ -z "$TEST1" ]; then
  exit 1
fi

if [ -n "$VERSION" ]; then
  TEST2=$(echo "$TEST1" | grep "[^\d]${VERSION}[^\d]" )
  if [ -z "$TEST2" ]; then
    exit 1
  fi
fi

exit 0

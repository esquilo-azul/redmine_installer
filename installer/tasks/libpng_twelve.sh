#!/bin/bash

set -u
set -e

function task_condition {
  return $(programeiro /apt/installed libpng12-0)
}

function task_dependencies {
  printf 'curl'
}

function task_fix {
  PACKAGE="$(mktemp -d)/libpng12.deb"
  curl -Lo "$PACKAGE" http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb
  sudo dpkg -i "$PACKAGE"
  rm "$PACKAGE"
}

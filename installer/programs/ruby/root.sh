#!/bin/bash

RESULT="$(asdf_root)/installs/ruby/${ruby_version}"

if [ $# -ge 1 ]; then
  path_expand "$1" "$RESULT"
else
  outout "${RESULT}\n"
fi

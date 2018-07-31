#!/bin/bash

set -u
set -h

for GEM in "$@"; do
  TEST=$(gem list --local | grep -io '^[0-9a-z\-]\+' | grep -i "^$GEM\$")
  if [ -z "$TEST" ]; then
    exit 1
  fi
done

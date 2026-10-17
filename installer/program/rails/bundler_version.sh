#!/bin/bash

set -u
set -e

GEMFILE_LOCK="${REDMINE_ROOT}/Gemfile.lock"
TERM='BUNDLED WITH'

grep -A 1 "$TERM" "$GEMFILE_LOCK" | grep -v "$TERM" | grep -o '\S\+'

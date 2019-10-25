#!/bin/bash

set -u
set -e

source "$INSTALL_ROOT/programs/rvm/source.sh"
(cd "$REDMINE_ROOT"; bin/bundle "$@")

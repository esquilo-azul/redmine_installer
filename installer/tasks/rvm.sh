#!/bin/bash

set -u
set -e

source "$INSTALL_ROOT/lib/rvm/source.sh"

function task_condition {
  [ -f ~/.rvm/bin/rvm ]
}

function task_fix {
  programeiro /apt/assert_installed curl
  \curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles
}

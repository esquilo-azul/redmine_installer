#!/bin/bash

set -u
set -e

source "$INSTALL_ROOT/lib/rvm/source.sh"

function task_dependencies {
  echo rvm
}

function task_condition {
  [ -f ~/.rvm/rubies/$rvm_ruby/bin/ruby ]
}

function task_fix {
  set +u
  set +e
  rvm install $rvm_ruby
}

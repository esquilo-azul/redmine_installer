#!/bin/bash

set -u
set -e

GEMS=(bundler)

function task_dependencies {
  echo ruby
}

function task_condition {
  programeiro /ruby/gem_installed "${GEMS[@]}"
}

function task_fix {
  gem install -V --conservative "${GEMS[@]}"
}

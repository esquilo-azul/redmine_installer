#!/bin/bash

set -u
set -e

GEMS=(bundler "$(programeiro /rails/bundler_version)")

function task_dependencies {
  echo ruby
}

function task_condition {
  programeiro /ruby/gem_installed "${GEMS[@]}"
}

function task_fix {
  programeiro /ruby/gem_install "${GEMS[@]}"
}

#!/bin/bash

set -u
set -e

GEMS=("bundler:$(programeiro /rails/bundler_version)")

function task_dependencies {
  echo ruby
}

function task_condition {
  package_installed ruby "${GEMS[@]}"
}

function task_fix {
  package_assert ruby "${GEMS[@]}"
}

#!/bin/bash

set -u
set -e

GEM_NAME="passenger"

function task_dependencies {
  echo ruby
}

function task_condition {
  package_installed ruby "$GEM_NAME"
}

function task_fix {
  package_assert ruby "$GEM_NAME"
}

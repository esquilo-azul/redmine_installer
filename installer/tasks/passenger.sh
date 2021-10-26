#!/bin/bash

set -u
set -e

GEM_NAME="passenger"

function task_dependencies {
  echo ruby
}

function task_condition {
  programeiro /ruby/gem_installed "$GEM_NAME"
}

function task_fix {
  programeiro /ruby/gem_install "$GEM_NAME"
}

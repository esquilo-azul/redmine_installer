#!/bin/bash

set -u
set -e

function task_dependencies {
  printf 'asdf'
}

function task_condition {
  [ "$(asdf_version_global nodejs)" == "$nodejs_version" ]
}

function task_fix {
  asdf_version_assert_global nodejs "$nodejs_version"
}

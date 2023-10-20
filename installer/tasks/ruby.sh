#!/bin/bash

set -u
set -e

function task_dependencies {
  printf 'asdf_profile'
}

function task_condition {
  [ "$(asdf_version_global ruby)" == "$ruby_version" ]
}

function task_fix {
  package_assert apt bzip2 curl gcc make zlib1g-dev
  asdf_version_assert_global ruby "$ruby_version"
}

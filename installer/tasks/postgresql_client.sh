#!/bin/bash

set -u
set -e

export PACKAGES=('postgresql-client')

function task_dependencies {
  echo postgresql_client
}

function task_condition {
  return $(programeiro /apt/installed "${PACKAGES[@]}")
}

function task_fix {
  package_assert apt "${PACKAGES[@]}"
}

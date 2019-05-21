#!/bin/bash

set -u
set -e

export POSTGRESQL_PACKAGE="postgresql-${postgresql_version}"

function task_condition {
  return $(programeiro /apt/installed "$POSTGRESQL_PACKAGE")
}

function task_fix {
  programeiro /apt/assert_installed "$POSTGRESQL_PACKAGE"
}

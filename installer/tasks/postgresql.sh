#!/bin/bash

set -u
set -e

export POSTGRESQL_PACKAGE="postgresql-${postgresql_version}"

function task_condition {
  if bool_r "$SKIP_DATABASE"; then return 0; fi
  if ! bool_r "$postgresql_internal"; then return 0; fi

  return $(programeiro /apt/installed "$POSTGRESQL_PACKAGE")
}

function task_fix {
  programeiro /apt/assert_installed "$POSTGRESQL_PACKAGE"
}

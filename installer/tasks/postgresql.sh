#!/bin/bash

set -u
set -e

function task_condition {
  if bool_r "$SKIP_DATABASE"; then return 0; fi
  if ! bool_r "$postgresql_internal"; then return 0; fi

  package_installed apt "$POSTGRESQL_PACKAGE"
}

function task_fix {
  package_assert apt "$POSTGRESQL_PACKAGE"
}

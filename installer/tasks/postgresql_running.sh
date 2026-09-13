#!/bin/bash

set -u
set -e

PACKAGE_ARGS=('systemctl' 'postgresql')

function task_condition {
  if bool_r "$SKIP_DATABASE"; then return 0; fi
  if ! bool_r "$postgresql_internal"; then return 0; fi

  SUDO=t package_installed "${PACKAGE_ARGS[@]}"
}

function task_dependencies {
  echo postgresql_cluster
}

function task_fix {
  SUDO=t package_assert "${PACKAGE_ARGS[@]}"
}

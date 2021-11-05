#!/bin/bash

set -u
set -e

function task_condition {
  if ! bool_r "$postgresql_internal"; then return 0; fi

  pg_lsclusters | grep "/var/lib/postgresql/${postgresql_version}/main"
}

function task_dependencies {
  echo postgresql
}

function task_fix {
  sudo pg_createcluster "${postgresql_version}" main --start
}

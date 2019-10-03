#!/bin/bash

set -u
set -e

function task_condition {
  if [ ! -f "/etc/postgresql/${postgresql_version}/main/postgresql.conf" ]; then
    return 1
  fi
}

function task_dependencies {
  echo postgresql
}

function task_fix {
  sudo pg_createcluster "${postgresql_version}" main --start
}

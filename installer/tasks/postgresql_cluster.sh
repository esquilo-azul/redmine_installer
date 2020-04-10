#!/bin/bash

set -u
set -e

function task_condition {
  pg_lsclusters | grep "/var/lib/postgresql/${postgresql_version}/main"
}

function task_dependencies {
  echo postgresql
}

function task_fix {
  sudo pg_createcluster "${postgresql_version}" main --start
}

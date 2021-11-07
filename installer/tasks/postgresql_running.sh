#!/bin/bash

set -u
set -e

function task_condition {
  if bool_r "$SKIP_DATABASE"; then return 0; fi
  if ! bool_r "$postgresql_internal"; then return 0; fi

  programeiro /linux/service_running postgresql
}

function task_dependencies {
  echo postgresql_cluster
}

function task_fix {
  sudo service postgresql start
}

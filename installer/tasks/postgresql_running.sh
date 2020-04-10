#!/bin/bash

set -u
set -e

function task_condition {
  programeiro /linux/service_running postgresql
}

function task_dependencies {
  echo postgresql_cluster
}

function task_fix {
  sudo service postgresql start
}

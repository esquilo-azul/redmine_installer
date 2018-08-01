#!/bin/bash

set -u
set -e

function task_condition {
  return 0
}

function task_dependencies {
  echo development passenger_apache_configuration
}

#!/bin/bash

set -u
set -e

function task_condition {
  return 0
}

function task_dependencies {
  echo libpng_twelve redmine_database_schema redmine_database_test
}

#!/bin/bash

set -u
set -e

function task_condition {
  programeiro /postgresql/test_connection template1
}

function task_dependencies {
  echo postgresql_client postgresql_running
}

function task_fix {
  sudo -u postgres psql -c "CREATE ROLE $postgresql_user LOGIN ENCRYPTED PASSWORD '$postgresql_password' NOINHERIT VALID UNTIL 'infinity';" > /dev/null
}

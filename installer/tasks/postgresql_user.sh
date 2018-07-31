#!/bin/bash

set -u
set -e

function task_condition {
  PGPASSWORD="$postgresql_password" psql -h 'localhost' -U "$postgresql_user" -c 'select 1' template1 > /dev/null 2> /dev/null
}

function task_dependencies {
  echo postgresql_running
}

function task_fix {
  sudo -u postgres psql -c "CREATE ROLE $postgresql_user LOGIN ENCRYPTED PASSWORD '$postgresql_password' NOINHERIT VALID UNTIL 'infinity';" > /dev/null
}

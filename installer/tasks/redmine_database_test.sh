#!/bin/bash

set -u
set -e

function task_condition {
  if bool_r "$SKIP_DATABASE"; then return 0; fi

  programeiro /postgresql/test_connection "$postgresql_database_test"
}

function task_dependencies {
  echo postgresql_user_superuser redmine_bundle
}

function task_fix {
  programeiro /rails/database_create test
}

#!/bin/bash

set -u
set -e

function task_condition {
  programeiro /postgresql/test_connection "$postgresql_database"
}

function task_dependencies {
  echo postgresql_user_superuser redmine_bundle
}

function task_fix {
  programeiro /rails/database_create development
}

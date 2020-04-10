#!/bin/bash

set -u
set -e

function task_condition {
  programeiro /redmine/migration_status
}

function task_dependencies {
  echo redmine_bundle redmine_database_configuration redmine_secret_key_base redmine_database
}

function task_fix {
  programeiro /rails/rake redmine:migrate
}

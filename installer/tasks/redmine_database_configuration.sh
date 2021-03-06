#!/bin/bash

set -u
set -e

set -u
set -e

TEMPLATE_ARGS=("$INSTALL_ROOT/template/redmine_database_configuration.yml"
  "$REDMINE_ROOT/config/database.yml")

if [ ! -v 'REDMINE_DATABASE_CONFIGURATION_EXTRA' ]; then
  export REDMINE_DATABASE_CONFIGURATION_EXTRA=''
fi

function task_condition {
  programeiro /template/diff "${TEMPLATE_ARGS[@]}"
}

function task_fix {
  programeiro /template/apply "${TEMPLATE_ARGS[@]}"
  programeiro /redmine/installer/triggers/set 'apache_restart'
}

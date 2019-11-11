#!/bin/bash

set -u
set -e

TEMPLATE_ARGS=("$INSTALL_ROOT/template/redmine_configuration.yml"
  "$REDMINE_ROOT/config/configuration.yml")

if [ ! -v 'REDMINE_CONFIGURATION_EXTRA' ]; then
  export REDMINE_CONFIGURATION_EXTRA=''
fi

function task_condition {
  programeiro /template/diff "${TEMPLATE_ARGS[@]}"
}

function task_fix {
  programeiro /template/apply "${TEMPLATE_ARGS[@]}"
  programeiro /redmine/installer/triggers/set 'apache_restart'
}

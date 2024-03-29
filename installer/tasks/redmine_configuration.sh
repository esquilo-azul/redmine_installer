#!/bin/bash

set -u
set -e

TEMPLATE_ARGS=(- "$REDMINE_ROOT/config/configuration.yml")

if [ ! -v 'REDMINE_CONFIGURATION_EXTRA' ]; then
  export REDMINE_CONFIGURATION_EXTRA=''
fi

function task_condition {
  programeiro /redmine/configuration | template_diff "${TEMPLATE_ARGS[@]}" -
}

function task_fix {
  programeiro /redmine/configuration | template_apply "${TEMPLATE_ARGS[@]}"
  programeiro /redmine/installer/triggers/set 'restart_application'
}

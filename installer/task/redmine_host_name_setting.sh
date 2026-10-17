#!/bin/bash

set -u
set -e

function host_name_setting_template {
  echo "${address_authority}${address_path}"
}
export -f host_name_setting_template

function host_name_setting_current {
  programeiro /redmine/setting/read 'host_name'
}
export -f host_name_setting_current

function task_dependencies {
  echo redmine_database_schema
}

function task_condition {
  if bool_r "$SKIP_DATABASE"; then return 0; fi

  return $(programeiro /text/diff_commands 'host_name_setting_template' 'host_name_setting_current')
}

function task_fix {
  set -u
  set -e
  programeiro /redmine/setting/write 'host_name' "$(host_name_setting_template)"
}

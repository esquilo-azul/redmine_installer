#!/bin/bash

set -u
set -e

function host_name_setting_template {
  echo "${address_authority}${address_path}"
}
export -f host_name_setting_template

function host_name_setting_current {
  programeiro /redmine/get_setting_value 'host_name'
}
export -f host_name_setting_current

function task_dependencies {
  echo redmine_database_schema
}

function task_condition {
  return $(programeiro /text/diff_commands 'host_name_setting_template' 'host_name_setting_current')
}

function task_fix {
  set -u
  set -e
  programeiro /redmine/set_setting_value 'host_name' "$(host_name_setting_template)"
}

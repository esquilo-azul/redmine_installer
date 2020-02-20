#!/bin/bash

set -u
set -e

SETTING_NAME='mail_from'

function task_dependencies {
  echo redmine_database_schema
}

function task_condition {
  [ "$(programeiro /redmine/get_setting_value "$SETTING_NAME")" == "$mail_from" ]
}

function task_fix {
  set -u
  set -e
  programeiro /redmine/set_setting_value "$SETTING_NAME" "$mail_from"
}

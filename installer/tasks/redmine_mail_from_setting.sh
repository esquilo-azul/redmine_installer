#!/bin/bash

set -u
set -e

SETTING_NAME='mail_from'

function task_dependencies {
  echo redmine_database_schema
}

function task_condition {
  if bool_r "$SKIP_DATABASE"; then return 0; fi

  [ "$(programeiro /redmine/setting/read "$SETTING_NAME")" == "$mail_from" ]
}

function task_fix {
  set -u
  set -e
  programeiro /redmine/setting/write "$SETTING_NAME" "$mail_from"
}

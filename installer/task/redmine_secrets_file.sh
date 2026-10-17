#!/bin/bash

set -u
set -e

TARGET="$REDMINE_ROOT/config/credentials.yml.enc"

function task_condition {
  [[ -f "$TARGET" ]]
}

function task_fix {
  programeiro /rails/rails credentials:edit
}

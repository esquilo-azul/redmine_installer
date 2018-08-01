#!/bin/bash

set -u
set -e

TEMPLATE="$INSTALL_ROOT/template/redmine_secrets.yml"
TARGET="$REDMINE_ROOT/config/secrets.yml"

function task_condition {
  [ -f "$TARGET" ]
}

function task_fix {
  export secret_key_base=$(programeiro /rails/generate_secret_key)
  programeiro /template/apply "$TEMPLATE" "$TARGET"
}

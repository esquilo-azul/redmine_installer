#!/bin/bash

set -u
set -e

TEMPLATE="$INSTALL_ROOT/template/redmine_secrets.yml"
TARGET="$REDMINE_ROOT/config/secrets.yml"

function task_dependencies {
  echo redmine_secrets_key
}

function task_condition {
  export secret_key_base="$(cat "$SECRET_KEY_PATH")"
  if [ -z "$secret_key_base" ]; then
    return 1
  fi

  programeiro /template/diff "$TEMPLATE" "$TARGET"
}

function task_fix {
  export secret_key_base="$(cat "$SECRET_KEY_PATH")"
  if [ -n "$secret_key_base" ]; then
    programeiro /template/apply "$TEMPLATE" "$TARGET"
  fi
}

#!/bin/bash

set -u
set -e

function task_dependencies {
  echo redmine_bundle
}

function task_condition {
  [ -f "$SECRET_KEY_PATH" ] && [ -n "$(cat "$SECRET_KEY_PATH")" ]
}

function task_fix {
  programeiro /rails/generate_secret_key > "$SECRET_KEY_PATH"
}

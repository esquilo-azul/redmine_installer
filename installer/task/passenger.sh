#!/bin/bash

set -u
set -e

GEM_NAME="passenger"

function task_dependencies {
  echo ruby
}

function task_condition {
  package_installed ruby "$GEM_NAME"
}

function task_fix {
  local TEMP_DIR="$(mktemp -d)"
  local TEMP_GEMFILE="${TEMP_DIR}/Gemfile"
  cp "${INSTALL_ROOT}/template/passenger_gemfile" "$TEMP_GEMFILE"
  BUNDLE_GEMFILE="$TEMP_GEMFILE" bundle install
}

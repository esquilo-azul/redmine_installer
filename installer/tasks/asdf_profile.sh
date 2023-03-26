#!/bin/bash

set -u
set -e

TEMPLATE="${INSTALL_ROOT}/template/asdf_profile.sh"

function task_dependencies {
  echo asdf
}

function task_condition {
  template_diff "$TEMPLATE" "$ASDF_PROFILE_PATH"
}

function task_fix {
  template_apply "$TEMPLATE" - | sudo tee "$ASDF_PROFILE_PATH" > /dev/null
}

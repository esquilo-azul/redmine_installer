#!/bin/bash

set -u
set -e

export NODEJS_PACKAGE="nodejs"

function task_condition {
  return $(programeiro /apt/installed "$NODEJS_PACKAGE")
}

function task_fix {
  programeiro /apt/assert_installed "$NODEJS_PACKAGE"
}

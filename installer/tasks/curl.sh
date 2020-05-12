#!/bin/bash

set -u
set -e

export CURL_PACKAGE='curl'

function task_condition {
  return $(programeiro /apt/installed "$CURL_PACKAGE")
}

function task_fix {
  programeiro /apt/assert_installed "$CURL_PACKAGE"
}

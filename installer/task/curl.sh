#!/bin/bash

set -u
set -e

export CURL_PACKAGE='curl'

function task_condition {
  package_installed apt "$CURL_PACKAGE"
}

function task_fix {
  package_assert apt "$CURL_PACKAGE"
}

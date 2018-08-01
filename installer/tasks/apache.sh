#!/bin/bash

set -u
set -e

APT_PACKAGES=(apache2)

function task_condition {
  programeiro /apt/installed "${APT_PACKAGES[@]}"
}

function task_fix {
  programeiro /apt/assert_installed "${APT_PACKAGES[@]}"
}

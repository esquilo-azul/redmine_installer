#!/bin/bash

set -u
set -e

APT_PACKAGES=(apache2)

function task_condition {
  programeiro /apt/installed "${APT_PACKAGES[@]}"
}

function task_fix {
  package_assert apt "${APT_PACKAGES[@]}"
}

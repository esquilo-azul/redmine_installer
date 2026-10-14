#!/bin/bash

set -u
set -e

function task_condition {
  [ -f "$(asdf_root)/asdf.sh" ]
}

function task_fix {
  package_assert apt git
  sudo install -d -o "$(id -un)" -g "$(id -gn)" -m 755 "$(asdf_root)"
  git clone https://github.com/asdf-vm/asdf.git "$(asdf_root)" --branch "v$(asdf_version)"
}

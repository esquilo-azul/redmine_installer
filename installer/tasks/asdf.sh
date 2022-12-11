#!/bin/bash

set -u
set -e

function task_condition {
  [ -d "$(asdf_root)" ]
}

function task_fix {
  package_assert apt git
  git clone https://github.com/asdf-vm/asdf.git "$(asdf_root)" --branch "v$(asdf_version)"
}

#!/bin/bash

set -u
set -e

function task_condition {
  return $(programeiro /apt/installed postgresql)
}

function task_fix {
  programeiro /apt/assert_installed postgresql
}

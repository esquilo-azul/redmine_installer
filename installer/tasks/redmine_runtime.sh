#!/bin/bash

set -u
set -e

function task_dependencies {
  echo redmine_bundle nodejs
}

function task_condition {
  return 0
}

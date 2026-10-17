#!/bin/bash

source "${BASH_TO_REQUIRE}"

if [[ $# -lt 1 ]]; then
  fatal_error "$0" '<TASK>'
fi

taskeiro_task_dependencies "$1"

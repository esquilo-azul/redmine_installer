#!/bin/bash

source "${BASH_TO_REQUIRE}"

function selected_tasks() {
  local PATTERN="$1"
  if [[ -n "$PATTERN" ]]; then
    taskeiro_find_tasks "$PATTERN"
  else
    taskeiro_all_tasks
  fi
}

var_set_by PATTERN cli_arg 1 '' "$@"
selected_tasks "$PATTERN" | sort | uniq

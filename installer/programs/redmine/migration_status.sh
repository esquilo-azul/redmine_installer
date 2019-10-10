#!/bin/bash

set -e
set -u

function migration_status() {
  local content="$(programeiro /rails/rake "$1" 2> /dev/null)"
  set +e
  echo "$content" | grep '^\s*down\s' > /dev/null 2> /dev/null
  down=$?
  echo "$content" | grep '^\s*up\s' > /dev/null 2> /dev/null
  up=$?
  set -e
  if [ -z "$content" ]; then
    echo 0
  elif [ "$down" -eq 0 -o "$up" -ne 0 ]; then
    echo 1
  else
    echo 0
  fi
}

if [ "$(migration_status 'db:migrate:status')" != '0' ]; then
  exit 1
fi
if [ "$(migration_status 'redmine:plugins:migrate:status')" != '0' ]; then
  exit 1
fi
exit 0
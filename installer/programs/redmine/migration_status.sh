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
    return 1
  elif [ "$down" -eq 0 -o "$up" -ne 0 ]; then
    return 1
  else
    return 0
  fi
}

function any_plugins_migrations_status() {
  ls "$REDMINE_ROOT/plugins/"*/db/migrate/*.rb > /dev/null 2>&1
}

if ! migration_status 'db:migrate:status'; then
  exit 1
fi
if any_plugins_migrations_status && ! migration_status 'redmine:plugins:migrate:status'; then
  exit 1
fi
exit 0

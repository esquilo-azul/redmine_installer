#!/bin/bash

set +e

function migration_status {
  programeiro /rails/rake db:migrate:status 2> /dev/null
}

migration_status | grep '^\s*down\s' > /dev/null 2> /dev/null
down=$?
migration_status | grep '^\s*up\s' > /dev/null 2> /dev/null
up=$?
if [ "$down" -eq 0 -o "$up" -ne 0 ]; then
  exit 1
else
  exit 0
fi

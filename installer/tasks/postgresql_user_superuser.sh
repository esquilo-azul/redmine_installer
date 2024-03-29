#!/bin/bash

set -u
set -e

function task_condition {
  if bool_r "$SKIP_DATABASE"; then return 0; fi
  if ! bool_r "$postgresql_internal"; then return 0; fi

  value=$(PGPASSWORD="$postgresql_password" psql -h 'localhost' -U "$postgresql_user" -c "select usesuper from pg_user where usename='$postgresql_user'" -q -t template1 | tr -d '[[:space:]]')
  if [ "$value" == 't' ]; then
    return 0
  else
    return 1
  fi
}

function task_dependencies {
  echo postgresql_user
}

function task_fix {
  sudo -u postgres psql -c "ALTER ROLE \"$postgresql_user\" WITH SUPERUSER;"  > /dev/null
}

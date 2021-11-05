#!/bin/bash

set -u
set -e

SQL="$1"
DATABASE="$(cli_arg 2 "$postgresql_database" "$@")"

PGPASSWORD="$postgresql_password" psql \
  --host "$postgresql_host" \
  --username "$postgresql_user" \
  --tuples-only \
  --no-align \
  --command "$SQL" \
  "$DATABASE"

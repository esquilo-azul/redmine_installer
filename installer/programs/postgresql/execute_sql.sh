#!/bin/bash

set -u
set -e

SQL="$1"

PGPASSWORD="$postgresql_password" psql \
  --host 'localhost' \
  --username "$postgresql_user" \
  --tuples-only \
  --no-align \
  --command "$SQL" \
  "$postgresql_database"

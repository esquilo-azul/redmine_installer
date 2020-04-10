#!/bin/bash

set -u
set -e

PGPASSWORD="$postgresql_password" psql -h 'localhost' -U "$postgresql_user" -tAc "$1" \
  "$postgresql_database"

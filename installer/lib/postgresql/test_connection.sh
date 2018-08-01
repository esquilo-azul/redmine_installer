#!/bin/bash

set -u
set -e

PGPASSWORD="$postgresql_password" psql -h 'localhost' -U "$postgresql_user" \
  -c 'select 1' "$1" > /dev/null 2> /dev/null

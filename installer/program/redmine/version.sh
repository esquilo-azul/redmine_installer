#!/bin/bash

set -u
set -e

VERSION_FILE="${REDMINE_ROOT}/lib/redmine/version.rb"

function version_part_value() {
  grep -o "${1}"'\s*=\s*[0-9]\+' "$VERSION_FILE" | grep -o '[0-9]\+'
}

PARTS=(MAJOR MINOR TINY)
FIRST=0

for PART in "${PARTS[@]}" ; do
  VALUE="$(version_part_value "$PART")"
  if [ -z "$VALUE" ]; then
    >&2 "Version value not found for part \"$PART\" in file \"$VERSION_FILE\""
  fi
  if [[ $FIRST -eq 0 ]]; then
    FIRST=1
  else
    printf '%s' '.'
  fi
  printf '%s' "$VALUE"
done

printf "\n"

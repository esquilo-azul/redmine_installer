#!/bin/bash

set -u
set -e

function triggers() {
  find "$(programeiro /redmine/installer/triggers/path)" -maxdepth 1 -mindepth 1 -type f \
    -exec basename '{}' \;
}

function trigger_run() {
  TRIGGER="$1"
  PROGRAM="/redmine/installer/triggers/list/$TRIGGER"
  >&2 printf "Running trigger \"$TRIGGER\"..."
  programeiro "$PROGRAM"
  rm -f "$(programeiro /redmine/installer/triggers/path)/$TRIGGER"
}

triggers | while read TRIGGER; do
  trigger_run "$TRIGGER"
done

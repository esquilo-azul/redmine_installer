#!/bin/bash

set -u
set -e

(cd "$REDMINE_ROOT"; bin/bundle "$@")

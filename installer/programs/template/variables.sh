#!/bin/bash

set -u
set -e

PATTERN='[a-zA-Z][a-zA-Z0-9_]*'
grep '${'$PATTERN'}' $1 -o | grep "$PATTERN" -o

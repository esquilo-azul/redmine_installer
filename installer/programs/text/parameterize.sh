#!/bin/sh

set -u
set -e

echo "$1" | sed 's/[^a-z0-9A-Z_-]\+/-/g' | sed 's/^[-_]\+//g' | sed 's/[-_]\+$//g'

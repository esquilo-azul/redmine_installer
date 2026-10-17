#!/bin/bash

set -e
set -u

IFS='&'
for p in ${postgresql_extra_settings}; do
  IFS='='
  printf -- '  %s: %s\n' ${p}
done

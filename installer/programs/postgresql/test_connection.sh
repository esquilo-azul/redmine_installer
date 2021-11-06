#!/bin/bash

set -u
set -e

programeiro /postgresql/execute_sql 'select 1' "$1" > /dev/null 2> /dev/null

#!/bin/bash

set -u
set -e

programeiro /postgresql/execute_sql "select value from settings where name='$1'"

#!/bin/bash

set -e
set -u

apt-cache show "$POSTGRESQL_DEFAULT_PACKAGE" | grep 'Version: ' | grep -o '[0-9]\+' | head -n 1

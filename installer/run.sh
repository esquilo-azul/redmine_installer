#!/bin/bash

set -u
set -e

export INSTALL_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export PLUGIN_ROOT=$(dirname "$INSTALL_ROOT")

function programeiro {
  PPATH="$INSTALL_ROOT/lib" "$PLUGIN_ROOT/vendor/programeiro/run.sh" "$@"
}
export -f programeiro

"$PLUGIN_ROOT/vendor/taskeiro/taskeiro" --path "$INSTALL_ROOT/tasks" "$@"

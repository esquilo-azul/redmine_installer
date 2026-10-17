#!/bin/bash

set -u
set -e

LINK="${apache_document_root}${address_path}"

function task_dependencies {
  echo apache
}

function task_condition {
  # Link não existe
  if [ ! -e "$LINK" ]; then
    return 1
  fi

  # Link aponta para local incorreto
  PUBLIC_DIR="$REDMINE_ROOT/public/"
  if [ -e "$LINK" -a $(readlink "$LINK") != "$PUBLIC_DIR" ]; then
    return 1
  fi
}

function task_fix {
  PUBLIC_DIR="$REDMINE_ROOT/public/"
  sudo rm -f "$LINK"
  sudo ln -s "$PUBLIC_DIR" "$LINK"
}

#!/bin/bash

set -u
set -e

TEMPLATE="$INSTALL_ROOT/template/redmine_as_apache_path.conf"
AVAILABLE_PATH="/etc/apache2/conf-available/${instance_id}.conf"
ENABLED_PATH="/etc/apache2/conf-enabled/${instance_id}.conf"

function task_dependencies {
  echo redmine_as_apache_base redmine_apache_document_root_link
}

function task_condition {
  if [ ! -f "$AVAILABLE_PATH" ]; then
    return 1
  fi
  if [ ! -f "$ENABLED_PATH" ]; then
    return 1
  fi
  return $(programeiro /template/diff "$TEMPLATE" "$AVAILABLE_PATH" )
}

function task_fix {
  programeiro /template/apply "$TEMPLATE" - | sudo tee "$AVAILABLE_PATH" > /dev/null
  sudo a2enconf "${instance_id}"
  programeiro /redmine/installer/triggers/set 'apache_restart'
}

#!/bin/bash

set -u
set -e

function restart_apache() {
  >&2 printf -- "%s\n" "Restarting Apache HTTPD..."
  SERVICE_NAME='apache2'
  if service --status-all | grep "$SERVICE_NAME" ; then
    sudo service "$SERVICE_NAME" restart
  else
    printf "Service \"%s\" is not installed\n" "$SERVICE_NAME"
  fi
}

function generate_plugins_assets() {
  >&2 printf -- "%s\n" "Generating plugins assets..."
  RAILS_ENV=production programeiro /rails/rake redmine:plugins:assets
}

generate_plugins_assets
restart_apache

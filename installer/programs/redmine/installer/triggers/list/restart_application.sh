#!/bin/bash

set -u
set -e

function restart_apache() {
  infom "Restarting Apache HTTPD..."
  SERVICE_NAME='apache2'
  if service --status-all | grep "$SERVICE_NAME" ; then
    sudo service "$SERVICE_NAME" restart
  else
    infom "Service \"${$SERVICE_NAME}\" is not installed"
  fi
}

function generate_plugins_assets() {
  infom "Generating plugins assets..."
  RAILS_ENV=production programeiro /rails/rake redmine:plugins:assets
}

generate_plugins_assets
restart_apache

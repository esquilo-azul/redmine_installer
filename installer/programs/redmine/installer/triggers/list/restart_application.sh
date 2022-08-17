#!/bin/bash

set -u
set -e

function restart_apache() {
  SERVICE_NAME='apache2'
  if service --status-all | grep "$SERVICE_NAME" ; then
    sudo service "$SERVICE_NAME" restart
  else
    printf "Service \"%s\" is not installed\n" "$SERVICE_NAME"
  fi
}

restart_apache

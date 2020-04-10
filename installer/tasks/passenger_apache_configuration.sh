#!/bin/bash

set -u
set -e

function passenger_load {
  echo LoadModule passenger_module "$(programeiro /passenger/apache_library)"
}

function passenger_conf {
  echo "
  <IfModule mod_passenger.c>
       PassengerRoot $(programeiro /passenger/root)
       PassengerDefaultRuby $(programeiro /ruby/path)
  </IfModule>"
}

function task_dependencies {
  echo passenger_apache_library apache
}
export -f task_dependencies

function task_condition {
  if [ ! -f /etc/apache2/mods-available/passenger.load ]; then
    return 1
  fi
  if [ ! -f /etc/apache2/mods-available/passenger.conf ]; then
    return 1
  fi
  if [ ! -f /etc/apache2/mods-enabled/passenger.load ]; then
    return 1
  fi
  if [ ! -f /etc/apache2/mods-enabled/passenger.conf ]; then
    return 1
  fi
  if ! passenger_load | diff /dev/stdin /etc/apache2/mods-enabled/passenger.load; then
    return 1
  fi
  if ! passenger_conf | diff /dev/stdin /etc/apache2/mods-enabled/passenger.conf; then
    return 1
  fi
}

function task_fix {
  passenger_load | sudo tee /etc/apache2/mods-available/passenger.load > /dev/null
  passenger_conf | sudo tee /etc/apache2/mods-available/passenger.conf > /dev/null
  sudo a2enmod passenger
  programeiro /redmine/installer/triggers/set 'apache_restart'
}

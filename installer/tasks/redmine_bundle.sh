#!/bin/bash

set -u
set -e

function task_dependencies {
  echo bundler redmine_database_configuration redmine_configuration
}

function task_condition {
  programeiro /rails/bundle check
}

function task_fix {
  package_assert apt libmagic-dev libmagickwand-dev libxslt1-dev libpq-dev imagemagick git cmake \
    g++
  programeiro /rails/bundle install
  programeiro /redmine/installer/triggers/set 'restart_application'
}

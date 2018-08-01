#!/bin/bash

set -u
set -e

function task_dependencies {
  echo passenger
}

function task_condition {
  [ -f "$(programeiro /passenger/apache_library)" ]
}

function task_fix {
  programeiro /apt/assert_installed libcurl4-openssl-dev libssl-dev apache2-dev \
    libapr1-dev libaprutil1-dev apache2
  passenger-install-apache2-module -a
}

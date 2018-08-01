#!/bin/bash

set -u
set -e

function task_dependencies {
  echo redmine_as_apache_base redmine_apache_document_root_link
}

function task_condition {
  if [ ! -f /etc/apache2/conf-available/redmine.conf ]; then
    return 1
  fi
  if [ ! -f /etc/apache2/conf-enabled/redmine.conf ]; then
    return 1
  fi
}

function task_fix {
  programeiro /template/apply "$INSTALL_ROOT/template/redmine_as_apache_path.conf" - | \
    sudo tee /etc/apache2/conf-available/redmine.conf > /dev/null
  sudo a2enconf redmine
}

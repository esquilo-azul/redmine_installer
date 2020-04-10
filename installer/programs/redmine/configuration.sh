#!/bin/bash

set -u
set -e

if [ "$smtp_authentication" == 'none' ]; then
  export smtp_user_password_section=''
else
  export smtp_user_password_section="
      user_name: '${smtp_username}'
      password: '${smtp_password}'"
fi

if [ "$(programeiro /redmine/version 4.0.0)" == '-1' ]; then
  export async_prefix='async_'
else
  export async_prefix=''
fi

programeiro /template/apply "$INSTALL_ROOT/template/redmine_configuration.yml" -

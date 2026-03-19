#!/bin/bash

set -u
set -e

function smtp_var_name() {
  if [[ "$1" == 'user_name' ]]; then
    local VAR_SUFFIX='username'
  else
    local VAR_SUFFIX="$1"
  fi
  outout "smtp_${VAR_SUFFIX}"
}

export smtp_authentication_section=''

KEYS=(authentication user_name password)
for KEY in "${KEYS[@]}"; do
  VAR_NAME="$(smtp_var_name "${KEY}")"
  VAR_VALUE="${!VAR_NAME}"
  if [[ -n "${VAR_VALUE}" ]]; then
    export smtp_authentication_section="${smtp_authentication_section}
      ${KEY}: '${VAR_VALUE}'"
  fi
done

if [ "$(programeiro /redmine/version 4.0.0)" == '-1' ]; then
  export async_prefix='async_'
else
  export async_prefix=''
fi

template_apply "$INSTALL_ROOT/template/redmine_configuration.yml" -

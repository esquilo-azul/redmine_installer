#!/bin/bash

set -u
set -e

function settingSetted {
  TEST=$(programeiro /postgresql/execute_sql "select 1 from settings where name='$1'")
  if [ -n "$TEST" -a "$TEST" == '1' ]; then
    return 0
  else
    return 1
  fi
}

function createSetting {
  programeiro /postgresql/execute_sql 'insert into settings(name,value,updated_on) values ('\'"$1"\'', '\'"$2"\'', current_timestamp)'
}

function updateSetting {
  programeiro /postgresql/execute_sql 'update settings set value='\'"$2"\'', updated_on=current_timestamp where name='\'"$1"\'
}

setting_name=$1
setting_value=$(printf '%s' "$2" | programeiro /text/escape_single_quotes)

if settingSetted "$setting_name"; then
  updateSetting "$setting_name" "$setting_value"
else
  createSetting "$setting_name" "$setting_value"
fi

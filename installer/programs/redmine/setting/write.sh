#!/bin/bash

set -u
set -e

setting_name=$1
setting_value=$(printf '%s' "$2" | programeiro /text/escape_single_quotes)
programeiro /postgresql/execute_sql "
BEGIN;
delete from settings where name='$setting_name';
insert into settings(name,value,updated_on) values ('$setting_name', '$setting_value', current_timestamp);
COMMIT;
"

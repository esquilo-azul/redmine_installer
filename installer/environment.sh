set -e
set -u

export INSTALL_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export PLUGIN_ROOT=$(dirname "$INSTALL_ROOT")
export REDMINE_ROOT=$(dirname "$(dirname "$PLUGIN_ROOT")")
export SUB_ROOT="${PLUGIN_ROOT}/sub"

for FILE in "${INSTALL_ROOT}/environment.d/"*.sh; do
  source "$FILE"
done

FILES_TO_SOURCE+=("$REDMINE_ROOT/config/install.sh")
for FILE in "$REDMINE_ROOT/config/install.d/"*.sh; do
  FILES_TO_SOURCE+=("$FILE")
done

SETUPS_PATH="$(_build_plugins_path 'setup.sh')"
IFSBAK="$IFS"
IFS=:
if ls $SETUPS_PATH 1> /dev/null 2>&1; then
  for SETUP in $SETUPS_PATH; do
    FILES_TO_SOURCE+=("$SETUP")
  done
fi
IFS="$IFSBAK"

for FILE_TO_SOURCE in "${FILES_TO_SOURCE[@]}"; do
  if [ -f "$FILE_TO_SOURCE" ]; then
    source "$FILE_TO_SOURCE"
  fi
done

export instance_id="$(programeiro /text/parameterize "$address_path")"
if [ -z "$instance_id" ]; then
  export instance_id="$(programeiro /text/parameterize "$REDMINE_ROOT")"
fi

export address_authority="$address_host"
if [ -n "$address_port" ]; then
  export address_authority="$address_authority:$address_port"
fi

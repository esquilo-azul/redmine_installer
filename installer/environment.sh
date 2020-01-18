set -e
set -u

export INSTALL_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export PLUGIN_ROOT=$(dirname "$INSTALL_ROOT")
export REDMINE_ROOT=$(dirname "$(dirname "$PLUGIN_ROOT")")

function _build_plugins_path {
  SUBDIR="$1"
  RESULT=''
  for DIR in "${REDMINE_ROOT}/plugins/"*"/installer/${SUBDIR}"; do
    if [ -n "$RESULT" ]; then
      RESULT+=':'
    fi
    RESULT+="$DIR"
  done
  printf -- "$RESULT\n"
}
export -f _build_plugins_path

SETTINGS_PATH="$(_build_plugins_path 'default_settings.sh')"
IFSBAK="$IFS"
IFS=:
for SETTINGS in $SETTINGS_PATH; do
  source "$SETTINGS"
done
IFS="$IFSBAK"
APP_SETTINGS="$REDMINE_ROOT/config/install.sh"
if [ -f "$APP_SETTINGS" ]; then
  source "$APP_SETTINGS"
fi

SETUPS_PATH="$(_build_plugins_path 'setup.sh')"
IFSBAK="$IFS"
IFS=:
for SETUP in $SETUPS_PATH; do
  source "$SETUP"
done
IFS="$IFSBAK"

function programeiro_path {
  _build_plugins_path "programs"
}
export -f programeiro_path

function programeiro {
  PPATH="$(programeiro_path)" "$PLUGIN_ROOT/vendor/programeiro/run.sh" "$@"
}
export -f programeiro

function taskeiro_path {
  _build_plugins_path "tasks"
}
export -f taskeiro_path

function taskeiro {
  "$PLUGIN_ROOT/vendor/taskeiro/taskeiro" --path "$(taskeiro_path)" "$@"
}
export -f taskeiro

export instance_id="$(programeiro /text/parameterize "$address_path")"
if [ -z "$instance_id" ]; then
  export instance_id="$(programeiro /text/parameterize "$REDMINE_ROOT")"
fi

export address_authority="$address_host"
if [ -n "$address_port" ]; then
  export address_authority="$address_authority:$address_port"
fi

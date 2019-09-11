export INSTALL_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export PLUGIN_ROOT=$(dirname "$INSTALL_ROOT")
export REDMINE_ROOT=$(dirname "$(dirname "$PLUGIN_ROOT")")

source "$INSTALL_ROOT/default-settings.sh"
APP_SETTINGS="$REDMINE_ROOT/config/install.sh"
if [ -f "$APP_SETTINGS" ]; then
  source "$APP_SETTINGS"
fi

function programeiro {
  PPATH="$INSTALL_ROOT/programs" "$PLUGIN_ROOT/vendor/programeiro/run.sh" "$@"
}
export -f programeiro

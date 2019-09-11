export INSTALL_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export PLUGIN_ROOT=$(dirname "$INSTALL_ROOT")
export REDMINE_ROOT=$(dirname "$(dirname "$PLUGIN_ROOT")")

source "$INSTALL_ROOT/default-settings.sh"
APP_SETTINGS="$REDMINE_ROOT/config/install.sh"
if [ -f "$APP_SETTINGS" ]; then
  source "$APP_SETTINGS"
fi

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

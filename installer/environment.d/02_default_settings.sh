SETTINGS_PATH="$(_build_plugins_path 'default_settings.sh')"
IFSBAK="$IFS"
IFS=:
for SETTINGS in $SETTINGS_PATH; do
  source "$SETTINGS"
done
IFS="$IFSBAK"

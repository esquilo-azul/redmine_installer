# Extra content for /config/configuration.yml
export REDMINE_CONFIGURATION_EXTRA=''

# Path to secret key
export SECRET_KEY_PATH="${REDMINE_ROOT}/config/secrets_key.txt"

if [ ! -v 'SKIP_DATABASE' ]; then
  SKIP_DATABASE='false'
fi
export SKIP_DATABASE="$(bool_s "$SKIP_DATABASE")"

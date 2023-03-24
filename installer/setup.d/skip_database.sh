if [ ! -v 'SKIP_DATABASE' ]; then
  SKIP_DATABASE='false'
fi
export SKIP_DATABASE="$(bool_s "$SKIP_DATABASE")"

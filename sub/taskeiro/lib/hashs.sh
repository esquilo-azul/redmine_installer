export HASHS_KEY_SEP='|'
export HASHS_KEY_VALUE_SEP=':'

# hash_init <HASH_VARIABLE>
hash_init() {
  export $1=''
}

# hash_add <HASH_VARIABLE> <KEY> <VALUE>
hash_put() {
  HASH="$1"
  KEY="$2"
  VALUE="$3"
  KEY_VALUE="${KEY}${HASHS_KEY_VALUE_SEP}${VALUE}"

  NEW_HASH=''
  UPDATED='no'
  local IFS=$HASHS_KEY_SEP
  for p in ${!HASH}; do
    [[ -n "$p" ]] || continue
    if [[ -n "$NEW_HASH" ]]; then NEW_HASH="${NEW_HASH}${HASHS_KEY_SEP}" ; fi
    if [[ "$p" == ${KEY}${HASHS_KEY_VALUE_SEP}* ]]; then
      NEW_HASH="${NEW_HASH}${KEY_VALUE}"
      UPDATED='yes'
    else
      NEW_HASH="${NEW_HASH}${p}"
    fi
  done
  if [[ "$UPDATED" == "no" ]]; then
    if [[ -n "$NEW_HASH" ]]; then NEW_HASH="${NEW_HASH}${HASHS_KEY_SEP}" ; fi
    NEW_HASH="${NEW_HASH}${KEY_VALUE}"
  fi
  export $HASH="$NEW_HASH"
}

# hash_get <HASH_VARIABLE> <KEY>
function hash_get() {
  HASH="$1"
  KEY="$2"

  local IFS=$HASHS_KEY_SEP
  for p in ${!HASH}; do
    [[ -n "$p" ]] || continue
    PREFIX="${KEY}${HASHS_KEY_VALUE_SEP}"
    if [[ "$p" == ${PREFIX}* ]]; then
      printf "${p#$PREFIX}"
    fi
  done
}

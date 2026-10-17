export HASH_PAIR_SEP='|'
export HASH_KV_SEP=':'

function hash_assert() {
  local HASH="$1"
  if [[ ! -v "${HASH}" ]]; then
    hash_init "${HASH}"
  fi
}
export -f hash_assert

# hash_delete <HASH> <KEY>
function hash_delete() {
  local HASH="$1"
  local KEY="$2"
  local NEW_HASH=''

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!HASH}; do
    [[ -n "$ITEM" ]] || continue
    if [[ "$ITEM" != "${KEY}${HASH_KV_SEP}"* ]]; then
      [[ -n "$NEW_HASH" ]] && NEW_HASH="${NEW_HASH}${HASH_PAIR_SEP}"
      NEW_HASH="${NEW_HASH}${ITEM}"
    fi
  done

  export "$HASH"="$NEW_HASH"
}
export -f hash_delete

# hash_each <HASH> <CALLBACK>
# Calls CALLBACK <KEY> <VALUE> for each entry
function hash_each() {
  local HASH="$1"
  local CALLBACK="$2"

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!HASH}; do
    [[ -n "$ITEM" ]] || continue
    "$CALLBACK" "${ITEM%%"$HASH_KV_SEP"*}" "${ITEM#*"$HASH_KV_SEP"}"
  done
}
export -f hash_each

# hash_get <HASH> <KEY>
# Outputs the value or returns 1 if key not found
function hash_get() {
  local HASH="$1"
  local KEY="$2"
  local PREFIX="${KEY}${HASH_KV_SEP}"

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!HASH}; do
    [[ -n "$ITEM" ]] || continue
    if [[ "$ITEM" == "${PREFIX}"* ]]; then
      printf '%s' "${ITEM#"$PREFIX"}"
      return 0
    fi
  done
  return 1
}
export -f hash_get

# hash_get <HASH> <KEY> [<DEFAULT>='']
# Outputs the value found in <HASH>[<KEY>] or <DEFAULT>.
function hash_get_or_default() {
  local HASH="$1"
  local KEY="$2"
  var_set_by DEFAULT cli_arg 3 '' "$@"

  if ! hash_get "${HASH}" "${KEY}"; then
    outout "$DEFAULT"
  fi
}
export -f hash_get_or_default

# hash_init <HASH>
function hash_init() {
  export "$1"=''
}
export -f hash_init

# hash_items <HASH>
# Outputs each "key:value" pair on its own line
function hash_items() {
  local HASH="$1"

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!HASH}; do
    [[ -n "$ITEM" ]] || continue
    outout_nl "$ITEM"
  done
}
export -f hash_items

# hash_key <HASH> <KEY>
# Returns 0 if key exists, 1 otherwise
function hash_key() {
  local HASH="$1"
  local KEY="$2"

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!HASH}; do
    [[ -n "$ITEM" ]] || continue
    [[ "$ITEM" == "${KEY}${HASH_KV_SEP}"* ]] && return 0
  done
  return 1
}
export -f hash_key

# hash_keys <HASH>
# Outputs each key on its own line
function hash_keys() {
  local HASH="$1"

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!HASH}; do
    [[ -n "$ITEM" ]] || continue
    outout_nl "${ITEM%%"$HASH_KV_SEP"*}"
  done
}
export -f hash_keys

# hash_merge <DESTINATION_HASH> <SOURCE_HASH>
# Copies all entries from SOURCE_HASH into DESTINATION_HASH; source keys override destination keys
function hash_merge() {
  local DESTINATION_HASH="$1"
  local SOURCE_HASH="$2"

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!SOURCE_HASH}; do
    [[ -n "$ITEM" ]] || continue
    hash_put "$DESTINATION_HASH" "${ITEM%%"$HASH_KV_SEP"*}" "${ITEM#*"$HASH_KV_SEP"}"
  done
}
export -f hash_merge

# hash_put <HASH> <KEY> <VALUE>
function hash_put() {
  local HASH="$1"
  local KEY="$2"
  local VALUE="$3"
  local PAIR="${KEY}${HASH_KV_SEP}${VALUE}"
  local NEW_HASH=''
  local UPDATED='no'

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!HASH}; do
    [[ -n "$ITEM" ]] || continue
    [[ -n "$NEW_HASH" ]] && NEW_HASH="${NEW_HASH}${HASH_PAIR_SEP}"
    if [[ "$ITEM" == "${KEY}${HASH_KV_SEP}"* ]]; then
      NEW_HASH="${NEW_HASH}${PAIR}"
      UPDATED='yes'
    else
      NEW_HASH="${NEW_HASH}${ITEM}"
    fi
  done

  if [[ "$UPDATED" == 'no' ]]; then
    [[ -n "$NEW_HASH" ]] && NEW_HASH="${NEW_HASH}${HASH_PAIR_SEP}"
    NEW_HASH="${NEW_HASH}${PAIR}"
  fi

  export "$HASH"="$NEW_HASH"
}
export -f hash_put

# hash_size <HASH>
# Outputs the number of entries
function hash_size() {
  local HASH="$1"
  local COUNT=0

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!HASH}; do
    [[ -n "$ITEM" ]] || continue
    COUNT=$(( COUNT + 1 ))
  done
  printf '%d' "$COUNT"
}
export -f hash_size

# hash_values <HASH>
# Outputs each value on its own line
function hash_values() {
  local HASH="$1"

  local IFS="$HASH_PAIR_SEP"
  for ITEM in ${!HASH}; do
    [[ -n "$ITEM" ]] || continue
    outout_nl "${ITEM#*"$HASH_KV_SEP"}"
  done
}
export -f hash_values

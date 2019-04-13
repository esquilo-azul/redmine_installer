function tests_init() {
  export FAIL=0
  export SUCCESS=0
}

function tests_end() {
  _infov "Success" $SUCCESS
  _infov "Failed" $FAIL
  if [ $FAIL -gt 0 ]; then
    _fatal_error 'Tests failed'
  else
    _success 'Tests passed'
  fi
}

function run_test() {
  if [ -n "$SAMPLE_TEMP_DIR" ]; then
    rm -rf "$SAMPLE_TEMP_DIR"
  fi
  export SAMPLE_TEMP_DIR=$(mktemp -d)
  events_reset
  export CURRENT_TEST="$1"
  "$1"
}

function add_test_result() {
  if [ $1 -eq 0 ]; then
    SUCCESS=$((SUCCESS+1))
  else
    FAIL=$((FAIL+1))
    >&2 printf "$CURRENT_TEST failed: $2\n"
  fi
}

function assert_equal() {
  MSG="\"$1\" == \"$2\""
  if [ "$1" == "$2" ]; then
    add_test_result 0 "$MSG"
  else
    add_test_result 1 "$MSG"
  fi
}

function assert_not_equal() {
  MSG="\"$1\" != \"$2\""
  if [ "$1" != "$2" ]; then
    add_test_result 0 "$MSG"
  else
    add_test_result 1 "$MSG"
  fi
}

function assert_message() {
  eval "$1" 2> /dev/null | grep "$2" > /dev/null
  R=$?
  assert_equal '0' "$R"
}

function assert_error_message() {
  out_file=$(mktemp)
  eval "$1" 2> "$out_file" >/dev/null
  grep "$2" "$out_file" > /dev/null
  R=$?
  add_test_result "$R" "\"$(sed 's/\n/ /g' "$out_file")\" ~= \"$2\""
}

function assert_success() {
  eval "$1" > /dev/null 2> /dev/null
  R=$?
  assert_equal '0' "$R"
}

function assert_fail() {
  eval "$1" > /dev/null 2> /dev/null
  R=$?
  assert_not_equal '0' "$R"
}

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
  "$1"
}

function assert_equal() {
  if [ "$1" == "$2" ]; then
    SUCCESS=$((SUCCESS+1))
  else
    FAIL=$((FAIL+1))
  fi
}

function assert_not_equal() {
  if [ "$1" != "$2" ]; then
    SUCCESS=$((SUCCESS+1))
  else
    FAIL=$((FAIL+1))
  fi
}

function assert_message() {
  eval "$1" 2> /dev/null | grep "$2" > /dev/null
  R=$?
  assert_equal '0' "$R"
}

function assert_error_message() {
  eval "$1" 2>&1 >/dev/null | grep "$2" > /dev/null
  R=$?
  assert_equal '0' "$R"
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

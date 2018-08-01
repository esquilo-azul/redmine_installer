#!/bin/bash

export MYROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$MYROOT/../lib/init.sh"
source "$MYROOT/test_lib.sh"
source "$MYROOT/events.sh"
export TASKEIRO=$(readlink -f "$MYROOT/../taskeiro")

tests_init

function test_help() {
  assert_message '"$TASKEIRO" -h' 'Usage'
  assert_message '"$TASKEIRO" -h' '\s-h\|--help'
  assert_message '"$TASKEIRO" -h' '\s-p|--path'
}
run_test 'test_help'

function test_no_args() {
  assert_error_message '"$TASKEIRO"' 'TASKEIRO_PATH.\+not a directory'
}
run_test 'test_no_args'

function test_no_targets() {
  assert_success '"$TASKEIRO" --path "$MYROOT/tasks"'
  assert_equal '|' "$(cat "$EVENTS_FILE")"
}
run_test 'test_no_targets'

function test_repeated_targets() {
  assert_success '"$TASKEIRO" --path "$MYROOT/tasks" task1 task1'
  assert_equal '|task1|' "$(cat "$EVENTS_FILE")"
}
run_test 'test_repeated_targets'

function test_failed_task() {
  assert_fail '"$TASKEIRO" --path "$MYROOT/tasks" task1 task2'
  assert_equal '|task1|task2|' "$(cat "$EVENTS_FILE")"
}
run_test 'test_failed_task'

function test_task_not_exists() {
  assert_fail '"$TASKEIRO" --path "$MYROOT/tasks" not_exist'
  assert_equal '|' "$(cat "$EVENTS_FILE")"
}
run_test 'test_task_not_exists'

function test_dependencies() {
  assert_success '"$TASKEIRO" --path "$MYROOT/tasks" dep1 task1'
  assert_equal '|task1|dep2|dep1|' "$(cat "$EVENTS_FILE")"
}
run_test 'test_dependencies'

tests_end

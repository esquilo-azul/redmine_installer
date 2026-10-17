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
  assert_error_message '"$TASKEIRO"' "TASKEIRO_PATH is empty"
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

function test_multiple_task_directories() {
  assert_success '"$TASKEIRO" --path "$MYROOT/tasks:$MYROOT/tasks2" dep3'
  assert_equal '|task1|dep3|' "$(cat "$EVENTS_FILE")"
}
run_test 'test_multiple_task_directories'

function test_before_run() {
  assert_success '"$TASKEIRO" --path "$MYROOT/tasks" before_run_task'
}
run_test 'test_before_run'

function test_hash() {
  hash_init 'myhash'
  assert_equal '' "$myhash"
  assert_equal '' "$(hash_get k1)"
  hash_put 'myhash' 'k1' 'v1'
  assert_equal 'k1:v1' "$myhash"
  assert_equal 'v1' "$(hash_get myhash k1)"
  hash_put 'myhash' 'k2' 'v2'
  assert_equal 'k1:v1|k2:v2' "$myhash"
  assert_equal 'v2' "$(hash_get myhash k2)"
  hash_put 'myhash' 'k1' 'v3'
  assert_equal 'k1:v3|k2:v2' "$myhash"
  assert_equal 'v3' "$(hash_get myhash k1)"
}
run_test 'test_hash'

function test_dependencies() {
  assert_success '"$TASKEIRO" --path "$MYROOT/tasks" task1'
  assert_equal '|task1|' "$(cat "$EVENTS_FILE")"

  events_reset
  assert_success '"$TASKEIRO" --path "$MYROOT/tasks:$MYROOT/tasks_with_dependencies" task1'
  assert_equal '|twd1|task1|' "$(cat "$EVENTS_FILE")"
}
run_test 'test_dependencies'

function test_multiple_dependencies() {
  assert_success '"$TASKEIRO" --path "$MYROOT/tasks" dep4'
  assert_equal '|task1|task3|dep4|' "$(cat "$EVENTS_FILE")"
}
run_test 'test_multiple_dependencies'

tests_end

export MYROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$MYROOT/../events.sh"

function task_condition() {
  [[ "$BEFORE_RUN_TEST_VAR" == 'right value' ]]
}

function task_fix() {
  printf "Do nothing\n"
}

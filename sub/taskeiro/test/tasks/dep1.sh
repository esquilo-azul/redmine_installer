export MYROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$MYROOT/../events.sh"

function task_dependencies() {
  echo 'dep2'
}

function task_condition() {
  events_contain dep1
}

function task_fix() {
  events_add dep1
}

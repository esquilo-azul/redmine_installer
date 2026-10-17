export MYROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$MYROOT/../events.sh"

function task_dependencies() {
  echo 'task1' 'task3'
}

function task_condition() {
  events_contain dep4
}

function task_fix() {
  events_add dep4
}

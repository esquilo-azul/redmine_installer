export MYROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$MYROOT/../events.sh"

function task_condition() {
  events_contain task1
}

function task_fix() {
  events_add task1
}

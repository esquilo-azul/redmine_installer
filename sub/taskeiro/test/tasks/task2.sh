export MYROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$MYROOT/../events.sh"

function task_condition() {
  return 1 # Always fails
}

function task_fix() {
  events_add task2
}

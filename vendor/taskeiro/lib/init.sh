export TASKEIRO_ROOT=$(dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))
export TASKEIRO_EXECUTER="$0"
export TASKEIRO_PATH=
export TASKEIRO_TASKS=
export TASKEIRO_DEBUG="${TASKEIRO_DEBUG:-}"
export TASKEIRO_CHECKED_TASKS='|'

source "$TASKEIRO_ROOT/lib/speaker.sh"
source "$TASKEIRO_ROOT/lib/cli.sh"
source "$TASKEIRO_ROOT/lib/manager.sh"

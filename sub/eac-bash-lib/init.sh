set -u
set -e
set -o pipefail

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
EACBASHLIB_ROOT="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

source "$EACBASHLIB_ROOT/bool.sh"
source "$EACBASHLIB_ROOT/cli.sh"
source "$EACBASHLIB_ROOT/debian.sh"
source "$EACBASHLIB_ROOT/inflector.sh"
source "$EACBASHLIB_ROOT/path.sh"
source "$EACBASHLIB_ROOT/python.sh"
source "$EACBASHLIB_ROOT/ruby.sh"
source "$EACBASHLIB_ROOT/snap.sh"
source "$EACBASHLIB_ROOT/speaker.sh"
source "$EACBASHLIB_ROOT/sudo.sh"
source "$EACBASHLIB_ROOT/template.sh"
source "$EACBASHLIB_ROOT/variables.sh"

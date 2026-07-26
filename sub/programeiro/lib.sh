SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
PROGRAMEIRO_ROOT_ROOT="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

export EACBASHLIB_NOT_FOUND_ERROR=7
export EACBASHLIB_SOURCE_URL='https://github.com/esquilo-azul/eac-bash-lib'
export PROGRAMEIRO_NOT_FOUND_ERROR=6

if [[ ! -v 'EACBASHLIB_ROOT' ]]; then
  export EACBASHLIB_ROOT="$(dirname "$PROGRAMEIRO_ROOT_ROOT")/eac-bash-lib"
fi
export EACBASHLIB_RC="${EACBASHLIB_ROOT}/init.sh"

if [[ ! -f "$EACBASHLIB_RC" ]]; then
  >&2 printf "%s\n" "\"$EACBASHLIB_RC\" not found."
  >&2 printf "%s %s\n" "You need to have a copy of ${EACBASHLIB_SOURCE_URL} in"
    "\"$EACBASHLIB_ROOT\" or in directory pointed by \$EACBASHLIB_ROOT." \
  exit $ERROR_EACBASHLIB_NOT_FOUND
fi

source "${EACBASHLIB_RC}"

for file in "${PROGRAMEIRO_ROOT_ROOT}/lib/"*.sh; do
  source "$file"
done

programeiro_paths | while read path; do
  if [ ! -d "$path" ]; then
    >&2 echo "\"$path\" in \$PROGRAMEIRO_PATH is not a directory"
    exit 2
  fi
done

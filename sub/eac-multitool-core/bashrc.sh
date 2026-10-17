SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR_BASHRC="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

source "${DIR_BASHRC}/bin/eac-multitool-core.sh"

while read -r MULTITOOL_NODE; do
  while read -r RC_FILE; do
    source "${RC_FILE}"
  done < <(find "${MULTITOOL_NODE}/bashrc.d" -type f -name '*.sh' 2> /dev/null | sort)
done < <(pathvar_to_lines 'MULTITOOL_PATH')

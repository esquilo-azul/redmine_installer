set -u
set -e

function template_apply() {
  if [ $# -lt 1 ]; then
    error "Usage:\n\ntemplate_apply <TEMPLATE_FILE> [<OUTPUT_FILE>='-']\n"
    error "\n\n<TEMPLATE_FILE> can be a file path or \"-\" (STDIN)\n"
    error "\n\n<OUTPUT_FILE> can be a file path or \"-\" (STDOUT)\n"
    return 1
  fi
  local TEMPLATE_FILE="$1"

  local OUTPUT_FILE='-'
  if [ $# -ge 2 ]; then
    OUTPUT_FILE="$2"
  fi

  out_tmp=$(mktemp)
  in_tmp=$(mktemp)

  if [ "$TEMPLATE_FILE" == '-' ]; then
    >&2 cat <&0 > "$in_tmp"
  else
    if [ ! -f "$TEMPLATE_FILE" ]; then
      error "Template file \"$TEMPLATE_FILE\" does not exist or is not a file\n"
      return 2
    fi
    >&2 cp "$TEMPLATE_FILE" "$in_tmp"
  fi
  cp "$in_tmp" "$out_tmp" >&2

  for var in $(template_variables "$TEMPLATE_FILE"); do
    if [ -z ${!var+x} ]; then
      >&2 echo "Variable \"$var\" is unset"
      return 1
    fi
    CONTENT="$(cat "$in_tmp"; printf Z)"
    CONTENT="${CONTENT%Z}"
    FROM="\%\%${var}\%\%"
    TO="${!var}"
    printf '%s' "${CONTENT/$FROM/$TO}" > "$out_tmp"
    cp "$out_tmp" "$in_tmp" >&2
  done

  if [ "$OUTPUT_FILE" == '-' ]; then
    cat "$out_tmp"
  else
    mkdir -p "$(dirname "$OUTPUT_FILE")" >&2
    cp "$out_tmp" "$OUTPUT_FILE" >&2
  fi
}
export -f template_apply

function template_diff() {
  if [ $# -lt 2 ]; then
    error "Usage:\n\template_diff <TEMPLATE_FILE> <OUTPUT_FILE>\n"
    error "\n\n<TEMPLATE_FILE> can be a file path or \"-\" (STDIN)\n"
    error "\n\n<OUTPUT_FILE> can be a file path or \"-\" (STDIN)\n"
    return 1
  fi

  local TEMPLATE_FILE="$(cli_file_path_or_stdin "$1")"
  local OUTPUT_FILE="$(cli_file_path_or_stdin "$2")"
  local INPUT_FILE="$(mktemp)"
  template_apply "$TEMPLATE_FILE" "$INPUT_FILE" <&0
  diff "$INPUT_FILE" "$OUTPUT_FILE" > /dev/null 2> /dev/null
}
export -f template_diff

function template_dir_apply() {
  SOURCE_ROOT="$1"
  if [ $# -ge 2 ]; then
    TARGET_ROOT="$2"
  else
    TARGET_ROOT=$(mktemp -d)
  fi

  for d in $(cd "$SOURCE_ROOT"; find -type d); do
    >&2 mkdir -p "$TARGET_ROOT/$d"
  done

  for f in $(cd "$SOURCE_ROOT"; find -type f); do
    template_apply "$SOURCE_ROOT/$f" > "$TARGET_ROOT/$f"
  done

  printf "$TARGET_ROOT\n"
}
export -f template_dir_apply

function template_variables() {
  if [ $# -lt 1 ]; then
    error "Usage:\n\ntemplate_variables <TEMPLATE_FILE>" \
      "\n<TEMPLATE_FILE> should be a file path."
    return 1
  fi

  FILE="$1"

  if [ ! -f "$FILE" ]; then
    error "\"$FILE\" does not exist or is not a file"
    return 2
  fi

  PATTERN='[a-zA-Z][a-zA-Z0-9_]*'
  grep '%%'$PATTERN'%%' "$FILE" -o | grep "$PATTERN" -o
}
export -f template_variables

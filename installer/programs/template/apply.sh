#!/bin/bash

set -u
set -e

if [ $# -lt 1 ]; then
  >&2 echo "Usage: $0 <TEMPLATE_FILE> [<OUTPUT_FILE>='-']"
  exit 1
fi

OUTPUT_FILE='-'
if [ $# -ge 2 ]; then
  OUTPUT_FILE="$2"
fi
TEMPLATE_FILE="$1"

out_tmp=$(mktemp)
in_tmp=$(mktemp)

if [ "$TEMPLATE_FILE" == '-' ]; then
  >&2 cat <&0 > "$in_tmp"
else
  if [ ! -f "$TEMPLATE_FILE" ]; then
    >&2 printf "Template file \"$TEMPLATE_FILE\" does not exist or is not a file\n"
    exit 2
  fi
  >&2 cp "$TEMPLATE_FILE" "$in_tmp"
fi
cp "$in_tmp" "$out_tmp" >&2

for var in $(programeiro /template/variables "$1"); do
  if [ -z ${!var+x} ]; then
    >&2 echo "Variable \"$var\" is unset"
    exit 1
  fi
  CONTENT="$(cat "$in_tmp"; printf Z)"
  CONTENT="${CONTENT%Z}"
  FROM="\${$var}"
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

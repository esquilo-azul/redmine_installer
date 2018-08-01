#!/bin/bash

set -u
set -e

if [ $# -lt 2 ]; then
  >&2 echo "Usage: $0 <TEMPLATE_FILE> <OUTPUT_FILE>"
  exit 1
fi

TEMPLATE_FILE="$1"
OUTPUT_FILE="$2"

if [ ! -f "$TEMPLATE_FILE" ]; then
  >&2 echo "Template \"$TEMPLATE_FILE\" does not exist"
  exit 2
fi

if [ "$OUTPUT_FILE" == '-' ]; then
  OUTPUT_FILE=/dev/stdin
else
  if [ ! -f "$OUTPUT_FILE" ]; then
    >&2 echo "Output file \"$OUTPUT_FILE\" does not exist"
    exit 3
  fi
fi

INPUT_FILE="$(mktemp)"
programeiro /template/apply "$TEMPLATE_FILE" "$INPUT_FILE"
diff "$INPUT_FILE" "$OUTPUT_FILE" > /dev/null 2> /dev/null

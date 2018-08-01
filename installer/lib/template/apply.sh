#!/bin/bash

set -u
set -e

if [ $# -lt 2 ]; then
  >&2 echo "Usage: $0 <TEMPLATE_FILE> <OUTPUT_FILE>"
  exit 1
fi

TEMPLATE_FILE="$1"
OUTPUT_FILE="$2"

out_tmp=$(mktemp)
in_tmp=$(mktemp)

cp "$TEMPLATE_FILE" "$in_tmp" >&2
cp "$TEMPLATE_FILE" "$out_tmp" >&2

for var in $(programeiro /template/variables "$1"); do
  if [ -z ${!var+x} ]; then
    >&2 echo "Variable \"$var\" is unset"
    exit 1
  fi
  sed -e "s|\${$var}|${!var}|" "$in_tmp" > "$out_tmp"
  cp "$out_tmp" "$in_tmp" >&2
done

if [ "$OUTPUT_FILE" == '-' ]; then
  cat "$out_tmp"
else
  mkdir -p "$(dirname "$OUTPUT_FILE")" >&2
  cp "$out_tmp" "$OUTPUT_FILE" >&2
fi

#!/bin/bash

set -u
set -e

function put_on_file {
  file=$(mktemp)
  "$1" > "$file"
  echo $file
}

file1=$(put_on_file "$1")
file2=$(put_on_file "$2")

set +e
diff "$file1" "$file2" > /dev/null
result=$?
set -e

rm -f "$file1"
rm -f "$file2"
exit $result

#!/bin/bash

set -e
set -u

FILE=$(programeiro /passenger/root)'/buildout/apache2/mod_passenger.so'

if [ -f "$FILE" ]; then
  echo $FILE
else
  echo ''
fi

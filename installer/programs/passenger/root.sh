#!/bin/bash

DIR="$(echo $(programeiro /ruby/root 'lib/ruby/gems/*/gems/passenger-*'))"
if [ -d "$DIR" ]; then
  echo $DIR
else
  echo ''
fi

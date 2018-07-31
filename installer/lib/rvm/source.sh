#!/bin/bash

set +u
set +e

rvm_source=~/.rvm/scripts/rvm
if [ -f "$rvm_source" ]; then
  source "$rvm_source" > /dev/null
  rvm list | grep "$rvm_ruby" > /dev/null
  result=$?
  if [  $result -eq 0 ]; then
    rvm use "$rvm_ruby" > /dev/null
  fi
fi

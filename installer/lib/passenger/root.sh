#!/bin/bash

DIR=$(echo ~/.rvm/gems/$rvm_ruby/gems/passenger-*)
if [ -d "$DIR" ]; then
  echo $DIR
else
  echo ''
fi

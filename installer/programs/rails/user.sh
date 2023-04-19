#!/bin/bash

# Referência: https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#PassengerUser
stat -c '%U' "$REDMINE_ROOT/config/environment.rb"

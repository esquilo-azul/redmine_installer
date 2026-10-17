#!/bin/bash

set -u
set -e

programeiro /rails/bundle exec rake "$@"

#!/bin/bash

set -u
set -e

RAILS_ENV="$1" programeiro /rails/rake db:create

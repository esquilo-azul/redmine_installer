#!/bin/bash

set -u
set -e

if node --version; then
  infom "Generating plugins assets..."
  RAILS_ENV=production programeiro /rails/rails assets:clean assets:precompile
fi

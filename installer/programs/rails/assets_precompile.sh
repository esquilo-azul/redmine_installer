#!/bin/bash

set -u
set -e

if node --version; then
  infom "Generating plugins assets..."
  RAILS_ENV=production RAILS_RELATIVE_URL_ROOT="${address_path}" programeiro /rails/rails assets:clean \
    assets:precompile
fi

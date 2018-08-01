#!/bin/bash

set -u
set -e

programeiro /rails/rake secret 2> /dev/null

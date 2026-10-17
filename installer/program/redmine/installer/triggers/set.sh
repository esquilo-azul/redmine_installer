#!/bin/bash

set -u
set -e

touch "$(programeiro /redmine/installer/triggers/path)/$1"

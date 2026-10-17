#!/bin/bash

set -e
set -u

eval echo ~$(programeiro /rails/user)/.ssh/$1

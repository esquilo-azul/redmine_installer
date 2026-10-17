#!/bin/bash

set -u
set -e

grep DISTRIB_RELEASE= < /etc/lsb-release | awk '{split($0,a,"="); print a[2]}'

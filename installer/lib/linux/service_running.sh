#!/bin/bash

set -u
set -e

service "$1" status > /dev/null 2> /dev/null

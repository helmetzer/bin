#!/bin/bash
# ls -l  && exit
# find . -name '*.log' -type f -delete
find .  -type f -print0 | xargs -0 chmod 0640
find .  -type d -print0 | xargs -0 chmod 0750

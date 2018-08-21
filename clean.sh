#!/bin/bash
cd $HOME/Musik/32GB-Stick || exit 1
# ls -l  && exit
# find . -name '*.log' -type f -delete
find . -type f \! -iname '*.mp3'
# find . -name '*.ini' -type f -print0 | xargs -0 /bin/rm -f
# find . -name '*.jpg' -type f -print0 | xargs -0 /bin/rm -f
# find . -name '*.log' -type f -print0 | xargs -0 /bin/rm -f
# find . -iname '*.cue' -type f -print0 | xargs -0 /bin/rm -f
# find . -name '*.txt' -type f -print0 | xargs -0 /bin/rm -f
# find . -name '*.gif' -type f -print0 | xargs -0 /bin/rm -f
# find . -name '*.db' -type f -print0 | xargs -0 /bin/rm -f

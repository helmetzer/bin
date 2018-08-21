#!/bin/sh
cd $HOME
for file in .cache \
   .mozilla/firefox/"Crash Reports"  \
   tmp \
   .thunderbird/"Crash Reports" \
   ; do
   touch "$file"/CACHEDIR.TAG
done


#!/bin/sh

# set -x # debug

TAG=CACHEDIR.TAG
HOST=$(hostname)
echo $HOST
case $HOST in
    orst-HP-Laptop-15-bs1xx)
        echo HP
        ;;
    *)
        echo not HP
        ;;
esac


cd $HOME
for file in .cache \
   .mozilla/firefox/"Crash Reports"  \
   tmp \
   .thunderbird/"Crash Reports" \
   dwhelper \
   ; do
   touch "$file"/$TAG
done

test $HOST = debian || { echo not debian; exit; }

echo yes we are on debian

for file in .mozilla \
   .thunderbird \
   ; do
   touch "$file"/$TAG
done


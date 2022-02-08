#!/bin/sh

# set -x # debug

TAG=CACHEDIR.TAG
HOST=$(hostname)
# HOST=debian
# echo $HOST


cd $HOME
FILES=.cache:tmp:dwhelper:.local/lib:.config/google-chrome:.config/session
case $HOST in
    debian|horst-LIFEBOOK-AH530)
        FILES=$FILES:.mozilla:.thunderbird:Downloads
        ;;
    horst-HP-Laptop-15-bs1xx)
    FILES="$FILES:.mozilla/firefox/Crash Reports"
    FILES="$FILES:.thunderbird/Crash Reports"
        ;;
    *)
        ;;
esac

IFS=:

for file in $FILES ; do
   touch "$file"/$TAG
done


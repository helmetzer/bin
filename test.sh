#!/bin/sh

# set -x # debug
if [ "$NEMO_SCRIPT_WINDOW_GEOMETRY" ]
then

    zenity --list --width=600 --height=600 --column "selected files" "$@"  > /dev/null
else
    while [ $# -ne 0 ]
    do
        echo $1
        shift
    done
fi


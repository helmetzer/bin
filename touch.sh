#!/bin/sh

# set -x # debug
if [ "$NEMO_SCRIPT_WINDOW_GEOMETRY" ]
then

    YYMMDD=$(zenity --width=600 --entry --text="YYMMDD eingeben" \
        --entry-text=26)
else
    YYMMDD="$1"
    shift
fi

touch -t 20${YYMMDD}1200 "$@" 


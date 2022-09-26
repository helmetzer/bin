#!/bin/sh

# set -x # debug
if [ "$NEMO_SCRIPT_WINDOW_GEOMETRY" ]
then

    YYMMDD=$(zenity --width=600 --entry --text="YYMMDD eingeben" \
        --entry-text=YYMMDD)
else
    YYMMDD="$1"
    shift
fi

while [ $# -ne 0 ]
do
touch -t 20${YYMMDD}1200 "$1" 
    shift
done


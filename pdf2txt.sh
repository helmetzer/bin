#!/bin/sh

# set -x # debug
if [ "$NEMO_SCRIPT_WINDOW_GEOMETRY" ]
then

    OUT=/daten/tmp/pdf2txt.$$
    exec > $OUT
    zenity --width=600 --info --text="Result in this file: $OUT" &
fi

while [ $# -ne 0 ]
do
    pdftotext -layout "$1" -
    shift
done


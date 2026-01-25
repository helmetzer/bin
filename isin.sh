#!/bin/bash
#
# bash required
#
# extract ISIN from a PDF File and rename this file
# it is assumed that ISIN ends with a digit and is enclosed in ()
#
# set -x # debug

while [ $# -ne 0 ]
do
    FILE="$1"; shift
#   echo $FILE ; continue
    ISIN=$(pdftotext "$FILE" - | grep -m 1 -o "(.\{11\}[[:digit:]])" -) ||
        { echo not found in "$FILE" ; continue ; }
#    echo $ISIN
    ISIN=${ISIN:1:-1}
#    echo $ISIN
    mv "$FILE" "$ISIN.pdf"
#    exit
done


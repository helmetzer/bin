#!/bin/sh

# set -x # debug
# 
DIR=/daten/Users/horst/Dokumente/ING-DiBa


CC=x.$$.sh
cat <<'eof' > $CC
B=$(basename "$1")
D=$(date -I -r "$1")
cp -a "$1" "./$D.$B"
eof

# echo "*$1*" ; exit

find "$DIR" -name "*$1*"  -exec sh $CC '{}' \;

rm $CC


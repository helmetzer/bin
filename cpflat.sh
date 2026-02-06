#!/bin/sh

# set -x # debug
# 
# finde Dateien die $1 im Namen haben im Verzeichnisbaum DIR
# Erzeuge Symlinks im aktuellen Verzeichnis.
# Nicht gut fuer Blanks im Dateinamen
#
# DIR=/daten/Users/horst/Dokumente/Baader


mycopy ()
{
    local B D

    B=$(basename "$1")
    D=$(date -I -r "$1")
    cp --symbolic-link "$1" "./$D.$B" # symbolic link
}

cleanup()
{
    ls ;
}

trap cleanup  0 1 2 3 6


for item in $(find "${DIR:-/daten/Users/horst/Dokumente/ING-DiBa}" \
    -name "*$1*"); do mycopy "$item"; done


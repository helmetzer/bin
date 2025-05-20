#!/bin/sh

ALT=2024
NEU=2025
# Spaltenbreite etc. gespeichert in $HOME/.local/share/gnucash/books
# $ALT.gnucash.gcm
# in gnucash: $ALT.gnucash speichern unter $NEU.gnucash
# Ueberfluessiges rausschmeissen
#
cd /daten/Users/horst/Dokumente/GnuCash  || exit 1
cp $NEU.gnucash Save.gnucash

echo sed s/$ALT-/$NEU-/g Save.gnucash > $NEU.gnucash


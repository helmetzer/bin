#!/bin/sh




cd $HOME/.local/share/gnucash/books
# cp Temp.gnucash.gcm 2024.gnucash.gcm
# exit
cd /daten/Users/Horst/Dokumente/GnuCash  || exit 1
sed s/2023-/2024-/g Temp.gnucash > 2024.gnucash
exit
# cp $JAHR.gnucash Temp.gnucash


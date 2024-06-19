#!/bin/sh

# set -x # debug

TAG=CACHEDIR.TAG
# HOST=$(hostname)
STICK=/media/$USER/INTENSO/Sicherung
cd $STICK || { echo Stick nicht oder falsch eingehaengt ; exit 1 ; }
DIR=$USER-$(date +%g%m%d%H%M)
mkdir $DIR  || exit 1
cd $DIR || exit 1
# save everything but .* - save .thunderbird
## (cd $HOME ; tar -Oc --exclude-tag $TAG * .thunderbird) | tar -xvf -
(cd /daten/Users/$USER ; tar -Oc --exclude-tag $TAG *) | tar -xvf -

ls ..

df

exit

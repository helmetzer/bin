#!/bin/sh

# set -x # debug

TAG=CACHEDIR.TAG
# HOST=$(hostname)
STICK=/media/horst/INTENSO/Sicherung
cd $STICK || exit 1
DIR=$USER-$(date +%g%m%d%H%M)
# mkdir $DIR  || exit 1
(cd /home ; tar -Oc --exclude-tag $TAG $USER) | tar -xvf -
mv $USER $DIR
ls
df

exit

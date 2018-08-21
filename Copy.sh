#!/bin/sh

DRY=--dry-run
DRY=

DELETE=
DELETE=--delete

BASEDIR=Users/Horst
FROM=/daten2/$BASEDIR
TO=/daten/$BASEDIR

DIR=Dokumente

call_rsync () {
  rsync $DRY $DELETE -i -a -u --stats --no-perms $FROM/$1 $TO
}

{
  for DIR in Dokumente # eBooks
  do
    call_rsync $DIR
  done
} > lll

# rsync $DRY $DELETE --modify-window=4000 --verbose --archive --update --stats --no-perms --no-owner --no-group \
#  /daten/Users/Horst/$DIR/ /media/horst/Extern3/$DIR > lll

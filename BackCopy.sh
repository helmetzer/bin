#!/bin/sh

DRY=--dry-run
DRY=

DELETE=
DELETE=--delete

BASEDIR=Users/Horst
FROM=/daten/$BASEDIR
TO=/daten2/Users/horst

call_rsync () {
  rsync $DRY $DELETE -i -a -u --stats --no-perms $FROM/$1 $TO
}

{
  for DIR in Dokumente eBooks
  do
    call_rsync $DIR
  done

  FROM=$HOME/.thunderbird
  MAIL_PROFILE=eiriiape.default
#  call_rsync $MAIL_PROFILE
} > lll

# rsync $DRY $DELETE --modify-window=4000 --verbose --archive --update --stats --no-perms --no-owner --no-group \
#  /daten/Users/Horst/$DIR/ /media/horst/Extern3/$DIR > lll

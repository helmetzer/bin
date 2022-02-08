#!/bin/sh

# set -x # debug

TO=/tmp/utf8.$$
cp "$1" $TO
iconv -f L1 -t UTF-8 $TO > "$1"

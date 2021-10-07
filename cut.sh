#!/bin/sh
while [ "$1" ]
do
  echo "$1"
  cut -d';' -f1-3 "$1" > "cut.$1"
  shift
done

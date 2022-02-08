#!/bin/sh

# set -x # debug

OUT=$(file $1)
zenity --width=600 --info --text="$OUT"

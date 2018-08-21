#!/bin/bash
# set -x # do not use dash or sh - no parameter passing with . command !!!
export TERM=xterm-256color # für mate-terminal
# set -- /daten/Users/Horst/Dokumente /home/horst
# . /home/horst/bin/mc-wrapper.sh
. /usr/lib/mc/mc-wrapper.sh /daten/Users/Horst/Dokumente /home/horst
exec bash

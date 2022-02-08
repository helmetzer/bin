#!/bin/sh

# set -x # debug

makelink()
{
    ln -sf "$2/$1.$3" "$1"
}
cd $HOME/.local/share/nemo/scripts
FILES=file:utf8
IFS=:

for file in $FILES ; do
   makelink $file $HOME/bin sh
done


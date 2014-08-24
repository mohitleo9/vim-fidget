#!/bin/bash

if [ "$FIDGETDIR" == "" ]; then
    FIDGETDIR=/tmp
fi

if [ "$1" == "" ]; then
    FIDGET=$FIDGETDIR/`python -c "import random; print hex(int(str(random.random())[2:10]))[2:]"`
else
    FIDGET=$FIDGETDIR/$1
fi

echo "Creating fiddle to $FIDGET"
(set -e;
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir $FIDGET;
cp $DIR/template/* $FIDGET;
echo $FIDGET
node node_server.js $FIDGET >/dev/null 2>/dev/null &
)

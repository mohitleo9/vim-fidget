#!/bin/bash

if [ "$FIDGETDIR" == "" ]; then
    FIDGETDIR=/tmp
fi

if [ "$1" == "" ]; then
    FIDGET=$FIDGETDIR/`python -c "import random; print (hex(int(str(random.random())[2:10])))[2:]"`
else
    FIDGET=$FIDGETDIR/$1
fi

echo "Creating fiddle to $FIDGET"
(set -e;
# get the actual file path avoiding symlinks
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo $DIR
mkdir $FIDGET;
cp $DIR/template/* $FIDGET;
echo $FIDGET
node $DIR/node_server.js $FIDGET >/dev/null 2>/dev/null &
)

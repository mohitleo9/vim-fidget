#!/bin/bash

if [ "$FIDGETDIR" == "" ]; then
    FIDGETDIR=/tmp
fi

if [ "$1" == "" ]; then
    FIDGET=$FIDGETDIR/`python -c "import random; print hex(int(str(random.random())[2:10]))[2:]"`
else
    FIDGET=$FIDGETDIR/$1
fi

VIM=mvim

function run_fiddle {
  $VIM -S fiddle.vim
}

if [ -e $FIDGET ]; then
    echo "Fiddle already exists, running it..."
    (set -e;
      cd $FIDGET;
      run_fiddle
    )
else
    echo "Creating fiddle to $FIDGET"
    (set -e;
        mkdir $FIDGET;
        cp template/* $FIDGET;
        echo $FIDGET
        node node_server.js $FIDGET >/dev/null 2>/dev/null &
    )
fi

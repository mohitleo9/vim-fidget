#!/bin/bash

if [ "$FIDDLEDIR" == "" ]; then
    FIDDLEDIR=/tmp
fi

if [ "$1" == "" ]; then
    FIDDLE=$FIDDLEDIR/`python -c "import random; print hex(int(str(random.random())[2:10]))[2:]"`
else
    FIDDLE=$FIDDLEDIR/$1
fi

VIM=mvim

function run_fiddle {
  $VIM -S fiddle.vim
  python server.py $FIDDLEHOST
}

if [ -e $FIDDLE ]; then
    echo "Fiddle already exists, running it..."
    (set -e;
      cd $FIDDLE;
      run_fiddle
    )
else
    echo Creating fiddle to $FIDDLE

    (set -e;
        mkdir $FIDDLE;
        cp template/* $FIDDLE;
        cd $FIDDLE;
        sass main.scss main.css;
    
        run_fiddle
    )
fi

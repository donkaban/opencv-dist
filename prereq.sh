#!/usr/bin/env bash

NAME=$(uname -s)
echo set prerequisites for ${NAME} platform ...

if [ $NAME == "Darwin" ]; then
    if [ ! -f /usr/local/bin/brew ]; then
        echo install brew ...
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brew tap homebrew/science && brew update
    brew install git cmake automake autoconf libtool
    brew install  jpeg libpng libtiff openexr eigen 
    brew cleanup && brew prune
fi

if [ $NAME == "Linux" ]; then
    sudo apt-get install -y build-essential gcc g++ cmake git pkg-config python-dev python-numpy 
    sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
    sudo apt-get install -y libjpeg-dev libpng-dev libtiff-dev libjasper-dev 
fi

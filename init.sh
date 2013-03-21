#!/bin/bash
# run this script to initialize this repo

mkdir backup/ undo/ swap/ bundle/ 2>/dev/null
git clone https://github.com/gmarik/vundle.git bundle/vundle 2>/dev/null
vim +BundleInstall! +qall

#!/bin/bash
# run this script to initialize this repo

mkdir backup/ undo/ swap/ autoload/
curl -fLo autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

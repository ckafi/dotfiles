#!/bin/bash
# run this script to initialize this repo

mkdir backup/ undo/ swap/ bundle/
git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim
vim +PluginInstall! +qall

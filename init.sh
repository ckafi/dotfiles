#!/bin/bash

REPODIR=$PWD
cd ~
mkdir .vim
cd .vim
ln -s $REPODIR/* .
mkdir backup/ undo/ swap/ autoload/
curl -fLo autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
VIM=vim
if whence nvim >/dev/null; then
  VIM=nvim
  ln -s vimrc nvimrc
  ln -s ~/.vim ~/.nvim
fi
$VIM +PlugInstall +qall

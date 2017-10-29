#!/bin/zsh

REPODIR=$PWD
cd ~

for f in (gitconfig latexmkrc tmux.conf vimperatorrc Xresources); do
  ln -s $REPODIR/$f .${f}
done

mkdir .config
for f in (aria2 dunst fontconfig i3 redshift.conf sxhkd termite zathura); do
  ln -s $REPODIR/$f .config/
done

mkdir .config/pacman
ln -s $REPODIR/makepkg.conf .config/pacman/

mkdir .config/vifm
ln -s $REPODIR/vifm/* .config/vifm

mkdir .config/fish
ln -s $REPODIR/fish/{config.fish, fishfile} .config/fish

mkdir .lein
ln -s $REPODIR/lein/profiles.clj .lein/

mkdir .ssh
ln -s $REPODIR/ssh/config .ssh/

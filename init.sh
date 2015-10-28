REPODIR=$PWD
cd ~
mkdir -p .config/nvim
cd .config/nvim
ln -s $REPODIR/* .
mkdir backup/ undo/ swap/ autoload/
curl -fLo autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall

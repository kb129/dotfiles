ROOT=$(cd $(dirname $0); pwd)
ln -s $ROOT/bashrc $HOME/.bashrc
ln -s $ROOT/tmux.conf $HOME/.tmux.conf
ln -s $ROOT/vim $HOME/.vim
ln -s $ROOT/vimrc $HOME/.vimrc
ln -s $ROOT/zlogin $HOME/.zlogin
ln -s $ROOT/zlogout $HOME/.zlogout
ln -s $ROOT/zpreztorc $HOME/.zpreztorc
ln -s $ROOT/zprofile $HOME/.zprofile
ln -s $ROOT/zshenv $HOME/.zshenv

mkdir -p $HOME/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim

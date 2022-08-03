ROOT=$(cd $(dirname $0); pwd)
cp -r $ROOT/vim $HOME/.vim
mkdir -p $HOME/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
ln -s $ROOT/bash_profile $HOME/.bash_profile
ln -s $ROOT/bashrc $HOME/.bashrc
ln -s $ROOT/tmux.conf $HOME/.tmux.conf
ln -s $ROOT/vimrc $HOME/.vimrc
ln -s $ROOT/zshrc $HOME/.zshrc
ln -s $ROOT/zlogin $HOME/.zlogin
ln -s $ROOT/zlogout $HOME/.zlogout
ln -s $ROOT/zpreztorc $HOME/.zpreztorc
ln -s $ROOT/zprofile $HOME/.zprofile
ln -s $ROOT/zshenv $HOME/.zshenv


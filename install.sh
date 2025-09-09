ROOT=$(cd $(dirname $0); pwd)

cp -r $ROOT/vim $HOME/.vim
mkdir -p $HOME/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
ln -s $ROOT/bash_profile $HOME/.bash_profile
ln -s $ROOT/bashrc $HOME/.bashrc
ln -s $ROOT/aliases $HOME/.bash_aliases
ln -s $ROOT/tmux.conf $HOME/.tmux.conf
ln -s $ROOT/screenrc $HOME/.screenrc
ln -s $ROOT/vimrc $HOME/.vimrc
ln -s $ROOT/zshrc $HOME/.zshrc
ln -s $ROOT/aliases $HOME/.zsh_aliases
ln -s $ROOT/zlogin $HOME/.zlogin
ln -s $ROOT/zlogout $HOME/.zlogout
ln -s $ROOT/zpreztorc $HOME/.zpreztorc
ln -s $ROOT/screenrc $HOME/.screenrc
# homebrew, if macOS
if [ "$(uname)" = "Darwin" ]; then
    ln -s $ROOT/macos/Brewfile $HOME/.Brewfile
    brew bundle --global
fi

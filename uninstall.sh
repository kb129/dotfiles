ROOT=$(cd $(dirname $0); pwd)
unlink $HOME/.bashrc
unlink $HOME/.tmux.conf
rm -rf $HOME/.vim
unlink $HOME/.vimrc
unlink $HOME/.zshrc
unlink $HOME/.zlogin
unlink $HOME/.zlogout
unlink $HOME/.zpreztorc
unlink $HOME/.zprofile
unlink $HOME/.zshenv
rm -rf $HOME/.zprezto
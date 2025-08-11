ROOT=$(cd $(dirname $0); pwd)
unlink $HOME/.bash_profile
unlink $HOME/.bashrc
unlink $HOME/.bash_aliases
unlink $HOME/.tmux.conf
rm -rf $HOME/.vim
unlink $HOME/.vimrc
unlink $HOME/.zshrc
unlink $HOME/.zsh_aliases
unlink $HOME/.zlogin
unlink $HOME/.zlogout
unlink $HOME/.zpreztorc
unlink $HOME/.zprofile
unlink $HOME/.zshenv
rm -rf $HOME/.zprezto
unlink $HOME/.screenrc
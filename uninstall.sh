ROOT=$(
  cd $(dirname $0)
  pwd
)
unlink $HOME/.bash_profile
unlink $HOME/.bashrc
unlink $HOME/.bash_aliases
unlink $HOME/.tmux.conf
rm -rf $HOME/.config/nvim
unlink $HOME/.zshrc
unlink $HOME/.zsh_aliases
unlink $HOME/.zlogin
unlink $HOME/.zlogout
unlink $HOME/.zpreztorc
rm -rf $HOME/.zprezto
unlink $HOME/.screenrc
if [ "$(uname)" = "Darwin" ]; then
  unlink $HOME/.Brewfile
  unlink $HOME/.config/ghostty/config
fi

ROOT=$(
  cd $(dirname $0)
  pwd
)

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
ln -s $ROOT/bash_profile $HOME/.bash_profile
ln -s $ROOT/bashrc $HOME/.bashrc
ln -s $ROOT/aliases $HOME/.bash_aliases
ln -s $ROOT/tmux.conf $HOME/.tmux.conf
ln -s $ROOT/screenrc $HOME/.screenrc
if [ ! -d "$HOME/.config/nvim" ]; then
  mkdir -p $HOME/.config/nvim
fi
ln -s $ROOT/nvim/init.lua $HOME/.config/nvim/init.lua
ln -s $ROOT/nvim/lua/ $HOME/.config/nvim/
ln -s $ROOT/zshrc $HOME/.zshrc
ln -s $ROOT/aliases $HOME/.zsh_aliases
ln -s $ROOT/zlogin $HOME/.zlogin
ln -s $ROOT/zlogout $HOME/.zlogout
ln -s $ROOT/zpreztorc $HOME/.zpreztorc
ln -s $ROOT/screenrc $HOME/.screenrc
# homebrew
if [ ! -d "/usr/local/bin/brew" ] && [ ! -d "/opt/homebrew/bin/brew" ]; then
  ln -s $ROOT/macos/Brewfile $HOME/.Brewfile
  brew bundle --global
fi
if [ "$(uname)" = "Darwin" ]; then
  if [ ! -d "$HOME/.config/ghostty" ]; then
    mkdir $HOME/.config/ghostty
  fi
  ln -s $ROOT/macos/ghostty.config $HOME/.config/ghostty/config
fi

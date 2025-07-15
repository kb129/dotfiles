#
# Executes commands at the start of an interactive session.
#
# PATH settings
typeset -U path PATH
path=(
  ${HOMEBREW_PREFIX}/bin(N-/) # Homebrew executables
  ${HOMEBREW_PREFIX}/sbin(N-/) # Homebrew system binaries
  /usr/bin # System executables
  /usr/sbin # System system binaries
  /bin # Essential executables
  /sbin # Essential system binaries
  /usr/local/bin(N-/) # Local executables
  /usr/local/sbin(N-/) # Local system binaries
  $HOME/.nodebrew/current/bin(N-/) # Nodebrew executables
  $HOME/.go/bin
  /home/linuxbrew/.linuxbrew/bin
  /home/linuxbrew/.linuxbrew/sbin
)

# brewfile
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi


if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# aliases
if [ -f $HOME/.zsh_aliases ]; then
    source $HOME/.zsh_aliases
fi
if [ -f $HOME/.zsh_secret ];then
    source $HOME/.zsh_secret
fi

# conda
CONDA_PREFIX=/opt/miniconda3
source ${CONDA_PREFIX}/bin/activate 

# go
export GOPATH=$HOME/.go

# completions and suggestions
if type brew >/dev/null 2>&1; then
  # Add Homebrew completions to FPATH
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  # Add Homebrew site-functions to FPATH
  FPATH=$(brew --prefix)/share/zsh/site-functions:${FPATH}
  # Enable zsh-autosuggestions plugin
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  # Initialize completions system
  autoload -Uz compinit && compinit
fi

# fzf
export FZF_DEFAULT_OPTS='--color=fg+:11 --height 70% --reverse --select-1 --exit-0 --multi'

# others
export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DOWNLOAD_DIR=$HOME/Downloads

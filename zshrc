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

# prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# aliases
if [ -f $HOME/.zsh_aliases ]; then
    source $HOME/.zsh_aliases
fi

# secret (API keys, etc.)
if [ -f $HOME/.zsh_secret ];then
    source $HOME/.zsh_secret
fi

# conda or miniconda
if [ -f $HOME/.zsh_conda ]; then
    source $HOME/.zsh_conda
fi

# go
export GOPATH=$HOME/.go

# brew
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi
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

RPROMPT='$(git config user.name 2>/dev/null)'

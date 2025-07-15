#
# Executes commands at the start of an interactive session.
#

# PATH settings
typeset -U path PATH
path=(
  ${HOMEBREW_PREFIX}/bin(N-/)
  ${HOMEBREW_PREFIX}/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  $HOME/.nodebrew/current/bin(N-/)
)

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# aliases
if [ -f $HOME/.zsh_aliases ];then
    source $HOME/.zsh_aliases
fi
if [ -f $HOME/.zsh_secret ];then
    source $HOME/.zsh_secret
fi

# conda
CONDA_PREFIX=${HOME}/dev/conda
CONDA_LOCALENVNAME=${CONDA_PREFIX}/envs/`hostname -s`
if [ -d ${CONDA_LOCALENVNAME} ]; then
  source ${CONDA_PREFIX}/bin/activate ${CONDA_LOCALENVNAME}
fi
# completions and suggestions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit && compinit
fi

# fzf
export FZF_DEFAULT_OPTS='--color=fg+:11 --height 70% --reverse --select-1 --exit-0 --multi'
